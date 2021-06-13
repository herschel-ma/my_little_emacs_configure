;;; init-go.el --- golang settings
;;; Commentary:
;;; code:
;(require 'lsp-mode)
(add-hook 'go-mode-hook #'lsp-deferred)
(defvar go--tools '("golang.org/x/tools/cmd/goimports"
		    "github.com/go-delve/delve/cmd/dlv"
		    "github.com/josharian/impl"
		    "github.com/cweill/gotests/..."
		    "github.com/fatih/gomodofiytags"
		    "github.com/davidrjenni/reftools/cmd/fillstruct")
  "Go tools may need.")

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
(add-hook 'go-mode-hook
          (lambda ()
            (setq indent-tabs-mode 1)
            (setq tab-width 2)))

(use-package go-mode
  :hook (go-mode . lsp-go-install-save-hooks)
  :config
  ;; go-fill-struct
  (use-package go-fill-struct)
  (use-package go-impl)
  (use-package go-gen-test)
  (use-package go-tag)
  (use-package go-rename))

(provide 'init-go)

;;; init-go.el ends here
