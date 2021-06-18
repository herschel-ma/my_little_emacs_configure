;;;; init-startup --- startup settings items
;;; Commentary:
;; 设置以下系统编码，虽然现在就不报错
;;; Code:
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;; 设置垃圾回收阈值，减少垃圾回收次数，提高启动速度
(setq gc-cons-threshold most-positive-fixnum)


;; 关闭工具栏, tool-bar-mode 即为一个 minor mode
(tool-bar-mode -1)

;; 关闭文件滑动控件
(scroll-bar-mode -1)

;; 关闭菜单栏
(menu-bar-mode -1)
(set-fringe-mode 10)        ; Give some breathing room
;; 禁用自动生成备份文件
(setq-default make-backup-files nil)

;; 设置打开默认全屏
(setq initial-frame-alist (quote ((fullscreen . maximized))))

(provide 'init-startup)
;;; init-startup ends here
