(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes '(deeper-blue))
 '(custom-safe-themes
   '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))
 '(package-selected-packages
   '(zenburn-theme which-key treemacs magit use-package company spacemacs-theme))
 '(spacemacs-theme-comment-bg nil)
 '(spacemacs-theme-comment-italic t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Do not show startup screen
(setq inhibit-startup-message t)

;; Disable tool bar, menu bar and scroll bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Highlight current line
(global-hl-line-mode t)

;; Set default directories
(setq default-directory "~/")
(setq command-line-default-directory "~/")

;; Macbook meta key config
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

;; Add MELPA to package archives
(require 'package)
(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'usepackage))

;; Load theme
(use-package zenburn-theme
  :ensure t
  :init
  (load-theme 'zenburn t))

;; Enable Complete Any (company)
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.3)
  (global-company-mode t))
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)  

;; Enable Magit
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

;; Enable treemacs
(use-package treemacs
  :ensure t
  :config
  (setq treemacs-is-never-other-window t)
  :bind
  (:map global-map
	("M-0" . treemacs-select-window)
	("C-x t t" . treemacs)
	("C-x t C-s" . treemacs-find-file)))  

;; Enable ido
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(ido-mode t)

;; Enable which key
(use-package which-key
  :ensure t
  :config (which-key-mode))
