;;; init-const.el ---  justify os
;;; Commentary:
;; 操作系统判断
;; 设置常量
;;; Code:

(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-linux* (eq system-type 'gnu/linux))
(defconst *is-windows* (or (eq system-type 'ms-dos) (eq system-type 'windows-nt)))

(provide 'init-const)

;;; init-const.el ends here
