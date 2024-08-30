(setq doom-theme 'catppuccin
      doom-font (font-spec :family "FiraCode Nerd Font" :size 12 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 12 :weight 'medium))

(set-frame-parameter nil 'alpha-background 95)
(add-to-list 'default-frame-alist '(alpha-background . 95))

(setq display-line-numbers-type 'relative
      tab-width 4)

(after! smart-tabs-mode
  (smart-tabs-insinuate 'c 'c++ 'javascript 'java 'python)

(setq-default indent-tabs-mode nil)
(add-hook 'c-mode-common-hook
          (lambda () (setq indent-tabs-mode t))))

(map! :leader "i d" #'indent-region)

(after! doom-modeline-core
  (setq doom-modeline-height 25
        doom-modeline-icon t
        doom-modeline-modal-icon nil
        doom-modeline-major-mode-icon t
        doom-modeline-enable-word-count t))

(defhydra doom-window-resize (:hint nil)
  "
                _k_ increase height
        _h_ decrease width    _l_ increase width
                _j_ decrease height
        "
  ("h" evil-window-increase-width)
  ("j" evil-window-increase-height)
  ("k" evil-window-decrease-height)
  ("l" evil-window-decrease-width)
  ("q" nil))

(map!
 :leader
 :desc "Resize windows"
 "r r" #'doom-window-resize/body)

(after! org
  (setq org-directory "~/documents/org/"
        org-agenda-files '("~/documents/org/agenda/")
        org-log-done 'time
        tab-width 4)

(setq org-startup-with-inline-images t
      org-image-actual-width 512)

(map! :leader "t o" #'org-table-toggle-column-width))

(add-hook 'org-mode 'org-auto-tangle-mode)
(after! org-auto-tangle
  (setq org-auto-tangle-default t))

(after! plant-uml-mode
  (setq org-plantuml-exec-mode 'plantuml
        org-plantuml-executable-path "/usr/bin/plantuml"))

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("org-plain-latex"
                 "\\documentclass{article}
                  [NO-DEFAULT-PACKAGES]
                  [PACKAGES]
                  [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(setq browse-url-browser-function 'eww-browse-url)
(after! eww
  (add-hook 'eww-mode-hook 'doom-modeline-mode))

(after! elfeed
  (setq elfeed-curl-max-connections 32
        elfeed-search-filter "@1-week-ago ")

(defun sk/elfeed-db-remove-entry (id)
  "Removes the entry for ID"
  (avl-tree-delete elfeed-db-index id)
  (remhash id elfeed-db-entries))

(defun sk/elfeed-search-remove-selected ()
  "Remove selected entries from database"
  (interactive)
  (let* ((entries (elfeed-search-selected))
	 (count (length entries)))
    (when (y-or-n-p (format "Delete %d entires?" count))
      (cl-loop for entry in entries
	       do (sk/elfeed-db-remove-entry (elfeed-entry-id entry)))))
  (elfeed-search-update--force))

(defvar ap/elfeed-update-complete-hook nil
  "Functions called with no arguments when `elfeed-update' is finished.")

(defvar ap/elfeed-updates-in-progress 0
  "Number of feed updates in-progress.")

(defvar ap/elfeed-search-update-filter nil
  "The filter when `elfeed-update' is called.")

(defun ap/elfeed-update-complete-hook (&rest ignore)
  "When update queue is empty, run `ap/elfeed-update-complete-hook' functions."
  (when (= 0 ap/elfeed-updates-in-progress)
    (run-hooks 'ap/elfeed-update-complete-hook)))

(add-hook 'elfeed-update-hooks #'ap/elfeed-update-complete-hook)

(defun ap/elfeed-update-message-completed (&rest _ignore)
  (message "Feeds updated"))

(add-hook 'ap/elfeed-update-complete-hook #'ap/elfeed-update-message-completed)

(defun ap/elfeed-search-update-restore-filter (&rest ignore)
  "Restore filter after feeds update."
  (when ap/elfeed-search-update-filter
    (elfeed-search-set-filter ap/elfeed-search-update-filter)
    (setq ap/elfeed-search-update-filter nil)))

(add-hook 'ap/elfeed-update-complete-hook #'ap/elfeed-search-update-restore-filter)

(defun ap/elfeed-search-update-save-filter (&rest ignore)
  "Save and change the filter while updating."
  (setq ap/elfeed-search-update-filter elfeed-search-filter)
  (setq elfeed-search-filter "#0"))

;; NOTE: It would be better if this hook were run before starting the feed updates, but in
;; `elfeed-update', it happens afterward.
(add-hook 'elfeed-update-init-hooks #'ap/elfeed-search-update-save-filter)

(defun ap/elfeed-update-counter-inc (&rest ignore)
  (cl-incf ap/elfeed-updates-in-progress))

(advice-add #'elfeed-update-feed :before #'ap/elfeed-update-counter-inc)

(defun ap/elfeed-update-counter-dec (&rest ignore)
  (cl-decf ap/elfeed-updates-in-progress)
  (when (< ap/elfeed-updates-in-progress 0)
    ;; Just in case
    (setq ap/elfeed-updates-in-progress 0)))

(add-hook 'elfeed-update-hooks #'ap/elfeed-update-counter-dec))

(after! elfeed-goodies
  (setq elfeed-goodies/entry-pane-size 0.5))

(after! elfeed-org
  (setq rmh-elfeed-org-files (list "~/documents/org/elfeed/elfeed.org")))

(require 'elfeed-tube)
(after! elfeed-tube
(elfeed-tube-setup)
  (setq mpv-executable "mpv"))

(after! dired
  (evil-define-key 'normal dired-mode-map
    (kbd "M-RET") 'dired-display-file
    (kbd "RET") 'dired-launch-with-prompt-command
    (kbd "h") 'dired-up-directory
    (kbd "l") 'dired-find-alternate-file
    (kbd "m") 'dired-mark
    (kbd "t") 'dired-toggle-marks
    (kbd "u") 'dired-unmark
    (kbd "C") 'dired-do-copy
    (kbd "D") 'dired-do-delete
    (kbd "J") 'dired-goto-file
    (kbd "M") 'dired-do-chmod
    (kbd "O") 'dired-do-chown
    (kbd "P") 'dired-do-print
    (kbd "R") 'dired-do-rename
    (kbd "T") 'dired-do-touch
    (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
    (kbd "Z") 'dired-do-compress
    (kbd "+") 'dired-create-directory
    (kbd "-") 'dired-do-kill-lines
    (kbd "% l") 'dired-downcase
    (kbd "% m") 'dired-mark-files-regexp
    (kbd "% u") 'dired-upcase
    (kbd "* %") 'dired-mark-files-regexp
    (kbd "* .") 'dired-mark-extension
    (kbd "* /") 'dired-mark-directories
    (kbd "; d") 'epa-dired-do-decrypt
    (kbd "; e") 'epa-dired-do-encrypt)

(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/trash/files/")

(dired-launch-enable))

(setq avy-all-windows 't)

(map! :leader "w a" #'ace-window)

(setq minimap-window-location 'right)
(map! :leader "t m" #'minimap-mode)

(defun personal/playlist-mpv ()
  "Play the media is current directory as a playlist using MPV."
  (interactive)
  (vterm)
  (vterm--goto-line -1)
  (vterm-send-string "mpv .")
  (vterm-send-return))

(map! :leader "p l" #'personal/playlist-mpv)

(after! speed-type
  (add-hook 'speed-type-mode-hook 'writeroom-mode))

(after! dap-mode
  (setq dap-python-debugger 'debugpy)

(map! :leader "d d" #'dap-debug
      :leader "d c" #'dap-disconnect
      :leader "d r" #'dap-debug-restart
      :leader "d n" #'dap-next
      :leader "d i" #'dap-step-in
      :leader "d o" #'dap-step-out
      :leader "d p" #'dap-breakpoint-toggle
      :leader "d u s" #'dap-ui-sessions
      :leader "d u p" #'dap-ui-breakpoints)

(setq read-process-output-max (* 1024 1024) ; 1mb
      lsp-idle-delay 0.500
      lsp-log-io nil))                      ; if set to true can cause a performance hit

(defalias 'elfeed-youtube
  (kmacro "0 / c h a n n e l <return> c f / f e e d s / v i d e o s . x m l ? c h a n n e l _ i d - <backspace> = <escape> 0 w i [ <escape> A ] [ <escape>"))

(map! :leader "m a c y t" #'elfeed-youtube)
