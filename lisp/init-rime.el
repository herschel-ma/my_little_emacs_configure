;;; init-rime.el --- settings for emacs rime
;;; Commentary:
;;; Code:
;; 输入法
(require 'rime)
;; 设置加载用户安装路径
(setq rime-user-data-dir "~/.config/ibus/rime")
;; 设置默认输入法为rime, 使用postframe 将提示设置在光标处
(setq-default default-input-method "rime"
	      rime-show-candidate 'posframe)
(setq rime-posframe-properties
      (list :background-color "#2D3DA8"
            :foreground-color "#dcdccc"
            :internal-border-width 1))

(setq rime-cursor "˰")
;; 探针函数，自动切换中英文输入的场景
(setq rime-disable-predicates
      '(rime-predicate-evil-mode-p ;; 普通模式下用英文
        rime-predicate-after-alphabet-char-p ;; 英文字母后英文
        rime-predicate-prog-in-code-p)) ;; 编程中除了注释等用英文
;; 状态栏提示是否进入中文模式
(setq-default mode-line-mule-info '((:eval (rime-lighter))))
(provide 'init-rime)
;;; init-rime.el ends here
