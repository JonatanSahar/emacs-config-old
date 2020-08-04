;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jonathan Sahar"
      user-mail-address "jonathan.sahar@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "Source Code Pro" :size 16)
      doom-big-font (font-spec :family "JetBrains Mono" :size 16)
      doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 16)
      doom-unicode-font (font-spec :name "DejaVu Sans Mono" :size 16))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
;;(setq doom-theme 'doom-vibrant)
;;
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/google_drive/.notes/")
;;
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; save every 20 characters typed (this is the minimum)
(setq org-my-anki-file "~/google_drive/.notes/slip-box/anki.org")
(setq org-capture-inbox-file "~/google_drive/.notes/gtd/inbox.org")
(setq org-capture-reminders-file "~/google_drive/.notes/gtd/reminders.org")
(setq org-capture-projects-file "~/google_drive/.notes/gtd/projects.org")
(setq org-capture-someday-file "~/google_drive/.notes/gtd/someday.org")
(setq org-capture-writing-inbox-file "~/google_drive/.notes/slip-box/2020-06-02-writing_inbox.org")

(setq auto-save-interval 20)
(setq auto-save-visited-mode t)


;; join lines
(define-key evil-normal-state-map (kbd "J") 'evil-join)
(define-key evil-normal-state-map (kbd "K") 'join-line)
;; (eval-after-load 'org-mode
;;  '(define-key evil-insert-state-map  [(return)]   'evil-org-return))

(setq key-chord-two-keys-delay 0.2)
(key-chord-define evil-insert-state-map "jk" #'evil-force-normal-state)
(key-chord-define evil-visual-state-map "jk" #'evil-force-normal-state)
(key-chord-define-global "jk" #'evil-force-normal-state)


;; movement
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
(define-key evil-normal-state-map (kbd "'") 'evil-goto-mark)
(define-key evil-normal-state-map (kbd "`") 'evil-goto-mark-line)
(setq-default pdf-view-display-size 'fit-width)
(setq pdf-view-resize-factor 1.1)


;; (use-package zoom
;;   :hook (doom-first-input . zoom-mode)
;;   :config
;;   (setq zoom-size '(0.618 . 0.618)
;;         zoom-ignored-major-modes '(dired-mode vterm-mode help-mode helpful-mode rxt-help-mode help-mode-menu org-mode which-key-mode)
;;         zoom-ignored-buffer-names '("*doom:scratch*" "*info*" "*helpful variable: argv*")
;;         zoom-ignored-buffer-name-regexps '("^\\*calc" "\\*helpful variable: .*\\*")
;;         zoom-ignore-predicates (list (lambda () (> (count-lines (point-min) (point-max)) 20)))))


(defun my/snipe_ivy ()
  (evilem-create (list 'evil-snipe-repeat
                       'evil-snipe-repeat-reverse)
                 :bind ((evil-snipe-scope 'buffer)
                        (evil-snipe-enable-highlight)
                        (evil-snipe-enable-incremental-highlight))))

(map! :map evil-snipe-parent-transient-map "C-;" #'my/snipe_ivy)

;; (map! :leader
;;       (:prefix-map "n"
;;       "r" nil))

;; (map! :leader                           ; Use leader key from now on
;;       (:prefix-map ("n" . "notes")
;;        (:prefix-map ("r" . "roam")
;;         :desc "find file" "f" 'org-roam-find-file)))
(map!
 :nvi "C-\\" #'toggle-input-method
 :nvi "C-s" #'save-buffer
 :nvi "C-l" #'org-roam-insert
 :nvi "C-S-L" #'org-ref-insert-link
 :i "S-SPC" #'evil-force-normal-state)

(map! [C-o] #'better-jumper-jump-forward
      [C-i] #'better-jumper-jump-forward)

(map! :map pdf-view-mode-map
      :nvi "I" #'org-noter-insert-precise-note
      :nvi "i" #'org-noter-insert-note)

(map! :leader
      :desc "Org Noter" :nv "nN" #'org-noter
      (:when (featurep! :completion helm)
        :desc "M-x" :n "SPC" #'helm-M-x))

(map! :n "gO" #'+evil/insert-newline-above
      :n "go" #'+evil/insert-newline-below)

(map! :leader
  :nv
       :desc "add line above" "iO" #'+evil/insert-newline-above
       :desc "add line below" "io" #'+evil/insert-newline-below)

(map! :leader
      ;; "`" 'winum-select-window-by-number
      "0" 'winum-select-window-0-or-10
      "1" 'winum-select-window-1
      "2" 'winum-select-window-2
      "3" 'winum-select-window-3
      "4" 'winum-select-window-4
      "5" 'winum-select-window-5
      "6" 'winum-select-window-6
      "7" 'winum-select-window-7
      "8" 'winum-select-window-8
      "9" 'winum-select-window-9
      (:prefix-map ("j" . "navigation")
       :desc "avy timer" "j" 'avy-goto-char-timer
       :desc "avy line" "l" 'avy-goto-line)
      (:prefix-map ("k" . "my commands")
       :desc "kill all other windows" "o" 'delete-other-windows
       :desc "kill buffer and window" "d" 'kill-buffer-and-window
       :desc "switch to previous buffer" "k" 'evil-switch-to-windows-last-buffer
       :desc "save current buffer" "s" 'save-buffer
       (:prefix-map ("r" . "references")
        :desc "crossref search for refernce" "r" 'doi-utils-add-entry-from-crossref-query
        :desc "add refernce from doi" "d" 'doi-utils-add-bibtex-entry-from-doi
        :desc "helm bibtex" "h" 'helm-bibtex
        )))


(evil-define-command my-evil-insert-char (count char)
  (interactive "<c><C>")
  (setq count (or count 1))
  (insert (make-string count char)))

(evil-define-command my-evil-append-char (count char)
  (interactive "<c><C>")
  (setq count (or count 1))
  (when (not (eolp))
    (forward-char))
  (insert (make-string count char)))

;; Deft
(setq deft-extensions '("txt" "tex" "org")
      deft-directory "~/google_drive/.notes/slip-box"
      deft-recursive t)

(setq-default evil-escape-delay 0.4)

;; set the browser location
(setq browse-url-browser-function 'browse-url-generic browse-url-generic-program "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe")

(defun org-journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.
  ;; (goto-char (point-min)))
  )
(setq org-agenda-files '("~/google_drive/.notes/gtd/reminders.org"
                            "~/google_drive/.notes/gtd/projects.org"
                            "~/google_drive/.notes/gtd/someday.org"
                            "~/google_drive/.notes/gtd/writing_inbox.org"))

(setq org-refile-targets '(( org-capture-projects-file :maxlevel . 1)
                           ( org-capture-someday-file :level . 1)
                           ( org-capture-inbox-file :maxlevel . 2)
                           ( org-capture-reminders-file :maxlevel . 1)))


(setq org-capture-templates
      '(("t" "Todo"
         entry
         (file+headline org-capture-inbox-file "Tasks")
         "** TODO %? %i\n  %a")

        ("n" "Note"
         entry
         (file+headline org-capture-writing-inbox-file "Notes")
         "** NOTE %? \n")

        ("j" "Journal entry" entry (function org-journal-find-location)
         "* %(format-time-string org-journal-time-format)%^{Title}\n%i%?")

        ("i" "Interesting things"
         entry
         (file+headline org-capture-someday-file "To read/watch")
         "** %? :bucket_list:\n")

        ("a" "Anki basic"
         entry
         (file+headline org-my-anki-file "Waiting for export")
         "* %<%H:%M>   %^g\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: TheDeck\n:END:\n** Front\n\t%?\n** Back\n\t\n")

        ("A" "Anki cloze"
         entry
         (file+headline org-my-anki-file "Waiting for export")
         "* %<%H:%M>   %^g\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Cloze\n:ANKI_DECK: TheDeck\n:END:\n** Text\n%x\n** Extra\n")))

(setq org-outline-path-complete-in-steps nil
      org-goto-interface 'outline-path-completion)

(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook (function (lambda () (setq bidi-paragraph-direction nil))))
(add-hook 'org-roam-mode-hook (function (lambda () (setq bidi-paragraph-direction nil))))
;; (add-hook! 'org-mode-hook #'org-roam-buffer-activate)

(use-package org-super-agenda
  :commands (org-super-agenda-mode)
  :after org-agenda
  :config (org-super-agenda-mode))

(org-super-agenda-mode)

(evil-snipe-override-mode 1)


;; Super-agenda
(setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-block-separator nil
      org-agenda-tags-column 100 ;; from testing this seems to be a good value
      org-agenda-compact-blocks t)


(setq
 org-ellipsis "▼"
 ;; ➡, ⚡, ▼, ↴, ∞, ⬎, ⤷, ⤵, …
 ;; org-agenda-files (quote ("~/Notes/todo.org" "~/Notes/appointments.org"))
 org-deadline-warning-days 7
 org-agenda-breadcrumbs-separator " ❱ "
 ;; org-directory "~/Notes")
 )

(customize-set-value
 'org-agenda-category-icon-alist
 `(
   ("work" "~/dotfiles/icons/money-bag.svg" nil nil :ascent center)
   ("chore" "~/dotfiles/icons/loop.svg" nil nil :ascent center)
   ("events" "~/dotfiles/icons/calendar.svg" nil nil :ascent center)
   ("todo" "~/dotfiles/icons/checklist.svg" nil nil :ascent center)
   ("walk" "~/dotfiles/icons/walk.svg" nil nil :ascent center)
   ("solution" "~/dotfiles/icons/solution.svg" nil nil :ascent center)
   ("research" ,(list (all-the-icons-material "check_box" :height 1.2)) nil nil :ascent center)
   ))
(setq org-agenda-custom-commands
      '(("o" "My Agenda"
         (
          (todo "TODO" (
                        (org-agenda-overriding-header "⚡ Do Today:\n")
                        (org-agenda-remove-tags t)
                        (org-agenda-prefix-format (concat "  %-2i %-13b" org-agenda-hidden-separator))
                        (org-agenda-todo-keyword-format "")))
          (agenda "" (
                      (org-agenda-overriding-header "⚡ Schedule:\n")
                      (org-agenda-start-day "+0d")
                      (org-agenda-span 5)
                      (org-agenda-repeating-timestamp-show-all nil)
                      (org-agenda-remove-tags t)
                      (org-agenda-prefix-format   (concat "  %-3i  %-15b %t%s" org-agenda-hidden-separator))
                      (org-agenda-todo-keyword-format " ☐ ")
                      (org-agenda-current-time-string "<┈┈┈┈┈┈┈ now")
                      (org-agenda-scheduled-leaders '("" ""))
                      (org-agenda-time-grid (quote ((daily today remove-match)
                                                    (0900 1200 1800 2100)
                                                    "      " "┈┈┈┈┈┈┈┈┈┈┈┈┈")))))
          )
         )))
;;
;; (setq org-agenda-custom-commands
;;       '(("o" "Overview"
;;          ((agenda "" ((org-agenda-span 'day)
;;                       (org-super-agenda-groups
;;                        '((:name "Today"
;;                           :time-grid t
;;                           :date today
;;                           :todo "TODAY"
;;                           :scheduled today
;;                           :order 1)))))
;;           (alltodo "" ((org-agenda-overriding-header "")
;;                        (org-super-agenda-groups
;;                         '((:name "Next to do"
;;                            :todo "NEXT"
;;                            :order 1)
;;                           (:name "Important"
;;                            :tag "Important"
;;                            :priority "A"
;;                            :order 6)
;;                           (:name "Due Today"
;;                            :deadline today
;;                            :order 2)
;;                           (:name "Due Soon"
;;                            :deadline future
;;                            :order 8)
;;                           (:name "Overdue"
;;                            :deadline past
;;                            :face error
;;                            :order 7)
;;                           (:name "Assignments"
;;                            :tag "Assignment"
;;                            :order 10)
;;                           (:name "Issues"
;;                            :tag "Issue"
;;                            :order 12)
;;                           (:name "Emacs"
;;                            :tag "Emacs"
;;                            :order 13)
;;                           (:name "Projects"
;;                            :tag "Project"
;;                            :order 14)
;;                           (:name "Research"
;;                            :tag "Research"
;;                            :order 15)
;;                           (:name "To read"
;;                            :tag "Read"
;;                            :order 30)
;;                           (:name "Waiting"
;;                            :todo "WAITING"
;;                            :order 20)
;;                           (:name "Wedding"
;;                            :tag "wedding"
;;                            :order 32)
;;                           (:name "University"
;;                            :tag "uni"
;;                            :order 32)
;;                           (:discard (:tag ("Chore" "Routine" "Daily")))))))))))

(add-to-list 'load-path "/home/jonathan/wordnut")
(require 'wordnut)
(global-set-key [f12] 'wordnut-search)
(global-set-key [(control f12)] 'wordnut-lookup-current-word)
(global-set-key [f11] 'flyspell-correct-at-point)

(evil-define-key 'normal wordnut-mode-map (kbd "q") 'quit-window)
(evil-define-key 'normal wordnut-mode-map (kbd "RET") 'wordnut-lookup-current-word)
(evil-define-key 'normal wordnut-mode-map (kbd "h") 'wordnut-history-backward)
(evil-define-key 'normal wordnut-mode-map (kbd "l") 'wordnut-history-forward)
(evil-define-key 'normal wordnut-mode-map (kbd "H") 'wordnut-history-lookup)
(evil-define-key 'normal wordnut-mode-map (kbd "/") 'wordnut-search)
(evil-define-key 'normal wordnut-mode-map (kbd "o") 'wordnut-show-overview)

;; Dictionary for completion.
;; Set up spell checker using Hunspell
(setq ispell-complete-word-dict
      (expand-file-name (concat user-emacs-directory "misc/" "complete-dictionary.txt")))

(defun my-generic-ispell-company-complete-setup ()
  ;; Only apply this locally.
  (make-local-variable 'company-backends)
  (setq company-backends (list 'company-ispell))

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


;; Org mode hooks and configuration

;; olivetti mode and text wrapping
(setq olivetti-body-width 90)
(add-hook! 'text-mode-hook #'olivetti-mode)
;; (add-hook 'org-mode-hook (lambda () (my-generic-ispell-company-complete-setup)))
;; (add-hook 'text-mode-hook
;;           '(lambda() (turn-on-auto-fill) (set-fill-column 80)))

(setq dired-dwim-target t)

;; org-roam, org-ref, org-roam-bibtex etc.
(setq org-roam-directory "~/google_drive/.notes/slip-box"
      org-roam-link-title-format "§:%s"
      org-roam-completion-system 'helm
      org-roam-index-file "~/google_drive/.notes/slip-box/index.org")

(setq org-roam-capture-templates
      '(("d" "default" plain (function org-roam-capture--get-point)
          "%?"
          :file-name "%<%Y-%m-%d>-${slug}"
          :head "#+TITLE: ${title}\n"
          :unnarrowed t)))
;;         ("l" "lit" plain (function org-roam--capture-get-point)
;;            "%?"
;;            :file-name "lit/${slug}"
;;            :head "#+setupfile:./hugo_setup.org
;; #+title: ${title}\n"
;;            :unnarrowed t)

;;           ("c" "concept" plain (function org-roam--capture-get-point)
;;            "%?"
;;            :file-name "concepts/${slug}"
;;            :head "#+setupfile:./hugo_setup.org
;; #+title: ${title}\n"
;;            :unnarrowed t)

;;           ("p" "private" plain (function org-roam-capture--get-point)
;;            "%?"
;;            :file-name "private/${slug}"
;;            :head "#+title: ${title}\n"
;;            :unnarrowed t)))

(setq org-roam-capture-ref-templates
      '(("r" "ref" plain (function org-roam-capture--get-point)
          "%?"
          :file-name "lit/${slug}"
          :head "#+setupfile:./hugo_setup.org
#+roam_key: ${ref}
#+hugo_slug: ${slug}
#+roam_tags: website
#+title: ${title}\n")))

(setq org-journal-file-header  ""
      org-journal-dir "~/google_drive/.notes"
      org-journal-date-prefix "#+TITLE:"
      org-journal-file-format "%Y-%m-%d.org"
      org-journal-date-format "%A, %d %B %Y \n"
      org-journal-enable-agenda-integration  t)

(setq reftex-default-bibliography '("~/google_drive/.notes/.bibliography/references.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/google_drive/.notes/.bibliography/bibliography_notes.org"
      org-ref-default-bibliography '("~/google_drive/.notes/.bibliography/references.bib")
      org-ref-pdf-directory "~/google_drive/.notes/.bibliography/bibtex_pdf/")

(setq bibtex-completion-bibliography "~/google_drive/.notes/.bibliography/references.bib"
      bibtex-completion-library-path "~/google_drive/.notes/.bibliography/bibtex_pdf/"
      bibtex-completion-notes-path "~/google_drive/.notes/.bibliography/bibliography_notes/"
      bibtex-completion-pdf-field "File"
      bibtex-completion-find-additional-pdfs t)

;; (setq org-agenda-files '("~/google_drive/.notes/agenda.org"))
(setq org-todo-keywords '((sequence "PENDING(p)" "TODO(t)" "NEXT(n)" "WAITING(w)" "DELEGATED(d)" "NOTE(N)"  "|" "DONE(d)" "CANCELLED(c)")))

(defun org-archive-done-tasks ()
  (interactive)
  (org-map-entries
    (lambda ()
      (org-archive-subtree)
      (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
    "/DONE" 'agenda))

(defun my/org-ref-open-pdf-at-point ()
  "Open the pdf for bibtex key under point if it exists."
  (interactive)
  (let* ((results (org-ref-get-bibtex-key-and-file))
          (key (car results))
          (pdf-file (funcall org-ref-get-pdf-filename-function key)))
    (if (file-exists-p pdf-file)
        (find-file pdf-file)
      (message "No PDF found for %s" key))))

(setq org-ref-open-pdf-function 'my/org-ref-open-pdf-at-point)

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

;; (define-key evil-normal-state-map kbd("C-'") 'evil-org-open-below)

(setq-default delete-by-moving-to-trash t                      ; Delete files to trash
              tab-width 4                                      ; Set width for tabs
              uniquify-buffer-name-style 'forward              ; Uniquify buffer names
              window-combination-resize t                      ; take new window space from all other windows (not just current)
              x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      inhibit-compacting-font-caches t            ; When there are lots of glyphs, keep them in memory
      backup-directory-alist `(("." . ,(concat user-emacs-directory "autosaved_files")))
      truncate-string-ellipsis "…")               ; Unicode ellispis are nicer than "...", and also save /precious/ space

(delete-selection-mode 1)                         ; Replace selection when inserting text
(display-time-mode 1)                             ; Enable time in the mode-line
(display-battery-mode 1)                          ; On laptops it's nice to know how much power you have
(global-subword-mode 1)                           ; Iterate through CamelCase words

(if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))

(setq evil-vsplit-window-right t
      evil-split-window-below t)

;; completion
(setq company-idle-delay 0.5
      company-minimum-prefix-length 2
      company-show-numbers t)
(add-hook 'evil-normal-state-entry-hook #'company-abort) ;; make aborting less annoying.

(setq-default history-length 1000)
(setq-default prescient-history-length 1000)

;; (require 'flyspell-lazy)
;; (flyspell-lazy-mode 0)
;; (setq ispell-dictionary "~/google_drive/dictionary_en_SCOWL_80.txt")
;; (setq ispell-personal-dictionary "~/google_drive/hunspell_personal")

(setq which-key-idle-delay 0.2)
(setq which-key-idle-secondary-delay 0.1)
(setq which-key-allow-multiple-replacements t)

(defun my_refile(file headline)
  (let ((pos (save-excursion
               (find-file file)
               (org-find-exact-headline-in-buffer headline))))
    (org-refile nil nil (list headline file nil pos)))
  ;; (switch-to-buffer (current-buffer))
  )

(defun my_get_question()
  (interactive)
  (when ((save-excursion (beginning-of-line) (looking-at "\*\*Q\..*$"))
         (save-excursion
           (progn
             (org-set-tags "exported")
             (evil-next-line)
             (setq question (thing-at-point 'sentence))
             (re-search-forward "A.$")
             (org-set-tags "exported")
             (evil-next-line)
             (setq answer (thing-at-point 'sentence))
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
               (my_refile "/home/jonathan/google_drive/.notes/anki.org" "Waiting for export")))))))


