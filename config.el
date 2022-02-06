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
       doom-font  (font-spec :family "NotoMono" :size 20)
       ;; doom-font  (font-spec :family "Source Code Pro" :size 18)
     ;; doom-font (font-spec :family "Alef" :size 20)
      doom-big-font (font-spec :family "NotoMono" :size 20)
      ;; doom-big-font (font-spec :family "JetBrains Mono" :size 20)
      ;; doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 20)
      doom-variable-pitch-font (font-spec :family "NotoSans" :size 20)
      doom-unicode-font (font-spec :name "NotoMono" :size 20))


;; (custom-theme-set-faces 'user
  ;;        '(variable-pitch ((t (:family "ETBembo" :height 180 :weight thin))))
  ;;        '(fixed-pitch ((t ( :family "Fira Code Retina" :height 200))))))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one-light)
;;(setq doom-theme 'doom-vibrant)
;;
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/google_drive/.notes.v2/slip-box")
;;
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq-default display-line-numbers-type 'relative)


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
 bibliography-dir (concat (getenv "HOME") "/google_drive/.bibliography/")
 bibliography-pdf-dir (list  "~/google_drive/.bibliography/zotero_pdf")

 bibliography-files '( "~/google_drive/.bibliography/motor-cognition.bib"  "~/google_drive/.bibliography/consciousness.bib")
 notes-dir (concat (getenv "HOME") "/google_drive/.notes.v2/")
 gtd-dir (concat notes-dir  "gtd/")
 slip-box-dir (concat notes-dir "slip-box/")
 literature-notes-dir (list  "~/google_drive/.notes.v2/slip-box/literature-notes/")

 org-my-anki-file (concat slip-box-dir "anki.org")
 org-capture-papers-file (concat slip-box-dir "2021-06-17-papers_by_subject.org")
 org-capture-inbox-file (concat gtd-dir "inbox.org")
 org-capture-reminders-file (concat gtd-dir "reminders.org")
 org-capture-projects-file (concat gtd-dir "projects.org")
 org-capture-someday-file (concat gtd-dir "someday.org")
 org-capture-writing-inbox-file (concat slip-box-dir "writing-inbox.org")

 org-directory notes-dir
 ;; org-roam-directory "~/slip-box"
 org-roam-directory slip-box-dir

 evil-respect-visual-line-mode 't
 delete-by-moving-to-trash nil                      ; Delete files to trash
 uniquify-buffer-name-style nil              ; Uniquify buffer names
 window-combination-resize t                      ; take new window space from all other        windows (not just current)
 x-stretch-cursor t                              ; Stretch cursor to the glyph width
 undo-limit 80000000                         ; Raise undo-limit to 80Mb
 evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
 garbage-collection-messages t
 auto-save-default t                         ; Nobody likes to lose work, I certainly don't
 inhibit-compacting-font-caches t            ; When there are lots of glyphs, keep them in memory
 backup-directory-alist `(("." . ,(concat user-emacs-directory "autosaved_files")))
 truncate-string-ellipsis "…")               ; Unicode ellispis are nicer than "...", and also save /precious/ space

(setq trash-directory "~/trashed-files-from-emacs/")
(setq browse-url-filename-alist '(("^/\\(ftp@\\|anonymous@\\)?\\([^:/]+\\):/*" . "ftp://\\2/") ("^/\\([^:@/]+@\\)?\\([^:/]+\\):/*" . "ftp://\\1\\2/") ("^/+" . "file:///") ("mnt/g" . "G:")))

;; (add-to-list browse-url-filename-alist (quote("mnt/g" . "G:")))
(load! "package-config.el")
(load! "my-functions.el")
(load! "faces.el")
(load! "keybindings.el")

(setq which-key-idle-delay 0.2
      which-key-idle-secondary-delay 0.1
      which-key-allow-multiple-replacements t)

(setq-default evil-shift-width 4 ; globally
              tab-width 4) ; globally
(setq evil-shift-width 4
      tab-width 4)

(delete-selection-mode 1)                         ; Replace selection when inserting text
(display-time-mode 1)                             ; Enable time in the mode-line
(display-battery-mode 1)                          ; On laptops it's nice to know how much power you have
(global-subword-mode 1)                           ; Iterate through CamelCase words

(setq-default major-mode 'org-mode)

(if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))

(setq
 visual-fill-column-width 90
 split-window-preferred-function 'visual-fill-column-split-window-sensibly

 dired-dwim-target t

 evil-vsplit-window-right t
 evil-split-window-below t)

(remove-hook 'text-mode-hook #'auto-fill-mode)

(defun my/snipe_ivy ()
  (evilem-create (list 'evil-snipe-repeat
                       'evil-snipe-repeat-reverse)
                 :bind ((evil-snipe-scope 'buffer)
                        (evil-snipe-enable-highlight)
                        (evil-snipe-enable-incremental-highlight))))

(map! :map evil-snipe-parent-transient-map "C-;" #'my/snipe_ivy )

(custom-set-variables
 '(helm-ag-base-command "rg --no-heading")
 `(helm-ag-success-exit-status '(0 2)))



(setq-default evil-escape-delay 0.4)

;; set the browser location
(setq browse-url-browser-function 'browse-url-generic browse-url-generic-program "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe")

(defun my/org-mode-hook()
          (interactive)
          (setq after-save-hook '(flycheck-handle-save t ))
          (sp-pair "$" "$")
)

(add-hook! org-agenda-mode #'writeroom-mode)
(add-hook! org-roam-mode #'visual-line-mode)
(add-hook! org-mode #'flyspell-mode #'org-superstar-mode #'my/org-mode-hook) ;; #'org-hide-properties)
(add-hook 'text-mode-hook (lambda ()
                            (setq bidi-paragraph-direction nil)
                            (setq helm-ff-fuzzy-matching t)
                            (setq captain-predicate (lambda () t))

                            (visual-fill-column-mode 1)
                            (visual-line-mode 1)
                            (flyspell-mode 1)
                            (captain-mode 1)
                            (abbrev-mode 1)
                            (my/set-faces)
                            (my/org-font)
                            ))

(add-hook 'prog-mode-hook (lambda ()
                            (setq helm-ff-fuzzy-matching t)
                            (setq captain-predicate (lambda () (nth 8 (syntax-ppss (point)))))
                            ))

(evil-snipe-override-mode 1)

(my/set-faces)

(require 'org-download)
(add-hook 'after-init-hook 'company-statistics-mode)

(customize-set-value
 'org-agenda-category-icon-alist
 `(
   ("research" "~/google_drive/icons/calendar.svg" nil nil :ascent center)
   ("school" "~/google_drive/icons/calendar.svg" nil nil :ascent center)
   ("personal" "~/google_drive/icons/checklist.svg" nil nil :ascent center)
   ("home" "~/google_drive/icons/checklist.svg" nil nil :ascent center)
   ("todo" "~/google_drive/icons/checklist.svg" nil nil :ascent center)
   ("bills" "~/google_drive/icons/money-bag.svg" nil nil :ascent center)
   ("downtown" "~/google_drive/icons/013-buildings.svg" nil nil :ascent center)
   ("emacs" "~/google_drive/icons/014-coding.svg" nil nil :ascent center)
   ))

;; (add-to-list 'load-path "/home/jonathan/wordnut")
;; (require 'wordnut)

(add-to-list 'load-path "/home/jonathan/.emacs.d/orgnv")
(load "orgnv.el")
(require 'orgnv)
(setq orgnv-directories '("/home/jonathan/google_drive/.notes.v2/slip-box"))


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
(map! :map org-mode-map :i
      "C-;" #'+company/complete
      "M-;" #'+company/complete)

(set-company-backend! 'text-mode 'company-dabbrev 'company-ispell)
;; (set-company-backend! 'text-mode 'company-capf)
(set-company-backend! 'prog-mode '(company-files))
(set-company-backend! 'emacs-lisp-mode '(company-files))

(add-hook 'bibtex-mode-hook 'my/convert-windows-to-linux-paths)
(add-hook 'text-mode-hook (lambda ()
                            (setq-local company-backends '(company-wordfreq))
                            (setq-local company-transformers nil)))

(defadvice! prompt-for-buffer (&rest _)
  :after 'evil-window-vsplit (switch-to-buffer))
;; LaTeX configuration
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

(setq TeX-output-view-style
    (quote
     (("^pdf$" "." "evince -f %o")
      ("^html?$" "." "iceweasel %o"))))

(setq initial-major-mode 'org-mode)
(setq helm-ff-fuzzy-matching t)

(set-input-method 'hebrew-full)

(remove-hook 'after-save-hook #'ws-butler-after-save)   ;
(add-hook 'after-init-hook 'company-statistics-mode)

;; (my-generic-ispell-company-complete-setup)

(defun my/dedicate-org-roam-buffer ()
  (add-to-list 'display-buffer-alist
               '("\\*org-roam\\*"
                 (display-buffer-in-side-window)
                 (dedicated . t)
                 (side . right)
                 (slot . 0)
                 (window-width . 0.33)
                 (window-parameters . ((no-other-window . t)
                                       (no-delete-other-windows . t)))))
  )

(my/dedicate-org-roam-buffer)

  (setq
   org-cite-global-bibliography bibliography-files
   org-cite-insert-processor 'citar)
;; (setq org-cite-csl-styles-dir "~/Zotero/styles")

(advice-add #'completing-read-multiple :override #'consult-completing-read-multiple)
(defun with-minibuffer-keymap (keymap)
  (lambda (fn &rest args)
    (minibuffer-with-setup-hook
        (lambda ()
          (use-local-map
           (make-composed-keymap keymap (current-local-map))))
      (apply fn args))))

(defvar embark-completing-read-prompter-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<tab>") 'abort-recursive-edit)
    map))

;; (advice-add 'embark-completing-read-prompter :around
;;             (with-minibuffer-keymap embark-completing-read-prompter-map))
;; (define-key vertico-map (kbd "C-<tab>") 'embark-act-with-completing-read)

  (defun embark-act-with-completing-read (&optional arg)
    (interactive "P")
    (let* ((embark-prompter 'embark-completing-read-prompter)
           (act (propertize "Act" 'face 'highlight))
           (embark-indicator (lambda (_keymap targets) nil)))
      (embark-act arg)))

(advice-add #'completing-read-multiple :override #'consult-completing-read-multiple)
(setq org-odt-preferred-output-format "docx")
