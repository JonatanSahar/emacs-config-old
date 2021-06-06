;;; ~/.doom.d/keybindings.el -*- lexical-binding: t; -*-

(map! :map org-mode-map :nv "j" nil)
(map!
    :nv "E" nil
    :nv "W" nil
    :n "gk" nil
    :n "zj" nil
    :n "zz" nil
    :n "zh" nil
    :n "zj" nil
    :n "zk" nil
    :n "zl" nil
    :n "z=" nil
    :n "gs" nil
    :n "gf" nil
    :vn "S" nil
    :nvi "C-h" nil
    :nvi "C-j" nil
    :nvi "C-k" nil
    :nvi "C-l" nil

    :map org-mode-map
    :nv "E" nil
    :nv "W" nil
    :n "gz" nil
    :n "gh" nil
    :n "gj" nil
    :n "gk" nil
    :n "gl" nil
    :n "gJ" nil
    :n "gK" nil
    :n "z=" nil

    :n "gf" nil
    :n "gs" nil
    :n "zh" nil
    :n "zj" nil
    :n "zk" nil
    :n "zl" nil
    :n "zl" nil

    :nvi "C-i" nil
    :nvi "C-h" nil
    :nvi "C-j" nil
    :nvi "C-k" nil
    :nvi "C-l" nil

    :map evil-org-mode-map
    :nvi [C-o] nil
    :nvi [C-i] nil
    :nvi "C-S-L" nil

    :map helm-find-files-map
 [control-backspace] nil
    )

(map!
 :nvi "C-h" nil
 :nvi "C-j" nil
 :nvi "C-k" nil
 :nvi "C-l" nil
 :nvi "C-L" nil
 )

(map!
 (:map evil-visual-state-map
         :nv
        "j" nil
        "k" nil
        "'" nil
        "`" nil)
        (:map evil-normal-state-map
         :nv
        "j" nil
        "k" nil
        "'" nil
        "`" nil)
        (:map evil-org-mode-map
        :nv
        "j" nil
        "k" nil
        "'" nil
        "`" nil)
        )

