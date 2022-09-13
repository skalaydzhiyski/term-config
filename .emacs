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

(global-linum-mode 1)
(setq linum-format "%d ")
;;(global-line-number-mode 1)

;; Evil
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode t)

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


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(markdown-preview-mode markdown-mode python-mode idomenu fzf flycheck-ocaml merlin-eldoc dune tuareg evil-visual-mark-mode evil-leader evil cmake-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ---------- OCAML --------------
;; Tuareg
(load "/home/darchitect/.opam/4.14.0/share/emacs/site-lisp/tuareg-site-file")

(let ((opam-share (ignore-errors (car (process-lines "opam" "var" "share")))))
    (when (and opam-share (file-directory-p opam-share))
    ;; Register Merlin
    (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
    (autoload 'merlin-mode "merlin" nil t nil)
    ;; Automatically start it in OCaml buffers
    (add-hook 'tuareg-mode-hook 'merlin-mode t)
    (add-hook 'caml-mode-hook 'merlin-mode t)
    ;; Use opam switch to lookup ocamlmerlin binary
    (setq merlin-command 'opam)))

;; Tuareg
(use-package tuareg
  :ensure t
  :mode (("\\.ocamlinit\\'" . tuareg-mode)))

;; Major mode for editing Dune project files
(use-package dune
  :ensure t)

;; Merlin provides advanced IDE features
(use-package merlin
  :ensure t
  :config
  (add-hook 'tuareg-mode-hook #'merlin-mode)
  (add-hook 'merlin-mode-hook #'company-mode)
  ;; we're using flycheck instead
  (setq merlin-error-after-save nil))

(use-package merlin-eldoc
  :ensure t
  :hook ((tuareg-mode) . merlin-eldoc-setup))

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

;; Global Key Settings
(global-set-key (kbd "C-c") nil) ;; TODO: remove me if you notice any weird behaviour related to Ctrl
(global-set-key (kbd "C-x f") 'ido-find-file)

