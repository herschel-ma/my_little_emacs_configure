;;; init-kbd --- binding keyboard for something
;;; Commentary:
;;; it's customize key bind mapping
;;; Code:

;; 将 macOS 上的 Command 映射为 Meta
(when *is-mac*
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none))

;; yes or no
(defalias 'yes-or-no-p 'y-or-n-p)

;; invoke translate for cursor surrounded word
(global-set-key [mouse-3] 'sdcv-search-pointer+);;鼠标右键
;; 激活输入中文翻译成英文模式
(global-set-key (kbd "<f5>") 'insert-translated-name-insert)

(provide 'init-kbd)

;;; init-kbd ends here
