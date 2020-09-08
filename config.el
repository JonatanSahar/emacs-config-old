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
;; (setq doom-font
(setq
       doom-font  (font-spec :family "Source Code Pro" :size 18)
     ;; doom-font (font-spec :family "Alef" :size 20)
      doom-big-font (font-spec :family "JetBrains Mono" :size 16)
      doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 16)
      doom-unicode-font (font-spec :name "DejaVu Sans Mono" :size 16))


;; Setting English Font
;; (set-face-attribute
;;  'default nil
;;  :stipple nil
;;  :height 200
;;  :width 'normal
;;  :inverse-video nil
;;  :box nil
;;  :strike-through nil
;;  :overline nil
;;  :underline nil
;;  :slant 'normal
;;  :weight 'normal
;;  :foundry "outline"
;;  :family "Fira code retina")
;;
;; (custom-theme-set-faces 'user
  ;;        '(variable-pitch ((t (:family "ETBembo" :height 180 :weight thin))))
  ;;        '(fixed-pitch ((t ( :family "Fira Code Retina" :height 200))))))
 
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

;; various settings
(setq
 notes-dir (concat (getenv "HOME") "/google_drive/.notes/")
 gtd-dir (concat notes-dir  "gtd/")
 slip-box-dir (concat notes-dir "slip-box/")
 literature-notes-dir (concat notes-dir "literature-notes/")
 org-my-anki-file (concat notes-dir "anki.org")
 org-capture-inbox-file (concat gtd-dir "inbox.org")
 org-capture-reminders-file (concat gtd-dir "reminders.org")
 org-capture-projects-file (concat gtd-dir "projects.org")
 org-capture-someday-file (concat gtd-dir "someday.org")
 org-capture-writing-inbox-file (concat slip-box-dir "writing_inbox.org")
 org-directory notes-dir
 org-roam-directory notes-dir

 auto-save-interval 20
 auto-save-visited-mode t)

(global-hl-fill-column-mode -1)

(defun my/org-faces()
  (interactive)
 (let* ((variable-tuple (cond
                              ((x-family-fonts "Alef")    '(:family "Alef"))
                              ((x-family-fonts "Fira Code Retina")    '(:family "Fira Code Retina"))
                              ((x-family-fonts "Source Sans Pro")    '(:family "Source Sans Pro"))
                              (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))
                              )
                        )
        (base-font-color     (face-foreground 'default nil 'default))
        (headline           `(:inherit default :weight normal :foreground ,base-font-color)))

   (custom-theme-set-faces 'user
                           `(org-level-8 ((t (,@headline ,@variable-tuple))))
                           `(org-level-7 ((t (,@headline ,@variable-tuple))))
                           `(org-level-6 ((t (,@headline ,@variable-tuple))))
                           `(org-level-5 ((t (,@headline ,@variable-tuple))))
                           `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
                           `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.1))))
                           `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.1))))
                           `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.15))))
                           `(org-document-title ((t (,@headline ,@variable-tuple :height 1.2 :underline nil))))))
 )
