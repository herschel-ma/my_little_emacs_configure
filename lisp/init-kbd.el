;; 将 macOS 上的 Command 映射为 Meta
(when *is-mac*
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none))

;; yes or no
(defalias 'yes-or-no-p 'y-or-n-p)
(provide 'init-kbd)
