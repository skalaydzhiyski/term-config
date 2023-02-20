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

;;(global-vim-empty-lines-mode)
;;(setq vim-empty-lines-indicator "*")

;; company completions configuration.
(global-company-mode)
(global-set-key (kbd "TAB") #'company-indent-or-complete-common)
; bind company-select-next to tab
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
     (define-key company-active-map [tab] 'company-complete-common-or-cycle)))
;; (setq company-selection t) <-- this doesn't make sense -- Dmitry
(setq company-idle-delay 0)


(global-undo-tree-mode 1)

(global-nlinum-mode 1)
(setq nlinum-format "%d ")
(electric-indent-mode nil)

;; ------------------- REQURE PACKAGES -------------------------

(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode t)
(setq evil-want-fine-undo 'fine)
(define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state) ;; TODO: change this to something different if it breaks main functionality
(define-key evil-normal-state-map (kbd "C-c") 'evil-normal-state) ;; TODO: change this to something different if it breaks main functionality
(define-key evil-normal-state-map (kbd "b") 'evil-backward-WORD-begin) ;; TODO: change this to something different if it breaks main functionality
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
;; capitalised versions of the write and quite ex commands.
(evil-ex-define-cmd "W" #'evil-write)
(evil-ex-define-cmd "Q" #'evil-quit)

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
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#32302f" "#fb4933" "#98971a" "#d79921" "#458588" "#d3869b" "#689d6a" "#282828"])
 '(compilation-message-face 'default)
 '(cua-global-mark-cursor-color "#689d6a")
 '(cua-normal-cursor-color "#a89984")
 '(cua-overwrite-cursor-color "#d79921")
 '(cua-read-only-cursor-color "#98971a")
 '(custom-safe-themes
   '("00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" "19a2c0b92a6aa1580f1be2deb7b8a8e3a4857b6c6ccf522d00547878837267e7" "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" "f5b6be56c9de9fd8bdd42e0c05fecb002dedb8f48a5f00e769370e4517dde0e8" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "1c9ba588b7dedc017c5ee7fab0b9c74595a622d94298d9b79633a55091bed503" "9ee253fcdb48535bf16df2700582b0a11fe99390b018755b941140f2fcdff219" "6b6bad9d7a844d5de02761a1bd155869512f47bd6a7b14d799eea5c37f08ead4" "30b14930bec4ada72f48417158155bc38dd35451e0f75b900febd355cda75c3e" "57e3f215bef8784157991c4957965aa31bac935aca011b29d7d8e113a652b693" "b1a691bb67bd8bd85b76998caf2386c9a7b2ac98a116534071364ed6489b695d" "78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27" "46f6f73fb47a2a19b6ee1a49781f835fd73a185674268d4e048acf6feac9c55d" "39f0ac86b012062fed46469cc5ea1b00aa534db587ad21d55a9717a1bac99a27" "c3fa63eab93d1f0b4bf9f60a98a2848ba29c34cc6f2ef5cf4076d9c190a47a6c" "cdc2a7ba4ecf0910f13ba207cce7080b58d9ed2234032113b8846a4e44597e41" default))
 '(fci-rule-color "#32302f")
 '(fringe-mode 10 nil (fringe))
 '(highlight-changes-colors '("#d3869b" "#b16286"))
 '(highlight-symbol-colors
   '("#511b3c9a2628" "#35b845883443" "#596d368233c0" "#462734963c8d" "#3e8b3c67250e" "#521b34e723f5" "#34573c9b3c88"))
 '(highlight-symbol-foreground-color "#bdae93")
 '(highlight-tail-colors
   '(("#32302f" . 0)
     ("#747400" . 20)
     ("#2e7d33" . 30)
     ("#14676b" . 50)
     ("#a76e00" . 60)
     ("#a53600" . 70)
     ("#9f4d64" . 85)
     ("#32302f" . 100)))
 '(hl-bg-colors
   '("#a76e00" "#a53600" "#b21b0b" "#9f4d64" "#8b2a58" "#14676b" "#2e7d33" "#747400"))
 '(hl-fg-colors
   '("#282828" "#282828" "#282828" "#282828" "#282828" "#282828" "#282828" "#282828"))
 '(hl-paren-colors '("#689d6a" "#d79921" "#458588" "#b16286" "#98971a"))
 '(ispell-dictionary nil)
 '(linum-format " %6d ")
 '(lsp-ui-doc-border "#bdae93")
 '(main-line-color1 "#222232")
 '(main-line-color2 "#333343")
 '(nrepl-message-colors
   '("#fb4933" "#d65d0e" "#d79921" "#747400" "#b9b340" "#14676b" "#689d6a" "#d3869b" "#b16286"))
 '(package-selected-packages
   '(hindent github-clone python-mode haskell-mode solarized-theme ir-black-theme cherry-blossom-theme badger-theme clues-theme afternoon-theme gruvbox-theme color-theme tmux-pane merlin-eldoc company idomenu flycheck-ocaml merlin dune tuareg cmake-mode use-package undo-tree nlinum))
 '(pdf-view-midnight-colors '("#fdf4c1" . "#1d2021"))
 '(pos-tip-background-color "#32302f")
 '(pos-tip-foreground-color "#bdae93")
 '(powerline-color1 "#222232")
 '(powerline-color2 "#333343")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#98971a" "#32302f" 0.2))
 '(term-default-bg-color "#282828")
 '(term-default-fg-color "#a89984")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   '((20 . "#fb4933")
     (40 . "#ecbf761e3d44")
     (60 . "#e2857f5127e8")
     (80 . "#d79921")
     (100 . "#bd9e88a00000")
     (120 . "#b06088bd0000")
     (140 . "#a2fe88960000")
     (160 . "#9568882d0000")
     (180 . "#98971a")
     (200 . "#7f0494f52b1c")
     (220 . "#795c9ba5393d")
     (240 . "#727aa253465b")
     (260 . "#6a02a90152fd")
     (280 . "#689d6a")
     (300 . "#61dd9f857096")
     (320 . "#61d9977d7886")
     (340 . "#61058f7e8026")
     (360 . "#458588")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   '(unspecified "#282828" "#32302f" "#b21b0b" "#fb4933" "#747400" "#98971a" "#a76e00" "#d79921" "#14676b" "#458588" "#9f4d64" "#d3869b" "#2e7d33" "#689d6a" "#a89984" "#282828"))
 '(xterm-color-names
   ["#32302f" "#fb4933" "#98971a" "#d79921" "#458588" "#d3869b" "#689d6a" "#a89984"])
 '(xterm-color-names-bright
   ["#282828" "#d65d0e" "#7c6f64" "#282828" "#a89984" "#b16286" "#bdae93" "#fbf1c7"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(merlin-eldoc-occurrences-face ((t (:background "dark slate blue" :inverse-video nil)))))
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line

;; ------------------- EXTRA ---------------------------------

(add-hook 'tuareg-mode-hook 'merlin-eldoc-setup)

;; ------------------- TMUX ----------------------------------

;; OCaml specific - send to utop.
(defun tmux-pane-below-load-main-in-utop () (interactive) (shell-command "tmux send-keys -t 1  '#use \"bin/main.ml\"\;;;'; tmux send-keys -t 1 Enter"))
(global-set-key (kbd "<f9>") 'tmux-pane-below-load-main-in-utop)
