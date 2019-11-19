; list the packages
(setq package-list '(helm 
		     projectile 
		     magit
		     ample-zen-theme
		     irony
		     company
		     flycheck
		     irony-eldoc
		     smartparens
		     clang-format
		     modern-cpp-font-lock))

(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
