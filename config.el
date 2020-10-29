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
 org-my-anki-file (concat slip-box-dir "anki.org")
 org-capture-inbox-file (concat gtd-dir "inbox.org")
 org-capture-reminders-file (concat gtd-dir "reminders.org")
 org-capture-projects-file (concat gtd-dir "projects.org")
 org-capture-someday-file (concat gtd-dir "someday.org")
 org-capture-writing-inbox-file (concat slip-box-dir "writing_inbox.org")
 org-directory notes-dir
 org-roam-directory notes-dir
 auto-save-interval 20
 auto-save-visited-mode t

delete-by-moving-to-trash t                      ; Delete files to trash
tab-width 4                                      ; Set width for tabs
uniquify-buffer-name-style 'forward              ; Uniquify buffer names
window-combination-resize t                      ; take new window space from all other windows (not just current)
x-stretch-cursor t                              ; Stretch cursor to the glyph width

undo-limit 80000000                         ; Raise undo-limit to 80Mb
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

(setq
 visual-fill-column-width 90
 split-window-preferred-function 'visual-fill-column-split-window-sensibly)

(setq dired-dwim-target t)

(setq evil-vsplit-window-right t
      evil-split-window-below t)


(load-file "~/.doom.d/keybindings.el")
(load-file "~/.doom.d/my-functions.el")
(load-file "~/.doom.d/package-config.el")

                        ;; `(line-number ((t (:inherit default :foreground "#9fa6b" :strike-through nil :underline nil :slant normal :weight normal :height 174 :width normal :foundry "ADBO" :family "Source Code Pro"))))
                        ;; `(line-number-current-line ((t (:inherit (hl-line default) :foreground "#bbc2cf" :strike-through nil :underline nil :slant normal :weight normal :height 174 :width normal :foundry "ADBO" :family "Source Code Pro"))))
(defun my/org-font ()
  (face-remap-add-relative 'default :family "alef" :height 190))

(setq text-scale-mode-step 1.05)

(setq
      org-journal-file-header  ""
      org-journal-dir "~/google_drive/.notes"
      org-journal-date-prefix "#+TITLE:"
      org-journal-file-format "%Y-%m-%d.org"
      org-journal-date-format "%A, %d %B %Y \n"
      org-journal-enable-agenda-integration  t)

;; (eval-after-load 'org-mode
;;  '(define-key evil-insert-state-map  [(return)]   'evil-org-return))

(remove-hook 'text-mode-hook #'auto-fill-mode)

(add-hook 'pdf-tools-enabled-hook 'pdf-view-midnight-minor-mode)
(defun my/snipe_ivy ()
  (evilem-create (list 'evil-snipe-repeat
                       'evil-snipe-repeat-reverse)
                 :bind ((evil-snipe-scope 'buffer)
                        (evil-snipe-enable-highlight)
                        (evil-snipe-enable-incremental-highlight))))

(map! :map evil-snipe-parent-transient-map "C-;" #'my/snipe_ivy)

(custom-set-variables
 '(helm-ag-base-command "rg --no-heading")
 `(helm-ag-success-exit-status '(0 2)))

;; (set-face-attribute 'line-number nil
;;                     :font "Iosevka Term Slab")
;; (set-face-attribute 'line-number-current-line nil
;;                     :font "Iosevka Term Slab"
;;                     :background "white" :foreground "black"))


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

(setq-default evil-escape-delay 0.4)

;; set the browser location
(setq browse-url-browser-function 'browse-url-generic browse-url-generic-program "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe")

(add-hook! org-mode #'flyspell-mode #'org-superstar-mode)
(add-hook 'text-mode-hook (lambda ()
                            (setq bidi-paragraph-direction nil)
                            (flyspell-mode 1)
                            (visual-fill-column-mode 1)
                            (olivetti-mode 1)
                            (face-remap-add-relative 'default :family "alef")))
(key-chord-mode 1)
(evil-snipe-override-mode 1)

(require 'org-download)
(add-hook 'after-init-hook 'company-statistics-mode)

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

;; (setq
;;  org-agenda-block-separator " "
;;  org-agenda-custom-commands
;;       '(("o" "my agenda"
;;          (
;;           (todo "NEXT|STRT|HOLD" (
;;                         (org-agenda-overriding-header "\n⚡ do today:\n")
;;                         (org-agenda-remove-tags t)
;;                         (org-agenda-prefix-format (concat "  %-2i %-13b" ))
;;                         (org-agenda-todo-keyword-format "")))
;;           (agenda "" (
;;                       (org-agenda-overriding-header "⚡ schedule:\n")
;;                       (org-agenda-start-day "+0d")
;;                       (org-agenda-span 5)
;;                       (org-agenda-remove-tags t)
;;                       (org-agenda-prefix-format   (concat "  %-3i  %-15b %t%s"))
;;                       (org-agenda-current-time-string "⟸ now")
;;                       (org-agenda-scheduled-leaders '("" ""))
;;                       (org-agenda-time-grid (quote ((daily today remove-match)
;;                                                     (0900 1200 1800 2100)
;;                                                     "      " "┈┈┈┈┈┈┈┈┈┈┈┈┈")))))
;;           )
;;          )))

(add-to-list 'load-path "/home/jonathan/wordnut")
(require 'wordnut)

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
  (add-hook 'org-roam-buffer-prepare-hook #'hide-mode-line-mode)

(setq
      org-journal-file-header  ""
      org-journal-dir "~/google_drive/.notes"
      org-journal-date-prefix "#+TITLE:"
      org-journal-file-format "%Y-%m-%d.org"
      org-journal-date-format "%A, %d %B %Y \n"
      org-journal-enable-agenda-integration  t)


(add-hook 'occur-mode-hook
          (defun occur-show-replace-context+ ()
            (add-hook 'replace-update-post-hook
                      'occur-mode-display-occurrence nil 'local)))
(define-advice occur-mode-display-occurrence
    (:around (fun &rest args) save-match-data)
  (save-match-data
    (apply fun args)))


;; completion
(setq company-idle-delay 0.5
      company-minimum-prefix-length 2
      company-show-numbers t)
(setq-default history-length 1000)
(setq-default prescient-history-length 1000)

(set-company-backend! 'prog-mode '(company-files))
(set-company-backend! 'emacs-lisp-mode '(company-files))

(setq which-key-idle-delay 0.2)
(setq which-key-idle-secondary-delay 0.1)
(setq which-key-allow-multiple-replacements t)
(setq-default evil-shift-width 4) ; globally
(setq-default tab-width 4) ; globally
(setq evil-shift-width 4)
(setq tab-width 4)
