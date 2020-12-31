;;; ~/.doom.d/package-config.el -*- lexical-binding: t; -*-
(use-package! deft
  :config
  (setq deft-extensions '("txt" "tex" "org")
        deft-directory slip-box-dir
        deft-recursive t)
  )

(use-package! org-pomodoro
  :config
  (setq org-pomodoro-manual-break nil))


(use-package! org-similarity
  :config
        (setq org-similarity-directory org-roam-directory)
        ;; the language passed to nltk's Snowball stemmer
        (setq org-similarity-language "english")
        ;; how many similar entries to list at the end of the buffer
        (setq org-similarity-number-of-documents 10)
        ;; whether to prepend the list entries with their cosine similarity score
        (setq org-similarity-show-scores nil)
)
;; "◉"
(use-package! org-superstar
  :config
  (setq org-superstar-headline-bullets-list '("○" "✸" "✿" "●" "►")
        inhibit-compacting-font-caches t)
  )

(use-package helm
  :config
  (setq helm-ff-fuzzy-matching t))

(setq helm-ff-fuzzy-matching t)

(use-package! pdf-tools
  :config
  (setq pdf-view-display-size 'fit-width
        pdf-view-resize-factor 1.1))

(use-package org-noter
  :after (:any org pdf-view)
  :config
  (setq
   ;; The WM can handle splits
   org-noter-notes-window-location 'horizontal-split
   ;; Please stop opening frames
   org-noter-always-create-frame nil
   ;; I want to see the whole file
   org-noter-hide-other nil
   ;; Everything is relative to the main notes file
   org-noter-notes-search-path (list  slip-box-dir)
   )
  )

(use-package! zoom
  :ensure t
  :config
  (setq
   zoom-mode t
   zoom-size '(0.7 . 0.7)
   zoom-ignore-predicates '((lambda () (
                             equal which-key-buffer-name
                                   (buffer-file-name (current-buffer)))))
   ))

(use-package org
  :ensure t
  :config
  (setq
    bidi-paragraph-direction nil
    org-id-link-to-org-use-id t ;;'create-if-interactive-and-no-custom-id

    org-outline-path-complete-in-steps nil
    org-goto-interface 'outline-path-completion

    org-ellipsis "▼"
    ;; ➡, ⚡, ▼, ↴, ∞, ⬎, ⤷, ⤵, …
    org-deadline-warning-days 7
    org-agenda-breadcrumbs-separator " ❱ "
    org-odd-levels-only  t
    org-startup-with-inline-images t
    org-hide-emphasis-markers t

    org-agenda-files '(
                       "~/google_drive/.notes/gtd/inbox.org"
                       "~/google_drive/.notes/gtd/reminders.org"
                       "~/google_drive/.notes/gtd/projects.org"
                       "~/google_drive/.notes/gtd/someday.org"
                       "~/google_drive/.notes/gtd/writing_inbox.org")

    org-refile-targets '(
                         ( org-capture-projects-file :maxlevel . 1)
                         ( org-capture-someday-file :level . 1)
                         ( org-capture-inbox-file :maxlevel . 2)
                         (nil . (:maxlevel . 9)) ;; current buffer
                         ( org-capture-reminders-file :maxlevel . 1))

    org-todo-keywords '(
                        (sequence "TODO(t)" "NEXT(n)" "HOLD(h)" "NOTE(N)" "|" "DONE(d)")
                        (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)"))

    org-agenda-block-separator " "
    org-agenda-custom-commands
    '(("o" "my agenda"
       (
        (todo "NEXT|HOLD" (
                           (org-agenda-overriding-header "\n⚡ Next up:\n")
                           (org-agenda-remove-tags t)
                           (org-agenda-prefix-format (concat "  %-2i %-13b" ))
                           (org-agenda-todo-keyword-format "")))
        (agenda "" (
                    (org-agenda-overriding-header "⚡ Schedule:\n")
                    (org-agenda-start-day "+0d")
                    (org-agenda-span 5)
                    (org-agenda-remove-tags t)
                    (org-agenda-prefix-format   (concat "  %-3i  %-15b %t%s"))
                    (org-agenda-current-time-string "⟸ now")
                    (org-agenda-scheduled-leaders '("" ""))
                    (org-agenda-time-grid (quote ((daily today remove-match)
                                                  (0900 1200 1800 2100)
                                                  "      " "┈┈┈┈┈┈┈┈┈┈┈┈┈")))))
        )
       ))
    org-capture-templates '(
                            ("t" "Todo"
                             entry
                             (file+headline org-capture-inbox-file "Tasks")
                             "* TODO %? %i")

                            ("T" "Todo with link"
                             entry
                             (file+headline org-capture-inbox-file "Tasks")
                             "* TODO %? %i\n** source: %l")

                              ("n" "Note"
                               entry
                               (file+headline org-capture-writing-inbox-file "Notes")
                               "* NOTE %? \n")

                              ("j" "Journal entry" entry (function org-journal-find-location)
                               "* %(format-time-string org-journal-time-format)%^{Title}\n%i%?")

                              ("i" "Interesting things"
                               entry
                               (file+headline org-capture-someday-file "To read/watch")
                               "** %? :bucket_list:\n")

                              ("a" "Anki basic"
                               entry
                               (file+headline org-my-anki-file "Waiting for export")
                               "* %<%H:%M> :drill: \n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: TheDeck\n:END:\n** Front\n\t%?\n** Back\n\t%i\n** Extra\n\t- source: %l")

                              ("A" "Anki close"
                               entry
                               (file+headline org-my-anki-file "Waiting for export")
                               "* %<%H:%M> :drill: \n:PROPERTIES:\n:ANKI_NOTE_TYPE: Cloze\n:ANKI_DECK: TheDeck\n:END:\n** Text\n\t%i%?\n** Extra\n\t- source: %l")

                              )
    )

  (setq org-format-latex-options
   (quote
    (:foreground default :background default :scale 2.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
         ("begin" "$1" "$" "$$" "\\(" "\\["))))

  )

