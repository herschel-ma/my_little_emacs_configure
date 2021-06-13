;;; init-ui.el --- to be prefer putty
;;; Commentary:
;;; ui 启动配置项
;;; Code:

;; (setq-default cursor-type 'bar)

;; 关闭启动帮助页面
(setq inhibit-splash-screen 1)

;; gruvbox-dark-soft-theme
;(use-package monokai-theme
;:init (load-theme 'monokai t))
(load-theme 'tango t)
(require 'all-the-icons)
(use-package smart-mode-line
  :init
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'respectful)
  (sml/setup))

;; (use-package doom-modeline
;;   :ensure t
;;   :config
;;   (setq doom-modeline-bar-width 4)
;;   (setq doom-modeline-buffer-state-icon

;;    :hook (after-init . doom-modeline-mode))
;; 通过修改字体解决windows上emacs的卡顿
(use-package emacs
 :if (display-graphic-p)
  :config
  ;; font settings
  (if *is-windows*
      (progn
	(set-face-attribute 'default nil :font "Microsoft Mono 9")
	(dolist (charset '(kana han symbol cjk-misc bopomofo))
	  (set-fontset-font (frame-parameter nil 'font)
			    charset (font-spec :family "Microsoft Yahei Mono" :size 12))))
  ;; 更改字体大小 16pt
  (set-face-attribute 'default nil :height 160)))

;; 显示行号
(use-package emacs
    :unless *is-windows*
    :config
    (setq display-line-numbers-type 'relative)
    (global-display-line-numbers-mode t))

;; 显示匹配括号
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

(provide 'init-ui)

;;; init-ui ends here
