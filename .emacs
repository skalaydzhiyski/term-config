(require 'package)

; List the packages you want
(setq package-list '(evil
                     evil-leader))


; Add Melpa as the default Emacs Package repository
; only contains a very limited number of packages
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

; Activate all the packages (in particular autoloads)
(package-initialize)

; Update your local package index
(unless package-archive-contents
  (package-refresh-contents))

;; use-package precheck
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)

; Install all missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; ------------------ GLOBAL CONFIG ----------------------------

(global-undo-tree-mode 1)
(global-nlinum-mode 1)
(setq nlinum-format "%d ")
(electric-indent-mode nil)

;; ------------------- REQURE PACKAGES -------------------------

(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode t)
(setq evil-want-fine-undo 'fine)
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "b" 'switch-to-buffer
  "w" 'save-buffer
  "W" 'save-buffer)
(define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state) ;; TODO: change this to something different if it breaks main functionality
(define-key evil-normal-state-map (kbd "C-c") 'evil-normal-state) ;; TODO: change this to something different if it breaks main functionality
;; Fix for $ not going to newline
(define-key evil-visual-state-map (kbd "$")
  (lambda() (interactive)
    (evil-end-of-line)    ; to end of line (including newline)
    (evil-backward-char)  ; back to second to last visible character (weird)
    (evil-forward-char))) ; forward to last visible character
(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
;; Global Key Settings
(global-set-key (kbd "C-c") nil) ;; TODO: remove me if you notice any weird behaviour related to Ctrl
(global-set-key (kbd "C-x f") 'ido-find-file)
;; Evil-Mode word in vim is not capturing underscores (the following entries are the fix
(defadvice evil-inner-word (around underscore-as-word1 activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (with-syntax-table table
      ad-do-it)))
(defadvice evil-forward-word-begin (around underscore-as-word2 activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (with-syntax-table table
      ad-do-it)))
(defadvice evil-forward-word-end (around underscore-as-word3 activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (with-syntax-table table
      ad-do-it)))
(defadvice evil-backward-word-end (around underscore-as-word4 activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (with-syntax-table table
      ad-do-it)))
(defadvice evil-backward-word-end (around underscore-as-word5 activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (with-syntax-table table
      ad-do-it)))
(defadvice evil-a-word (around underscore-as-word6 activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (with-syntax-table table
      ad-do-it)))

;; ------------------ USE-PACKAGE MODULES -----------------------

;; Major mode for OCaml programming
;;(use-package tuareg
;;  :ensure t
;;  :mode (("\\.ocamlinit\\'" . tuareg-mode)))

;; Major mode for editing Dune project files
(use-package dune
  :ensure t)

;; Merlin provides advanced IDE features
;;(use-package merlin
;;  :ensure t
;;  :config
;;  (add-hook 'tuareg-mode-hook #'merlin-mode)
;;  (add-hook 'merlin-mode-hook #'company-mode)
;;  ;; we're using flycheck instead
;;  (setq merlin-error-after-save nil)
;;  (setq merlin-command "<PREFIX>/bin/ocamlmerlin"))

;;(use-package merlin-eldoc
;;  :ensure t
;;  :hook ((tuareg-mode) . merlin-eldoc-setup))

;; This uses Merlin internally
(use-package flycheck-ocaml
  :ensure t
  :config
  (flycheck-ocaml-setup))


(use-package idomenu
  :ensure t
  :config
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t))
(ido-mode 1)


;; better Vim-like undo
(use-package undo-tree
  :config
  (undo-tree-mode 1))
(define-key evil-normal-state-map (kbd "u") 'undo-tree-undo)
(define-key evil-normal-state-map (kbd "C-r") 'undo-tree-redo)

;; --------------- GENERATED CONFIGS ------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(tmux-pane merlin-eldoc company idomenu flycheck-ocaml merlin dune tuareg cmake-mode use-package undo-tree nlinum evil-leader)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(merlin-eldoc-occurrences-face ((t (:background "dim gray" :inverse-video t)))))
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line

;; ------------------- EXTRA ---------------------------------

(add-hook 'tuareg-mode-hook 'merlin-eldoc-setup)

