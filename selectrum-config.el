;;; jnf-selectrum.el --- Summary -*- lexical-binding: t; -*-
;;;
;;; Commentary:
;;;
;;; Code:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package! selectrum
  :config
  (selectrum-mode +1)
  (map! :map selectrum-minibuffer-map
        "C-." #'embark-act
        "C-," #'embark-become
        "C-/" #'embark-export
        "C-a" #'my/embark-ace-action
        "C-b" #'embark-become
        "C-e" #'embark-export
        "C-j" #'selectrum-previous-candidate
        "C-j" #'selectrum-next-candidate)
  :bind ("C-x C-z" . selectrum-repeat))

(use-package! ripgrep
  :init (setq ripgrep-arguments "--ignore-case")
  )

(use-package! prescient)

(use-package! selectrum-prescient
  :after prescient
  :config ;; to make sorting and
           (selectrum-prescient-mode +1)
           ;; filtering more intelligent to save your command history
           ;; on disk, so the sorting gets more intelligent over time
           (prescient-persist-mode +1))


(use-package! savehist
  )

;; Enable richer annotations using the Marginalia package
(use-package! marginalia
  :after (selectrum)
  ;; Either bind `marginalia-cycle` globally or only in the minibuffer
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package! such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

;; Example configuration for Consult
;; https://github.com/minad/consult
(use-package! consult
  ;; Replace bindings. Lazily loaded due by `use-package!'.
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c b" . consult-bookmark)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complet-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("s-b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-s-b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-from-kill-ring)                ;; orig. yank-pop
         ("<help> a" . consult-apropos)            ;; orig. apropos-command
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("C-x C-SPC" . consult-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-project-imenu)
         ;; M-s bindings (search-map)
         ("M-s f" . consult-find)
         ("M-s L" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("C-c f" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s m" . consult-multi-occur)
         ("M-s k" . consult-to-ivy)
         ("s-r" . consult-recent-file)
         ("C-c o" . consult-file-externally)
         ("s-4" . consult-bookmark)
         ("C-y" . yank)
         ("C-s" . consult-line) ;; I've long favored Swiper mapped to c-s
         ("s-l" . consult-goto-line)
         ;; Isearch integration
         ("M-s e" . consult-isearch)
         ;; ("s-t" . jnf/consult-find-using-fd)
         ("s-3" . consult-imenu)
         ("s-#" . consult-project-imenu)
         :map isearch-mode-map
         ("M-e" . consult-isearch)                 ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch)               ;; orig. isearch-edit-string
         ("M-s l" . consult-line))                 ;; required by consult-line to detect isearch

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
  :config

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
  )


;; Optionally add the `consult-flycheck' command.
(use-package! consult-flycheck
  :bind (:map flycheck-command-map
              ("!" . consult-flycheck)))

;; https://github.com/oantolin/embark
(use-package! embark
  :hook (embark-pre-action . refresh-selectrum)
  :init
  (defun refresh-selectrum ()
    (setq selectrum--previous-input-string nil))
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
        (map! :map selectrum-minibuffer-map
        ("C-a" #'embark-act)       ;; pick some comfortable binding
        ("C-e" #'embark-export)
        ("C-b" #'embark-bindings)
        )
        (setq embark-action-indicator
        (lambda (map &optional _target)
                (which-key--show-keymap "Embark" map nil nil 'no-paging)
                #'which-key--hide-popup-ignore-command)
        embark-become-indicator embark-action-indicator)
        ;; Hide the mode line of the Embark live/completions buffers
        (add-to-list 'display-buffer-alist
                '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                        nil
                        (window-parameters (mode-line-format . none))))
        (defun pause-selectrum ()
        (when (eq embark-collect--kind :live)
        (with-selected-window (active-minibuffer-window)
                (shrink-window selectrum-num-candidates-displayed)
                (setq-local selectrum-num-candidates-displayed 0))))

        (add-hook 'embark-collect-mode-hook #'pause-selectrum)

        (defun embark-which-key-indicator ()
        "An embark indicator that displays keymaps using which-key.
        The which-key help message will show the type and value of the
        current target followed by an ellipsis if there are further
        targets."
        (lambda (&optional keymap targets prefix)
        (if (null keymap)
                (which-key--hide-popup-ignore-command)
        (which-key--show-keymap
        (if (eq (plist-get (car targets) :type) 'embark-become)
                "Become"
                (format "Act on %s '%s'%s"
                        (plist-get (car targets) :type)
                        (embark--truncate-target (plist-get (car targets) :target))
                        (if (cdr targets) "…" "")))
        (if prefix
                (pcase (lookup-key keymap prefix 'accept-default)
                ((and (pred keymapp) km) km)
                (_ (key-binding prefix 'accept-default)))
                keymap)
        nil nil t (lambda (binding)
                        (not (string-suffix-p "-argument" (cdr binding))))))))

        (setq embark-indicators
        '(embark-which-key-indicator
        embark-highlight-indicator
        embark-isearch-highlight-indicator))

        (defun embark-hide-which-key-indicator (fn &rest args)
        "Hide the which-key indicator immediately when using the completing-read prompter."
        (when-let ((win (get-buffer-window which-key--buffer
                                        'visible)))
        (quit-window 'kill-buffer win)
        (let ((embark-indicators (delq #'embark-which-key-indicator embark-indicators)))
        (apply fn args))))

        (advice-add #'embark-completing-read-prompter
                :around #'embark-hide-which-key-indicator)
  )


;; Consult users will also want the embark-consult package.
(use-package! embark-consult
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . embark-consult-preview-minor-mode))

;; Useful for editing grep results:
;;
;; 1) "C-c f" invoke `consult-ripgrep'
;; 2) "C-s-e" invoke `embark-export' (On OS X map that's Ctrl+Cmd+e)
;; 3) "e" or "C-c C-p" invoke `wgrep-change-to-wgrep-mode'
;; 4) Save or cancel
;;    a) Save: "C-x C-s" invoke `save-buffer' (or "C-c C-c")
;;    b) Cancel: "C-c C-k"
(use-package! wgrep
  :after (embark-consult ripgrep)
  :bind (:map wgrep-mode-map
              ;; Added keybinding to echo Magit behavior
              ("C-c C-c" . save-buffer)
         :map grep-mode-map
         ("e" . wgrep-change-to-wgrep-mode)
         :map ripgrep-search-mode-map
         ("e" . wgrep-change-to-wgrep-mode)))

;; https://github.com/gagbo/consult-lsp
;; (use-package! consult-lsp
;;   :after (consult lsp-mode)
;;   :commands consult-lsp-symbols)

;; https://github.com/minad/vertico
;;
;; See System Crafters - https://www.reddit.com/r/emacs/comments/neh3d7/streamline_your_emacs_completions_with_vertico/
;; Vertico and Jonathanctrum provide similar functions.  Favor jonathanctrum.
;; (use-package! vertico
;;   :custom (vertico-cycle t)
;;   :init (vertico-mode))

;; https://github.com/minad/orderless
;;
;; Useful for not requiring strict word order
(use-package! orderless
  :demand t
  :config
  ;; See
  ;; https://github.com/minad/consult/wiki#orderless-style-dispatchers-ensure-that-the--regexp-works-with-consult-buffer
  ;; for background of this function.
  ;;
  ;; Recognizes the following patterns:
  ;; * ~flex flex~
  ;; * =literal literal=
  ;; * `initialism initialism`
  ;; * !without-literal without-literal!
  ;; * .ext (file extension)
  ;; * regexp$ (regexp matching at end)
  (defun dm/orderless-dispatch (pattern _index _total)
    (cond
     ;; Ensure that $ works with Consult commands, which add disambiguation suffixes
     ((string-suffix-p "$" pattern) `(orderless-regexp . ,(concat (substring pattern 0 -1) "[\x100000-\x10FFFD]*$")))
     ;; File extensions
     ((string-match-p "\\`\\.." pattern) `(orderless-regexp . ,(concat "\\." (substring pattern 1) "[\x100000-\x10FFFD]*$")))
     ;; Ignore single !
     ((string= "!" pattern) `(orderless-literal . ""))
     ;; Without literal
     ((string-prefix-p "!" pattern) `(orderless-without-literal . ,(substring pattern 1)))
     ((string-suffix-p "!" pattern) `(orderless-without-literal . ,(substring pattern 0 -1)))
     ;; Initialism matching
     ((string-prefix-p "`" pattern) `(orderless-initialism . ,(substring pattern 1)))
     ((string-suffix-p "`" pattern) `(orderless-initialism . ,(substring pattern 0 -1)))
     ;; Literal matching
     ((string-prefix-p "=" pattern) `(orderless-literal . ,(substring pattern 1)))
     ((string-suffix-p "=" pattern) `(orderless-literal . ,(substring pattern 0 -1)))
     ;; Flex matching
     ((string-prefix-p "~" pattern) `(orderless-flex . ,(substring pattern 1)))
     ((string-suffix-p "~" pattern) `(orderless-flex . ,(substring pattern 0 -1)))))
  :custom
  (completion-styles '(orderless))
  (completion-category-defaults nil)
  (read-file-name-completion-ignore-case t)
  (completion-category-overrides '((file . (styles partial-completion))
    				   (minibuffer . (initials))))
  (orderless-style-dispatchers '(dm/orderless-dispatch)))

(defvar my/bibs '("/home/jonathan/google_drive/.bibliography/motor-cognition.bib"))

(use-package bibtex-actions
  :after (embark oc)
  :config
  (setq bibtex-actions-bibliography my/bibs
        org-cite-global-bibliography my/bibs
        org-cite-insert-processor 'oc-bibtex-actions
        org-cite-follow-processor 'oc-bibtex-actions
        org-cite-activate-processor 'oc-bibtex-actions)
  (setq bibtex-actions-at-point-function 'embark-act)
  (add-to-list 'embark-target-finders 'bibtex-actions-citation-key-at-point)
  (add-to-list 'embark-keymap-alist '(bib-reference . bibtex-actions-map))
  (add-to-list 'embark-keymap-alist '(citation-key . bibtex-actions-buffer-map))

  (setq bibtex-actions-file-note-org-include '(org-id org-roam-ref))
  ;; (setq bibtex-actions-file-open-note-function 'orb-bibtex-actions-edit-note)
;; use consult-completing-read for enhanced interface
  (setq bibtex-actions-templates '((main . "${author editor:30}     ${date year issued:4}     ${title:48}")
                                   (suffix . "${tags keywords keywords:*}   ${=key= id:15}    ${=type=:12}")
                                   (note . "#+title: Notes on ${author editor}, ${title}
* main points
* findings
* methods
* summary and short reference
* general notes
* see also (notes, tags/ other papers):
")))

  (setq bibtex-actions-symbols
        `((file . (,(all-the-icons-icon-for-file "foo.pdf" :face 'all-the-icons-dred) .
                ,(all-the-icons-icon-for-file "foo.pdf" :face 'bibtex-actions-icon-dim)))
        (note . (,(all-the-icons-icon-for-file "foo.txt") .
                ,(all-the-icons-icon-for-file "foo.txt" :face 'bibtex-actions-icon-dim)))
        (link .
              (,(all-the-icons-faicon "external-link-square" :v-adjust 0.02 :face 'all-the-icons-dpurple) .
         ,(all-the-icons-faicon "external-link-square" :v-adjust 0.02 :face 'bibtex-actions-icon-dim)))))
  ;; Here we define a face to dim non 'active' icons, but preserve alignment
  (defface bibtex-actions-icon-dim
    '((((background dark)) :foreground "#282c34")
      (((background light)) :foreground "#fafafa"))
    "Face for obscuring/dimming icons"
    :group 'all-the-icons-faces)

)

  ;; (load "~/.emacs.d/.local/straight/repos/bibtex-actions/oc-bibtex-actions.el")
(advice-add #'completing-read-multiple :override #'consult-completing-read-multiple)
(provide 'selectrum-config.el)
;;; jnf-selectrum.el ends here
