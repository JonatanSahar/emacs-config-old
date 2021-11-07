;;; ~/.doom.d/package-config.el -*- lexical-binding: t; -*-
(use-package! deft
  :config
  (setq deft-extensions '("txt" "tex" "org")
        deft-directory slip-box-dir
        ;; deft-strip-title-regexp ":PROPERTIES:\n\\(.+\n\\)+:END:\n#+title:"
        deft-strip-summary-regexp ":PROPERTIES:\n\\(.+\n\\)+:END:\n#+.*"
        deft-use-filename-as-title t
        deft-recursive t)
  )

(use-package! org-pomodoro
  :config
  (setq org-pomodoro-manual-break nil))


(use-package! org-superstar
  :config
  (setq org-superstar-headline-bullets-list '("○" "✸" "✿" "●" "►")
        inhibit-compacting-font-caches t)
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

    org-ellipsis "▼"
    ;; ➡, ⚡, ▼, ↴, ∞, ⬎, ⤷, ⤵, …
    org-deadline-warning-days 7
    org-agenda-breadcrumbs-separator " ❱ "
    org-odd-levels-only  t
    org-startup-with-inline-images t
    org-hide-emphasis-markers t

    org-agenda-files '(
                       "~/google_drive/.notes.v2/gtd/inbox.org"
                       "~/google_drive/.notes.v2/gtd/reminders.org"
                       "~/google_drive/.notes.v2/gtd/projects.org"
                       "~/google_drive/.notes.v2/gtd/someday.org"
                       "~/google_drive/.notes.v2/gtd/writing_inbox.org")

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

                            ("p" "Paper ref to read "
                             entry
                             (file+headline org-capture-papers-file "Misc")
                             "* TODO %? %i")

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
                               "* %<%H:%M> :drill: \n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: TheDeck\n:END:\n** Front\n\t%?\n** Back\n\t%i\n** Extra\n\t- source:")

                              ("A" "Anki close"
                               entry
                               (file+headline org-my-anki-file "Waiting for export")
                               "* %<%H:%M> :drill: \n:PROPERTIES:\n:ANKI_NOTE_TYPE: Cloze\n:ANKI_DECK: TheDeck\n:END:\n** Text\n\t%i%?\n** Extra\n\t- source:")

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
              ;; #'org-roam-unlinked-references-insert-section
              ))
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
    bibtex-completion-notes-path "/home/jonathan/google_drive/.notes.v2/slip-box/literature-notes/"

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
(use-package! org-roam-bibtex
  :after org-roam
  :config
  (require 'org-ref)) ; optional: if Org Ref is not loaded anywhere else, load it here
;; (use-package org-roam-bibtex
;;   :hook (org-roam-mode . org-roam-bibtex-mode)
;;   :config
;;   (setq orb-preformat-keywords '("=key=" "title" "url" "file" "author-or-editor" "keywords"))
;;   (setq org-roam-capture-templates
;;         '(
;;           ("d" "default" plain "%?"
;;            :if-new (file+head "${slug}.org"
;;                               "#+title: ${title}\n")
;;            :immediate-finish t
;;            :unnarrowed t)
;;           ("r" "ref" plain "%?"
;;         :if-new (file+head "literature-notes/Notes: ${title}"
;;         "#+title: Notes: ${title}\n\n- tags :: \n- source :: \n\n* Notes:"
;;         )
;;         :unnarrowed t
;;                  )
;;           ))
;;   (require 'org-ref)
;;   )

(setq
 org-ref-bibliography-notes "/home/jonathan/google_drive/.notes/slip-box/literature-notes/"
 org-ref-default-bibliography '("/home/jonathan/google_drive/.bibliography/motor-cognition.bib")
 org-ref-pdf-directory "~/google_drive/.bibliography/zotero-pdf"
 org-ref-notes-directory "/home/jonathan/google_drive/.notes/slip-box/literature-notes/"
 org-ref-notes-function 'orb-edit-notes)

;; (after! org-roam
;;   (org-roam-bibtex-mode))

;; Anki configuration
(use-package anki-editor
  :after org
  :bind (:map org-mode-map
         ("<f5>" . anki-editor-cloze-region-auto-incr)
         ("C-<f5>" . anki-editor-cloze-region-dont-incr)
         ("<f6>" . anki-editor-reset-cloze-number)
         ("<f7>"  . anki-editor-push-tree))
  ;; :hook (org-capture-after-finalize . anki-editor-reset-cloze-number) ; Reset cloze-number after each capture.
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
(custom-set-variables '(matlab-shell-command-switches '("-nodesktop -nosplash -nodisplay")))
(setq matlab-verify-on-save-flag nil)
(add-hook! matlab-mode #'doom/toggle-line-numbers)

(setq completion-ignore-case t)

(use-package define-word
  :config
  (setq define-word-offline-dict-directory "/mnt/c/Users/Jonathan/Google Drive/wiktionary-en-en/ding/en-en-withforms-enwiktionary.txt")
  (map! :ni
                "M-#" #'define-word
                "M-$" #'define-word-at-point
                )
  )


(after! org-reveal
  (setq org-reveal-root "file:/home/jonathan/reveal/reveal.js"))

(setq darkroom-margins 0.25)

(use-package writeroom-mode
  :config
  (setq
   writeroom-major-modes '(org-mode prog-mode)
   writeroom-mode-line t
   writeroom-use-derived-modes t)
  ;; (global-writeroom-mode)
)
(require 'org-mime)

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e/")
(require 'mu4e)

(setq mu4e-maildir (expand-file-name "~/Maildir"))

; get mail
(setq mu4e-get-mail-command "mbsync -c ~/.emacs.d/mu4e/.mbsyncrc -a"
  ;; mu4e-html2text-command "w3m -T text/html" ;;using the default mu4e-shr2text
  mu4e-view-prefer-html t
  mu4e-update-interval 180
  mu4e-headers-auto-update t
  mu4e-compose-signature-auto-include nil
  mu4e-compose-format-flowed t)

;; to view selected message in the browser, no signin, just html mail
(add-to-list 'mu4e-view-actions
  '("ViewInBrowser" . mu4e-action-view-in-browser) t)

;; enable inline images
(setq mu4e-view-show-images t)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; every new email composition gets its own frame!
(setq mu4e-compose-in-new-frame t)

;; don't save message to Sent Messages, IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

(add-hook 'mu4e-view-mode-hook #'visual-line-mode)

;; <tab> to navigate to links, <RET> to open them in browser
(add-hook 'mu4e-view-mode-hook
  (lambda()
;; try to emulate some of the eww key-bindings
(local-set-key (kbd "<RET>") 'mu4e~view-browse-url-from-binding)
(local-set-key (kbd "<tab>") 'shr-next-link)
(local-set-key (kbd "<backtab>") 'shr-previous-link)))

;; from https://www.reddit.com/r/emacs/comments/bfsck6/mu4e_for_dummies/elgoumx
(add-hook 'mu4e-headers-mode-hook
      (defun my/mu4e-change-headers ()
	(interactive)
	(setq mu4e-headers-fields
	      `((:human-date . 25) ;; alternatively, use :date
		(:flags . 6)
		(:from . 22)
		(:thread-subject . ,(- (window-body-width) 70)) ;; alternatively, use :subject
		(:size . 7)))))

;; if you use date instead of human-date in the above, use this setting
;; give me ISO(ish) format date-time stamps in the header list
;(setq mu4e-headers-date-format "%Y-%m-%d %H:%M")

;; spell check
(add-hook 'mu4e-compose-mode-hook
    (defun my-do-compose-stuff ()
       "My settings for message composition."
       (visual-line-mode)
       (org-mu4e-compose-org-mode)
           (use-hard-newlines -1)
       (flyspell-mode)))

(require 'smtpmail)

;;rename files when moving
;;NEEDED FOR MBSYNC
(setq mu4e-change-filenames-when-moving t)

;;set up queue for offline email
;;use mu mkdir  ~/Maildir/acc/queue to set up first
(setq smtpmail-queue-mail nil)  ;; start in normal mode

;;from the info manual
(setq mu4e-attachment-dir  "~/Downloads")

(setq message-kill-buffer-on-exit t)
(setq mu4e-compose-dont-reply-to-self t)

(require 'org-mu4e)

;; convert org mode to HTML automatically
(setq org-mu4e-convert-to-html t)

;;from vxlabs config
;; show full addresses in view message (instead of just names)
;; toggle per name with M-RET
(setq mu4e-view-show-addresses 't)

;; don't ask when quitting
(setq mu4e-confirm-quit nil)

;; mu4e-context
(setq mu4e-context-policy 'pick-first)
(setq mu4e-compose-context-policy 'always-ask)
(setq mu4e-contexts
  (list
   (make-mu4e-context
    :name "work" ;;for acc1-gmail
    :enter-func (lambda () (mu4e-message "Entering context work"))
    :leave-func (lambda () (mu4e-message "Leaving context work"))
    :match-func (lambda (msg)
		  (when msg
		(mu4e-message-contact-field-matches
		 msg '(:from :to :cc :bcc) "jonathan.sahar@gmail.com")))
    :vars '((user-mail-address . "jonathan.sahar@gmail.com")
	    (user-full-name . "Jonahtan Sahar")
	    (mu4e-sent-folder . "/acc1-gmail/[acc1].Sent Mail")
	    (mu4e-drafts-folder . "/acc1-gmail/[acc1].drafts")
	    (mu4e-trash-folder . "/acc1-gmail/[acc1].Bin")
	    (mu4e-compose-signature . (concat "Formal Signature\n" "Emacs 25, org-mode 9, mu4e 1.0\n"))
	    (mu4e-compose-format-flowed . t)
	    (smtpmail-queue-dir . "~/Maildir/acc1-gmail/queue/cur")
	    (message-send-mail-function . smtpmail-send-it)
	    (smtpmail-smtp-user . "jonathan.sahar")
	    (smtpmail-starttls-credentials . (("smtp.gmail.com" 587 nil nil)))
	    (smtpmail-auth-credentials . (expand-file-name "~/.authinfo.gpg"))
	    (smtpmail-default-smtp-server . "smtp.gmail.com")
	    (smtpmail-smtp-server . "smtp.gmail.com")
	    (smtpmail-smtp-service . 587)
	    (smtpmail-debug-info . t)
	    (smtpmail-debug-verbose . t)
	    (mu4e-maildir-shortcuts . ( ("/acc1-gmail/INBOX"            . ?i)
					("/acc1-gmail/[acc1].Sent Mail" . ?s)
					("/acc1-gmail/[acc1].Bin"       . ?t)
					("/acc1-gmail/[acc1].All Mail"  . ?a)
					("/acc1-gmail/[acc1].Starred"   . ?r)
					("/acc1-gmail/[acc1].drafts"    . ?d)
					))))
   (make-mu4e-context
    :name "personal" ;;for acc2-gmail
    :enter-func (lambda () (mu4e-message "Entering context personal"))
    :leave-func (lambda () (mu4e-message "Leaving context personal"))
    :match-func (lambda (msg)
        (when msg
        (mu4e-message-contact-field-matches
        msg '(:from :to :cc :bcc) "acc2@gmail.com")))
        :vars '((user-mail-address . "acc2@gmail.com")
        (user-full-name . "User Account2")
        (mu4e-sent-folder . "/acc2-gmail/[acc2].Sent Mail")
        (mu4e-drafts-folder . "/acc2-gmail/[acc2].drafts")
        (mu4e-trash-folder . "/acc2-gmail/[acc2].Trash")
        (mu4e-compose-signature . (concat "Informal Signature\n" "Emacs is awesome!\n"))
        (mu4e-compose-format-flowed . t)
        (smtpmail-queue-dir . "~/Maildir/acc2-gmail/queue/cur")
        (message-send-mail-function . smtpmail-send-it)
        (smtpmail-smtp-user . "acc2")
        (smtpmail-starttls-credentials . (("smtp.gmail.com" 587 nil nil)))
        (smtpmail-auth-credentials . (expand-file-name "~/.authinfo.gpg"))
        (smtpmail-default-smtp-server . "smtp.gmail.com")
        (smtpmail-smtp-server . "smtp.gmail.com")
        (smtpmail-smtp-service . 587)
        (smtpmail-debug-info . t)
        (smtpmail-debug-verbose . t)
        (mu4e-maildir-shortcuts . ( ("/acc2-gmail/INBOX"            . ?i)
        ("/acc2-gmail/[acc2].Sent Mail" . ?s)
        ("/acc2-gmail/[acc2].Trash"     . ?t)
        ("/acc2-gmail/[acc2].All Mail"  . ?a)
        ("/acc2-gmail/[acc2].Starred"   . ?r)
        ("/acc2-gmail/[acc2].drafts"    . ?d)
        ))))))



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

(use-package bibtex-completion)
;; (use-package evil-better-visual-line
;;   :ensure t
;;   :config
;;   (evil-better-visual-line-on))
;; (use-package org-preview-html)
