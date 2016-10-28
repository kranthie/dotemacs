;;; References
;; http://pages.sachachua.com/.emacs.d/Sacha.html
;; http://aaronbedra.com/emacs.d/
;; https://www.mfoot.com/static/emacs-config/config.html
;; https://github.com/jonathanchu/dotemacs/blob/master/emacs-init.el

;;; Required libraries
(require 'cl)

;;; Personal info
(setq user-full-name "Kranthi Muppala"
      user-mail-address "")

;;; Package initialization
(package-initialize)
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
  ;(package-refresh-contents)
  )

;;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (setq use-package-verbose t)
  (setq use-package-always-ensure t)
  (require 'use-package))
(use-package diminish)

;;; Startup
(setq inhibit-splash-screen t
      initial-scratch-message nil)
(use-package fortune-cookie
  :config
  ;(setq fortune-cookie-cowsay-enable nil) ; Disable cowsay
  (fortune-cookie-mode)                   ; Enable fortune cookie mode
)

;;; Http Proxy
(setq url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|127.*\\)")
     ("http" . "proxy:8080")
     ("https" . "proxy:8080")))

;;; Interface
;; Hide all bars
(when window-system
  (progn
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (set-frame-font "Inconsolata 16")))
;; Theme
(use-package atom-one-dark-theme)
;; Smart mode line
(use-package smart-mode-line
  :config
  (progn 
    (setq sml/no-confirm-load-theme t)
    (setq sml/theme 'powerline)
    (sml/setup)))
;; Background
(set-background-color "black")
;; Fullscreen
(toggle-frame-fullscreen)
(global-set-key [(s return)] #'toggle-frame-fullscreen)
;; Line and column number
(column-number-mode 1)
(line-number-mode 1)
(size-indication-mode t)
;; Time
(display-time-mode 1)
;; Cursor
(setq-default cursor-type 'bar)
;; Anti aliasing
(setq mac-allow-anti-aliasing t)

;; Font size increase/decrease
(global-set-key (kbd "s-=") 'text-scale-increase)
(global-set-key (kbd "s--") 'text-scale-decrease)
(global-set-key (kbd "s-0") 'text-scale-adjust)
;; C-x C-0 restores the default font size

;;; Indicate empty lines
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;;; Parenthesis
(add-hook 'prog-mode-hook (lambda () (electric-pair-mode)))
(show-paren-mode)           ; Automatically highlight parenthesis pairs
(setq show-paren-delay 0) ; show the paren match immediately
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
)

;;; Text selection
(delete-selection-mode t)
(transient-mark-mode t)

;;; Undo-redo
(use-package undo-tree
  :diminish undo-tree-mode
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))

;;; Which key
(use-package which-key
  :defer t
  :diminish which-key-mode
  :init
  (setq which-key-idle-delay 2)
  (which-key-mode)
  (which-key-setup-side-window-right))

;;; Indentation
(setq tab-width 2
      indent-tabs-mode nil)
(use-package indent-guide
  :config
  (add-hook 'prog-mode-hook (lambda () (indent-guide-mode)))
  )

;;; System clipboard
(setq x-select-enable-clipboard t)

;;; Bell
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;;; Backup files and auto save files
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;;; Save history
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

;;; Yes and no
(defalias 'yes-or-no-p 'y-or-n-p)

;;; Winner mode - window configuration navigation
(use-package winner
  :defer t)

;;; Desktop save mode
(desktop-save-mode t)
(setq desktop-restore-eager 5)
(setq desktop-save t)

;;; Recentf
(use-package recentf
  :diminish
  :config
  (recentf-mode)
  :bind
  ("C-x C-r" . recentf-open-files))

;;; Projectile
(use-package projectile
  :config
  (projectile-global-mode))
(use-package ag)

;;; Project explorer
(use-package project-explorer
  :ensure t
  :config
  (setq pe/width 60))

;;; Helm
(use-package helm
  :init (progn
    (require 'helm-config)
    (use-package helm-projectile
      :commands helm-projectile)
    (use-package helm-ag)
    (helm-mode 1))
  :bind
  ("M-x" . helm-M-x)
  ("C-x b" . helm-mini)
  :config (setq projectile-completion-system 'helm))

;;; Yasnippet
(use-package yasnippet
  :config (yas-global-mode 1))

;;; Git
(use-package magit
  :config
  (global-set-key (kbd "C-x g") 'magit-status))
(use-package helm-git-grep
  :config
  (global-set-key (kbd "C-c g") 'helm-git-grep))

;;; Perforce
(use-package p4
  :ensure t)

;;; Scala
(use-package ensime
  :ensure t
  :pin melpa-stable)

;;; Tern
(use-package tern
  :ensure t
  :config
  (progn
    (require 'tern-auto-complete)
    (tern-ac-setup)))
(use-package tern-auto-complete
  :ensure t)

;;; Javascript
(use-package js2-mode
  :ensure t
  :init
    (add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
     (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
     (add-hook 'js-mode-hook 'js2-minor-mode)
     (setq js2-highlight-level 3)
     (require 'js)
     (define-key js-mode-map "{" 'paredit-open-curly)
     (define-key js-mode-map "}" 'paredit-close-curly-and-newline))
(use-package js2-refactor
  :ensure t)

;;; Java
(use-package jdee
  :ensure t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (atom-one-dark-theme which-key use-package undo-tree tern-auto-complete smart-mode-line-powerline-theme rainbow-delimiters project-explorer p4 neotree magit js2-refactor jdee indent-guide helm-projectile helm-git-grep helm-ag guide-key fortune-cookie ensime color-theme-sanityinc-tomorrow atom-dark-theme ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
