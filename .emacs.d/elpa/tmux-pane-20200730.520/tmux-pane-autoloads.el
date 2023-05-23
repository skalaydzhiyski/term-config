;;; tmux-pane-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "tmux-pane" "tmux-pane.el" (0 0 0 0))
;;; Generated autoloads from tmux-pane.el

(autoload 'tmux-pane--windmove "tmux-pane" "\
Move focus to window according to DIR and TMUX-CMD.

\(fn DIR FLAG)" t nil)

(autoload 'tmux-pane-open-vertical "tmux-pane" "\
Open a vertical pane." t nil)

(autoload 'tmux-pane-open-horizontal "tmux-pane" "\
Open a horizontal pane." t nil)

(autoload 'tmux-pane-close "tmux-pane" "\
Close last pane." t nil)

(autoload 'tmux-pane-rerun "tmux-pane" "\
Rerun command in the last pane." t nil)

(autoload 'tmux-pane-toggle-vertical "tmux-pane" "\
Toggle vertical pane." t nil)

(autoload 'tmux-pane-toggle-horizontal "tmux-pane" "\
Toggle horizontal pane." t nil)

(autoload 'tmux-pane-omni-window-last "tmux-pane" "\
Switch to the last window of Emacs or tmux." t nil)

(autoload 'tmux-pane-omni-window-up "tmux-pane" "\
Switch to the up window of Emacs or tmux." t nil)

(autoload 'tmux-pane-omni-window-down "tmux-pane" "\
Switch to the down window of Emacs or tmux." t nil)

(autoload 'tmux-pane-omni-window-left "tmux-pane" "\
Switch to the left window of Emacs or tmux." t nil)

(autoload 'tmux-pane-omni-window-right "tmux-pane" "\
Switch to the right window of Emacs or tmux." t nil)

(defvar tmux-pane-mode nil "\
Non-nil if Tmux-Pane mode is enabled.
See the `tmux-pane-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `tmux-pane-mode'.")

(custom-autoload 'tmux-pane-mode "tmux-pane" nil)

(autoload 'tmux-pane-mode "tmux-pane" "\
Seamlessly navigate between tmux pane and emacs window.

If called interactively, enable Tmux-Pane mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "tmux-pane" '("windmove-last")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; tmux-pane-autoloads.el ends here
