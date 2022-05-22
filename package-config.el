;;; ~/.doom.d/package-config.el -*- lexical-binding: t; -*-
;; (use-package! deft
;;   :config
;;   (setq deft-extensions '("txt" "tex" "org")
;;         deft-directory slip-box-dir
;;         ;; deft-strip-title-regexp ":PROPERTIES:\n\\(.+\n\\)+:END:\n#+title:"
;;         deft-strip-summary-regexp ":PROPERTIES:\n\\(.+\n\\)+:END:\n#+.*"
;;         deft-use-filename-as-title t
;;         deft-recursive t)
;;   )

(use-package! org-pomodoro
  :config
  (setq org-pomodoro-manual-break nil))


(use-package! org-superstar
  :config
  (setq org-superstar-headline-bullets-list '("\u200b" "\u200b" "○" "\u200b" "●" "○" "✿"  "●" )
  ;; (setq org-superstar-headline-bullets-list '("\u200b" "\u200b" "○" "●" "✸" "○" "✿" "►" "●" )
        inhibit-compacting-font-caches t)
  (setq org-superstar-item-bullet-alist '((42 . 45) (43 . 42) (45 . 43)))
  )

;; (use-package helm
;;   :init
;;   (setq helm-ff-fuzzy-matching t))

 ;; (after! helm
;;   (setq helm-ff-fuzzy-matching t))

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
   org-noter-default-notes-file-names '("misc-literature-notes.org")
   org-noter-separate-notes-from-heading t))

(use-package org
  :config
  (setq
    bidi-paragraph-direction nil
    org-id-link-to-org-use-id 'create-if-interactive
    org-id-method 'ts
    org-outline-path-complete-in-steps nil
    org-goto-interface 'outline-path-completion
    org-cycle-separator-lines 1
    ;; org-image-actual-width nil
    org-export-with-toc 'nil
    org-image-actual-width (list 550)
    org-ellipsis "…"
    ;; ➡, ⚡, ▼, ↴, ∞, ⬎, ⤷, ⤵, …
    org-deadline-warning-days 7
    org-agenda-breadcrumbs-separator " ❱ "
    org-odd-levels-only  t
    org-startup-with-inline-images t
    org-hide-emphasis-markers t
    org-list-indent-offset 2
    org-list-demote-modify-bullet
       '(("+" . "*") ("-" . "+") ("*" . "-"))
    org-agenda-files '(
                       "~/google_drive/notes/gtd/inbox.org"
                       "~/google_drive/notes/gtd/reminders.org"
                       "~/google_drive/notes/gtd/projects.org"
                       "~/google_drive/notes/gtd/someday.org"
                       "~/google_drive/notes/gtd/writing_inbox.org")

    org-refile-targets '(
                         ( org-capture-projects-file :maxlevel . 1)
                         ( org-capture-someday-file :level . 1)
                         ( org-capture-inbox-file :maxlevel . 2)
                         (nil . (:maxlevel . 9)) ;; current buffer
                         ( org-capture-reminders-file :maxlevel . 1))

    org-todo-keywords '(
                        (sequence "TODO(t)" "NEXT(n)" "READ(r)" "NOTE(N)" "|" "DONE(d)")
                        (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)"))

    org-agenda-block-separator " "
    org-agenda-custom-commands
    '(("o" "my agenda"
       (
        (todo "NEXT|HOLD" (
                           (org-agenda-overriding-header "\n⚡ Next up:\n")
                           (org-agenda-remove-tags t)
                           (org-agenda-prefix-format (concat "  %-2i  %t%s" ))
                           ;; (org-agenda-prefix-format (concat "  %-2i %-13b" ))
                           (org-agenda-todo-keyword-format "")))
        (agenda "" (
                    (org-agenda-overriding-header "⚡ Schedule:\n")
                    (org-agenda-start-day "+0d")
                    (org-agenda-span 5)
                    (org-agenda-remove-tags t)
                    (org-agenda-prefix-format   (concat "  %-3i  %t%s"))
                    ;; (org-agenda-prefix-format   (concat "  %-3i  %-15b %t%s"))
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
                             (file org-capture-inbox-file )
                             "* TODO %? %i")

                            ("T" "Todo with link"
                             entry
                             (file+headline org-capture-inbox-file "Tasks")
                             "* TODO %? %i\n** source: %l")

                            ("p" "Paper ref to read "
                             entry
                             (file+headline org-capture-papers-file "Misc")
                             "* TODO %? %i")

                            ("m" "meeting notes"
                             entry
                             (file org-capture-meeting-file )
                             "* %<%D, %H:%M> - meeting with %?")

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
                               ;; "* %<%H:%M> \n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: %^{deck?|School|Master|Research}\n:END:\n** Front\n\t%?\n** Back\n\t%i\n** Extra\n\t- source:")
                               "* %<%H:%M> \n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: School\n:END:\n** Front\n\t%?\n** Back\n\t%i\n** Extra\n\t- source:")

                              ("A" "Anki close"
                               entry
                               (file+headline org-my-anki-file "Waiting for export")
                               "* %<%H:%M> \n:PROPERTIES:\n:ANKI_NOTE_TYPE: Cloze\n:ANKI_DECK: School\n:END:\n** Text\n\t%?\n** Extra\n\t- source:")

                              )
    )

  (setq org-format-latex-options
   (quote
    (:foreground default :background default :scale 2.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
         ("begin" "$1" "$" "$$" "\\(" "\\["))))
  )