(use-package! org-roam
  :hook (org-load . org-roam-mode)
  :commands (org-roam-buffer-toggle-display
             org-roam-find-file
             org-roam-graph
             org-roam-insert
             org-roam-switch-to-buffer
             org-roam-dailies-date
             org-roam-dailies-today
             org-roam-dailies-tomorrow
             org-roam-dailies-yesterday)
  :preface
  :init
  :config
  (setq
   org-roam-db-location "~/org-roam/org-roam.db"
   org-roam-directory (file-truename org-roam-directory)
   org-roam-link-title-format "§:%s"
   org-roam-completion-system 'helm
   org-roam-index-file (file-truename "~/google_drive/.notes/slip-box/index.org")

   org-roam-capture-templates
      '(("d" "default" plain (function org-roam-capture--get-point)
          "%?"
          :file-name "%<%Y-%m-%d>-${slug}"
          :head "#+TITLE: ${title}\n"
          :unnarrowed t))

;;   org-roam-capture-ref-templates
;;       '(("r" "ref" plain (function org-roam-capture--get-point)
;;           "%?"
;;           :file-name "lit/${slug}"
;;           :head "#+setupfile:./hugo_setup.org
;; #+roam_key: ${ref}
;; #+hugo_slug: ${slug}
;; #+roam_tags: website
;; #+title: ${title}\n"))
        )
        (set-company-backend! 'org-mode '(company-capf company-yasnippet company-dabbrev))
  )

(add-hook 'org-roam-buffer-prepare-hook #'hide-mode-line-mode)

