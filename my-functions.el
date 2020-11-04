;;; ~/.doom.d/my-functions.el -*- lexical-binding: t; -*-

(defun evil--mc-make-cursor-at-col (_startcol endcol orig-line)
  (move-to-column endcol)
  (unless (= (line-number-at-pos) orig-line)
    (evil-mc-make-cursor-here))
  )
    ;;; During visual selection point has +1 value
(defun my-evil-mc-make-vertical-cursors (beg end)
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
