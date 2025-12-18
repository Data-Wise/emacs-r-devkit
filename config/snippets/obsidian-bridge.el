;;; obsidian-bridge.el --- Obsidian Research Lab Integration -*- lexical-binding: t; -*-

;; Copyright (C) 2025 Data-Wise
;; Author: Data-Wise
;; Version: 1.0
;; Package-Requires: ((emacs "26.1"))
;; Keywords: tools, obsidian, research

;;; Commentary:
;; This module integrates Emacs/ESS with the 'obs' CLI tool to enable a
;; "Lab Notebook" workflow. It allows linking R projects to Obsidian folders,
;; logging artifacts (plots, html), and fetching theoretical context.

;;; Code:

(defgroup obsidian-ops nil
  "Settings for Obsidian CLI Ops integration."
  :group 'tools)

(defcustom obsidian-ops-cli-command "obs"
  "Name or path of the Obsidian CLI command."
  :type 'string
  :group 'obsidian-ops)

;;;###autoload
(defun obs-r-link-project (obsidian-path)
  "Link the current R project to a specific Obsidian folder.
OBSIDIAN-PATH should be relative to your Vault Root (e.g., 'Research_Lab/MyProject')."
  (interactive "sObsidian Folder Path (e.g., Research_Lab/MyProject): ")
  (let ((default-directory (project-root (project-current))))
    (if (not default-directory)
        (error "Not inside a recognized project")
      (shell-command (format "%s r-dev link \"%s\"" obsidian-ops-cli-command obsidian-path))
      (message "Linked current project to %s" obsidian-path))))

;;;###autoload
(defun obs-log-file (file description)
  "Log a specific FILE to the Obsidian Lab Notebook (06_Analysis) with DESCRIPTION.
Useful for saving plots, simulation results, or reports."
  (interactive "fFile to log: 
sDescription: ")
  (let ((cmd (format "%s r-dev log \"%s\" -m \"%s\""
                     obsidian-ops-cli-command
                     (expand-file-name file)
                     description)))
    (shell-command cmd)
    (message "Logged %s to Obsidian." (file-name-nondirectory file))))

;;;###autoload
(defun obs-fetch-theory (term)
  "Search the Knowledge Base for a theoretical concept (TERM) and display it.
Uses the 'obs r-dev context' command."
  (interactive "sSearch Concept: ")
  (let ((result (shell-command-to-string (format "%s r-dev context \"%s\"" obsidian-ops-cli-command term))))
    (with-current-buffer (get-buffer-create "*Obsidian Context*")
      (erase-buffer)
      (insert result)
      (markdown-mode)
      (display-buffer (current-buffer)))))

;;;###autoload
(defun obs-sync-draft (file)
  "Push a FILE (vignette/Rmd) to Obsidian (02_Drafts) for editing."
  (interactive "fDraft File: ")
  (shell-command (format "%s r-dev draft \"%s\"" obsidian-ops-cli-command (expand-file-name file)))
  (message "Synced draft to Obsidian."))

(provide 'obsidian-bridge)
;;; obsidian-bridge.el ends here
