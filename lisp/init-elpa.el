;; ===========
;; 更改软件源
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			 ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))
(package-initialize)

;; 不要检查签名
(setq package-check-signature nil)

;; 初始化包管理器
(unless (bound-and-true-p package--initialized)
  (package-initialize))

;; 刷新软件源
(unless package-archive-contents
  (package-refresh-contents))

;; 安装 use-package 包
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; 使用use-package管理扩展
;; 建议添加的配置
(eval-and-compile
  (setq use-package-always-ensure t) ;不用每个包都手动添加 :ensure t关键字
  (setq use-package-always-defer t) ;不用每个包都手动添加 :defer t 关键字,默认都是延迟加载
  (setq use-package-always-demand nil)
  (setq use-package-expand-minimally t)
  (setq use-package-verbose t))

;; 使用包管理器
(require 'use-package)

;; 常用的格式
;(use-package smooth-scrolling
;	     :ensure t ;; 是否一定要确保安装
;	     :defer nil ;; 是否要延迟加载
;	     :init (setq smooth-scrolling-margin 2) ;; 初始化参数
;	     :config (smooth-scrolling-mode t) ;; 基本配置参数
;	     :bind ;; 快捷键的绑定
;	     :hook) ;; hook模式的绑定

(provide 'init-elpa)
