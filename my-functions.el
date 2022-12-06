;;; ~/.doom.d/my-functions.el -*- lexical-binding: t; -*-
(defun evil--mc-make-cursor-at-col (_startcol endcol orig-line)
  (move-to-column endcol)
  (unless (= (line-number-at-pos) orig-line)
    (evil-mc-make-cursor-here))
  )
    ;;; During visual selection point has +1 value
(defun my/evil-mc-make-vertical-cursors (beg end)
  (interactive (list (region-beginning) (- (region-end) 1)))
  (evil-exit-visual-state)
  (evil-mc-pause-cursors)
      ;;; Because `evil-mc-resume-cursors` produces a cursor,
      ;;; we have to skip a current line here to avoid having +1 cursor
  (apply-on-rectangle #'evil--mc-make-cursor-at-col
                      beg end (line-number-at-pos))
  (evil-mc-resume-cursors)
      ;;; Because `evil-mc-resume-cursors` produces a cursor, we need to place it on on the
      ;;; same column as the others
  (move-to-column (evil-mc-column-number end))
  ;; (evil-digit-argument-or-evil-beginning-of-line)
  ;; (evil-beginning-of-visual-line)
  )

(defun org-journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.
  ;; (goto-char (point-min)))
  )

(defun get-buffers-matching-mode (mode)
  "Returns a list of buffers where their major-mode is equal to MODE"
  (let ((buffer-mode-matches '()))
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (if (eq mode major-mode)
            (push 'buffer-mode-matches buf))))
    buffer-mode-matches))

(defun multi-occur-in-this-mode ()
  "Show all lines matching REGEXP in buffers with this major mode."
  (interactive)
  (multi-occur
   (get-buffers-matching-mode major-mode)
   (car (occur-read-primary-args))))

(defun my/org-search ()
  (interactive)
  (org-refile '(4)))

(defun my/org-archive-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
   "/DONE" 'agenda))

(defun my/paragraph-LTR ()
  (interactive)
  (setq bidi-paragraph-direction 'left-to-right))


(defun my/paragraph-RTL ()
  (interactive)
  (setq bidi-paragraph-direction 'right-to-left))


(defun my_refile(file headline)
  (let ((pos (save-excursion
               (find-file file)
               (org-find-exact-headline-in-buffer headline))))
    (org-refile nil nil (list headline file nil pos)))
  ;; (switch-to-buffer (current-buffer))
  )

(defun my_get_anki_cloze()
  (interactive)
  (when (looking-at ".*[.*].*$")
    (save-excursion
      (beginning-of-line)
      (setq question
            (buffer-substring-no-properties (point) (line-end-position)))
      (with-temp-buffer
        (insert "
** Question %^G
:PROPERTIES:
:ANKI_NOTE_TYPE: Cloze
:ANKI_DECK: 
:END:
*** Text
\t"
                question
                "
*** Extra
\t"
                )

        (search-backward "Question")
        (my_refile org-my-anki-file "Waiting for export")))))

(defun my_get_anki_question()
  (interactive)
  (when (looking-at ".*Q\..*$")
    (beginning-of-line)
    (search-forward "Q.")
    (setq question (string-trim-left (concat (org-get-heading) "\n" (org-get-entry)) "\t*\**Q\."))
    (search-forward "A.")
    (setq answer (string-trim-left (concat (org-get-heading) "\n" (org-get-entry)) "\t*\**A\."))
    (save-excursion
      (with-temp-buffer
        (insert "
** Question %^G
:PROPERTIES:
:ANKI_NOTE_TYPE: Basic
:ANKI_DECK: TheDeck
:END:
*** Front
\t"
                question
                "
*** Back
\t"
                answer)

        (search-backward "drill")
        (my_refile org-my-anki-file "Waiting for export")))))


(defun my/org-open-other-window ()
  "Jump to bookmark in another frame. See `bookmark-jump' for more."
  (interactive)
  (let ((org-link-frame-setup (acons 'file 'find-file-other-window org-link-frame-setup)))
    (org-open-at-point)))

(map! :prefix "g" :nv "F" nil)
(map! :prefix "g" :nv "F" 'my/org-open-other-window)

(defun ar/toggle-quote-wrap-all-in-region (beg end)
  "Toggle wrapping all items in region with double quotes."
  (interactive (list (mark) (point)))
  (unless (region-active-p)
    (user-error "no region to wrap"))
  (let ((deactivate-mark nil)
        (replacement (string-join
                      (mapcar (lambda (item)
                                (if (string-match-p "^\".*\"$" item)
                                    (string-trim item "\"" "\"")
                                  (format "\"%s\"" item)))
                              (split-string (buffer-substring beg end)))
                      " ")))
    (delete-region beg end)
    (insert replacement)))

(defun my/search-replace ()
  (interactive)
  (if (use-region-p) (my/search-replace-in-region) (evil-ex "%s/"))
  )

(defun my/search-replace-in-region ()
  (interactive)
  (let ((evil-ex-initial-input "s/"))
    (call-interactively 'evil-ex))
  )

(evil-define-command my/evil-insert-char (count char)
  (interactive "<c><C>")
  (setq count (or count 1))
  (insert (make-string count char)))

(evil-define-command my/evil-append-char (count char)
  (interactive "<c><C>")
  (setq count (or count 1))
  (when (not (eolp))
    (forward-char))
  (insert (make-string count char)))

(defun my/visual-inside-org-header()
  (interactive)
  (evil-middle-of-visual-line)
  (evil-org-beginning-of-line)
  (evil-visual-char)
  (end-of-line))

(defun my/fix-windows-bib-file()
  (interactive)
  (let ((case-fold-search t)) ; or nil
    (goto-char (point-min))
    (while (search-forward "C\\\:" nil t)
      (replace-match "c:\/"))

    (goto-char (point-min))
    (while (search-forward "\\\\" nil t)
      (replace-match "\/"))

    (goto-char (point-min))
    (while (search-forward "G\\\:" nil t)
      (replace-match "g:\/")

      ))

  (save-buffer)
  )

(defun my/convert-windows-to-linux-paths()
  (interactive)
  (let ((case-fold-search t)) ; or nil
    (goto-char (point-min))
    (while (search-forward "C\\:" nil t)
      (replace-match "\/mnt\/c"))

    (goto-char (point-min))
    (while (search-forward "\\\\" nil t)
      (replace-match "\/"))
    (save-buffer) ;; repeat for other string pairs

    (goto-char (point-min))
    (while (search-forward "G\\:" nil t)
      (replace-match "\/mnt\/g")

      (save-buffer)
      )))

(defun my/get-buffer-name()
  "Copy and show the name of the current buffer."
  (interactive)
  (kill-new (buffer-name))
  (message "%s" (buffer-name)))

(defun my/org-roam-create-note-from-headline ()
  "Create an Org-roam note from the current headline and jump to it.

Normally, insert the headline’s title using the ’#title:’ file-level property
and delete the Org-mode headline. However, if the current headline has a
Org-mode properties drawer already, keep the headline and don’t insert
‘#+title:'. Org-roam can extract the title from both kinds of notes, but using
‘#+title:’ is a bit cleaner for a short note, which Org-roam encourages."
  (interactive)
  (let ((title (nth 4 (org-heading-components)))
        (has-properties (org-get-property-block)))
    (org-cut-subtree)
    (org-roam-find-file title nil nil 'no-confirm)
    (org-paste-subtree)
    (unless has-properties
      (kill-line)
      (while (outline-next-heading)
        (org-promote)))
    (goto-char (point-min))
    (when has-properties
      (kill-line)
      (kill-line))))

(defun my/export-org-to-docx ()
  "Export the current org file as a docx via markdown."
  (interactive)
  (let* ((bibfile (expand-file-name (car (org-ref-find-bibliography))))
         ;; this is probably a full path
         (current-file (buffer-file-name))
         (basename (file-name-sans-extension current-file))
         (docx-file (concat basename ".docx")))
    (save-buffer)
    (when (file-exists-p docx-file) (delete-file docx-file))
    (shell-command (format
                    ;; "pandoc -s -S %s -o %s"
                    ;; (shell-quote-argument current-file) (shell-quote-argument docx-file)))
                    "pandoc -s -S --bibliography=%s %s -o %s"
                    (shell-quote-argument bibfile) (shell-quote-argument current-file) (shell-quote-argument docx-file)))
    ))

(defun helm-bibtex-format-pandoc-citation (keys)
  (concat "[" (mapconcat (lambda (key) (concat "@" key)) keys "; ") "]"))

;; inform helm-bibtex how to format the citation in org-mode
;; (setf (cdr (assoc 'org-mode bibtex-completion-format-citation-functions))
;;   'helm-bibtex-format-pandoc-citation)

(setq bibtex-completion-format-citation-functions
      '((org-mode      . helm-bibtex-format-pandoc-citation)
        (latex-mode    . bibtex-completion-format-citation-cite)
        (markdown-mode . bibtex-completion-format-citation-pandoc-citeproc)
        (default       . bibtex-completion-format-citation-default)))
(setq bibtex-completion-additional-search-fields '(keywords))
(defun my/yank-org-headline ()
  (interactive)
  (let
      ((text (nth 4 (org-heading-components))))
    (kill-new text)))

;; (make-temp-name
;;  (concat (s-replace  "/mnt/c/Users/Jonathan/Google Drive/" "/home/jonathan/google_drive/" (buffer-file-name))
;;          "_"
;;          (format-time-string "%Y%m%d_%H%M%S_"))) ".png"))
(defun my/org-paste-image ()
  "Paste an image into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (let* ((target-file
          (concat
           (make-temp-name
            (concat "/home/jonathan/google_drive/.notes/associated_images/" (buffer-name)
                    "_"
                    (format-time-string "%Y%m%d_%H%M%S_"))) ".jpeg"))
         (wsl-path
          (concat (as-windows-path(file-name-directory target-file))
                  "\\"
                  (file-name-nondirectory target-file)))
         (ps-script
          (concat "(Get-Clipboard -Format image).Save('" wsl-path "')")))

    (powershell ps-script)

    (if (file-exists-p target-file)
        (progn (insert (concat "[[" target-file "]]"))
               (org-display-inline-images))
      (user-error wsl-path)
      (user-error
       "Error pasting the image, make sure you have an image in the clipboard!"))
    ))

(defun my/capture-screen ()
  (interactive)
  (let* ((ps-script "[system.windows.forms.sendkeys]::sendwait('{PRTSC}')"))
    (powershell ps-script)
    )
  )

(defun as-windows-path (unix-path)
  ;; "Takes a unix path and returns a matching WSL path
  ;; (e.g. \\wsl$\Ubuntu-20.04\tmp)"
  ;; substring removes the trailing \n
  (substring
   (shell-command-to-string
    (concat "wslpath -w " unix-path)) 0 -1))

(defun powershell (script)
  "executes the given script within a powershell and returns its return value"
  (call-process "powershell.exe" nil nil nil
                "-Command" (concat "& {" script "}")))

(defun my/fix-hebrew-hyphen()
  "Hide Org property drawer using text properties.
Based on the code shared at
https://org-roam.discourse.group/t/org-roam-major-redesign/1198/34."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "־" nil t)
      (replace-match "-"))
    ))

(defun my/org-hide-properties-display ()
  "Hide Org property drawer using text properties.
Based on the code shared at
https://org-roam.discourse.group/t/org-roam-major-redesign/1198/34."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward
            "^ *:PROPERTIES:\n\\( *:.+?:.*\n\\)+ *:END:\n" nil t)
      (add-text-properties (match-beginning 0) (match-end 0)
                           (list 'display ""
                                 'line-prefix "⋮ ")))))

(defun my/org-show-properties-display ()
  "Show Org property drawer using text properties.
Based on the code shared at
https://org-roam.discourse.group/t/org-roam-major-redesign/1198/34."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward
            "^ *:PROPERTIES:\n\\( *:.+?:.*\n\\)+ *:END:\n" nil t)
      (remove-list-of-text-properties (match-beginning 0) (match-end 0)
                                      (list 'display
                                            'line-prefix)))))

(defun my/helm-or-evil-escape ()
  "Escape from anything."
  (interactive)
  (cond ((minibuffer-window-active-p (minibuffer-window))
         ;; quit the minibuffer if open.
         (abort-recursive-edit))
        ;; Run all escape hooks. If any returns non-nil, then stop there.
        ;; ((cl-find-if #'funcall doom-escape-hook))
        ;; don't abort macros
        ((or defining-kbd-macro executing-kbd-macro) nil)
        ;; Back to the default
        ((keyboard-quit))))


                                        ; alternate whitespace-mode with whitespace.el defaults, doom defaults and off:

(defun my/set-whitespace-defaults()
                                        ; only save the values the first time we get here
  (unless (boundp 'my/default-whitespace-style)
    (setq bh:default-whitespace-style                (default-value 'whitespace-style)
          bh:default-whitespace-display-mappings     (default-value 'whitespace-display-mappings)
          bh:doom-whitespace-style                   whitespace-style
          bh:doom-whitespace-display-mappings        whitespace-display-mappings
          bh:whitespace-mode                         "doom")))

                                        ; whitespace-style etc are set up with default-values in whitespace.el and then
                                        ; modified in doom-highlight-non-default-indentation-h (in core/core-ui.el).
                                        ; This is added to after-change-major-mode-hook in doom-init-ui-h (in
                                        ; core/core-ui.el) and called a LOT: so I need to capture doom's modified
                                        ; settings after that. The trouble is, this file (config.el) is called _before_
                                        ; doom-init-ui-h which is called in window-setup-hook as the last gasp of
                                        ; doom-initialize! find-file-hook appears to work.

(add-hook 'find-file-hook #'my/set-whitespace-defaults 'append)

                                        ; doom=>default=>off=>doom=>...
(defun my/toggle-whitespace () (interactive)
       (cond ((equal my/whitespace-mode "doom")
              (setq whitespace-style my/default-whitespace-style
                    whitespace-display-mappings my/default-whitespace-display-mappings
                    my/whitespace-mode "default")
              (prin1 (concat "whitespace-mode is whitespace default"))
              (whitespace-mode))
             ((equal my/whitespace-mode "default")
              (setq my/whitespace-mode "off")
              (prin1 (concat "whitespace-mode is off"))
              (whitespace-mode -1))
             (t ; (equal my/whitespace-mode "off")
              (setq whitespace-style my/doom-whitespace-style
                    whitespace-display-mappings my/doom-whitespace-display-mappings
                    my/whitespace-mode "doom")
              (prin1 (concat "whitespace-mode is doom default"))
              (whitespace-mode))))

(global-set-key (kbd "C-<f4>")          'my/toggle-whitespace)

(defun my/org-toggle-item
    (interactive)
  (org-toggle-item)
  (org-end-of-line)
  )


(defun open-file-in-browser (file) (browse-url-of-file file))
;; (defun export-to-html-and-open (file)
;;   (let* (html-filename (org-html-export-to-html file))
;;        (open-file-in-browser html-filename)))
(map! :map embark-file-map "O" #'open-file-in-browser)
(map! :map embark-file-map "F" #'citar-file-open-external)
(map! :map embark-file-map "C-o" #'find-file-other-frame)
(map! :map embark-general-map "W" #'widen)
(map! :map citar-citation-map "f" #'citar-file-open-external)

;; (defun my/set-writeroom-width ()
;;   (interactive)
;;   (setq writeroom-width (if writeroom-width )))

(defun my/orgnv-update-db ()
  (setq orgnv--database (orgnv-build-database))
  )

(defmacro wsl--open-with (id &optional app dir)
  `(defun ,(intern (format "wsl/%s" id)) ()
     (interactive)
     (wsl-open-with ,app ,dir)))

(defun wsl-open-with (&optional app-name path)
  "Send PATH to APP-NAME on WSL."
  (interactive)
  (let* ((path (expand-file-name
                (replace-regexp-in-string
                 "'" "\\'"
                 (or path (if (derived-mode-p 'dired-mode)
                              (dired-get-file-for-visit)
                            (buffer-file-name)))
                 nil t)))
         (command (format "%s `wslpath -w %s`" (shell-quote-argument app-name) path)))
    (shell-command-to-string command)))

(wsl--open-with open-in-default-program "explorer.exe" buffer-file-name)
(wsl--open-with reveal-in-explorer "explorer.exe" default-directory)
;; M-x wsl/open-in-default-program
;; M-x wsl/reveal-in-explorer
(defun my/open-current-with (arg)
  "Open visited file in default external program.

With a prefix ARG always prompt for command to use."
  (interactive "P")
  (when buffer-file-name
    (shell-command (concat
                    (read-shell-command "Open current file with: ")
                    " "
                    (shell-quote-argument buffer-file-name)))))
(global-set-key (kbd "C-c O") #'my/open-current-with)

(defun my/org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
   same directory as the org-buffer and insert a link to this file."
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat (buffer-file-name)
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  ;; (shell-command "snippingtool /clip")
  (shell-command (concat "powershell -command \"Add-Type -AssemblyName System.Windows.Forms;if ($([System.Windows.Forms.Clipboard]::ContainsImage())) {$image = [System.Windows.Forms.Clipboard]::GetImage();[System.Drawing.Bitmap]$image.Save('" filename "',[System.Drawing.Imaging.ImageFormat]::Png); Write-Output 'clipboard content saved as file'} else {Write-Output 'clipboard does not contain image data'}\""))
  (insert (concat "[[file:" filename "]]"))
  (org-display-inline-images))


(defun as-windows-path (unix-path)
  ;; "Takes a unix path and returns a matching WSL path
  ;; (e.g. \\wsl$\Ubuntu-20.04\tmp)"
  ;; substring removes the trailing \n
  (substring
   (shell-command-to-string
    (concat "wslpath -w " unix-path)) 0 -1))

(defun powershell (script)
  "executes the given script within a powershell and returns its return value"
  (call-process "powershell.exe" nil nil nil
                "-Command" (concat "& {" script "}")))

(defun format-image-inline (source attributes info)
  (let* ((ext (file-name-extension source))
         (prefix (if (string= "svg" ext) "data:image/svg+xml;base64," "data:;base64,"))
         (data (with-temp-buffer (url-insert-file-contents source) (buffer-string)))
         (data-url (concat prefix (base64-encode-string data)))
         (attributes (org-combine-plists `(:src ,data-url) attributes)))
    (org-html-close-tag "img" (org-html--make-attribute-string attributes) info)))

(defun matlab-shell-help-at-point ()
  (interactive)
  (let ((fcn (matlab-read-word-at-point)))
    (if (and fcn (not (equal fcn "")))
        (matlab-shell-describe-command fcn))))

(defhydra my/mc-hydra (:color pink
                       :hint nil
                       :pre (evil-mc-pause-cursors))
  "
^Match^            ^Line-wise^           ^Manual^
^^^^^^----------------------------------------------------
_Z_: match all     _j_: make & go down   _z_: toggle here
_n_: make & next   _k_: make & go up     _r_: remove last
_N_: make & prev   ^ ^                   _R_: remove all
_s_: skip & next   ^ ^                   _p_: pause/resume
_S_: skip & prev

Current pattern: %`evil-mc-pattern

"
  ;; (setq evil-mc-pattern (buffer-substring region-beginning region-end))

  ("Z" #'evil-mc-make-all-cursors)
  ("n" #'evil-mc-make-and-goto-next-match)
  ("N" #'evil-mc-make-and-goto-prev-match)
  ("s" #'evil-mc-skip-and-goto-next-match)
  ("S" #'evil-mc-skip-and-goto-prev-match)
  ("k" #'evil-mc-make-cursor-move-next-line)
  ("j" #'evil-mc-make-cursor-move-prev-line)
  ("z" #'my/make-cursor-here)
  ("r" #'+multiple-cursors/evil-mc-undo-cursor)
  ("R" #'evil-mc-undo-all-cursors)
  ("p" #'+multiple-cursors/evil-mc-toggle-cursors)
  ("q" #'evil-mc-resume-cursors "quit" :color blue)
  ("<escape>" #'evil-mc-resume-cursors "quit" :color blue))

(defun my/revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer :ignore-auto :noconfirm))

(shell-command-to-string "wslpath -w '/mnt/g/My Drive/notes/gtd/inbox.org_20220410_170636_v4R344.png'")

(defun my/make-cursor-here ()
  (interactive)
  (+multiple-cursors/evil-mc-toggle-cursor-here)
  (evil-mc-pause-cursors))

;; Use Fira Code font faces in current buffer
(defun my-buffer-face-mode-programming ()
  "Sets a fixed width (monospace) font in current buffer"
  (interactive)
  ;; (setq buffer-face-mode-face '(:extend t :family "Fira Code"))
  (setq buffer-face-mode-face '(:extend t :family "Roboto Mono"))
  (buffer-face-mode))

(defun my-buffer-face-mode-text ()
  (interactive)
  (setq buffer-face-mode-face '(:extend t :family "Heebo"))
  (buffer-face-mode))

(defun my/toggle-writing-mode ()
  "Toggle a distraction-free environment for writing."
  (interactive)
  (cond ((bound-and-true-p olivetti-mode)
         (olivetti-mode -1)
         (olivetti-toggle-hide-modeline)
         (toggle-frame-fullscreen)
         (menu-bar-mode 1))
        (t
         (olivetti-mode 1)
         (olivetti-toggle-hide-modeline)
         (toggle-frame-fullscreen)
         (menu-bar-mode -1))))

(defun my/bash-shell ()
  (interactive)
  (let ((shell-file-name "C:\\Windows\\System32\\bash.exe" ))
    (shell "*bash*"))
  )

(defun my/indent-buffer ()
  (interactive)
  (save-excursion
    (evil-indent (point-min) (point-max))
    ))
