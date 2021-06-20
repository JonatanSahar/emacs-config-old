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

(defun my/org-font ()
  (interactive)
  (face-remap-add-relative 'default :family "alef" :height 190))

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
** Question :drill:
:PROPERTIES:
:ANKI_NOTE_TYPE: Cloze
:ANKI_DECK: TheDeck
:END:
*** Text
\t"
                       question
                       "
*** Extra
\t"
                       )

             (search-backward "drill")
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
** Question :drill:
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

(defun my/search-replace-in-region ()
  (interactive)
  (setq evil-ex-initial-input "s/")
  (call-interactively 'evil-ex)
  )

(defun my/make-list()
  (interactive)
  (concat ":'<,'>s/^/\"/" (kbd "RET") "gv=gv")
  (evil-visual-restore)
  (concat ":'<,'>s/\n/\", /" (kbd "RET"))
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


(defun my/convert-windows-to-linux-paths()
  (interactive)
        (let ((case-fold-search t)) ; or nil
                (goto-char (point-min))
                (while (search-forward "C\\:" nil t)
                (replace-match "\/mnt\/c"))

                (goto-char (point-min))
                (while (search-forward "\\\\" nil t)
                (replace-match "\/"))
                (save-buffer)
  ;; repeat for other string pairs
  ))

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
