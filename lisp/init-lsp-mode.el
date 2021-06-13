;;; init-lsp-mode.el --- Settings for lsp-mode
;;; commentary:
;;; code:
(use-package lsp-mode
  ;; add prog-mode to lsp instead of adding one by one
  ;; :hook ((prog-mode . (lsp-deferred))
  :commands (lsp lsp-deferred)
  :hook (
	 (go-mode . lsp-deferred)
	 (python-mode . lsp-deferred)
	
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :init (setq lsp-keep-workspace-alive nil ;; Auto kill LSP server
	      lsp-gopls-use-placeholders nil
              lsp-enable-indentation t
              lsp-enable-on-type-formatting t
              lsp-auto-guess-root t
              lsp-enable-snippet t
              lsp-prefer-flymake t
              lsp-prefer-capf t
              lsp-modeline-diagnostics-enable t
              lsp-modeline-diagnostics-scope :workspace ;; workspace/global/file
              lsp-idle-delay 0.500
              read-process-output-max (* 1024 1024) ;; 1MB
              lsp-completion-provider :capf)
  :config
  ;; Configure LSP Clients
  (use-package lsp-clients
    :ensure nil
    :functions (lsp-format-buffer lsp-organize-imports)))

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
    :config
    (which-key-mode))


(provide 'init-lsp-mode)
;;; init-lsp-mode.el ends here
