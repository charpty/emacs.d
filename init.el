;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                           ("melpa" . "http://elpa.emacs-china.org/melpa/")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("2a7beed4f24b15f77160118320123d699282cbf196e0089f113245d4b729ba5d" default))
 '(package-selected-packages
   '(modern-cpp-font-lock multiple-cursors smartparens irony-eldoc flycheck company irony ample-zen-theme clang-format helm-projectile projectile magit helm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x b") #'helm-buffers-list)
;(setq helm-ff-auto-update-initial-value nil)
(menu-bar-mode -1)
(with-eval-after-load 'helm
  (define-key helm-map (kbd "TAB") #'helm-execute-persistent-action)
  (define-key helm-map (kbd "<tab>") #'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") #'helm-select-action))

(helm-mode 1)


(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-c t") 'ff-get-other-file)

(load-theme 'ample-zen t)

;; irony-mode
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)

(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; company mode
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)

;; flycheck-mode
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)
(eval-after-load 'flycheck
'(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;; eldoc-mode
(add-hook 'irony-mode-hook 'irony-eldoc)

(require 'smartparens-config)
(add-hook 'c++-mode-hook 'smartparens-mode)
(add-hook 'c-mode-hook 'smartparens-mode)

(require 'clang-format)
(global-set-key [C-M-tab] 'clang-format-region)
(fset 'c-indent-region 'clang-format-region)
(global-set-key (kbd "C-c i") 'clang-format-region)

(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
(setq c-default-style "linux"
      c-basic-offset 4)
;((multiple-cursors-detect) (kbd "C-c u") 'clang-format-buffer)

(require 'modern-cpp-font-lock)
(modern-c++-font-lock-global-mode t)
