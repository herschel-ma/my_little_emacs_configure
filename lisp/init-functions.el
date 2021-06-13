;;; init-functions.el --- defines many functions which may be used at sometime
;;; Commentary:
;;; =======functions======
;;; Code:
;;; 打开init.el
(defun open-init-file ()
  (interactive)
  (counsel-find-file "~/.emacs.d/init.el"))


(global-set-key (kbd "<f1>") 'open-init-file)


(provide 'init-functions)
;;; init-functions.el ends here
