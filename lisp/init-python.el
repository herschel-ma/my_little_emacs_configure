;;; init-python.el --- Python settings
;;; Commentary:
;;; herschel copys Cabins, github.com/cabins/.emacs.d
;;; Code:

(defvar python-tools '("python-language-server[all]"
		       "python-lsp-server"
		       "black"
		       "isort")
  "Moudles for Python development.")

(setq-default python-indent-offset 4
	      python-indent-guess-indent-offset-verbose nil)

;; use black to format the Python code
(use-package blacken
  :hook ((python-mode . blacken-mode)))
;; sort the python imports
(use-package py-isort
  :init (setq python-sort-imports-on-save t))

(provide 'init-python)
;;; init-python.el ends here
