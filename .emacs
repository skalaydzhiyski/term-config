(require 'package)
(require 'use-package)

(package-initialize)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://stable.melpa.org/packages/"))

;; -------------------- Global Configuration --------------------
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
(auto-save-mode 0)
(desktop-save-mode 1)
(ido-mode 1) ;; disable this in case you choose to use Ivy 
(save-place-mode 1)
(column-number-mode 1)
(display-battery-mode t)
(show-paren-mode t)
(global-hl-line-mode t) ;; This highlights the current line in the buffer
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x 0") 'kill-buffer-and-window)
(setq default-tab-width 2)

(global-display-line-numbers-mode t) ;; pretty line numbers
(fset 'yes-or-no-p 'y-or-n-p)
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

;; custom themes not available in MELPA path
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(setq x-select-enable-clipboard t) ;; get clipboard enabled for copy-paste
(setq x-select-enable-primary t) ;; enable copy selected text block

;; this is the color of hl-line for gruvbox
(set-face-background 'hl-line "#313131")

;; Addt the below line underneath the ultra-bold line in case you switch back to naysayer theme
;; '(mode-line-inactive ((t (:background "#a19857" :foreground "#062329" :box nil :weight ultra-bold))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Liberation Mono" :foundry "1ASC" :slant normal :weight normal :height 97 :width normal))))
 '(mode-line ((t (:weight ultra-bold)))))

;; disable highlight line and line numbers in eshell and haskell-interactive
(add-hook 'eshell-mode-hook (lambda ()
                                    (setq-local global-hl-line-mode
                                                nil)))
(add-hook 'eshell-mode-hook
	(lambda () (display-line-numbers-mode 0)))

(add-hook 'haskell-interactive-mode-hook (lambda ()
                                    (setq-local global-hl-line-mode
                                                nil)))
(add-hook 'haskell-interactive-mode-hook
	(lambda () (display-line-numbers-mode 0)))

(add-hook 'vterm-mode-hook (lambda ()
                                    (setq-local global-hl-line-mode
                                                nil)))
(add-hook 'vterm-mode-hook
	(lambda () (display-line-numbers-mode 0)))