;; Since the org module lazy loads org-protocol (waits until an org URL is
;; detected), we can safely chain `org-roam-protocol' to it.
(use-package org-roam-protocol
  :after org-protocol)



(require 'org-ref)
(setq
 org-ref-bibliography-notes "~/google_drive/.notes/.bibliography/bibliography_notes.org"
 org-ref-default-bibliography "~/google_drive/.notes/.bibliography/references.bib"
 org-ref-pdf-directory "~/google_drive/.notes/.bibliography/bibtex_pdf"
 org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
 ;; org-ref-note-title-format "* TODO %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :END:\n\n"
 org-ref-notes-directory "~/google_drive/.notes/literature-notes/"
 org-ref-notes-function 'orb-edit-notes)

(setq
    bibtex-completion-bibliography "~/google_drive/.notes/.bibliography/references.bib"
    bibtex-completion-library-path '( "~/google_drive/.notes/.bibliography/bibtex_pdf")
    bibtex-completion-notes-path "~/google_drive/.notes/literature-notes"
    bibtex-completion-pdf-field "File"
    bibtex-completion-notes-template-multiple-files
    (concat
    "#${title} \n"
    "#+ROAM_KEY: cite:${=key=}\n"
    ":PROPERTIES:\n"
    ":Custom_ID: ${=key=}\n"
    ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
    ":AUTHOR: ${author-abbrev}\n"
    ":JOURNAL: ${journaltitle}\n"
    ":DATE: ${date}\n"
    ":YEAR: ${year}\n"
    ":DOI: ${doi}\n"
    ":URL: ${url}\n"
    ":END:\n\n"
    "* Notes\n")
    bibtex-completion-find-additional-pdfs t)

(use-package org-roam-bibtex
  :after (org-roam)
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (setq orb-preformat-keywords '("=key=" "title" "url" "file" "author-or-editor" "keywords")
        orb-templates'(("r" "ref" plain #'org-roam-capture--get-point "" :file-name "Notes: ${title}" :head "#+TITLE: ${title}\n#+ROAM_KEY: ${ref}\n- tags ::\n- keywords :: ${keywords}\n\n:PROPERTIES:\n:Custom_ID: ${=key=}\n:URL: ${url}\n:AUTHOR: ${author-or-editor}\n" :unnarrowed t)))
            ;; "- tags ::\n- keywords :: ${keywords}\n\n* ${title}\n:PROPERTIES:\n:Custom_ID: ${=key=}\n:URL: ${url}\n:AUTHOR: ${author-or-editor}\n:NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n:NOTER_PAGE: \n:END:\n\n * Notes"
  )

;; Anki configuration
(use-package anki-editor
  :after org
  :bind (:map org-mode-map
         ("<f5>" . anki-editor-cloze-region-auto-incr)
         ("C-<f5>" . anki-editor-cloze-region-dont-incr)
         ("<f6>" . anki-editor-reset-cloze-number)
         ("<f7>"  . anki-editor-push-tree))
  :hook (org-capture-after-finalize . anki-editor-reset-cloze-number) ; Reset cloze-number after each capture.
  :config

  (setq anki-editor-create-decks t ;; Allow anki-editor to create a new deck if it doesn't exist
        anki-editor-org-tags-as-anki-tags t)

  (defun anki-editor-cloze-region-auto-incr (&optional arg)
    "Cloze region without hint and increase card number."
    (interactive)
    (anki-editor-cloze-region my-anki-editor-cloze-number "")
    (setq my-anki-editor-cloze-number (1+ my-anki-editor-cloze-number))
    (forward-sexp))

  (defun anki-editor-cloze-word-under-cursor-auto-incr (&optional arg)
    "Cloze region without hint and increase card number."
    (interactive)
    (evil-backward-word-begin)
    (evil-visual-char)

    ;; (evil-select-an-object 'evil-symbol beg end type 1))
    ;; (evil-select-an-object)
    (evil-forward-word-end)
    ;; (evil-forward-char)
    (anki-editor-cloze-region my-anki-editor-cloze-number "")
    (setq my-anki-editor-cloze-number (1+ my-anki-editor-cloze-number))
    (forward-sexp))

  (defun anki-editor-cloze-region-dont-incr (&optional arg)
    "Cloze region without hint using the previous card number."
    (interactive)
    (anki-editor-cloze-region (1- my-anki-editor-cloze-number) "")
    (forward-sexp))

  (defun anki-editor-reset-cloze-number (&optional arg)
    "Reset cloze number to ARG or 1"
    (interactive)
    (setq my-anki-editor-cloze-number (or arg 1)))

  (defun anki-editor-push-tree ()
    "Push all notes under a tree."
    (interactive)
    (anki-editor-push-notes '(4))
    (anki-editor-reset-cloze-number))

  ;; Initialize
  (anki-editor-reset-cloze-number))

(use-package hydra
  :defer 5
  :bind (("C-c C-w" . hydra-window-resize/body)
         ("C-c  C-u" . hydra-outline/body)
         ("C-x  C-m " . multiple-cursors-hydra/body)
         ("C-x  C-'" . hydra-fold/body))
  :config
  (defhydra hydra-expand-region ()
    "region: "
    ("k" er/expand-region "expand")
    ("j" er/contract-region "contract"))
  (general-def 'visual 'global "v" 'hydra-expand-region/body)

  (defhydra hydra-fold (:pre (hs-minor-mode 1))
    "fold"
    ("t" fold-dwim-toggle "toggle")
    ("h" fold-dwim-hide-all "hide-all")
    ("s" fold-dwim-show-all "show-all")
    ("q" nil "quit"))

  (defun my-funcs/resize-window-down ()
    "Resize a window downwards."
    (interactive)
    (if (window-in-direction 'below)
        (enlarge-window 1)
      (shrink-window 1)))
  (defun my-funcs/resize-window-up ()
    "Resize a window upwards."
    (interactive)
    (if (window-in-direction 'above)
        (enlarge-window 1)
      (shrink-window 1)))
  (defun my-funcs/resize-window-left ()
    "Resize a window leftwards."
    (interactive)
    (if (window-in-direction 'left)
        (enlarge-window-horizontally 1)
      (shrink-window-horizontally 1)))
  (defun my-funcs/resize-window-right ()
    "Resize a window rightwards."
    (interactive)
    (if (window-in-direction 'right)
        (enlarge-window-horizontally 1)
      (shrink-window-horizontally 1)))
  (defhydra hydra-window-resize (global-map "C-c w")
    "Window resizing"
    ("j" my-funcs/resize-window-down "down")
    ("k" my-funcs/resize-window-up "up")
    ("l" my-funcs/resize-window-right "right")
    ("h" my-funcs/resize-window-left "left"))

  (defhydra hydra-outline (:color pink :hint nil)
    "
 ^Hide^             ^Show^           ^Move
 ^^^^^^------------------------------------------------------
 _q_: sublevels     _a_: all         _u_: up
 _t_: body          _e_: entry       _n_: next visible
 _o_: other         _i_: children    _p_: previous visible
 _c_: entry         _k_: branches    _f_: forward same level
 _l_: leaves        _s_: subtree     _b_: backward same level
 _d_: subtree   _<tab>_: cycle
 "
    ;; Hide
    ("q" hide-sublevels)  ; Hide everything but the top-level headings
    ("t" hide-body)    ; Hide everything but headings (all body lines)
    ("o" hide-other)   ; Hide other branches
    ("c" hide-entry)   ; Hide this entry's body
    ("l" hide-leaves)  ; Hide body lines in this entry and sub-entries
    ("d" hide-subtree) ; Hide everything in this entry and sub-entries
    ;; Show
    ("a" show-all)                      ; Show (expand) everything
    ("e" show-entry)                    ; Show this heading's body
    ("i" show-children) ; Show this heading's immediate child sub-headings
    ("k" show-branches) ; Show all sub-headings under this heading
    ("s" show-subtree) ; Show (expand) everything in this heading & below
    ("<tab>" org-cycle)
    ;; Move
    ("u" outline-up-heading)               ; Up
    ("n" outline-next-visible-heading)     ; Next
    ("p" outline-previous-visible-heading) ; Previous
    ("f" outline-forward-same-level)       ; Forward - same level
    ("b" outline-backward-same-level)      ; Backward - same level
    ("z" nil "leave"))

  (defhydra multiple-cursors-hydra (:hint nil)
    "
      ^Up^            ^Down^        ^Other^
 ----------------------------------------------
 [_p_]   Next    [_n_]   Next    [_l_] Edit lines
 [_P_]   Skip    [_N_]   Skip    [_a_] Mark all
 [_M-p_] Unmark  [_M-n_] Unmark  [_r_] Mark by regexp
 ^ ^             ^ ^             [_q_] Quit
 "
    ("l" mc/edit-lines :exit t)
    ("a" mc/mark-all-like-this :exit t)
    ("n" mc/mark-next-like-this)
    ("N" mc/skip-to-next-like-this)
    ("M-n" mc/unmark-next-like-this)
    ("p" mc/mark-previous-like-this)
    ("P" mc/skip-to-previous-like-this)
    ("M-p" mc/unmark-previous-like-this)
    ("r" mc/mark-all-in-region-regexp :exit t)
    ("q" nil))
  (defhydra hydra-origami (:color red)
    "
  _o_pen node    _n_ext fold       toggle _f_orward    _t_oggle recursively
  _c_lose node   _p_revious fold   toggle _a_ll
  "
    ("o" origami-open-node)
    ("t" origami-recursively-toggle-node)
    ("c" origami-close-node)
    ("n" origami-next-fold)
    ("p" origami-previous-fold)
    ("f" origami-forward-toggle-node)
    ("a" origami-toggle-all-nodes))
  )
(setq olivetti-body-width 100)

(set-company-backend! 'matlab-mode '(company-capf company-yasnippet company-dabbrev))
(custom-set-variables '(matlab-shell-command-switches '("-nodesktop -nosplash -nodisplay")))

(add-hook! matlab-mode #'doom/toggle-line-numbers)

;; add at top of org file: #+LATEX_CLASS: tufte-book
;; (with-eval-after-load 'ox-latex
;;   (append-to-list
;;    'org-latex-classes
;;    '(("tufte-book"
;;       "\\documentclass[a4paper, sfsidenotes, justified, notitlepage]{tufte-book}
;;      \\input{~/google_drive/laTex_templates/tufte-book.tex}"
;;       ("\\part{%s}" . "\\part*{%s}")
;;       ("\\chapter{%s}" . "\\chapter*{%s}")
;;       ("\\section{%s}" . "\\section*{%s}")
;;       ("\\subsection{%s}" . "\\subsection*{%s}")))))

(use-package roam-block
  :load-path "/home/jonathan/.emacs.d/manually-installed-packages/roam-block"
  :hook (after-init . roam-block-mode)
  :init (setq roam-block-home '("/home/jonathan/.emacs.d/manually-installed-packages/roam-block/home")
              roam-block-ref-highlight t
              roam-block-embed-highlight t)
  :bind
  (:map roam-block-mode-map
        (("C-c b r s" . roam-block-ref-store)
         ("C-c b r i" . roam-block-ref-insert)
         ("C-c b r d" . roam-block-ref-delete)
         ("C-c b r t" . roam-block-ref-highlight-toggle)
         ("C-c b e s" . roam-block-embed-store)
         ("C-c b e i" . roam-block-embed-insert)
         ("C-c b e t" . roam-block-embed-highlight-toggle)
         ("C-c b d" . roam-block-delete-block))))
