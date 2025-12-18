;;; test-emacs-r-devkit.el --- Tests for emacs-r-devkit -*- lexical-binding: t; -*-

;;; Commentary:
;; Unit tests for emacs-r-devkit custom functions and configurations

;;; Code:

(require 'ert)
(require 'ess-r-mode)

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
  (should (fboundp 'emacs-r-devkit/insert-s7-class))
  (should (fboundp 'emacs-r-devkit/insert-s7-method))
  (should (fboundp 'emacs-r-devkit/insert-s7-generic)))

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
  (let ((bin-dir (expand-file-name "~/.emacs.d/bin")))
    (should (file-exists-p (expand-file-name "r-styler-check.R" bin-dir)))
    (should (file-exists-p (expand-file-name "export-gui-path.sh" bin-dir)))))

(ert-deftest test-helper-scripts-executable ()
  "Test helper scripts are executable."
  (let ((export-path (expand-file-name "~/.emacs.d/bin/export-gui-path.sh")))
    (when (file-exists-p export-path)
      (should (file-executable-p export-path)))))

;;; Integration Tests

(ert-deftest test-which-key-integration ()
  "Test which-key is configured."
  (should (featurep 'which-key))
  (should which-key-mode))

(ert-deftest test-exec-path-from-shell ()
  "Test exec-path-from-shell is configured."
  (should (featurep 'exec-path-from-shell)))

;;; Provide

(provide 'test-emacs-r-devkit)

;;; test-emacs-r-devkit.el ends here
