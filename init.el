
(require 'package)

;;; Code:
(global-set-key (kbd "C-c C-c M-x") #'execute-extended-command)

(defvar install-packages-el "install-packages.el")
(defvar current-conf-dir (file-name-directory load-file-name))
(ignore-errors (load-file (expand-file-name install-packages-el current-conf-dir)))

(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))
(unless package--initialized (package-initialize t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("2a7beed4f24b15f77160118320123d699282cbf196e0089f113245d4b729ba5d" default))
 '(helm-completion-style 'emacs)
 '(package-selected-packages
   '(elisp-format modern-cpp-font-lock multiple-cursors smartparens irony-eldoc company irony clang-format helm-projectile projectile magit helm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'smartparens-config)
;; Always start smartparens mode in js-mode.
(add-hook 'c++-mode-hook 'smartparens-mode)
(add-hook 'c-mode-hook 'smartparens-mode)
(global-set-key (kbd "M-p") #'sp-backward-sexp)
(global-set-key (kbd "M-n") #'sp-forward-sexp)
(global-set-key (kbd "C-c w") #'sp-copy-sexp)
(setq sp-escape-quotes-after-insert nil)
(smartparens-global-mode 1)
(show-smartparens-global-mode 1)
(electric-pair-mode t)

(setq grep-command "grep -nH --exclude-dir=test/ --exclude-dir=build/ --exclude-dir=testlib/ -R -e ")

(menu-bar-mode -1)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x b") #'helm-buffers-list)
(global-set-key (kbd "C-x C-o") #'helm-occur)
(setq helm-buffer-max-length 50)
(setq helm-buffers-fuzzy-matching t)
; set helm always show buffer at the bottom
(setq helm-always-two-windows nil)
(setq helm-display-buffer-default-height 23)
(setq helm-ff-DEL-up-one-level-maybe t)
(setq helm-default-display-buffer-functions '(display-buffer-in-side-window))
(with-eval-after-load 'helm (define-key helm-map (kbd "TAB") #'helm-execute-persistent-action)
                      (define-key helm-map (kbd "<tab>") #'helm-execute-persistent-action)
                      (define-key helm-map (kbd "C-z") #'helm-select-action))

(helm-mode 1)

(setq projectile-globally-ignored-files '("*.tgz" "*.tar" "*dblite" "*.pdf"))
(setq projectile-globally-ignored-directories '("testdata" "logs"))

(global-set-key (kbd "C-x p f") #'helm-projectile-find-file-dwim)
(global-set-key (kbd "C-x p g") #'helm-projectile-grep)

(global-set-key (kbd "C-x TAB") #'helm-imenu)
(defvar cc-imenu-el "cc-imenu.el")
(load-file (expand-file-name cc-imenu-el current-conf-dir))

;; magit
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-c t") 'ff-get-other-file)

(defvar my-theme-el "my-theme.el")
(cond ((file-exists-p (expand-file-name my-theme-el current-conf-dir))
       (load-file (expand-file-name my-theme-el current-conf-dir)))
       (t (load-theme 'ample-zen t)))

;; company mode
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)

;; flycheck
(require 'flycheck)
; Disable clang check, gcc check works better
(setq-default flycheck-disabled-checkers (append flycheck-disabled-checkers '(c/c++-clang)))
; Enable C++11 support for gcc
(add-hook 'c++-mode-hook (lambda ()
                           (setq flycheck-gcc-language-standard "c++11")))
(setq flycheck-highlighting-mode 'lines)
(global-flycheck-mode)

;; clang-format
(require 'clang-format)
(global-set-key [C-M-tab] 'clang-format-region)
(fset 'c-indent-region 'clang-format-region)
(global-set-key (kbd "C-c i") 'clang-format-region)
(global-set-key (kbd "C-c u") 'clang-format-buffer)

(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
(setq c-default-style "linux" c-basic-offset 4)

(require 'modern-cpp-font-lock)
(modern-c++-font-lock-global-mode t)

;; set this to prevent emacs from broken hard link
(setq auto-save-default nil)
(setq make-backup-files nil)

;; custom keymap
(global-set-key (kbd "C-@") 'set-mark-command)

;; custom functions
(defun re-compile()
  (interactive)
  (save-some-buffers t)
  (switch-to-buffer-other-window "*compilation*")
  (compile compile-command))

(global-set-key [f6] 're-compile)

(provide 'init)
;;; init ends here
