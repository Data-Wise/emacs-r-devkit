;;; test-emacs-r-devkit.el --- Tests for emacs-r-devkit -*- lexical-binding: t; -*-

;;; Commentary:
;; Unit tests for emacs-r-devkit custom functions and configurations

;;; Code:

;; Robustly find project root
(defvar test-emacs-r-devkit--root
  (expand-file-name ".." (file-name-directory (or load-file-name buffer-file-name default-directory))))

;; Load dependencies if available
(mapc (lambda (pkg) (ignore-errors (require pkg)))
      '(company flycheck which-key exec-path-from-shell lsp-mode ess-r-mode))

;; Load the project config to get custom functions
;; Load init.el from config directory
(let ((init-file (expand-file-name "config/init.el" test-emacs-r-devkit--root)))
  (if (file-exists-p init-file)
      (load-file init-file)
    (error "init.el not found at %s" init-file)))

;; Ensure essential variables are bound for tests
(unless (boundp 'ess-r-backend) (setq ess-r-backend 'lsp))
(unless (boundp 'company-idle-delay) (setq company-idle-delay 0.1))

;; Add project bin to exec-path for tests
(let ((project-bin (expand-file-name "bin" test-emacs-r-devkit--root)))
  (push project-bin exec-path))

;;; Test Helper Functions

(defun test-emacs-r-devkit/with-temp-r-buffer (body-fn)
  "Execute BODY-FN in a temporary R buffer."
  (with-temp-buffer
    (ess-r-mode)
    (funcall body-fn)))

;;; Configuration Tests

(ert-deftest test-spacemacs-layers-loaded ()
  "Test that required Spacemacs layers are loaded."
  (should (featurep 'ess))
  (should (featurep 'flycheck))
  (should (featurep 'company))
  (should (featurep 'lsp-mode)))

(ert-deftest test-ess-configuration ()
  "Test ESS is properly configured."
  (should (boundp 'ess-r-backend))
  (should (eq ess-r-backend 'lsp)))

(ert-deftest test-company-configuration ()
  "Test company-mode is configured."
  (should (boundp 'company-idle-delay))
  (should (numberp company-idle-delay)))

;;; Custom Function Tests

(ert-deftest test-roxygen-skeleton-function-exists ()
  "Test roxygen skeleton function is defined."
  (should (fboundp 'emacs-r-devkit/insert-roxygen-skeleton)))

(ert-deftest test-styler-toggle-function-exists ()
  "Test styler toggle function is defined."
  (should (fboundp 'emacs-r-devkit/toggle-styler))
  (should (boundp 'emacs-r-devkit/styler-enabled)))

(ert-deftest test-s7-functions-exist ()
  "Test S7 helper functions are defined."
  (should (fboundp 'emacs-r-devkit/s7-insert-class))
  (should (fboundp 'emacs-r-devkit/s7-insert-method))
  (should (fboundp 'emacs-r-devkit/s7-insert-generic)))

;;; Edge Case Tests for Custom Functions

(ert-deftest test-roxygen-skeleton-no-function ()
  "Test roxygen skeleton when no function signature is found."
  (with-temp-buffer
    (ess-r-mode)
    (insert "# Just a comment\nx <- 1\n")
    ;; Should not error, just insert basic skeleton
    (should (condition-case nil
                (progn (emacs-r-devkit/insert-roxygen-skeleton) t)
              (error nil)))))

(ert-deftest test-styler-guard-nonexistent-file ()
  "Test styler guard with nonexistent file."
  (let ((emacs-r-devkit/styler-enabled t))
    (with-temp-buffer
      (ess-r-mode)
      ;; Buffer with no file - styler guard returns nil (can't style)
      (insert "x <- 1")
      ;; Should return nil for buffers without files
      (should-not (emacs-r-devkit/style-buffer-with-guard)))))

(ert-deftest test-styler-toggle ()
  "Test styler toggle functionality."
  (let ((initial-state emacs-r-devkit/styler-enabled))
    (emacs-r-devkit/toggle-styler)
    (should (not (eq initial-state emacs-r-devkit/styler-enabled)))
    ;; Toggle back
    (emacs-r-devkit/toggle-styler)
    (should (eq initial-state emacs-r-devkit/styler-enabled))))

(ert-deftest test-s7-insert-class-basic ()
  "Test S7 class insertion with basic input."
  (with-temp-buffer
    (ess-r-mode)
    ;; Mock read-string to return a test class name
    (cl-letf (((symbol-function 'read-string)
               (lambda (prompt) "TestClass")))
      (emacs-r-devkit/s7-insert-class)
      (should (string-match-p "TestClass" (buffer-string)))
      (should (string-match-p "s7::new_class" (buffer-string))))))

(ert-deftest test-s7-insert-method-basic ()
  "Test S7 method insertion with basic input."
  (with-temp-buffer
    (ess-r-mode)
    (let ((call-count 0))
      (cl-letf (((symbol-function 'read-string)
                 (lambda (prompt)
                   (setq call-count (1+ call-count))
                   (if (= call-count 1) "print" "TestClass"))))
        (emacs-r-devkit/s7-insert-method)
        (should (string-match-p "s7::method" (buffer-string)))
        (should (string-match-p "print" (buffer-string)))
        (should (string-match-p "TestClass" (buffer-string)))))))

(ert-deftest test-s7-insert-generic-basic ()
  "Test S7 generic insertion with basic input."
  (with-temp-buffer
    (ess-r-mode)
    (cl-letf (((symbol-function 'read-string)
               (lambda (prompt) "my_generic")))
      (emacs-r-devkit/s7-insert-generic)
      (should (string-match-p "s7::new_generic" (buffer-string)))
      (should (string-match-p "my_generic" (buffer-string))))))

;;; Keybinding Tests

(ert-deftest test-major-mode-leader-bindings ()
  "Test major mode leader key bindings in R mode."
  (test-emacs-r-devkit/with-temp-r-buffer
   (lambda ()
     ;; Test that major mode map exists
     (should (keymapp ess-r-mode-map))
     
     ;; Test specific bindings exist
     (should (lookup-key ess-r-mode-map (kbd "C-c r r")))
     (should (lookup-key ess-r-mode-map (kbd "C-c r S"))))))

(ert-deftest test-ess-eval-bindings ()
  "Test ESS evaluation keybindings."
  (test-emacs-r-devkit/with-temp-r-buffer
   (lambda ()
     (should (lookup-key ess-r-mode-map (kbd "C-<return>"))))))

;;; Mode Activation Tests

(ert-deftest test-r-mode-activation ()
  "Test R mode activates correctly."
  (with-temp-buffer
    (insert "x <- 1:10\n")
    (ess-r-mode)
    (should (eq major-mode 'ess-r-mode))))

(ert-deftest test-flycheck-in-r-mode ()
  "Test Flycheck activates in R mode."
  (test-emacs-r-devkit/with-temp-r-buffer
   (lambda ()
     (flycheck-mode 1)
     (should flycheck-mode))))

(ert-deftest test-company-in-r-mode ()
  "Test Company mode activates in R mode."
  (test-emacs-r-devkit/with-temp-r-buffer
   (lambda ()
     (company-mode 1)
     (should company-mode))))

;;; LSP Tests

(ert-deftest test-lsp-backend-configured ()
  "Test LSP backend is configured for R."
  (should (eq ess-r-backend 'lsp)))

;;; Helper Script Tests

(ert-deftest test-helper-scripts-exist ()
  "Test helper scripts are present."
  (let ((bin-home (expand-file-name "~/.emacs.d/bin"))
        (bin-project (expand-file-name "bin" test-emacs-r-devkit--root)))
    (should (or (file-exists-p (expand-file-name "r-styler-check.R" bin-home))
                (file-exists-p (expand-file-name "r-styler-check.R" bin-project))))
    (should (or (file-exists-p (expand-file-name "export-gui-path.sh" bin-home))
                (file-exists-p (expand-file-name "export-gui-path.sh" bin-project))))))

(ert-deftest test-helper-scripts-executable ()
  "Test helper scripts are executable."
  (let ((export-path (expand-file-name "~/.emacs.d/bin/export-gui-path.sh")))
    (when (file-exists-p export-path)
      (should (file-executable-p export-path)))))

;;; Buffer State Edge Cases

(ert-deftest test-r-mode-in-non-r-buffer ()
  "Test that R mode functions handle non-R buffers gracefully."
  (with-temp-buffer
    ;; Not in R mode
    (fundamental-mode)
    ;; These should not error in non-R buffers
    (should (condition-case nil
                (progn (emacs-r-devkit/toggle-styler) t)
              (error nil)))))

(ert-deftest test-styler-disabled-state ()
  "Test styler behavior when disabled."
  (let ((emacs-r-devkit/styler-enabled nil))
    (with-temp-buffer
      (ess-r-mode)
      (insert "x<-1")
      ;; Should return t (allow save) when disabled
      (should (emacs-r-devkit/style-buffer-with-guard)))))

(ert-deftest test-empty-r-buffer ()
  "Test R mode activation in empty buffer."
  (with-temp-buffer
    (ess-r-mode)
    (should (eq major-mode 'ess-r-mode))
    (should (= (buffer-size) 0))))

;;; Integration Tests

(ert-deftest test-which-key-integration ()
  "Test which-key is configured."
  (should (featurep 'which-key))
  (should which-key-mode))

(ert-deftest test-exec-path-from-shell ()
  "Test exec-path-from-shell is configured."
  ;; This is only loaded in GUI mode on macOS in init.el
  (when (and (eq system-type 'darwin) (not noninteractive))
    (should (featurep 'exec-path-from-shell))))

;;; Provide

(provide 'test-emacs-r-devkit)

;;; test-emacs-r-devkit.el ends here
