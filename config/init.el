;;; init.el --- emacs-r-devkit - Emacs configuration for R package development
;;; Commentary:
;; A curated Emacs configuration for R package development (including S7),
;; Quarto/LaTeX writing, teaching statistics, and Zotero/Obsidian integration.
;;
;; Compatible with vanilla Emacs and emacs-plus on macOS, Linux.
;;
;; Features:
;; - Flycheck + lintr + external styler checker
;; - Styler-on-save with guard (save only if styler succeeds)
;; - Smart roxygen insertion that parses function signatures
;; - Interactive usethis scaffolding (use_r, use_test, use_package_doc)
;; - S7 class/method skeleton helpers
;; - PATH export for macOS GUI Emacs
;; - LSP mode, company, vertico, consult
;; - Quarto/polymode, AUCTeX, pdf-tools, org enhancements
;; - Citar + Obsidian integration

;;; Code:

;;; ============================================================================
;;; Package Management Setup
;;; ============================================================================

;; Initialize package system
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;; ============================================================================
;;; macOS-specific: PATH and Environment Setup
;;; ============================================================================

;; Detect macOS (works for both vanilla Emacs and emacs-plus)
(defun emacs-r-devkit/is-macos ()
  "Return t if running on macOS."
  (or (eq system-type 'darwin)
      (eq system-type 'mac)
      (string-match-p "darwin" system-configuration)))

;; Detect GUI mode (works for vanilla, emacs-plus, terminal)
(defun emacs-r-devkit/is-gui ()
  "Return t if running in GUI mode."
  (or window-system
      (daemonp)))

;; Ensure GUI Emacs inherits shell PATH (critical for macOS)
;; Works with both vanilla Emacs and emacs-plus
(use-package exec-path-from-shell
  :if (and (emacs-r-devkit/is-macos) (emacs-r-devkit/is-gui))
  :config
  (setq exec-path-from-shell-variables '("PATH" "MANPATH" "QUARTO_BIN" "R_HOME")
        exec-path-from-shell-check-startup-files nil
        exec-path-from-shell-arguments '("-l"))
  (exec-path-from-shell-initialize))

;; Helper function to run export-gui-path.sh if needed
(defun emacs-r-devkit/export-gui-path ()
  "Run export-gui-path.sh to set launchctl PATH on macOS."
  (interactive)
  (if (not (emacs-r-devkit/is-macos))
      (message "export-gui-path is macOS-only")
    (let ((script-path (expand-file-name "~/.emacs.d/bin/export-gui-path.sh")))
      (if (file-exists-p script-path)
          (let ((result (shell-command-to-string script-path)))
            (message "PATH export result: %s" result))
        (message "export-gui-path.sh not found at %s" script-path)))))

;;; ============================================================================
;;; UI/UX Improvements
;;; ============================================================================

;; Basic UI cleanup (compatible with all Emacs builds)
(setq inhibit-startup-message t)

;; Safely disable UI elements (some might not exist in terminal mode)
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Menu bar: keep on macOS GUI (convention), hide on terminal/Linux
(if (and (emacs-r-devkit/is-macos) (emacs-r-devkit/is-gui))
    (menu-bar-mode 1)
  (when (fboundp 'menu-bar-mode) (menu-bar-mode -1)))

;; Line numbers in programming modes (Emacs 26+)
(when (version<= "26.1" emacs-version)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode))

;; Better scrolling
(setq scroll-conservatively 100
      scroll-margin 3
      scroll-preserve-screen-position t)

;; Highlight current line
(global-hl-line-mode 1)

;; Show matching parentheses
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Better defaults
(setq-default indent-tabs-mode nil
              tab-width 2
              fill-column 80)

;; Backup and auto-save settings
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; UTF-8 everywhere
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25
      recentf-max-saved-items 100)

;; macOS-specific keybindings (both vanilla and emacs-plus)
(when (emacs-r-devkit/is-macos)
  (setq mac-command-modifier 'super
        mac-option-modifier 'meta
        mac-right-option-modifier nil)) ; Allow right-option for special chars

;;; ============================================================================
;;; Completion Framework: Vertico, Consult, Marginalia
;;; ============================================================================

(use-package vertico
  :init
  (vertico-mode))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package consult
  :bind (("C-s" . consult-line)
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("M-y" . consult-yank-pop)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;;; ============================================================================
;;; Company Mode - Code Completion
;;; ============================================================================

(use-package company
  :hook (after-init . global-company-mode)
  :bind (:map company-active-map
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous)
              ("<tab>" . company-complete-selection))
  :custom
  (company-idle-delay 0.1)
  (company-minimum-prefix-length 2)
  (company-tooltip-align-annotations t)
  (company-require-match nil))

;;; ============================================================================
;;; Flycheck - Syntax Checking
;;; ============================================================================

(use-package flycheck
  :init (global-flycheck-mode)
  :config
  ;; Configure R lintr checker
  (setq flycheck-lintr-linters "with_defaults(line_length_linter(120))")

  ;; Define custom styler checker
  (flycheck-define-checker r-styler-check
    "An R syntax checker using styler via external script."
    :command ("Rscript"
              (eval (expand-file-name "~/.emacs.d/bin/r-styler-check.R"))
              source-original)
    :error-patterns
    ((warning line-start (file-name) ":" line ":" column ": " (message) line-end))
    :modes (ess-r-mode ess-mode))

  ;; Add styler checker to R modes (after ESS loads)
  (with-eval-after-load 'ess-r-mode
    (add-to-list 'flycheck-checkers 'r-styler-check)))

;;; ============================================================================
;;; ESS - Emacs Speaks Statistics (R support)
;;; ============================================================================

(use-package ess
  :config
  ;; ESS configuration
  (setq ess-ask-for-ess-directory nil
        ess-local-process-name "R"
        ess-use-flymake nil  ; Use flycheck instead
        ess-use-company t
        ess-style 'RStudio
        ess-indent-offset 2
        ess-offset-arguments 'open-delim
        ess-roxy-hide-show-p t)

  ;; Auto-start R settings
  (setq inferior-R-args "--no-save --no-restore")

  ;; Enable Flycheck in ESS modes
  (add-hook 'ess-r-mode-hook #'flycheck-mode)
  (add-hook 'inferior-ess-r-mode-hook
            (lambda ()
              (setq-local comint-scroll-to-bottom-on-input t)
              (setq-local comint-scroll-to-bottom-on-output t)
              (setq-local comint-move-point-for-output t))))

;;; ============================================================================
;;; Styler Integration - Auto-format on Save
;;; ============================================================================

(defvar emacs-r-devkit/styler-enabled t
  "Toggle styler-on-save functionality.")

(defun emacs-r-devkit/toggle-styler ()
  "Toggle automatic styling on save."
  (interactive)
  (setq emacs-r-devkit/styler-enabled (not emacs-r-devkit/styler-enabled))
  (message "Styler on save: %s" (if emacs-r-devkit/styler-enabled "enabled" "disabled")))

(defun emacs-r-devkit/style-buffer-with-guard ()
  "Run styler on current buffer, but only save if it succeeds.
Returns t if styling succeeded or is disabled, nil if it failed."
  (if (not emacs-r-devkit/styler-enabled)
      t  ; Styler disabled, allow save
    (when (and (derived-mode-p 'ess-r-mode)
               (buffer-file-name))
      (let* ((file (buffer-file-name))
             (temp-file (make-temp-file "styler-" nil ".R"))
             (original-content (buffer-string))
             (original-point (point)))
        (unwind-protect
            (progn
              ;; Write current buffer to temp file
              (with-temp-file temp-file
                (insert original-content))
              ;; Try to style it
              (let* ((cmd (format "Rscript -e 'styler::style_file(\"%s\")' 2>&1" temp-file))
                     (result (shell-command-to-string cmd)))
                (if (string-match-p "Error" result)
                    (progn
                      (message "Styler failed: %s" result)
                      nil)  ; Return nil to prevent save
                  ;; Styler succeeded, replace buffer content
                  (let ((new-content (with-temp-buffer
                                       (insert-file-contents temp-file)
                                       (buffer-string))))
                    (unless (string= original-content new-content)
                      (erase-buffer)
                      (insert new-content)
                      (goto-char original-point)
                      (message "Buffer styled with styler"))
                    t))))  ; Return t to allow save
          ;; Cleanup
          (when (file-exists-p temp-file)
            (delete-file temp-file)))))))

;; Add to before-save-hook for R files
(add-hook 'ess-r-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'emacs-r-devkit/style-buffer-with-guard nil t)))

;;; ============================================================================
;;; Smart Roxygen Insertion
;;; ============================================================================

(defun emacs-r-devkit/insert-roxygen-skeleton ()
  "Insert a roxygen2 skeleton based on the current function signature.
If a region is selected, use it as the @examples section."
  (interactive)
  (let ((examples-text (when (use-region-p)
                         (buffer-substring-no-properties (region-beginning) (region-end))))
        (func-name "")
        (params '()))

    ;; Try to parse function signature
    (save-excursion
      (when (re-search-forward "\\([a-zA-Z0-9._]+\\)\\s-*<-\\s-*function\\s-*(\\([^)]*\\))" nil t)
        (setq func-name (match-string 1))
        (let ((params-string (match-string 2)))
          (when (> (length params-string) 0)
            (setq params (split-string params-string "," t "\\s-*"))))))

    ;; Insert roxygen skeleton
    (beginning-of-line)
    (insert "#' Title\n")
    (insert "#'\n")
    (insert "#' Description\n")
    (insert "#'\n")

    ;; Insert @param for each parameter
    (dolist (param params)
      (let ((param-name (car (split-string param "=" t "\\s-*"))))
        (insert (format "#' @param %s \n" param-name))))

    (when (> (length params) 0)
      (insert "#'\n"))

    (insert "#' @return \n")

    ;; Insert examples if region was selected
    (when examples-text
      (insert "#' @examples\n")
      (dolist (line (split-string examples-text "\n"))
        (insert (format "#' %s\n" line))))

    (insert "#' @export\n")))

;;; ============================================================================
;;; Usethis Integration
;;; ============================================================================

(defun emacs-r-devkit/usethis-use-r (name)
  "Call usethis::use_r() and open the created file."
  (interactive "sR file name (without .R): ")
  (let* ((cmd (format "Rscript -e 'usethis::use_r(\"%s\")'" name))
          (output (shell-command-to-string cmd))
          (file-path (format "R/%s.R" name)))
    (message "usethis output: %s" output)
    (sit-for 0.5)  ; Wait for file creation
    (when (file-exists-p file-path)
      (find-file file-path)
      (message "Opened %s" file-path))))

(defun emacs-r-devkit/usethis-use-test (name)
  "Call usethis::use_test() and open the created test file."
  (interactive "sTest name (without test- prefix): ")
  (let* ((cmd (format "Rscript -e 'usethis::use_test(\"%s\")'" name))
          (output (shell-command-to-string cmd))
          (file-path (format "tests/testthat/test-%s.R" name)))
    (message "usethis output: %s" output)
    (sit-for 0.5)
    (when (file-exists-p file-path)
      (find-file file-path)
      (message "Opened %s" file-path))))

(defun emacs-r-devkit/usethis-use-package-doc ()
  "Call usethis::use_package_doc() and open the package doc file."
  (interactive)
  (let* ((cmd "Rscript -e 'usethis::use_package_doc()'")
          (output (shell-command-to-string cmd)))
    (message "usethis output: %s" output)
    (sit-for 0.5)
    (let ((pkg-doc (car (file-expand-wildcards "R/*-package.R"))))
      (when pkg-doc
        (find-file pkg-doc)
        (message "Opened %s" pkg-doc)))))

;;; ============================================================================
;;; S7 Helpers
;;; ============================================================================

(defun emacs-r-devkit/s7-insert-class ()
  "Insert an S7 class skeleton."
  (interactive)
  (let ((class-name (read-string "Class name: ")))
    (insert (format "#' %s class\n" class-name))
    (insert "#'\n")
    (insert "#' @format An S7 class\n")
    (insert "#' @export\n")
    (insert (format "%s <- s7::new_class(\n" class-name))
    (insert (format "  \"%s\",\n" class-name))
    (insert "  properties = list(\n")
    (insert "    # Define properties here\n")
    (insert "  ),\n")
    (insert "  validator = function(self) {\n")
    (insert "    # Add validation logic\n")
    (insert "  }\n")
    (insert ")\n")))

(defun emacs-r-devkit/s7-insert-method ()
  "Insert an S7 method skeleton."
  (interactive)
  (let ((generic-name (read-string "Generic function name: "))
        (class-name (read-string "Class name: ")))
    (insert (format "#' %s method for %s\n" generic-name class-name))
    (insert "#'\n")
    (insert (format "#' @param x A %s object\n" class-name))
    (insert "#' @param ... Additional arguments\n")
    (insert "#' @export\n")
    (insert (format "s7::method(%s, %s) <- function(x, ...) {\n" generic-name class-name))
    (insert "  # Implementation here\n")
    (insert "}\n")))

(defun emacs-r-devkit/s7-insert-generic ()
  "Insert an S7 generic function skeleton."
  (interactive)
  (let ((generic-name (read-string "Generic function name: ")))
    (insert (format "#' %s generic\n" generic-name))
    (insert "#'\n")
    (insert "#' @param x An object\n")
    (insert "#' @param ... Additional arguments\n")
    (insert "#' @export\n")
    (insert (format "%s <- s7::new_generic(\"%s\", \"x\")\n" generic-name generic-name))))

;;; ============================================================================
;;; LSP Mode - Language Server Protocol
;;; ============================================================================

(use-package lsp-mode
  :commands lsp
  :hook ((ess-r-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :config
  (setq lsp-keymap-prefix "C-c l"
        lsp-headerline-breadcrumb-enable nil
        lsp-enable-symbol-highlighting t
        lsp-lens-enable nil
        lsp-signature-auto-activate t
        lsp-signature-render-documentation t)

  ;; R languageserver configuration
  (setq lsp-r-server-command "R"
        lsp-r-server-args '("--slave" "-e" "languageserver::run()")))

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-show-with-cursor nil
        lsp-ui-doc-show-with-mouse t
        lsp-ui-sideline-show-hover t
        lsp-ui-sideline-show-diagnostics t))

;;; ============================================================================
;;; Quarto Support
;;; ============================================================================

(use-package quarto-mode
  :mode (("\\.qmd\\'" . quarto-mode)))

(use-package polymode
  :config
  (add-to-list 'auto-mode-alist '("\\.qmd\\'" . poly-quarto-mode)))

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;;; ============================================================================
;;; LaTeX Support - AUCTeX
;;; ============================================================================

(use-package tex
  :ensure auctex
  :config
  (setq TeX-auto-save t
        TeX-parse-self t
        TeX-PDF-mode t)
  (setq-default TeX-master nil)

  ;; Use pdf-tools for viewing if available
  (when (fboundp 'pdf-tools-install)
    (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
          TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
          TeX-source-correlate-start-server t)))

(use-package pdf-tools
  :if (emacs-r-devkit/is-gui)  ; Only in GUI mode
  :config
  (pdf-tools-install :no-query)
  (setq-default pdf-view-display-size 'fit-page)
  (setq pdf-view-resize-factor 1.1))

;;; ============================================================================
;;; Org Mode Enhancements
;;; ============================================================================

(use-package org
  :config
  (setq org-startup-indented t
        org-hide-leading-stars t
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0
        org-confirm-babel-evaluate nil
        org-export-with-smart-quotes t)

  ;; Org babel languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t)
     (emacs-lisp . t)
     (shell . t)
     (python . t))))

;;; ============================================================================
;;; Citar - Citation Management (Zotero Integration)
;;; ============================================================================

(use-package citar
  :custom
  (citar-bibliography '("~/Zotero/library.bib"))  ; Adjust path as needed
  :bind
  (("C-c b" . citar-insert-citation)
   :map minibuffer-local-map
   ("M-b" . citar-insert-preset)))

;;; ============================================================================
;;; Magit - Git Integration
;;; ============================================================================

(use-package magit
  :bind ("C-x g" . magit-status)
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;;; ============================================================================
;;; Which-Key - Display Key Bindings
;;; ============================================================================

(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.5
        which-key-sort-order 'which-key-key-order-alpha))

;;; ============================================================================
;;; Yasnippet - Snippets
;;; ============================================================================

(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :after yasnippet)

;;; ============================================================================
;;; Project Management
;;; ============================================================================

(use-package projectile
  :init
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config
  (setq projectile-completion-system 'default
        projectile-enable-caching t
        projectile-indexing-method 'alien))

;;; ============================================================================
;;; Keybindings for Custom Functions
;;; ============================================================================

(global-set-key (kbd "C-c r r") 'emacs-r-devkit/insert-roxygen-skeleton)
(global-set-key (kbd "C-c r u") 'emacs-r-devkit/usethis-use-r)
(global-set-key (kbd "C-c r t") 'emacs-r-devkit/usethis-use-test)
(global-set-key (kbd "C-c r p") 'emacs-r-devkit/usethis-use-package-doc)
(global-set-key (kbd "C-c r s c") 'emacs-r-devkit/s7-insert-class)
(global-set-key (kbd "C-c r s m") 'emacs-r-devkit/s7-insert-method)
(global-set-key (kbd "C-c r s g") 'emacs-r-devkit/s7-insert-generic)
(global-set-key (kbd "C-c r S") 'emacs-r-devkit/toggle-styler)
(global-set-key (kbd "C-c r P") 'emacs-r-devkit/export-gui-path)

;;; ============================================================================
;;; Custom Variables (safe for .dir-locals.el)
;;; ============================================================================

(put 'emacs-r-devkit/styler-enabled 'safe-local-variable #'booleanp)

;;; ============================================================================
;;; Performance Optimizations
;;; ============================================================================

;; Increase gc threshold during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Reset gc threshold after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 20 1024 1024)))) ; 20MB

;;; ============================================================================
;;; Startup Message
;;; ============================================================================

(defun emacs-r-devkit/startup-message ()
  "Display emacs-r-devkit startup message with system info."
  (message "emacs-r-devkit loaded! [%s %s | %s] Key prefix: C-c r"
           (if (emacs-r-devkit/is-macos) "macOS" "Linux")
           (if (emacs-r-devkit/is-gui) "GUI" "Terminal")
           emacs-version))

(add-hook 'emacs-startup-hook #'emacs-r-devkit/startup-message)

(provide 'init)
;;; init.el ends here

;;; ============================================================================
;;; Obsidian Research Lab Integration
;;; ============================================================================

;; Load the Obsidian Bridge module if present
(let ((obs-bridge-file (expand-file-name "snippets/obsidian-bridge.el" user-emacs-directory)))
  (when (file-exists-p obs-bridge-file)
    (load obs-bridge-file)
    ;; Recommended Keybindings
    (global-set-key (kbd "C-c o l") 'obs-r-link-project)
    (global-set-key (kbd "C-c o f") 'obs-log-file)
    (global-set-key (kbd "C-c o t") 'obs-fetch-theory)
    (global-set-key (kbd "C-c o d") 'obs-sync-draft)))
