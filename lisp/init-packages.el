;;; init-packages.el --- Settings for packages
;;; commentary:
;;; code:
(use-package restart-emacs)
(use-package benchmark-init
  :init (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate))

;; use-> M-x benchmark-init/show-durations-tree
;; or
;; M-x benchmark-init/show-durations-tabulated

(use-package crux
  ;; delete current line
  :bind (("C-c k" . crux-smart-kill-line)
  ;;优化版的回到行首
  ;;快速打开Emacs配置文件
  ;;快速连接两行等
  ("C-c ^" . crux-top-join-line)
  ("C-x ," . crux-find-user-init-file)))

(use-package hungry-delete
  ;; delete continus blank
  :bind (("C-c DEL" . hungry-delete-backward)
	 ("C-c d" . hungry-delete-forward)))
;; 文本编辑之行/块上下移动
(use-package drag-stuff
  :bind (("<M-up>". drag-stuff-up)
         ("<M-down>" . drag-stuff-down)))

;; 原生搜索替换 C-s C-r M-%
;; 三剑客强化搜索，改善 Minibuffer
(use-package ivy
  :defer 1
  :demand
  :hook (after-init . ivy-mode)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-initial-inputs-alist nil
        ivy-count-format "%d/%d "
        enable-recursive-minibuffers t
        ivy-re-builders-alist '((t . ivy--regex-ignore-order))))

(use-package counsel
  :after (ivy)
  :bind (;("M-x" .  execute-extended-command)
	 ("C-x C-f" . counsel-find-file)
         ("C-c f" . counsel-recentf)
         ("C-c g" . counsel-git)))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper-isearch-backward))
  :config (setq swiper-action-recenter t
                swiper-include-line-number-in-search t))