(define-key evil-normal-state-map (kbd "J") 'evil-join)
(define-key evil-normal-state-map (kbd "K") 'join-line)
;; (eval-after-load 'org-mode
;;  '(define-key evil-insert-state-map  [(return)]   'evil-org-return))

(setq key-chord-two-keys-delay 0.2)
(key-chord-define evil-insert-state-map "jk" #'evil-force-normal-state)
(key-chord-define evil-visual-state-map "jk" #'evil-force-normal-state)
(key-chord-define-global "jk" #'evil-force-normal-state)

(key-chord-define-global "zh" #'windmove-left)
(key-chord-define-global "zl" #'windmove-right)
(key-chord-define-global "zk" #'windmove-up)
(key-chord-define-global "zj" #'windmove-down)

;; movement
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
(define-key evil-normal-state-map (kbd "'") 'evil-goto-mark)
(define-key evil-normal-state-map (kbd "`") 'evil-goto-mark-line)
(setq-default pdf-view-display-size 'fit-width)
(setq pdf-view-resize-factor 1.1)



(defun my/snipe_ivy ()
  (evilem-create (list 'evil-snipe-repeat
                       'evil-snipe-repeat-reverse)
                 :bind ((evil-snipe-scope 'buffer)
                        (evil-snipe-enable-highlight)
                        (evil-snipe-enable-incremental-highlight))))

(map! :map evil-snipe-parent-transient-map "C-;" #'my/snipe_ivy)



(map!
 :map evil-org-mode-map
 :i "C-S-L" nil
 :map pdf-view-mode-map
 :n "gl" nil)

(map!
 :nvi "C-\\" #'toggle-input-method
 :nvi "C-s" #'save-buffer
 :i "S-SPC" #'evil-force-normal-state
 :map evil-org-mode-map
 :i "C-l" #'org-roam-insert
 :i "C-S-L" #'org-ref-insert-link)

(map! [C-o] #'better-jumper-jump-backward
      [C-i] #'better-jumper-jump-forward)

(map! :map org-roam-backlinks-mode-map "return" #'org-open-at-point)

(map! :map pdf-view-mode-map
      :nvi "I" #'org-noter-insert-precise-note
      :nvi "i" #'org-noter-insert-note)

(map! :leader
      :desc "Org Noter" :nv "nN" #'org-noter
      (:when (featurep! :completion helm)
        :desc "M-x" :n "SPC" #'helm-M-x))

(map!
    :n "gk" nil
    :n "zj" nil
    :n "zz" nil
    :n "zh" nil
    :n "zj" nil
    :n "zk" nil
    :n "zl" nil

    :map org-mode-map
    :n "gz" nil
    :n "gh" nil
    :n "gj" nil
    :n "gk" nil
    :n "gl" nil
    :n "gJ" nil
    :n "gK" nil

    :n "zz" nil
    :n "zh" nil
    :n "zj" nil
    :n "zk" nil
    :n "zl" nil
 )

(map!
 :n "gO" #'+evil/insert-newline-above
 :n "go" #'+evil/insert-newline-below
 :n "gK" #'+evil/insert-newline-above
 :n "gJ" #'+evil/insert-newline-below

 :n "g]" #'kmacro-end-and-call-macro
 :n "g." #'er/expand-region

 :n "gh" #'windmove-left
 :n "gj" #'windmove-down
 :n "gk" #'windmove-up
 :n "gl" #'windmove-right

 :n "zh" #'windmove-left
 :n "zj" #'windmove-down
 :n "zk" #'windmove-up
 :n "zl" #'windmove-right
 )


(map! :prefix "zz"
       :n "z" #'evil-scroll-line-to-center
       :n "h" #'evil-window-left
       :n "j" #'evil-window-down
       :n "k" #'evil-window-up
       :n "l" #'evil-window-right)

(map! :leader
  :nv
  :desc "add line above" "ik" #'+evil/insert-newline-above
  :desc "add line below" "ij" #'+evil/insert-newline-below)

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
      (:prefix ("j" . "navigation")
       :desc "avy timer" "j" 'avy-goto-char-timer
       :desc "avy line" "l" 'avy-goto-line)
      (:prefix ("k" . "my commands")
       :desc "kill all other windows" "o" 'delete-other-windows
       :desc "kill buffer and window" "w" '+workspace/close-window-or-workspace
       :desc "kill buffer and window" "d" 'kill-current-buffer
       :desc "switch to previous buffer" "k" 'evil-switch-to-windows-last-buffer
       :desc "save current buffer" "s" 'save-buffer
       :desc "refile subtree" "r" 'org-refile
       (:prefix ("b" . "references")
        :desc "crossref search for refernce" "r" 'doi-utils-add-entry-from-crossref-query
        :desc "add refernce from doi" "d" 'doi-utils-add-bibtex-entry-from-doi
        :desc "helm bibtex" "h" 'helm-bibtex
        )))



(defhydra hydra-window (:color red
                        :columns 3)
  ("h" windmove-left "window-left")
  ("j" windmove-down "window-down")
  ("k" windmove-up "window-up")
  ("l" windmove-right "right-left")
  (">" (window-resize nil 15 1) "increase window size horizontally")
  ("<" (window-resize nil -15 1) "decrease window size horizontally")
  ("+" (window-resize nil 15 nil) "increase window size vertically")
  ("-" (window-resize nil -15 nil) "increase window size vertically")
  ("|" (lambda ()
         (interactive)
         (split-window-right)
         (windmove-right)) "split right")
  ("_" (lambda ()
         (interactive)
         (split-window-below)
         (windmove-down)) "split down")
  ("q" nil "quit" :color blue))
(map! :leader "w." 'hydra-window/body)


;; (use-package org-noter
;;   :after (:any org pdf-view)
;;   :config
;;   (setq
;;    ;; ;; The WM can handle splits
;;    ;; org-noter-notes-window-location 'other-frame
;;    ;; ;; Please stop opening frames
;;    ;; org-noter-always-create-frame nil
;;    ;; ;; I want to see the whole file
;;    ;; org-noter-hide-other nil
;;    ;; ;; Everything is relative to the main notes file
;;    org-noter-notes-search-path (list  literature-notes-dir)
;;    )
;;   )

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
      deft-directory slip-box-dir
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
(setq org-agenda-files '("~/google_drive/.notes/gtd/inbox.org"
                         "~/google_drive/.notes/gtd/reminders.org"
                         "~/google_drive/.notes/gtd/projects.org"
                         "~/google_drive/.notes/gtd/someday.org"
                         "~/google_drive/.notes/gtd/writing_inbox.org"))

(setq org-refile-targets '(
                           ( org-capture-projects-file :maxlevel . 1)
                           ( org-capture-someday-file :level . 1)
                           ( org-capture-inbox-file :maxlevel . 2)
                           (nil . (:maxlevel . 2)) ;; current buffer
                           ( org-capture-reminders-file :maxlevel . 1)))

;; (after! org
  (setq org-todo-keywords '((sequence "SORT" "TODO(t)" "NEXT(n)" "START(s)" "HOLD(h)" "NOTE(N)" "|" "DONE(d)")
                           (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")))
  (setq org-capture-templates
      '(("t" "Todo"
         entry
         (file+headline org-capture-inbox-file "Tasks")
         "** TODO %? %i\n")

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
;; )

(setq org-outline-path-complete-in-steps nil
      org-goto-interface 'outline-path-completion)

(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook (function (lambda () (setq bidi-paragraph-direction nil))))
(add-hook 'org-roam-mode-hook (function (lambda () (setq bidi-paragraph-direction nil))))
;; (add-hook! 'org-mode-hook #'org-roam-buffer-activate)

(evil-snipe-override-mode 1)




;;pomodoro
(use-package org-pomodoro)
(setq org-pomodoro-manual-break nil)


(setq
 org-ellipsis "▼"
 ;; ➡, ⚡, ▼, ↴, ∞, ⬎, ⤷, ⤵, …
 org-deadline-warning-days 7
 org-agenda-breadcrumbs-separator " ❱ "
org-odd-levels-only  t
org-hide-emphasis-markers t)



(defun my/evaluate_in_parens()
(interactive)
(let (pos1 pos2 bds)
  (if (use-region-p)
     (setq pos1 (region-beginning) pos2 (region-end))
    (progn
      (setq bds (bounds-of-thing-at-point 'defun))
      (setq pos1 (car bds) pos2 (cdr bds))))

  ;; now, pos1 and pos2 are the starting and ending positions of the
  ;; current word, or current text selection if exist.
  (downcase-region pos1 pos2)
  ))

(defun my/org-search ()
  (interactive)
  (org-refile '(4)))


(customize-set-value
 'org-agenda-category-icon-alist
 `(
   ("research" "~/google_drive/icons/calendar.svg" nil nil :ascent center)
   ("school" "~/google_drive/icons/calendar.svg" nil nil :ascent center)
   ("home" "~/google_drive/icons/checklist.svg" nil nil :ascent center)
   ("todo" "~/google_drive/icons/checklist.svg" nil nil :ascent center)
   ("wedding" "~/google_drive/icons/012-wedding-rings.svg" nil nil :ascent center)
   ("bills" "~/google_drive/icons/money-bag.svg" nil nil :ascent center)
   ("downtown" "~/google_drive/icons/013-buildings.svg" nil nil :ascent center)
   ("emacs" "~/google_drive/icons/014-coding.svg" nil nil :ascent center)
   ))

(setq
 org-agenda-block-separator " "
 org-agenda-custom-commands
      '(("o" "my agenda"
         (
          (todo "NEXT|STRT" (
                        (org-agenda-overriding-header "\n⚡ do today:\n")
                        (org-agenda-remove-tags t)
                        (org-agenda-prefix-format (concat "  %-2i %-13b" ))
                        (org-agenda-todo-keyword-format "")))
          (agenda "" (
                      (org-agenda-overriding-header "⚡ schedule:\n")
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
         )))
config.el


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

(setq olivetti-body-width 120)
;; olivetti mode and text wrapping
(add-hook! 'text-mode-hook
           #'turn-on-olivetti-mode
           #'my/org-faces);; #'variable-pitch-mode)

(add-hook! 'prog-mode-hook
           #'turn-on-olivetti-mode)

(use-package olivetti
  :ensure t
  :config (setq olivetti-body-width 120)
  )

(add-hook 'visual-line-mode-hook #'visual-fill-column-mode)
(setq
 visual-fill-column-width 90
 split-window-preferred-function 'visual-fill-column-split-window-sensibly)

(setq dired-dwim-target t)

(use-package org-roam
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
        ;; org-roam-verbose nil  ; https://youtu.be/fn4jIlFwuLU
        ;; org-roam-completion-system 'default
        org-roam-directory "~/google_drive/.notes/slip-box"
        org-roam-link-title-format "§:%s"
        org-roam-completion-system 'helm
        org-roam-index-file "~/google_drive/.notes/slip-box/index.org")
)

  ;; ;; Normally, the org-roam buffer doesn't open until you explicitly call
  ;; ;; `org-roam'. If `+org-roam-open-buffer-on-find-file' is non-nil, the
  ;; ;; org-roam buffer will be opened for you when you use `org-roam-find-file'
  ;; ;; (but not `find-file', to limit the scope of this behavior).
  ;; (add-hook 'find-file-hook
  ;;   (defun +org-roam-open-buffer-maybe-h ()
  ;;     (and +org-roam-open-buffer-on-find-file
  ;;          (memq 'org-roam-buffer--update-maybe post-command-hook)
  ;;          (not (window-parameter nil 'window-side)) ; don't proc for popups
  ;;          (not (eq 'visible (org-roam-buffer--visibility)))
  ;;          (with-current-buffer (window-buffer)
  ;;            (org-roam-buffer--get-create)))))

  ;; ;; Hide the mode line in the org-roam buffer, since it serves no purpose. This
  ;; ;; makes it easier to distinguish among other org buffers.
  ;; (add-hook 'org-roam-buffer-prepare-hook #'hide-mode-line-mode)


;; Since the org module lazy loads org-protocol (waits until an org URL is
;; detected), we can safely chain `org-roam-protocol' to it.
(use-package org-roam-protocol
  :after org-protocol)


(use-package company-org-roam
  :after org-roam
  :config
  (set-company-backend! 'org-mode '(company-org-roam company-yasnippet company-dabbrev)))


(setq org-roam-capture-templates
      '(("d" "default" plain (function org-roam-capture--get-point)
          "%?"
          :file-name "%<%Y-%m-%d>-${slug}"
          :head "#+TITLE: ${title}\n"
          :unnarrowed t)))

(setq org-roam-capture-ref-templates
      '(("r" "ref" plain (function org-roam-capture--get-point)
          "%?"
          :file-name "lit/${slug}"
          :head "#+setupfile:./hugo_setup.org
#+roam_key: ${ref}
#+hugo_slug: ${slug}
#+roam_tags: website
#+title: ${title}\n")))

;; (use-package org-roam-bibtex
;;   :after (org-roam)
;;   :hook (org-roam-mode . org-roam-bibtex-mode)
;;   :config
;;   (setq orb-preformat-keywords
;;    '("=key=" "title" "url" "file" "author-or-editor" "keywords"))
;;   (setq orb-templates
;;         '(("r" "ref" plain (function org-roam-capture--get-point)
;;            ""
;;            :file-name "${slug}"
;;            :head "#+TITLE: ${=key=}: ${title}\n#+ROAM_KEY: ${ref}
;; - tags ::
;; - keywords :: ${keywords}
;; \n* ${title}\n  :PROPERTIES:\n  :Custom_ID: ${=key=}\n  :URL: ${url}\n  :AUTHOR: ${author-or-editor}\n  :NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n  :NOTER_PAGE: \n  :END:\n\n"

;;            :unnarrowed t))))

(setq
      org-journal-file-header  ""
      org-journal-dir "~/google_drive/.notes"
      org-journal-date-prefix "#+TITLE:"
      org-journal-file-format "%Y-%m-%d.org"
      org-journal-date-format "%A, %d %B %Y \n"
      org-journal-enable-agenda-integration  t)

(setq
 org-ref-bibliography-notes "~/google_drive/.notes/.bibliography/bibliography_notes.org"
 org-ref-default-bibliography "~/google_drive/.notes/.bibliography/references.bib"
 org-ref-pdf-directory "~/google_drive/.notes/.bibliography/bibtex_pdf"
 org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
 org-ref-note-title-format "* TODO %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :END:\n\n"
 org-ref-notes-directory "~/google_drive/.notes/literature-notes/"
 org-ref-notes-function 'orb-edit-notes)


;; (setq bibtex-completion-pdf-open-function
;;   (lambda (fpath)
;;     (start-process "open" "*open*" "open" fpath)))

(require 'org-ref)
(setq
    bibtex-completion-bibliography "~/google_drive/.notes/.bibliography/references.bib"
    bibtex-completion-library-path '( "~/google_drive/.notes/.bibliography/bibtex_pdf")
    bibtex-completion-notes-path "~/google_drive/.notes/literature-notes"
    bibtex-completion-pdf-field "File"
    ;; bibtex-completion-notes-template-multiple-files
    ;; (concat
    ;; "#+TITLE: ${title}\n"
    ;; "#+ROAM_KEY: cite:${=key=}\n"
    ;; "* TODO Notes\n"
    ;; ":PROPERTIES:\n"
    ;; ":Custom_ID: ${=key=}\n"
    ;; ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
    ;; ":AUTHOR: ${author-abbrev}\n"
    ;; ":JOURNAL: ${journaltitle}\n"
    ;; ":DATE: ${date}\n"
    ;; ":YEAR: ${year}\n"
    ;; ":DOI: ${doi}\n"
    ;; ":URL: ${url}\n"
    ;; ":END:\n\n")
    bibtex-completion-find-additional-pdfs t)


(defun my/org-archive-done-tasks ()
  (interactive)
  (org-map-entries
    (lambda ()
      (org-archive-subtree)
      (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
    "/DONE" 'agenda))

(defun my/paragraph-LTR ()
    (setq bidi-paragraph-direction 'left-to-right))


(defun my/paragraph-RTL ()
    (setq bidi-paragraph-direction 'right-to-left))


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
;; (add-hook 'evil-normal-state-entry-hook #'company-abort) ;; make aborting less annoying.

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