;; save window configuration
(global-set-key (kbd "<f5>") '(setq my-window-list (current-frame-configuration)))
(global-set-key (kbd "<f6>") '(set-frame-configuration my-window-list))

;; -------------------- Package Configuration --------------------


(setq evil-want-C-u-scroll t)
(use-package evil
  :ensure t
  :config
    (evil-mode 1)
)
(define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
(evil-ex-define-cmd "q" 'kill-this-buffer)
(evil-ex-define-cmd "W" 'evil-write)
(evil-ex-define-cmd "quit" 'evil-quit)
(setq evil-motion-state-cursor 'box)
(setq evil-visual-state-cursor 'box)
(setq evil-normal-state-cursor 'box)
(setq evil-insert-state-cursor 'box)
(setq evil-emacs-state-cursor  'hbar)


;;(use-package beacon ;; This applies a beacon effect to the highlighted line
;;   :ensure t
;;   :config
;;   (beacon-mode 1))


(use-package org
  :ensure t)


(use-package markdown-mode
  :ensure t)


(use-package magit
  :ensure t)


(use-package vterm
  :load-path "/home/darchitect/work/emacs-libvterm")


(use-package haskell-mode
  :ensure t)
(add-hook 'haskell-mode-hook #'hindent-mode)
(eval-after-load 'haskell-mode
          '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))
(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))
(eval-after-load 'haskell-mode '(progn
  (define-key haskell-mode-map (kbd "<f9>") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)))
(eval-after-load 'haskell-cabal '(progn
  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))
;; ghcid support

;; TODO: configure haskell tags properly here when you actually need it


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(ansi-term-color-vector
   [unspecified "#14191f" "#d15120" "#81af34" "#deae3e" "#7e9fc9" "#a878b5" "#7e9fc9" "#dcdddd"] t)
 '(awesome-tray-mode-line-active-color "#2fafff")
 '(awesome-tray-mode-line-inactive-color "#323232")
 '(column-number-mode t)
 '(compilation-message-face 'default)
 '(custom-enabled-themes '(naysayer))
 '(custom-safe-themes
   '("30efcf226fdfb581f45ebbe4a8520b721637583e4231a289bc1921fa0fba707c" "70907b7e68c6fda0f74c98350d107c38271485dfdc5d834669ab94c52fdd9d6c" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "2ce76d65a813fae8cfee5c207f46f2a256bac69dacbb096051a7a8651aa252b0" "0ad9efaf2cb57180461c0cc454aca921927605b4a1d78ad36625ba83b4a412e9" "05793a3d1d18619a2d72af300892a818d22757ed35c8d32c1725263d483604ff" "e081d167861aa1af9e423a10b00c560b1c18ab8f3627dfbe35ff4455bd993d36" "6dc02f2784b4a49dd5a0e0fd9910ffd28bb03cfebb127a64f9c575d8e3651440" "249e100de137f516d56bcf2e98c1e3f9e1e8a6dce50726c974fa6838fbfcec6b" "06ed754b259cb54c30c658502f843937ff19f8b53597ac28577ec33bb084fa52" "e266d44fa3b75406394b979a3addc9b7f202348099cfde69e74ee6432f781336" "e8567ee21a39c68dbf20e40d29a0f6c1c05681935a41e206f142ab83126153ca" "c95813797eb70f520f9245b349ff087600e2bd211a681c7a5602d039c91a6428" "11cc65061e0a5410d6489af42f1d0f0478dbd181a9660f81a692ddc5f948bf34" "9cd57dd6d61cdf4f6aef3102c4cc2cfc04f5884d4f40b2c90a866c9b6267f2b3" "d9a28a009cda74d1d53b1fbd050f31af7a1a105aa2d53738e9aa2515908cac4c" "f00a605fb19cb258ad7e0d99c007f226f24d767d01bf31f3828ce6688cbdeb22" "6128465c3d56c2630732d98a3d1c2438c76a2f296f3c795ebda534d62bb8a0e3" "d516f1e3e5504c26b1123caa311476dc66d26d379539d12f9f4ed51f10629df3" "3c7a784b90f7abebb213869a21e84da462c26a1fda7e5bd0ffebf6ba12dbd041" "9a3ff7953afc7fc756c8f993e1acdf6f9e80c1881d14dbdffce7829db62d2c3e" "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" "3c68f48ea735abe65899f489271d11cbebbe87da7483acf9935ea4502efd0117" "585942bb24cab2d4b2f74977ac3ba6ddbd888e3776b9d2f993c5704aa8bb4739" "748d024b0d016cc0e7a4326577ce12c6bc918b273acecd355548d7477ad2fc5c" "97f8522ab2c0ff08dd511ff74ef3af612adc03e450dbd6d724c973f1511939ae" default))
 '(display-battery-mode t)
 '(exwm-floating-border-color "#646464")
 '(fci-rule-character-color "#192028")
 '(fci-rule-color "#192028")
 '(flymake-error-bitmap '(flymake-double-exclamation-mark modus-themes-fringe-red))
 '(flymake-note-bitmap '(exclamation-mark modus-themes-fringe-cyan))
 '(flymake-warning-bitmap '(exclamation-mark modus-themes-fringe-yellow))
 '(fringe-mode 10 nil (fringe))
 '(global-display-line-numbers-mode t)
 '(haskell-interactive-popup-errors nil)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type 'stack-ghci)
 '(highlight-changes-colors '("#EF5350" "#7E57C2"))
 '(highlight-tail-colors
   '(("#010F1D" . 0)
     ("#B44322" . 20)
     ("#34A18C" . 30)
     ("#3172FC" . 50)
     ("#B49C34" . 60)
     ("#B44322" . 70)
     ("#8C46BC" . 85)
     ("#010F1D" . 100)))
 '(hl-todo-keyword-faces
   '(("HOLD" . "#c0c530")
     ("TODO" . "#feacd0")
     ("NEXT" . "#b6a0ff")
     ("THEM" . "#f78fe7")
     ("PROG" . "#00d3d0")
     ("OKAY" . "#4ae2f0")
     ("DONT" . "#70b900")
     ("FAIL" . "#ff8059")
     ("BUG" . "#ff8059")
     ("DONE" . "#44bc44")
     ("NOTE" . "#d3b55f")
     ("KLUDGE" . "#d0bc00")
     ("HACK" . "#d0bc00")
     ("TEMP" . "#ffcccc")
     ("FIXME" . "#ff9077")
     ("XXX+" . "#ef8b50")
     ("REVIEW" . "#6ae4b9")
     ("DEPRECATED" . "#bfd9ff")))
 '(ibuffer-deletion-face 'modus-themes-mark-del)
 '(ibuffer-filter-group-name-face 'modus-themes-pseudo-header)
 '(ibuffer-marked-face 'modus-themes-mark-sel)
 '(ibuffer-title-face 'default)
 '(ispell-dictionary nil)
 '(linum-format " %5i ")
 '(magit-diff-use-overlays nil)
 '(main-line-color1 "#222232")
 '(main-line-color2 "#333343")
 '(org-src-block-faces 'nil)
 '(package-selected-packages
   '(vterm auto-complete bash-completion ipython-shell-send hindent ## railscasts-reloaded-theme fantom-theme night-owl-theme iceberg-theme kaolin-themes solarized-theme smex use-package twilight-anti-bright-theme theme-looper modus-vivendi-theme modus-operandi-theme markdown-preview-mode magit ivy-rich highlight-numbers helm haskell-mode haskell-emacs gruvbox-theme evil dracula-theme darktooth-theme counsel clues-theme blackboard-theme beacon badwolf-theme abyss-theme))
 '(pdf-view-midnight-colors '("#fdf4c1" . "#32302f"))
 '(pos-tip-background-color "#16211C")
 '(pos-tip-foreground-color "#dcded9")
 '(powerline-color1 "#222232")
 '(powerline-color2 "#333343")
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#C792EA")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#FFEB95")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#F78C6C")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#7FDBCA")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#82AAFF")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   '(unspecified "#011627" "#010F1D" "#DC2E29" "#EF5350" "#D76443" "#F78C6C" "#D8C15E" "#FFEB95" "#5B8FFF" "#82AAFF" "#AB69D7" "#C792EA" "#AFEFE2" "#7FDBCA" "#D6DEEB" "#FFFFFF")))