;; complete
(use-package company
  :config
  (setq company-dabbrev-code-everywhere t
        company-dabbrev-code-modes t
        company-dabbrev-code-other-buffers 'all
        company-dabbrev-downcase nil
        company-dabbrev-ignore-case t
        company-dabbrev-other-buffers 'all
        company-require-match nil
        company-minimum-prefix-length 2
        company-show-numbers t
        company-tooltip-limit 20
        company-idle-delay 0
        company-echo-delay 0
        company-tooltip-offset-display 'scrollbar
        company-begin-commands '(self-insert-command))
  (push '(company-semantic :with company-yasnippet) company-backends)
  :hook ((after-init . global-company-mode)))

;; company go
(use-package company-go
  :config
  ;; possible improvements
  (setq company-tooltip-limit 20)
  (setq company-idle-delay .3)
  (setq company-echo-delay 0)
  (setq company-begin-commands '(self-insert-command)))
;; Only use company-mode with company-go in go-mode
(add-hook 'go-mode-hook (lambda ()
			  (set (make-local-variable 'company-backends) '(company-go))
			  (company-mode)))

;; syntax check
(use-package flycheck
  :hook (after-init . global-flycheck-mode))
;; 行排序 M-x sort-lines
;; 交换字符 C-t 交换单词 M-t

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; 窗口管理之MiniBuffer交互优化
(use-package ivy-posframe
  :init
  (setq ivy-posframe-display-functions-alist
    '((swiper . ivy-posframe-display-at-frame-center)
      (complete-symbol . ivy-posframe-display-at-point)
      (counsel-M-x . ivy-posframe-display-at-frame-center)
      (counsel-find-file . ivy-posframe-display-at-frame-center)
      (ivy-switch-buffer . ivy-posframe-display-at-frame-center)
      (t . ivy-posframe-display)))
  (ivy-posframe-mode 1))


;; command log mode
;; usage -> clm/toggle-command-log-buffer
(use-package command-log-mode)

;; smex is a M-x enhancement for Emacs
(use-package smex
  :config
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; This is your old M-x
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command))
;; (require 'smex)
(smex-initialize)
;; modified smex that typing a space will insert a hyphen '-'
(defadvice smex (around space-inserts-hyphen activate compile)
  (let ((ido-cannot-complete-command
	 `(lambda ()
	    (interactive)
	    (if (string == " "(this-command-keys))
		(insert ?-)
	      (funcall, ido-cannot-complete-command)))))
  ad-do-it))
;; update less often
;; I don't like have smex update everytime I run (auto-update is usually go enough, and is noticeably faster).
;; But It's annoying when I manually load a file and the new commands are not in smex.
;; So I add a smex-update to after-load-functions.
(defun smex-update-after-load (unused)
  (when (boundp 'smex-cache)
  (smex-update)))
(add-hook 'after-load-functions 'smex-update-after-load)
;; using acronyms(缩写)
(defadvice ido-set-matches-1 (around ido-smex-acronym-matches activate)
  "Filters ITEMS by setting acronynms first."
  (if (and (fboundp 'smex-already-running) (smex-already-running) (> (length ido-text) 1))

      ;; We use a hash table for the matches, <type> => <list of items>, where
      ;; <type> can be one of (e.g. `ido-text' is "ff"):
      ;; - strict: strict acronym match (i.e. "^f[^-]*-f[^-]*$");
      ;; - relaxed: for relaxed match (i.e. "^f[^-]*-f[^-]*");
      ;; - start: the text start with (i.e. "^ff.*");
      ;; - contains: the text contains (i.e. ".*ff.*");
      (let ((regex (concat "^" (mapconcat 'char-to-string ido-text "[^-]*-")))
            (matches (make-hash-table :test 'eq)))

        ;; Filtering
        (dolist (item items)
          (let ((key))
            (cond
             ;; strict match
             ((string-match (concat regex "[^-]*$") item)
              (setq key 'strict))

             ;; relaxed match
             ((string-match regex item)
              (setq key 'relaxed))

             ;; text that start with ido-text
             ((string-match (concat "^" ido-text) item)
              (setq key 'start))

             ;; text that contains ido-text
             ((string-match ido-text item)
              (setq key 'contains)))

            (when key
              ;; We have a winner! Update its list.
              (let ((list (gethash key matches ())))
                (puthash key (push item list) matches)))))

        ;; Finally, we can order and return the results
        (setq ad-return-value (append (gethash 'strict matches)
                                      (gethash 'relaxed matches)
                                      (gethash 'start matches)
                                      (gethash 'contains matches))))

    ;; ...else, run the original ido-set-matches-1
    ad-do-it))

;; doom-themes to list some themes to choose.
(use-package doom-themes
  :ensure t
  :config
  ;;Global settings (defaults)
  (setq doom-themes-enable-bold t ; if nil bold is universally disabled
	doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-nord-light t)
  ;; enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; corrects (and improves) org-mode's native fontification
  (doom-themes-org-config))

;; sdcv to translate word
;; expand path where to load dict
(defvar herschel-emacs-sdcv-data-dir
  "~/.stardict/dic")
(use-package sdcv
  :config
  (setq sdcv-dictionary-simple-list
	'(
	  "KDic11万英汉词典"
	  "朗道英汉字典5.0"
	  "朗道汉英字典5.0"))
  (setq sdcv-dictionary-complete-list      ;; a complete dictionary list
        '("KDic11万英汉词典"
          "朗道英汉字典5.0"
          "朗道汉英字典5.0"
          "英汉汉英专业词典"
          "中国大百科全书2.0版"
	  "CET4"
	  "CET6"
	  "CEDICT汉英辞典"
	  "计算机词汇"
	  "21世纪双语科技词典"
          ))
  (setq sdcv-dictionary-data-dir herschel-emacs-sdcv-data-dir) ;设置星际译王本地词典的目录
)
(require 'company-english-helper)
(toggle-company-english-helper)

;; Rainbow delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; ox-hugo
(use-package ox-hugo
  :ensure t            ;Auto-install the package from Melpa (optional)
  :after ox)

(use-package yasnippet
  :config
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets"))
  :hook (after-init . yas-global-mode))

(use-package magit
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; NOTE: Make sure to configure a GitHub token before using this package!
;; - https://magit.vc/manual/forge/Token-Creation.html#Token-Creation
;; - https://magit.vc/manual/ghub/Getting-Started.html#Getting-Started
(use-package forge
  :after magit)
;; games :)
;; builtin gomoku
(use-package minesweeper)
(use-package pacmacs)
(use-package fireplace)
(provide 'init-packages)

;;; init-packages.el ends here
