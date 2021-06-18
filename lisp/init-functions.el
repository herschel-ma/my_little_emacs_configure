;;; init-functions.el --- defines many functions which may be used at sometime
;;; Commentary:
;;; =======functions======
;;; Code:
;;; 打开init.el
(defun open-init-file ()
  "Open init.el."
  (interactive)
  (counsel-find-file "~/.emacs.d/init.el"))


(global-set-key (kbd "<f1>") 'open-init-file)

(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(defun remove-dos-eol ()
  "Replace Dos eolns CR LF with UNIX CR."
  (interactive)
  ;; let ponter go to the buffer's begin char
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

(provide 'init-functions)
;;; init-functions.el ends here