;;(use-package counsel
;;  :after ivy
;;  :config (counsel-mode))
;;(use-package ivy
;;  :ensure t)
;;(setq ivy-re-builders-alist
;;      '((swiper . ivy--regex-plus)
;;        (t      . ivy--regex-fuzzy)))
;;(setq ivy-use-virtual-buffers t)
;;(setq ivy-count-format "(%d/%d) ")
;;(global-set-key (kbd "C-s") 'swiper-isearch)
;;(global-set-key (kbd "M-x") 'counsel-M-x)
;;(global-set-key (kbd "C-x C-f") 'counsel-find-file)
;;(global-set-key (kbd "M-y") 'counsel-yank-pop)
;;(global-set-key (kbd "<f1> f") 'counsel-describe-function)
;;(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;;(global-set-key (kbd "<f1> l") 'counsel-find-library)
;;(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;;(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;;(global-set-key (kbd "<f2> j") 'counsel-set-variable)
;;(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
;;(global-set-key (kbd "C-c v") 'ivy-push-view)
;;(global-set-key (kbd "C-c V") 'ivy-pop-view)
;;(ivy-mode 1) ;; enable Ivy everywhere


;; -------------------- Fix splash screen resolution with Libeartion Mono ---------------------------

(defun use-fancy-splash-screens-p ()
  "Return t if fancy splash screens should be used."
  (when (and (display-graphic-p)
             (or (and (display-color-p)
          (image-type-available-p 'xpm))
                 (image-type-available-p 'pbm)))
    (let ((frame (fancy-splash-frame)))
      (when frame
  (let* ((img (create-image (fancy-splash-image-file)))
         (image-height (and img (cdr (image-size img nil frame))))
         ;; We test frame-height so that, if the frame is split
         ;; by displaying a warning, that doesn't cause the normal
         ;; splash screen to be used.
         (frame-height (1- (frame-height frame))))
   ;; The original value added to the `image-height' for the test was 19; however,
   ;; that causes the test to fail on X11 by about 1.5 -- so use 17 instead.
    (> frame-height (+ image-height 17)))))))

;; -------------------- Fix indendation bug of haskell-mode ---------------------------

(defun haskell-indentation-indent-line ()
  "Indent current line, cycle though indentation positions.
Do nothing inside multiline comments and multiline strings.
Start enumerating the indentation points to the right.  The user
can continue by repeatedly pressing TAB.  When there is no more
indentation points to the right, we switch going to the left."
  (interactive)
    ;; try to repeat
  (when (not (haskell-indentation-indent-line-repeat))
    (setq haskell-indentation-dyn-last-direction nil)
    ;; parse error is intentionally not caught here, it may come from
    ;; `haskell-indentation-find-indentations', but escapes the scope
    ;; and aborts the operation before any moving happens
    (let* ((cc (current-column))
           (ci (haskell-indentation-current-indentation))
           (inds (save-excursion
                   (move-to-column ci)
                   (or (haskell-indentation-find-indentations)
                       '(0))))
           (valid (memq ci inds))
           (cursor-in-whitespace (< cc ci))
           (evil-special-command? (and (bound-and-true-p evil-mode)
                                       (memq this-command '(evil-open-above
                                                            evil-open-below
                                                            evil-replace))))
           (on-last-indent (eq ci (car (last inds)))))
      (if (and valid cursor-in-whitespace)
          (move-to-column ci)
        (haskell-indentation-reindent-to
         (funcall
          (if on-last-indent
              #'haskell-indentation-previous-indentation
            #'haskell-indentation-next-indentation)
          (if evil-special-command?
              (save-excursion
                (end-of-line 0)
                (1- (haskell-indentation-current-indentation)))
            ci)
          inds
          'nofail)
         cursor-in-whitespace))
      (setq haskell-indentation-dyn-last-direction (if on-last-indent 'left 'right)
            haskell-indentation-dyn-last-indentations inds))))


;; -------------------- Tab completion settings --------------------------------------
(use-package auto-complete
  :ensure t
  :config
  (progn
    (require 'auto-complete-config)
    (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
    (ac-config-default)
    (ac-set-trigger-key "TAB")
    (ac-set-trigger-key "<tab>"))
  :pin melpa
)