(use-package! org-roam
  :init
  (map!
        :leader
        :prefix "k"
        :desc "org-roam" "l" #'org-roam-buffer-toggle
        :prefix "n"
        :desc "org-roam" "l" #'org-roam-buffer-toggle
        :desc "org-roam-node-insert" "i" #'org-roam-node-insert
        :desc "org-roam-node-find" "f" #'org-roam-node-find
        :desc "org-roam-ref-find" "r" #'org-roam-ref-find
        :desc "org-roam-show-graph" "g" #'org-roam-show-graph
        :desc "org-roam-capture" "c" #'org-roam-capture
        :desc "org-roam-dailies-capture-today" "j" #'org-roam-dailies-capture-today

        :map org-roam-preview-map :desc "universal argument" "C-u" #'universal-argument
        :map org-roam-mode-map :desc "universal argument" "C-u" #'universal-argument
        )
  (setq
   org-roam-directory (file-truename org-roam-directory)
        org-roam-db-gc-threshold most-positive-fixnum
        org-id-link-to-org-use-id t)
  (add-to-list 'display-buffer-alist
               '(("\\*org-roam\\*"
                  (display-buffer-in-direction)
                  (direction . right)
                  (window-width . 0.25)
                  (window-height . fit-window-to-buffer))))
  :config
  (setq org-roam-mode-sections
        (list #'org-roam-backlinks-insert-section
              #'org-roam-reflinks-insert-section
              #'org-roam-unlinked-references-insert-section
              ))

  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :target (file+head "%<%Y-%m-%d-%H%M%S>-${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t)))

  (setq org-roam-dailies-directory "daily/")
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :if-new (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n"))))
  ;; (set-company-backend! 'org-mode '(company-capf))
  (org-roam-setup)


  )

;; Since the org module lazy loads org-protocol (waits until an org URL is
;; detected), we can safely chain `org-roam-protocol' to it.
(use-package org-roam-protocol
  :after org-protocol)

(defun my/get-bib-file-list ()
  "Get the list of all the bib files containing my bib database."
  (mapcan (lambda (dir) (directory-files dir t "\\.bib\\'"))
'("/home/jonathan/google_drive/.bibliography/")))

(use-package helm-bibtex
  :config
  (setq
    bibtex-completion-bibliography (my/get-bib-file-list)
    bibtex-completion-library-path '( "~/google_drive/.bibliography/zotero-pdf")
    bibtex-completion-notes-path "/home/jonathan/google_drive/notes/slip-box/literature-notes/"

    bibtex-completion-additional-search-fields '(keywords)
    bibtex-completion-display-formats '((t . "${author:36} ${title:36} ${year:4} ${=has-pdf=:1}${=has-note=:1} ${=type=:7} ${keywords:*}"))
    bibtex-completion-pdf-field "File"
    bibtex-completion-find-additional-pdfs t)
    (setq helm-bibtex-notes-template-one-file "
        #+title: notes on: ${author-or-editor} (${year}): ${title}
        * main points
        * findings
        * methods
        * summary and short reference
        * general notes
        * see also (notes, tags/ other papers):

        ")
    (setq helm-bibtex-notes-template-multiple-files "
        #+title: notes on: ${author-or-editor} (${year}): ${title}
        * main points
        * findings
        * methods
        * summary and short reference
        * general notes
        * see also (notes, tags/ other papers):

        ")
  )


(use-package! org-ref
  :after org
  :init
  (let
      ((cache-dir (concat doom-cache-dir "org-ref")))
    (unless (file-exists-p cache-dir)
      (make-directory cache-dir t))
    (setq orhc-bibtex-cache-file (concat cache-dir "/orhc-bibtex-cache")))
  :config
 (setq
  org-ref-bibliography-notes "/home/jonathan/google_drive/.notes/slip-box/literature-notes/"
  org-ref-default-bibliography '("/home/jonathan/google_drive/.bibliography/motor-cognition.bib" "~/google_drive/.bibliography/methods.bib" "~/google_drive/.bibliography/consciousness.bib")
  org-ref-pdf-directory "~/google_drive/.bibliography/zotero-pdf"
  org-ref-notes-directory "/home/jonathan/google_drive/.notes/slip-box/literature-notes/"
  org-latex-pdf-process
  '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
    "bibtex %b"
    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f")
  org-ref-notes-function 'orb-edit-notes
 org-latex-logfiles-extensions (quote ("lof" "lot" "tex" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl" "pygtex" "pygstyle")))
 )

(use-package! org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (require 'org-ref)) ; optional: if Org Ref is not loaded anywhere else, load it here

;; Anki configuration
(use-package anki-editor
  :after org
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
  ;; (defhydra hydra-expand-region ()
  ;;   "region: "
  ;;   ("k" er/expand-region "expand")
  ;;   ("j" er/contract-region "contract"))
  ;; (general-def 'visual 'global "v" 'hydra-expand-region/body)

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
        (enlarge-window 10)
      (shrink-window 10)))
  (defun my-funcs/resize-window-up ()
    "resize a window upwards."
    (interactive)
    (if (window-in-direction 'above)
        (enlarge-window 10)
      (shrink-window 10)))
  (defun my-funcs/resize-window-left ()
    "resize a window leftwards."
    (interactive)
    (if (window-in-direction 'left)
        (enlarge-window-horizontally 10)
      (shrink-window-horizontally 10)))
  (defun my-funcs/resize-window-right ()
    "resize a window rightwards."
    (interactive)
    (if (window-in-direction 'right)
        (enlarge-window-horizontally 10)
      (shrink-window-horizontally 10)))
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

(set-company-backend! 'matlab-mode '(company-capf company-dabbrev))
(set-company-backend! 'matlab-shell-mode '(company-capf company-matlab-shell company-dabbrev))
(custom-set-variables '(matlab-shell-command-switches '("-nodesktop -nosplash ")))
;; (custom-set-variables '(matlab-shell-command-switches '("-nodesktop -nosplash -nodisplay")))
(setq matlab-verify-on-save-flag nil)
(defadvice! inhibit-real-only-a (oldfun &rest r)
  "Temporary remove read-only lines in shell buffer - fixes problems with completion"
  :around#'matlab-shell-collect-command-output
      (let ((inhibit-read-only t)) (apply oldfun r)))
(defun my-setup-matlab-mode()
  (doom/toggle-line-numbers)
  (visual-line-mode))
(add-hook! matlab-mode #'my-setup-matlab-mode)

(setq completion-ignore-case t)

(use-package define-word
  :config
  (setq define-word-offline-dict-directory "/mnt/c/Users/Jonathan/Google Drive/wiktionary-en-en/ding/en-en-withforms-enwiktionary.txt")
  (map! :ni
                "M-#" #'define-word
                "M-$" #'define-word-at-point
                )
  )


(use-package writeroom-mode
  :config
  (setq
   writeroom-major-modes '(org-mode prog-mode)
   writeroom-maximize-window nil
   writeroom-mode-line t
   writeroom-use-derived-modes t)
  ;; (global-writeroom-mode)
)
(require 'org-mime)

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e/")
(require 'mu4e)


(use-package consult-dir
  :bind (("C-x C-d" . consult-dir)
         :map minibuffer-local-completion-map
         ("C-x C-d" . consult-dir)
         ("C-x C-j" . consult-dir-jump-file)))

(use-package ispell
  :config
  (setq
   ispell-complete-word-dict "/home/jonathan/google_drive/dictionaries/en-GB-new.dic"
   ispell-personal-dictionary "/home/jonathan/google_drive/dictionaries/en-GB_personal.dic"
    company-ispell-dictionary ispell-complete-word-dict

    ))

(defun my-generic-ispell-company-complete-setup ()
  (when ispell-complete-word-dict
    (let*
      (
        (has-dict-complete
          (and ispell-complete-word-dict (file-exists-p ispell-complete-word-dict)))
        (has-dict-personal
          (and ispell-personal-dictionary (file-exists-p ispell-personal-dictionary)))
        (is-dict-outdated
          (and
            has-dict-complete has-dict-personal
            (time-less-p
              (nth 5 (file-attributes ispell-complete-word-dict))
              (nth 5 (file-attributes ispell-personal-dictionary))))))

      (when (or (not has-dict-complete) is-dict-outdated)
        (with-temp-buffer

          ;; Optional: insert personal dictionary, stripping header and inserting a newline.
          (when has-dict-personal
            (insert-file-contents ispell-personal-dictionary)
            (goto-char (point-min))
            (when (looking-at "personal_ws\-")
              (delete-region (line-beginning-position) (1+ (line-end-position))))
            (goto-char (point-max))
            (unless (eq ?\n (char-after))
              (insert "\n")))

          (call-process "aspell" nil t nil "-d" "en_US" "dump" "master")
          ;; Case insensitive sort is important for the lookup.
          (let ((sort-fold-case t))
            (sort-lines nil (point-min) (point-max)))
          (write-region nil nil ispell-complete-word-dict))))))

(after! citar
  (setq! citar-bibliography (my/get-bib-file-list))
  (setq! citar-at-point-function 'embark-act)
  (setq! citar-file-note-org-include '(org-id org-roam-ref))
  (setq! citar-notes-paths literature-notes-dir)
  (setq! citar-library-paths bibliography-pdf-dir)
;;   (setq citar-templates '((main . "${author editor:30}     ${date year issued:4}     ${title:48}")
;;                                    (suffix . "${tags keywords keywords:*}   ${=key= id:15}    ${=type=:12}")
;;                                    (preview . "${author editor} (${year issued date}) ${title}, ${journal journaltitle publisher container-title collection-title}.\n")
;;                                    (note . "Notes on ${author editor}, ${title}
;; * general notes
;; * summary and short reference
;; * see also (notes, tags/ other papers):
;; ")))
  (setq citar-templates '((main . " ${title:48}    ${date year issued:4}     ${author editor:30}")
                                   (suffix . "${tags keywords keywords:*}   ${=key= id:15}    ${=type=:12}")
                                   (preview . "${author editor} (${year issued date}) ${title}, ${journal journaltitle publisher container-title collection-title}.\n")
                                   (note . "Notes on ${author editor}, ${title}
* general notes
* summary and short reference
* see also (notes, tags/ other papers):
")))

  (setq citar-symbols
        `((file . (,(all-the-icons-icon-for-file "foo.pdf" :face 'all-the-icons-dred) .
                   ,(all-the-icons-icon-for-file "foo.pdf" :face 'citar-icon-dim)))
          (note . (,(all-the-icons-icon-for-file "foo.txt") .
                   ,(all-the-icons-icon-for-file "foo.txt" :face 'citar-icon-dim)))
          (link .
                (,(all-the-icons-faicon "external-link-square" :v-adjust 0.02 :face 'all-the-icons-dpurple) .
                 ,(all-the-icons-faicon "external-link-square" :v-adjust 0.02 :face 'citar-icon-dim)))))
;; Here we define a face to dim non 'active' icons, but preserve alignment
  (defface citar-icon-dim
    '((((background dark)) :foreground "#282c34")
      (((background light)) :foreground "#fafafa"))
    "Face for obscuring/dimming icons"
    :group 'all-the-icons-faces)

  (defun gen-bib-cache-idle ()
    "Generate bib item caches with idle timer"
    (run-with-idle-timer 0.5 nil #'citar-refresh))

  (add-hook 'LaTeX-mode-hook #'gen-bib-cache-idle)
  (add-hook 'org-mode-hook #'gen-bib-cache-idle)
  )

(after! consult
(consult-customize
 consult-buffer consult-buffer-other-window consult-ripgrep consult-git-grep consult-grep
 consult-bookmark consult-recent-file consult-xref
 ;; consult--source-file consult--source-project-file consult--source-bookmark
 :preview-key (kbd "M-."))
  ;; Replace bindings. Lazily loaded due by `use-package!'.
  ;; :bind (;; C-c bindings (mode-specific-map)
  ;;        ("C-c h" . consult-history)
  ;;        ("C-c m" . consult-mode-command)
  ;;        ("C-c b" . consult-bookmark)
  ;;        ("C-c k" . consult-kmacro)
  ;;        ;; C-x bindings (ctl-x-map)
  ;;        ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complet-command
  ;;        ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
  ;;        ("s-b" . consult-buffer)                ;; orig. switch-to-buffer
  ;;        ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
  ;;        ("C-s-b" . consult-buffer-other-window)
  ;;        ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
  ;;        ;; Custom M-# bindings for fast register access
  ;;        ("M-#" . consult-register-load)
  ;;        ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
  ;;        ("C-M-#" . consult-register)
  ;;        ;; Other custom bindings
  ;;        ("M-y" . consult-yank-from-kill-ring)                ;; orig. yank-pop
  ;;        ("<help> a" . consult-apropos)            ;; orig. apropos-command
  ;;        ;; M-g bindings (goto-map)
  ;;        ("M-g e" . consult-compile-error)
  ;;        ("M-g g" . consult-goto-line)             ;; orig. goto-line
  ;;        ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
  ;;        ("M-g o" . consult-outline)
  ;;        ("M-g m" . consult-mark)
  ;;        ("M-g k" . consult-global-mark)
  ;;        ("C-x C-SPC" . consult-mark)
  ;;        ("M-g i" . consult-imenu)
  ;;        ("M-g I" . consult-project-imenu)
  ;;        ;; M-s bindings (search-map)
  ;;        ("M-s f" . consult-find)
  ;;        ("M-s L" . consult-locate)
  ;;        ("M-s g" . consult-grep)
  ;;        ("M-s G" . consult-git-grep)
  ;;        ("M-s r" . consult-ripgrep)
  ;;        ("C-c f" . consult-ripgrep)
  ;;        ("M-s l" . consult-line)
  ;;        ("M-s m" . consult-multi-occur)
  ;;        ("M-s k" . consult-to-ivy)
  ;;        ("s-r" . consult-recent-file)
  ;;        ("C-c o" . consult-file-externally)
  ;;        ("s-4" . consult-bookmark)
  ;;        ("C-y" . yank)
  ;;        ("C-s" . consult-line) ;; I've long favored Swiper mapped to c-s
  ;;        ("s-l" . consult-goto-line)
  ;;        ;; Isearch integration
  ;;        ("M-s e" . consult-isearch)
  ;;        ;; ("s-t" . jnf/consult-find-using-fd)
  ;;        ("s-3" . consult-imenu)
  ;;        ("s-#" . consult-project-imenu)
  ;;        :map isearch-mode-map
  ;;        ("M-e" . consult-isearch)                 ;; orig. isearch-edit-string
  ;;        ("M-s e" . consult-isearch)               ;; orig. isearch-edit-string
  ;;        ("M-s l" . consult-line))                 ;; required by consult-line to detect isearch

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0
        register-preview-function #'consult-register-format)


  ;; From https://github.com/minad/consult/wiki#find-files-using-fd
  ;; Note: this requires lexical binding
  (defun jnf/consult-find-using-fd (&optional dir initial)
    "Find project files.

A replacement for `projectile-find-file'."
    (interactive "P")
    (let ((consult-find-command "fd --color=never --hidden --exclude .git/ --full-path ARG OPTS"))
      (consult-find dir initial)))

  (defun jnf/consult-line (consult-line-function &rest rest)
  "Advising function around `CONSULT-LINE-FUNCTION'.

When there's an active region, use that as the first parameter
for `CONSULT-LINE-FUNCTION'.  Otherwise, use the current word as
the first parameter.  This function handles the `REST' of the
parameters."
  (interactive)
  (apply consult-line-function
         (if (use-region-p) (buffer-substring (region-beginning) (region-end)))
           rest))

(defun jnf/consult-ripgrep (consult-ripgrep-function &optional dir &rest rest)
    "Use region or thing at point to populate initial parameter for `CONSULT-RIPGREP-FUNCTION'.

When there's an active region, use that as the initial parameter
for the `CONSULT-RIPGREP-FUNCTION'.  Otherwise, use the thing at
point.

`DIR' use the universal argument (e.g. C-u prefix) to first set
the directory.  `REST' is passed to the `CONSULT-RIPGREP-FUNCTION'."
    (interactive "P")
    (apply consult-ripgrep-function
           dir
           (if (use-region-p) (buffer-substring (region-beginning) (region-end)))
           rest))

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)
  (advice-add #'consult-line :around #'jnf/consult-line '((name . "wrapper")))
  (advice-add #'consult-ripgrep :around #'jnf/consult-ripgrep '((name . "wrapper")))

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Updating the default to include "--ignore-case"
  (setq consult-ripgrep-command "rg --null --line-buffered --color=ansi --max-columns=1000 --ignore-case --no-heading --line-number . -e ARG OPTS")

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.

  ;; Optionally configure preview. Note that the preview-key can also be
  ;; configured on a per-command basis via `consult-config'. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-p"))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; Probably not needed if you are using which-key.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; Optionally configure a function which returns the project root directory.
  ;; There are multiple reasonable alternatives to chose from:
  ;; * projectile-project-root
  ;; * vc-root-dir
  ;; * project-roots
  ;; * locate-dominating-file
  (autoload 'projectile-project-root "projectile")
  (setq consult-project-root-function #'projectile-project-root)
  ;; (setq consult-project-root-function
  ;;       (lambda ()
  ;;         (when-let (project (project-current))
  ;;           (car (project-roots project)))))
  ;; (setq consult-project-root-function #'vc-root-dir)
  ;; (setq consult-project-root-function
  ;;       (lambda () (locate-dominating-file "." ".git")))


;; Optionally add the `consult-flycheck' command.
(use-package! consult-flycheck
  :bind (:map flycheck-command-map
              ("!" . consult-flycheck)))
 )

(use-package! consult-company
  :config
  (define-key company-mode-map [remap completion-at-point] #'consult-company)
  )
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;; (use-package! dired-narrow
;;   :bind (:map dired-mode-map
;;               ("/" . dired-narrow)))
;; fix org-open-file for wsl by temporarily replacing start-process-shell-command with call-process-shell-command
;; if we don't do this, emacs on WSL will block forever trying to open exported file with windows handler
(defun wsl-fix-org-open-file (orig-org-open-file &rest args)
  ;; temporarily replace function,
  ;; see https://endlessparentheses.com/understanding-letf-and-how-it-replaces-flet.html
  (cl-letf (((symbol-function 'start-process-shell-command) #'call-process-shell-command))
    (apply orig-org-open-file args)))

(advice-add #'org-open-file :around #'wsl-fix-org-open-file)
(use-package org-super-agenda
  :config
  (org-super-agenda-mode t))
(add-to-list 'org-agenda-custom-commands
             '("r" "Categor: Research" todo ""
              ((org-super-agenda-groups
                '((:category ("research"))
                  ;; (:category ("research"))
                  (:discard (:anything))
                  ))
                )))
(with-eval-after-load 'citar

  (defun citar-open-library-file (key-entry)
    "Open library file associated with the KEY-ENTRY.

With prefix, rebuild the cache before offering candidates."
    (interactive (list (citar-select-ref
                        :rebuild-cache current-prefix-arg)))
    (let ((embark-default-action-overrides '((file . citar-file-open-external))))
      (message "embark-default-action-overrides %s" embark-default-action-overrides)
      (when (and citar-library-paths
                 (stringp citar-library-paths))
        (error "Make sure 'citar-library-paths' is a list of paths"))
      (citar--library-file-action key-entry 'open)))
  )

(with-eval-after-load 'citar
(defun citar--library-file-action (key-entry action)
  "Run ACTION on file associated with KEY-ENTRY."
  (let* ((fn (pcase action
               ('open 'citar-file-open-external 'citar-file-open)
               ('attach 'mml-attach-file)))
         (ke (citar--ensure-entries key-entry))
         (key (caar ke))
         (entry (cdar ke))
         (files
          (citar-file--files-for-entry
           key
           entry
           citar-library-paths
           citar-file-extensions))
         (file
          (pcase (length files)
            (1 (car files))
            ((guard (> 1))
             (citar-select-file files)))))
    (if file
        (funcall fn file)
      (message "No associated file"))))
  )

(use-package! lsp-pyright
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred
(use-package dabbrev
  ;; Swap M-/ and C-M-/
  :bind (("M-/" . dabbrev-completion)
         ("C-M-/" . dabbrev-expand))
  ;; Other useful Dabbrev configurations.
  :custom
  (dabbrev-ignored-buffer-regexps '("\\.\\(?:pdf\\|jpe?g\\|png\\)\\'")))


(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)

  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))

(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

(use-package corfu
  :custom
  (corfu-quit-at-boundary 'separator)
  (corfu-auto nil)          ;; Enable auto completion
  (corfu-separator ?\s) ;; Set to orderless separator, if not using space
  (corfu-cycle t)             ;; Enable cycling for `corfu-next/previous'
  (corfu-preselect-first t) ;; Disable candidate preselection
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.25)
  (corfu-min-width 40)
  ;; (corfu-max-width corfu-min-width)       ; Always have the same width

  ;; (corfu-count 14)
  (corfu-scroll-margin 4)
  (corfu-echo-documentation t)
  (corfu-preview-current nil)
;; (lsp-completion-provider :none) ; Use corfu instead the default for lsp completions
;; :hook (lsp-completion-mode . kb/corfu-setup-lsp) ; Use corfu for lsp completion

  ;; Another key binding can be used, such as S-SPC.
  ;; (:map corfu-map ("M-SPC" . corfu-insert-separator))
  :init
  (global-corfu-mode)

  :config
  (advice-add 'corfu--setup :after 'evil-normalize-keymaps)
  (advice-add 'corfu--teardown :after 'evil-normalize-keymaps)
  (evil-make-overriding-map corfu-map)

  (defun corfu-enable-always-in-minibuffer ()
  "Enable Corfu in the minibuffer if Vertico/Mct are not active."
  (unless (or (bound-and-true-p mct--active) ; Useful if I ever use MCT
              (bound-and-true-p vertico--input))
    (setq-local corfu-auto nil)       ; Ensure auto completion is disabled
    (corfu-mode 1)))

  (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1)

  ;; (defun kb/corfu-setup-lsp ()
  ;; "Use orderless completion style with lsp-capf instead of the
  ;; default lsp-passthrough."
  ;; (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
  ;;       '(orderless)))
 )

;;  ;; Manual completion example
;; (use-package corfu
;;   :custom
;;   ;; (corfu-separator ?_) ;; Set to orderless separator, if not using space
;;   :bind
;;   ;; Configure SPC for separator insertion
;;   (:map corfu-map ("SPC" . corfu-insert-separator))
;;   :init
;;   (global-corfu-mode))
(use-package cape
    :custom
  (cape-dabbrev-min-length 3)

  ;; :general (:prefix "M-c"              ; Choose a particular completion function
  ;;                   "p" 'completion-at-point
  ;;                   "t" 'complete-tag   ; etags
  ;;                   "d" 'cape-dabbrev   ; basically `dabbrev-completion'
  ;;                   "f" 'cape-file
  ;;                   "k" 'cape-keyword
  ;;                   "s" 'cape-symbol
  ;;                   "a" 'cape-abbrev
  ;;                   "i" 'cape-ispell
  ;;                   "l" 'cape-line
  ;;                   "w" 'cape-dict
  ;;                   "\\" 'cape-tex
  ;;                   "_" 'cape-tex
  ;;                   "^" 'cape-tex
  ;;                   "&" 'cape-sgml
  ;;                   "r" 'cape-rfc1345)

  :hook (
         (emacs-lisp-mode .  kb/cape-capf-setup-elisp)
         ;; (org-mode . kb/cape-capf-setup-org)
         (text-mode . kb/cape-capf-setup-text)
         ;; (lsp-completion-mode . kb/cape-capf-setup-lsp)
         ;; (eshell-mode . kb/cape-capf-setup-eshell)
         ;; (git-commit-mode . kb/cape-capf-setup-git-commit)
         ;; (LaTeX-mode . kb/cape-capf-setup-latex)
         ;; (sh-mode . kb/cape-capf-setup-sh)
         )

  :init
  ;; Elisp
  (defun kb/cape-capf-ignore-keywords-elisp (cand)
    "Ignore keywords with forms that begin with \":\" (e.g.
:history)."
    (or (not (keywordp cand))
        (eq (char-after (car completion-in-region--data)) ?:)))
  (defun kb/cape-capf-setup-elisp ()
    "Replace the default `elisp-completion-at-point'
completion-at-point-function. Doing it this way will prevent
disrupting the addition of other capfs (e.g. merely setting the
variable entirely, or adding to list).

Additionally, add `cape-file' as early as possible to the list."
    (setf (elt (cl-member 'elisp-completion-at-point completion-at-point-functions) 0)
          #'elisp-completion-at-point)
    (add-to-list 'completion-at-point-functions #'cape-symbol)
    ;; I prefer this being early/first in the list
    (add-to-list 'completion-at-point-functions #'cape-file)
)
;; Org
  (defun kb/cape-capf-setup-org ()
    (interactive)
    (require 'org-roam)
    (if (org-roam-file-p)
        (org-roam--register-completion-functions-h)
      (let (result)
        (dolist (element (list
                          (cape-super-capf #'cape-ispell #'cape-dabbrev)
                          )
                         result)
          (add-to-list 'completion-at-point-functions element)))
      ))

  (defun kb/cape-capf-setup-text ()
    ;; I prefer this being early/first in the list
    (add-to-list 'completion-at-point-functions #'cape-file)
    (let (result)
      (dolist (element (list
                        (cape-super-capf #'cape-ispell #'cape-dabbrev)
                        )
                       result)
        (add-to-list 'completion-at-point-functions element)))

    )

  )
