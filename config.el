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
;;
(setq
        doom-font  (font-spec :family "Roboto Mono" :weight 'regular :size 18)
        doom-big-font  (font-spec :family "Roboto Mono" :weight 'regular :size 18)
 ;; doom-font  (font-spec :family "Alef" :size 14)
 ;; doom-font  (font-spec :family "Source Code Pro" :size 18)
 ;; doom-font (font-spec :family "Alef" :size 10)
 ;; doom-big-font (font-spec :family "Noto Mono" :size 10)
 ;; doom-big-font (font-spec :family "JetBrains Mono" :size 10)
 ;; doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 14)
 doom-variable-pitch-font (font-spec :family "Noto Sans" :size 16)
 ;; doom-unicode-font (font-spec :name "Noto Mono" :size 10))
 )


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
 notes-dir "G:\\My Drive\\notes"
 gtd-dir (concat (file-name-as-directory notes-dir)  (file-name-as-directory "gtd"))
 slip-box-dir (concat (file-name-as-directory notes-dir)  (file-name-as-directory "slip-box"))
 literature-notes-dir (list (concat (file-name-as-directory slip-box-dir)  (file-name-as-directory "literature-notes")))
 emacs-directory (concat (file-name-as-directory (getenv "HOME")) (file-name-as-directory ".emacs.d"))
 org-capture-writing-inbox-file (concat (file-name-as-directory notes-dir) "writing_inbox.org")
)

 (setq
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

(add-to-list 'load-path (concat emacs-directory (file-name-as-directory "orgnv")))
(load "orgnv.el")
(require 'orgnv)
(setq orgnv-directories (list (concat (file-name-as-directory notes-dir)  (file-name-as-directory "slip-box"))))

(load! "package-config.el")
(load! "my-functions.el")
;; (load! "faces.el")
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

(font-lock-add-keywords nil '(("\"\\(\\(?:.\\|\n\\)*?[^\\]\\)\"" 0 font-lock-string-face)))
;; (add-hook! org-agenda-mode #'writeroom-mode)
(add-hook! org-roam-mode #'visual-line-mode)
(defun my/org-mode-hook()
          (interactive)
          (+zen/toggle)
          ;; (setq after-save-hook '(flycheck-handle-save t ))
          (sp-pair "$" "$"))
(add-hook! org-mode #'my/org-mode-hook) ;; #'org-hide-properties)
;; (add-hook! org-mode #'flyspell-mode #'org-superstar-mode #'writeroom-mode #'my/org-mode-hook) ;; #'org-hide-properties)
(add-hook 'text-mode-hook 'my-buffer-face-mode-text)
(add-hook 'text-mode-hook (lambda ()
                            (setq bidi-paragraph-direction nil)
                            (setq bidi-paragraph-start-re  "^")
                            (setq bidi-paragraph-separate-re  "^")
                            (setq helm-ff-fuzzy-matching t)
                            (setq captain-predicate (lambda () t))

                            (visual-fill-column-mode 1)
                            (visual-line-mode 1)
                            ;; (flyspell-mode 1)
                            (captain-mode 1)
                            (abbrev-mode 1)
                            (font-lock-mode 1)
                            (buffer-face-mode)
                            (+zen/toggle)
                            ))


(add-hook 'prog-mode-hook 'my-buffer-face-mode-programming)
(add-hook 'prog-mode-hook (lambda ()
                            (setq captain-predicate (lambda () (nth 8 (syntax-ppss (point)))))
                            ))

(evil-snipe-override-mode 1)

(add-hook 'after-init-hook 'company-statistics-mode)


(add-hook 'occur-mode-hook
          (defun occur-show-replace-context+ ()
            (add-hook 'replace-update-post-hook
                      'occur-mode-display-occurrence nil 'local)))
(define-advice occur-mode-display-occurrence
    (:around (fun &rest args) save-match-data)
  (save-match-data
    (apply fun args)))


  (setq-default prescient-history-length 1000)

(add-hook 'bibtex-mode-hook 'my/fix-windows-bib-file)
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

;; (my-generic-ispell-company-complete-setup)

(defun my/dedicate-org-roam-buffer ()
  (interactive)
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


  (defun embark-act-with-completing-read (&optional arg)
    (interactive "P")
    (let* ((embark-prompter 'embark-completing-read-prompter)
           (act (propertize "Act" 'face 'highlight))
           (embark-indicator (lambda (_keymap targets) nil)))
      (embark-act arg)))


(setq org-odt-preferred-output-format "docx")
(defun my/make-small-frame () (interactive) (set-frame-size (selected-frame) 50 42))

(defun my/make-medium-frame () (interactive) (set-frame-size (selected-frame) 100 42))
(defun my/make-large-frame () (interactive) (set-frame-size (selected-frame) 150 42))
(add-to-list 'default-frame-alist '(height . 40))
(add-to-list 'default-frame-alist '(width . 50))

(setq org-id-link-to-org-use-id 'create-if-interactive)
(setq python-shell-prompt-detect-failure-warning nil)
(setq lsp-pylsp-plugins-flake8-max-line-length 90)
(custom-set-variables '(linum-format 'dynamic))
;; (toggle-frame-fullscreen)
(setq org-fold-core-style "overlays")


(setq flycheck-python-pycompile-executable "c:/Python310/python")

;;; On Windows, commands run by flycheck may have CRs (\r\n line endings).
;;; Strip them out before parsing.
(defun flycheck-parse-output (output checker buffer)
  "Parse OUTPUT from CHECKER in BUFFER.

OUTPUT is a string with the output from the checker symbol
CHECKER.  BUFFER is the buffer which was checked.

Return the errors parsed with the error patterns of CHECKER."
  (let ((sanitized-output (replace-regexp-in-string "\r" "" output))
        )
    (funcall (flycheck-checker-get checker 'error-parser) sanitized-output checker buffer)))

(setq lsp-typescript-npm "c:/Program Files/nodejs/npm")

(setq lsp-pyright-python-executable-cmd "c:/Python310/python")

(setq +zen-text-scale 1)

(setq +bidi-hebrew-font (font-spec :family "Heebo"))

(add-hook! (text-mode) :local (lambda ()
                            (add-hook! after-save-hook #'my/fix-hebrew-hyphen)

                            ))

;; (setq mouse-wheel-scroll-amount '(2 (1)))
(setq mouse-wheel-scroll-amount '(2 (hscroll)))

(my/dedicate-org-roam-buffer)

;;; Ibuffer and extras (dired-like buffer list manager)
  (setq ibuffer-expert t)
  (setq ibuffer-display-summary nil)
  (setq ibuffer-use-other-window nil)
  (setq ibuffer-show-empty-filter-groups nil)
  (setq ibuffer-movement-cycle nil)
  (setq ibuffer-default-sorting-mode 'filename/process)
  (setq ibuffer-use-header-line t)
  (setq ibuffer-default-shrink-to-minimum-size nil)
  (setq ibuffer-formats
        '((mark modified read-only locked " "
                (name 40 40 :left :elide)
                " "
                (size 9 -1 :right)
                " "
                (mode 16 16 :left :elide)
                " " filename-and-process)
          (mark " "
                (name 16 -1)
                " " filename)))
  (setq ibuffer-saved-filter-groups nil)
  (setq ibuffer-old-time 48)
  (add-hook 'ibuffer-mode-hook #'hl-line-mode)
  (define-key global-map (kbd "C-x C-b") #'ibuffer)
  (let ((map ibuffer-mode-map))
    (define-key map (kbd "* f") #'ibuffer-mark-by-file-name-regexp)
    (define-key map (kbd "* g") #'ibuffer-mark-by-content-regexp) ; "g" is for "grep"
    (define-key map (kbd "* n") #'ibuffer-mark-by-name-regexp)
    (define-key map (kbd "s n") #'ibuffer-do-sort-by-alphabetic)  ; "sort name" mnemonic
    (define-key map (kbd "/ g") #'ibuffer-filter-by-content))

(add-hook 'dired-mode-hook 'dired-filter-mode)
(setq citar--multiple-setup (cons "<tab>"  "RET"))
