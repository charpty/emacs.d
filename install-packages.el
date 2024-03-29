
;;; Code:
(defvar package-list '(helm
		       projectile
                       helm-projectile
		       magit
		       ample-zen-theme
		       company
		       flycheck
		       smartparens
		       clang-format
		       modern-cpp-font-lock))

(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

; activate all the packages (in particular autoloads)
(unless package--initialized (package-initialize t))

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(provide 'install-packages)
;;; install-packages ends here
