;;; init.el --- Settings entrance
;;; commentary:
;;; code:
;; 设置加载的目标目录到load-path中(将lisp目录加载到加载路径中)
(add-to-list 'load-path
	     (expand-file-name (concat user-emacs-directory "lisp"))
	     (expand-file-name (concat user-emacs-directory "lisp/emacs-rime")))

;; 设置自定义配置的配置文件
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'init-const)
(require 'init-startup)
(require 'init-elpa)
(require 'init-packages)
(require 'init-ui)
(require 'init-lsp-mode)
(require 'init-python)
(require 'init-go)
(require 'init-pair)
(require 'init-meow)
(require 'init-rime)
(require 'insert-translated-name)
(require 'init-functions)
(require 'init-kbd)
;; (require 'init-org)

;;; init.el ends here