(map! :map ivy-minibuffer-map
      "ESC" 'minibuffer-keyboard-quit
      "C-j" 'ivy-next-line
      "C-k" 'ivy-previous-line)

(map!
 :map pdf-view-mode-map
 :vin "gl" nil)

(map! :map matlab-mode-map
 :nv "C-S-m" (lambda ()
         (interactive)
         (org-switch-to-buffer-other-window "*MATLAB*")
         )
)

(map!
 :nvi "C-\\" #'toggle-input-method
 :nvi "C-s" (lambda ()
         (interactive)
         (evil-normal-state)
         (save-buffer)
         )
 :i "S-SPC" #'evil-force-normal-state
 :map evil-org-mode-map
 :i "C-S-l" #'org-roam-insert
 :i "C-{" #'org-roam-insert)
 ;; :i "C-S-L" #'org-ref-insert-link)

(map!
 :map helm-map
 "C-j" #'helm-next-line
 "C-k" #'helm-previous-line
 [control-backspace] #'backward-kill-word
 "ESC" #'helm-exit-minibuffer
 :map helm-find-files-map
 [control-backspace] #'backward-kill-word
 )


(map!
 :map ivy-mode-map
 "ESC" #'minibuffer-keyboard-quit)

(map! :map evil-org-mode-map :localleader :n
      "E" #'my/export-org-to-docx
      "n" #'org-narrow-to-subtree
      "N" #'widen
      )

(map! :nvi
      [C-o] #'better-jumper-jump-backward
      [C-i] #'better-jumper-jump-forward

      :map org-mode-map
      :nvi
      [C-o] #'better-jumper-jump-backward
      [C-i] #'better-jumper-jump-forward

      :map evil-org-mode-map
      :nvi
      [C-o] #'better-jumper-jump-backward
      [C-i] #'better-jumper-jump-forward
      )

(map! :map org-roam-backlinks-mode-map "return" #'org-open-at-point)
(map! :map pdf-view-mode-map
      :nvi "gl" nil
      :nvi "k" (lambda ()
         (interactive)
         (evil-collection-pdf-view-previous-line-or-previous-page  10))
      :nvi "j" (lambda ()
         (interactive)
         (evil-collection-pdf-view-next-line-or-next-page 10))
      :nvi "h" (lambda ()
         (interactive)
         (image-backward-hscroll 20))
      :nvi "l" (lambda ()
         (interactive)
         (image-forward-hscroll 20))
      :nvi "i" #'org-noter-insert-precise-note
      :nvi "I" #'org-noter-insert-note)

(map! :leader
      :nv
      "bb" nil
      "fc" nil)


(map! :map evil-motion-state-map :nv "j" #'evil-next-visual-line)

(map! :leader
      :nv
      :desc "copy buffer name"  "fc" #'my/get-buffer-name
      :desc "helm-bibtex"  "nb" #'helm-bibtex
      :desc "Org Noter"  "nN" #'org-noter
      (:when (featurep! :completion helm)
        :desc "M-x" :n "SPC" #'helm-M-x))


(map!
 :n "gO" #'+evil/insert-newline-above
 :n "go" #'+evil/insert-newline-below
 :n "gK" #'+evil/insert-newline-above
 :n "gJ" #'+evil/insert-newline-below

 :n "g[" #'org-roam-insert
 :n "g]" #'kmacro-end-and-call-macro
 :n "g." #'er/expand-region


 ;; :n "gh" #'windmove-left
 ;; :n "gj" #'windmove-down
 ;; :n "gk" #'windmove-up
 ;; :n "gl" #'windmove-right

 :nv "gj" #'avy-goto-char-timer
 ;; :n "gh" #'
 ;; :n "gk" #'
 ;; :n "gl" #'

 :n "g+" #'evil-numbers/inc-at-pt
 :vn "gs" #'evil-snipe-S
 :nv "gf" #'evil-repeat
 :nv "E" #'evil-end-of-line-or-visual-line
 :nv "W" #'evil-beginning-of-visual-line
 :nvi "C-l" #'windmove-right
 :nvi "C-S-l" #'org-roam-insert
 :nvi "C-h" #'windmove-left
 :nvi "C-j" #'windmove-down
 :nvi "C-k" #'windmove-up

 :map vterm-mode-map
 :nv "p" #'term-paste

 ;; :map dired-mode-map
 ;; :nv "YY" #'(lambda ()
 ;;              (interactive)
 ;;              (dired-copy-filename-as-kill 0))

 :map org-mode-map
 :nv "E" #'evil-org-end-of-line
 :nv "W" #'evil-org-beginning-of-line

 :vn "zh" #'org-up-element
 :vn "zj" #'org-forward-heading-same-level
 :vn "zk" #'org-backward-heading-same-level
 :vn "zl" #'org-next-visible-heading

 :n "z=" #'helm-flyspell-correct
 :n "g=" #'helm-flyspell-correct

 :nv "gf" #'evil-repeat
 :nvi "C-S-l" #'org-roam-insert
 :nvi "C-l" #'windmove-right
 :nvi "C-h" #'windmove-left
 :nvi "C-j" #'windmove-down
 :nvi "C-k" #'windmove-up
 )

;; (map!
;;  :map org-mode-map
;;  :prefix "gf"
;;  :vn "h" #'org-up-element
;;  :vn "j" #'org-forward-heading-same-level
;;  :vn "k" #'org-backward-heading-same-level
;;  :vn "l" #'org-next-visible-heading
;;        )

(map! :prefix "zz"
      :map org-mode-map
      :nv "n" #'anki-editor-cloze-region-auto-incr
      :nv "N" #'anki-editor-cloze-region-dont-incr
      :nv "c" #'anki-editor-cloze-word-under-cursor-auto-incr
      :nv "l" #'evil-next-flyspell-error
      :nv "Z" (lambda ()
         (interactive)
         (call-interactively #'evil-next-flyspell-error)
         (call-interactively #'helm-flyspell-correct)
         )
      :nv "z" (lambda ()
         (interactive)
         (call-interactively #'evil-prev-flyspell-error)
         (call-interactively #'helm-flyspell-correct)
         )
       )

(map! :leader
  :nv
  "sp" #'counsel-rg
  "sd" #'counsel-rg
  "ss" #'swiper
  :desc "equate window sizes" "we" #'balance-windows
  :desc "minimize window" "wmm" #'minimize-window
  :desc "minimize window" "wO" #'minimize-window
  :desc "maximize window" "wmM" #'doom/window-maximize-buffer
  :desc "switch to buffer" "bb" #'helm-mini
  :desc "add line above" "ik" #'+evil/insert-newline-above
  :desc "add line below" "ij" #'+evil/insert-newline-below)

(map! :map org-mode-map :localleader
  ("x" (lambda ()
         (interactive)
         (evil-org-beginning-of-line)
         (evil-visual-char)
         (end-of-line))))

(map! :localleader
      (:map matlab-mode-map
       :n "f" #'matlab-shell-help-at-point))

(map! :leader
        (:prefix ("j" . "navigation")
        :desc "avy timer" "j" 'avy-goto-char-timer
        :desc "avy line" "l" 'avy-goto-line)

        ;; (:prefix ("y" . "yank")
        ;;  :desc "header content" "y" #'my/visual-inside-org-header)

        (:prefix ("k" . "my commands")
        :desc "select header content" "y" #'my/visual-inside-org-header
        :desc "copy header content" "h" #'my/yank-org-headline
        :desc "kill all other windows" "o" 'delete-other-windows
        :desc "kill buffer and window" "w" '+workspace/close-window-or-workspace
        :desc "kill buffer" "d" 'kill-current-buffer
        :desc "switch to previous buffer" "k" 'evil-switch-to-windows-last-buffer
        :desc "search and replace vim style" "s" #'(lambda () (interactive) (evil-ex "%s/"))
        :desc "search and replace vim style - in region" "S" #'my/search-replace-in-region
        :desc "refile subtree" "r" 'org-refile
        :desc "paste from kill-ring" "p" 'helm-show-kill-ring
        :desc "helm org rifle" "R" 'helm-org-rifle
        :desc "run macro" "e" #'kmacro-end-and-call-macro
        :desc "generate laTex previews" "l" #'org-latex-preview
                (:prefix ("b" . "references")
                :desc "crossref search for refernce" "r" 'doi-utils-add-entry-from-crossref-query
                :desc "add refernce from doi" "d" 'doi-utils-add-bibtex-entry-from-doi)
                )
        )

(setq
      avy-style 'at-full
      avy-all-windows 't
      avy-single-candidate-jump 't)

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

(map! :leader "w." 'hydra-window-resize/body)

(define-key evil-normal-state-map (kbd "J") 'evil-join)
(define-key evil-normal-state-map (kbd "K") 'join-line)

(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "gj" #'evil-force-normal-state)
;; (key-chord-define evil-insert-state-map "df" #'evil-force-normal-state)
;; (key-chord-define evil-visual-state-map "df" #'evil-force-normal-state)
(key-chord-define evil-insert-state-map "jk" #'evil-force-normal-state)
(key-chord-define evil-visual-state-map "jk" #'evil-force-normal-state)
;; (key-chord-define evil-insert-state-map "kk" #'evil-execute-in-normal-state)
;; (key-chord-define evil-insert-state-map "fg" #'evil-execute-in-normal-state)

;; (key-chord-define org-mode-map "[[" #'org-roam-insert)

 "ESC" #'helm-exit-minibuffer
;; (key-chord-define ivy-minibuffer-map "jk" #'minibuffer-keyboard-quit)
(map! :map ivy-minibuffer-map :nvi "C-c k" #'minibuffer-keyboard-quit)
;; (key-chord-define-global  "zh" #'windmove-left)
;; (key-chord-define-global  "zl" #'windmove-right)
;;
;; (key-chord-define-global  "zk" #'windmove-up)
;; (key-chord-define-global  "zj" #'windmove-down)

(map!
 (:map evil-visual-state-map
         :nv
        "j" #'evil-next-visual-line
        "k" #'evil-previous-visual-line
        "'" #'evil-goto-mark
        "`" #'evil-goto-mark-line)
        (:map evil-normal-state-map
         :nv
        "j" #'evil-next-visual-line
        "k" #'evil-previous-visual-line
        "'" #'evil-goto-mark
        "`" #'evil-goto-mark-line)
        (:map evil-org-mode-map
        :nv
        "j" #'evil-next-visual-line
        "k" #'evil-previous-visual-line
        "'" #'evil-goto-mark
        "`" #'evil-goto-mark-line)
        )

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

(map!
   :nvi "C-c  c" #'org-capture
   :nvi "C-c  m" #'my/evil-mc-make-vertical-cursors
   :nvi "C-c  h" #'my/visual-inside-org-header
   :nvi "C-c  a" #'(lambda () (interactive) (org-capture nil "a"))
   :nvi "C-c  A" #'(lambda () (interactive) (org-capture nil "A"))
   :nvi "C-c  o" #'(lambda () (interactive) (org-agenda nil "o"))
 )

