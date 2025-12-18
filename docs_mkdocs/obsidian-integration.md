# Obsidian Research Lab Integration

The **emacs-r-devkit** is designed to work seamlessly with the **Obsidian CLI Ops** (`obs`) tool, creating a powerful "Lab Notebook" workflow. This integration allows you to push results from your R environment directly into your permanent Knowledge Base.

## Prerequisites

1.  **Obsidian CLI Ops**: You must have the `obs` CLI installed.
    *   [Installation Guide](https://data-wise.github.io/obsidian-cli-ops/installation/)
2.  **Federated Vault**: Your Obsidian vault should be structured with a `Research_Lab` folder (standard in the Data-Wise ecosystem).

## The Workflow

The core philosophy is simple: **Emacs is for Computation, Obsidian is for Memory.**

| Activity | Tool |
| :--- | :--- |
| Writing Code | Emacs (ESS) |
| Running Simulations | R |
| **Archiving Plots** | **obs log** |
| **Drafting Vignettes** | **obs draft** |
| **Checking Math** | **obs context** |

## Emacs Configuration

Add the following Elisp functions to your `init.el` or `config.el` to expose the `obs` CLI powers directly inside Emacs.

```elisp
(defgroup obsidian-ops nil
  "Settings for Obsidian CLI Ops integration."
  :group 'tools)

(defun obs-r-link-project (obsidian-path)
  "Link the current R project to a specific Obsidian folder."
  (interactive "sObsidian Folder Path (e.g., Research_Lab/MyProject): ")
  (shell-command (format "obs r-dev link \"%s\"" obsidian-path))
  (message "Linked current project to %s" obsidian-path))

(defun obs-log-file (file description)
  "Log a specific file to the Obsidian Lab Notebook (06_Analysis)."
  (interactive "fFile to log: \nsDescription: ")
  (let ((cmd (format "obs r-dev log \"%s\" -m \"%s\""
                     (expand-file-name file)
                     description)))
    (shell-command cmd)
    (message "Logged %s to Obsidian." (file-name-nondirectory file))))

(defun obs-fetch-theory (term)
  "Search the Knowledge Base for a theoretical concept and display it."
  (interactive "sSearch Concept: ")
  (let ((result (shell-command-to-string (format "obs r-dev context \"%s\"" term))))
    (with-current-buffer (get-buffer-create "*Obsidian Context*")
      (erase-buffer)
      (insert result)
      (markdown-mode)
      (display-buffer (current-buffer)))))

;; Keybindings
(global-set-key (kbd "C-c o l") 'obs-r-link-project)
(global-set-key (kbd "C-c o f") 'obs-log-file)
(global-set-key (kbd "C-c o t") 'obs-fetch-theory)
```bash

## Common Use Cases

### 1. Saving a Plot
After generating a plot in R:

1.  Save it: `ggsave("results/simulation_v1.png")`
2.  In Emacs: `M-x obs-log-file` -> Select `results/simulation_v1.png` -> Desc: "Run with n=500"
3.  **Result:** The file is copied to your Obsidian project's `06_Analysis` folder, timestamped and safe.

### 2. Checking Formulas
You are writing a function for the **Sobel Test** and forget the standard error formula.

1.  In Emacs: `C-c o t` (or `M-x obs-fetch-theory`)
2.  Type: "Sobel Standard Error"
3.  **Result:** A buffer opens showing the relevant Markdown snippet from your `Knowledge_Base`, complete with LaTeX formulas.

### 3. Drafting Documentation
You want to write the prose for your package vignette in Obsidian's distraction-free editor.

1.  Create draft in R: `usethis::use_vignette("intro")`
2.  Run in terminal (or shell-command): `obs r-dev draft vignettes/intro.Rmd`
3.  **Result:** The file appears in `Research_Lab/.../02_Drafts`. You write there. When done, you copy it back (or use `rsync`).

