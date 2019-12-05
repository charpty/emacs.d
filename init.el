
(require 'package)

;;; Code:
(global-set-key (kbd "C-c C-c M-x") #'execute-extended-command)

;; (load "~/.emacs.d/install-packages.el")
(defvar install-packages-script "install-packages.el")
(ignore-errors (load-file (expand-file-name install-packages-script (file-name-directory load-file-name))))

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
(global-set-key (kbd "M-p") #'sp-down-sexp)
(global-set-key (kbd "M-n") #'sp-up-sexp)
(setq sp-escape-quotes-after-insert nil)
(electric-pair-mode t)

(setq grep-command "grep -nH --exclude-dir=test/ --exclude-dir=build/ --exclude-dir=testlib/ -R -e ")

(menu-bar-mode -1)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x b") #'helm-buffers-list)
(global-set-key (kbd "C-x p f") #'helm-projectile-find-file-dwim)
(global-set-key (kbd "C-x p g") #'helm-projectile-grep)
; set helm always show buffer at the bottom
(setq helm-always-two-windows nil)
(setq helm-display-buffer-default-height 23)
(setq helm-default-display-buffer-functions '(display-buffer-in-side-window))
(with-eval-after-load 'helm (define-key helm-map (kbd "TAB") #'helm-execute-persistent-action)
                      (define-key helm-map (kbd "<tab>") #'helm-execute-persistent-action)
                      (define-key helm-map (kbd "C-z") #'helm-select-action))

(helm-mode 1)

;; magit
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-c t") 'ff-get-other-file)

;; theme
(load-theme 'spacemacs-dark t)

;; irony-mode
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)

(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; company mode
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)

;; eldoc-mode
(add-hook 'irony-mode-hook 'irony-eldoc)

;; flycheck
(require 'flycheck)
; Disable clang check, gcc check works better
(setq-default flycheck-disabled-checkers (append flycheck-disabled-checkers '(c/c++-clang)))
; Enable C++11 support for gcc
(add-hook 'c++-mode-hook (lambda ()
                           (setq flycheck-gcc-language-standard "c++11")))
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

(provide 'init)
;;; init ends here
