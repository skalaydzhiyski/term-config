(require 'package)

; List the packages you want
(setq package-list '(evil
                     evil-leader))

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")))

; Add Melpa as the default Emacs Package repository
; only contains a very limited number of packages
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

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

(setq column-number-mode t)
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
;;(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
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
(defadvice evil-search-word-backward (around underscore-as-word7 activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (with-syntax-table table
      ad-do-it)))

(evil-ex-define-cmd "W" #'evil-write)
(evil-ex-define-cmd "Q" #'evil-quit)

;; ------------------ USE-PACKAGE MODULES -----------------------

;; Major mode for OCaml programming
;;(use-package tuareg
;;  :ensure t
;;  :mode (("\\.ocamlinit\\'" . tuareg-mode)))

;; Major mode for editing Dune project files
;;(use-package dune
;;  :ensure t)

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
;;  :hook ((reason-mode tuareg-mode caml-mode) . merlin-eldoc-setup))

;; This uses Merlin internally
;;(use-package flycheck-ocaml
;;  :ensure t
;;  :config
;;  (flycheck-ocaml-setup))

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
 '(eldoc-idle-delay 0.5)
 '(package-selected-packages
   '(ocamlformat python-black fzf json-mode eglot company-quickhelp company-anaconda anaconda-mode company-jedi jedi python-mode markdown-mode yaml yaml-mode haskell-tab-indent haskell-mode tmux-pane merlin-eldoc company idomenu flycheck-ocaml merlin dune tuareg cmake-mode use-package undo-tree nlinum evil-leader)))
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

;; sending reload objects to tmux for OCAML dev
(defvar load_command "#use \"bin/main.ml\";;" "")
(defun load_main_to_utop () "Run rake routes under Zeus" (interactive)
  (shell-command (format "tmux send-keys -t bottom '%s;'; tmux send-keys -t bottom Enter" load_command)))

(defun save_and_exit_evil_mode ()
  "save and exit evil mode insert"
  (interactive)
  (save-buffer)
  (evil-normal-state))
(global-set-key [f8] 'save_and_exit_evil_mode)
(global-set-key [f9] 'load_main_to_utop)

(add-to-list 'load-path "/Users/darchitect/.opam/default/share/emacs/site-lisp")
;;(require 'ocp-indent)


(use-package company
 :ensure t
 :config
 (setq company-idle-delay 0
       company-minimum-prefix-length 2
       company-show-numbers t
       company-tooltip-limit 10
       company-tooltip-maximum-width 80
       company-tooltip-align-annotations t
       ;; invert the navigation direction if the the completion popup-isearch-match
       ;; is displayed on top (happens near the bottom of windows)
       company-tooltip-flip-when-above t)
 (global-company-mode t)
 )

;; setup C++ development
(add-hook 'c++-mode-hook 'company-mode)
(add-to-list 'company-clang-arguments '"-I/usr/lib/gcc/x86_64-w64-mingw32/10-win32/include")
(add-to-list 'company-clang-arguments '"-I/usr/x86_64-w64-mingw32/include")
(add-to-list 'company-clang-arguments '"-I/home/darchitect/wine-bottles/sierra-chart/drive_c/SierraChart/ACS_Source")

(require 'lsp-mode)
(add-hook 'c++-mode-hook 'lsp)
(setq lsp-clients-clangd-executable "/usr/bin/clangd")  ; Adjust the path if needed

(add-hook 'c++-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'clang-format-buffer nil t)))


;; comment out both of these if you want more modern autocomplete on every char instead of TAB
;; NOTE! Uncomment below if you want to flip between f7 and tab
;;(global-set-key (kbd "TAB") 'company-complete-common-or-cycle)
;;(let ((map company-active-map))
;;     (define-key map (kbd "TAB") 'company-complete-common-or-cycle))
(global-set-key [f7] 'company-complete-selection)
(let ((map company-active-map))
     (define-key map [f7] 'company-complete-selection))
(global-set-key [f6] 'company-complete-common-or-cycle)
(let ((map company-active-map))
     (define-key map [f6] 'company-complete-common-or-cycle))

;; clean whitespace when saving except fundamental mode
(add-hook 'before-save-hook
	(lambda ()
		(unless (eq major-mode 'fundamental-mode)
			(delete-trailing-whitespace))))

(add-to-list 'default-frame-alist '(background-color . "gray8"))

(use-package anaconda-mode
  :ensure t
  :config
  (add-hook 'python-mode-hook 'anaconda-mode)
  ;;(add-hook 'python-mode-hook 'anaconda-eldoc-mode)
  )
(use-package company-anaconda
  :ensure t
  :init (require 'rx)
  :after (company)
  :config
  (add-to-list 'company-backends 'company-anaconda)
  )
(use-package company-quickhelp
  ;; Quickhelp may incorrectly place tooltip towards end of buffer
  ;; See: https://github.com/expez/company-quickhelp/issues/72
  :ensure t
  :config
  (company-quickhelp-mode)
  )

;; Another choice is Jedi, but it is designed to work with
;; AutoComplete instead of company-mode.  There's jedi-company, but
;; `jedi:setup` will always setup ac, unless you disable it
;; explicitly, which is annoying.  Also, you don't get the tool tip.

;; If you really want to try with jedi+company, use below scripts it
;; (remove the :disabled tag)
(use-package jedi
  :disabled
  :after (epc pos-tip)
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup)
  :config
  ;; For setup
  ;; http://d.hatena.ne.jp/n-channel/20131220/1387551080
  ;; and this:
  ;; http://kenbell.hatenablog.com/entry/2017/01/15/112344

  ;; Under windows, process might very long and EPC may fail.
  ;; Set it larger. What a bummer...
  ;;(if (memq system-type '(ms-dos windows-nt))
  ;;(setq epc:accept-process-timeout 1000))
  )
(use-package company-jedi
  :disabled
  :ensure t
  :config)

(setq indent-tabs-mode nil)
(setq tab-width 4)

;; setup python stuff
(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode t)
        (setq tab-width 4)
        (setq python-indent-offset 4)))

(defun my-python-mode-action ()
  (make-local-variable 'before-save-hook)
  (add-hook 'before-save-hook (lambda ()
                                (save-restriction
                                  (widen)
                                  (untabify (point-min) (point-max))))))
(add-hook 'python-mode-hook 'my-python-mode-action)
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'company-mode)
(add-hook 'python-mode-hook 'eglot)
(setq jedi:complete-on-dot t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; underscore is a word
(modify-syntax-entry ?_ "w")

;; fuzzy find
(global-set-key [f5] 'ido-find-file)

;; autoformat on save for OCAML
(add-hook 'tuareg-mode-hook (lambda ()
  (add-hook 'before-save-hook #'ocamlformat-before-save)))

;; prevent creation of ~ files
(setq make-backup-files nil)

(defvar dune_build_and_run_command "dune build; dune exec $(basename $PWD)")
(defun dune-build () "Run `dune build` and run" (interactive)
  (save_and_exit_evil_mode)
  (shell-command (format "tmux send-keys -t bottom '%s;'; tmux send-keys -t bottom Enter" dune_build_and_run_command)))
(global-set-key [f12] 'dune-build)

;; close error messages in the pane below
(defun close-split-below ()
  "Close the split pane below the current one."
  (interactive)
  (evil-window-down nil)
  (evil-window-delete))
(global-set-key [f4] 'close-split-below)

(global-undo-tree-mode)
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

(electric-pair-mode 1)
