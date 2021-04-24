;;; package --- Summary
;; Duy's .emacs config file

;;; Commentary:
;; Includes setup for Magit, Python and Anaconda (amongst others)

;;; Code:

;; Do not show startup screen
(setq inhibit-startup-message t)

;; Disable tool bar, menu bar and scroll bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Highlight current line
(global-hl-line-mode t)
;; Enable line numbers
(global-display-line-numbers-mode t)

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

(use-package blackout
  :ensure t
  :blackout eldoc-mode)

;; Load theme
(use-package zenburn-theme
  :ensure t
  :init
  (load-theme 'zenburn t))

;; Enable Complete Any (company)
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.1)
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
  (add-hook 'treemacs-mode-hook (lambda() (display-line-numbers-mode -1)))
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
  :config (which-key-mode)
  :blackout which-key-mode)

;; Setup conda
(use-package conda
  :ensure t
  :config (progn
	    (conda-env-initialize-interactive-shells)
	    (conda-env-initialize-eshell)
	    (setq conda-anaconda-home (getenv "CONDA_PREFIX"))
	    (setq conda-env-home-directory (getenv "CONDA_PREFIX"))
	    (conda-env-autoactivate-mode t)))


;; Company anaconda for auto completion
(use-package company-anaconda
  :ensure t
  :config
  (add-to-list 'company-backends #'company-anaconda))

;; Enable flycheck
(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; Enable blacken
(use-package blacken
  :ensure t
  :config
  (setq blacken-line-length 79))

;; Enable anaconda-mode and apply flycheck and blacken on save
(use-package anaconda-mode
  :ensure t
  :config
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
  (add-hook 'python-mode-hook 'blacken-mode)
  (add-hook 'python-mode-hook 'flycheck-mode)
  )

(use-package smartparens
  :ensure t
  :blackout smartparens-mode
  :config (progn
            (require 'smartparens-config)
            (require 'smartparens-latex)
            (require 'smartparens-html)
            (require 'smartparens-python)
            (smartparens-global-mode t)
            (setq sp-autodelete-wrap t)
            (setq sp-cancel-autoskip-on-backward-movement nil)

            (setq-default sp-autoskip-closing-pair t)))

(use-package winum
  :ensure t
  :init (setq winum-keymap
              (let ((map (make-sparse-keymap)))
                ;; (bind-key "M-0" #'winum-select-window-0-or-10 map)
                (bind-key "M-1" #'winum-select-window-1 map)
                (bind-key "M-2" #'winum-select-window-2 map)
                (bind-key "M-3" #'winum-select-window-3 map)
                (bind-key "M-4" #'winum-select-window-4 map)
                (bind-key "M-5" #'winum-select-window-5 map)
                (bind-key "M-6" #'winum-select-window-6 map)
                (bind-key "M-7" #'winum-select-window-7 map)
                (bind-key "M-8" #'winum-select-window-8 map)
                (bind-key "C-x w" #'winum-select-window-by-number map)
                map))
  :config (progn
            (setq winum-scope                       'frame-local
                  winum-reverse-frame-list          nil
                  ;; winum-auto-assign-0-to-minibuffer t
                  winum-auto-setup-mode-line        nil
                  winum-ignored-buffers             '(" *which-key*"))

            (winum-mode)))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(elpa-mirror markdown-mode winum zenburn-theme which-key use-package treemacs-all-the-icons spacemacs-theme smartparens python-black magit flycheck elpy doom-themes conda company-jedi company-anaconda blackout blacken)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
