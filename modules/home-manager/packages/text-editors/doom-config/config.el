(setq doom-theme 'doom-gruvbox)
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 12 :weight 'medium))
(set-frame-parameter nil 'alpha-background 95)
(add-to-list 'default-frame-alist '(alpha-background . 95))

(setq display-line-numbers-type 'relative)

(setq-default tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

(smart-tabs-insinuate 'c 'javascript 'java)

(setq-default indent-tabs-mode nil)
(add-hook 'c-mode-common-hook
          (lambda () (setq indent-tabs-mode t)))

(setq doom-modeline-height 25)
(setq doom-modeline-icon t)
(setq doom-modeline-modal-icon nil)
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-enable-word-count t)

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
 "r r" #'doom-window-resize/body
 )

(setq org-directory "~/doc/org/")
(setq org-agenda-files '("~/doc/org/agenda.org"))
(setq org-log-done 'time)

(setq org-image-actual-width nil)
(setq org-hide-emphasis-markers nil)
(setq org-ellipsis "⤵")

(custom-set-faces
  '(org-document-title ((t (:inherit outline-1 :height 2.7))))
  '(org-document-info ((t (:inherit outline-1 :height 2.0))))
  '(org-level-1 ((t (:inherit outline-1 :height 1.7))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.6))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.5))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.4))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.3))))
  '(org-level-6 ((t (:inherit outline-5 :height 1.3))))
  '(org-level-7 ((t (:inherit outline-5 :height 1.2))))
  '(org-level-8 ((t (:inherit outline-5 :height 1.1)))))

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

(setq org-startup-with-inline-images t)

(setq org-export-in-background nil)

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

(require 'oc-biblatex)
(setq org-latex-pdf-process (list "latexmk -pdf %f"))

(setq org-latex-src-block-backend 'listings)

(defun personal/org-present-start ()
  (setq writeroom-width 30)
  (writeroom-mode 1)
  (display-line-numbers-mode 0)
  (doom-big-font-mode 1))

(defun personal/org-present-end ()
  ;; Stop centering the document
  (setq writeroom-width 100)
  (writeroom-mode 0)
  (doom-modeline-mode 1)
  (visual-fill-column-mode 0)
  (display-line-numbers-mode 1)
  (doom-big-font-mode 0))

(defun personal/org-present-prepare-slide (buffer-name heading)
  ;; Show only top-level headlines
  (org-overview)

  ;; Unfold the current entry
  (org-fold-show-entry)

  ;; Show only direct subheadings of the slide but don't expand them
  (org-fold-show-children))

(add-hook 'org-present-mode-hook 'personal/org-present-start)
(add-hook 'org-present-mode-quit-hook 'personal/org-present-end)
(add-hook 'org-present-after-navigate-functions 'personal/org-present-prepare-slide)

(map! :leader "t p" #'org-present)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((plantuml . t))) ; this line activates plantuml

(setq org-plantuml-exec-mode 'plantuml)
(setq org-plantuml-executable-path "/usr/bin/plantuml")

(setq browse-url-browser-function 'eww-browse-url)

(add-hook 'eww-mode-hook 'writeroom-mode)

(setq elfeed-curl-max-connections 32)
(after! elfeed
  (setq elfeed-search-filter "@3-months-ago "))

(defun personal/elfeed-reload ()
  (interactive)
  "Unload, Delete and generate a new Elfeed database."
  (elfeed-db-unload)
  (let ((default-directory "~/.config/emacs/.local/elfeed/"))
    (shell-command "rm -r db"))
  (elfeed-update))

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

(add-hook 'elfeed-update-hooks #'ap/elfeed-update-counter-dec)

(setq elfeed-goodies/entry-pane-size 0.5)

(setq rmh-elfeed-org-files (list "~/doc/org/elfeed.org"))

(require 'elfeed-tube)
(elfeed-tube-setup)

(setq mpv-executable "mpv")

;; (map! :leader "e f" #'elfeed)
;; (map! :leader "e u" #'elfeed-update)
;; (map! :leader "e p" #'elfeed-tube-mpv)

(dired-launch-enable)

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

(setq avy-all-windows 't)

(map! :leader "w a" #'ace-window)

(setq minimap-window-location 'right)
(map! :leader "t m" #'minimap-mode)

(setq eradio-player '("mpv" "--no-video" "--no-terminal"))

(setq eradio-channels '(("Lofi Girl - Study" . "https://youtu.be/jfKfPfyJRdk")
                        ("Lofi Girl - Synth" . "https://youtu.be/4xDzrJKXOOY")
                        ("Lofi Girl - Piano" . "https://youtu.be/vMxYL4Cj85Y")))

(map! :leader (:prefix ("r" . "eradio") :desc "Play a radio channel" "p" 'eradio-play))
(map! :leader (:prefix ("r" . "eradio") :desc "Stop the radio player" "s" 'eradio-stop))
(map! :leader (:prefix ("r" . "eradio") :desc "Toggle the radio player" "t" 'eradio-toggle))

(defun personal/playlist-mpv ()
    "Play the media is current directory as a playlist using MPV."
    (interactive)
    (require 'vterm)
    (vterm)
    (vterm--goto-line -1)
    (vterm-send-string "mpv .")
    (vterm-send-return))

(map! :leader "p l" #'personal/playlist-mpv)

(map! :leader "d d" #'dap-debug)
(map! :leader "d c" #'dap-disconnect)
(map! :leader "d r" #'dap-debug-restart)

(map! :leader "d n" #'dap-next)
(map! :leader "d i" #'dap-step-in)
(map! :leader "d o" #'dap-step-out)

(map! :leader "d p" #'dap-breakpoint-toggle)

(map! :leader "d u s" #'dap-ui-sessions)
(map! :leader "d u p" #'dap-ui-breakpoints)

(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq lsp-idle-delay 0.500)
(setq lsp-log-io nil) ; if set to true can cause a performance hit

(defalias 'elfeed-before
   (kmacro "0 $ x d i [ 0 f [ P j 0"))
(defalias 'elfeed-after
   (kmacro "0 w d t [ f [ ; p A ] <escape> j 0"))
(defalias 'elfeed-youtube
   (kmacro "0 w c t U h t t p s : / / w w w . y o u t u b e . c o m / f e e d s / v i d e o s . x m l ? c h a n n e l _ i d = <escape> 0 w i [ [ <escape> A ] [ <escape>"))
