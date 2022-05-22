;;; ~/.doom.d/keybindings.el -*- lexical-binding: t; -*-

(map!
    :nvi "C-SPC" nil
    :i "C-z" nil
    :i  "C-k" nil
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
    :nvi "C-s-b" nil
    :nvi "C-s-a" nil
    :nvi "C-s-e" nil
    :nvi "M-q" nil
    :nvi "C-c p" nil
    :nvi "M-l" nil
    :nvi "C-v" nil
    :v "C-c" nil
    :nvi "C-M i" nil

    (:map org-mode-map
    :nv "j" nil
    :nv "E" nil
    :nv "W" nil
    :n "zc" nil
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

    :v "C-c" nil
    :nvi "C-v" nil
    :nvi "M-l" nil
    :nvi "C-c p" nil
    :nvi "C-M i" nil
    :nvi "C-i" nil
    :nvi "C-h" nil
    :nvi "C-j" nil
    :nvi "C-k" nil
    :nvi "C-l" nil)
    (:map org-roam-preview-map :desc "universal argument" "C-u" nil)
    (:map org-roam-mode-map :desc "universal argument" "C-u" nil)

    (:map evil-org-mode-map
    :nvi [C-o] nil
    :nvi [C-i] nil
    :nvi "C-S-L" nil)

    (:map helm-find-files-map
     [control-backspace] nil)

   :i "C-v" nil) ;;unmap a bunch of keys

(map! :map (evil-org-mode-map emacs-lisp-mode-map prog-mode-map text-mode-map org-mode-map)
  :ni "M-`" #'delete-other-windows
  :i "C-z" #'evil-undo
  :i "C-Z" #'evil-emacs-state
  :n "<down>" (lambda nil (interactive) (scroll-up-command 1))
  :n "<up>"   (lambda nil (interactive) (scroll-down-command 1))
  :i "C-S-j" (lambda nil (interactive) (scroll-up-command 1))
  :i "C-S-k" (lambda nil (interactive) (scroll-down-command 1))
  :n "k" #'evil-previous-visual-line
  :n "j" #'evil-next-visual-line
  ;; :n "j" (lambda nil (interactive) (scroll-up-command 1))
  ;; :n "k" (lambda nil (interactive) (scroll-down-command 1))
  :i "C-c S" #'company-ispell
  :ni "C-c =" #'helm-flyspell-correct
  :nv "C-e" #'evil-end-of-line-or-visual-line
  :i "M-h" #'org-beginning-of-line
  :i "M-l" #'org-end-of-line
  :i "C-S-k" #'previous-line
  :i "C-S-j" #'next-line
  :i "C-S-l" #'right-char
  :i "C-S-h" #'left-char
  :i "C-'" #'right-char
  :i "C-;" #'left-char
  :i "C-k" #'evil-previous-visual-line
  :i "C-j" #'evil-next-visual-line
  :i "C-l" #'right-word
  :i "C-h" #'left-word
  :nvi "C-z" #'evil-undo
  :nvi "C-y" #'evil-redo
  )

 (map!
 :nvi "M-q" #'+workspace/other
 :ni "C-{" #'org-roam-node-insert
 :ni "C-}" #'org-ref-insert-link)

(defun my/save-and-change-to-normal ()
         (interactive)
         (evil-normal-state)
         (save-buffer)
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
 ;; :i "C-SPC" #'consult-company
 :ni "C-{" #'org-roam-node-insert)
;; :i "C-S-L" #'org-ref-insert-link)

(map!
 :map pdf-view-mode-map
 :nvi "go" nil)
(map!
 :map pdf-view-mode-map
 :nvi "C-c O" (lambda () (interactive) (dired-jump) (dired-open))
 :nvi "go" (kbd "SPC o - & RET")
 :vin "gl" nil
 :map company-active-map "C-s" #'my/save-and-change-to-normal
 )

(map!
 (:map matlab-mode-map
 :nv "C-S-m" (lambda ()
         (interactive)
         (org-switch-to-buffer-other-window "*MATLAB*"))
  :ni "C-c h" #'matlab-shell-help-at-point
 )
 (:map matlab-shell-mode-map
  :ni "C-c l" #'comint-clear-buffer
  :nv "C-l" #'windmove-right
  :nv "C-h" #'windmove-left
  :nv "C-j" #'windmove-down
  :nv "C-k" #'windmove-up
  )
)


(map!
 :map helm-map
 "C-j" #'helm-next-line
 "C-k" #'helm-previous-line
 [control-backspace] #'backward-kill-word
 "ESC" #'helm-exit-minibuffer
 :map helm-find-files-map
 [control-backspace] #'backward-kill-word
 )


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
         (pdf-view-scroll-down-or-previous-page  10))
      :nvi "j" (lambda ()
         (interactive)
         (pdf-view-scroll-up-or-next-page 10))
      ;; :nvi "j" #'pdf-view-scroll-up-or-next-page
      ;; :nvi "k" #'pdf-view-scroll-down-or-previous-page

      :nvi "h" (lambda ()
         (interactive)
         (image-backward-hscroll 25))
      :nvi "l" (lambda ()
         (interactive)
         (image-forward-hscroll 25))
      :nvi "i" #'org-noter-insert-precise-note
      :nvi "I" #'org-noter-insert-note)

(map! :leader
      :nv
      "bb" nil
      "is" nil
      "ir" nil
      "fc" nil)

(map! :leader
      :nv
      "ir" #'org-ref-insert-link
)

;; (map! :map evil-motion-state-map :nv "j" #'evil-next-visual-line)

(map! :leader
      :nv
      :desc "copy buffer name"  "fc" #'my/get-buffer-name
      :desc "helm-bibtex"  "nB" #'helm-bibtex
      :desc "citar references"  "nb" #'citar-open
      :desc "rebuild orgNv database"  "nr" #'(lambda () (interactive) (setq orgnv--database (orgnv-build-database)))
      :desc "Org Noter"  "nN" #'org-noter
      "M-x" :n "SPC" #'execute-extended-command)


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
 :nvi "C-S-l" #'org-roam-insert
 :nv "C-l" #'windmove-right
 :nv "C-h" #'windmove-left
 :nv "C-j" #'windmove-down
 :nv "C-k" #'windmove-up
 ;; :nvi "C-c l" #'toggle-input-method
 :nvi "M-;" #'toggle-input-method

 :map vterm-mode-map
 :nv "p" #'term-paste
 :nvi "C-c p" #'term-paste
 :nvi "C-c v" #'term-paste
 :nvi "C-c c" #'evil-yank
 :n "!" #'+workspace/close-window-or-workspace
 :map dired-mode-map
 :nv "g\/g" #'dired-filter-mode
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
 :ni "]]" #'org-roam-node-insert
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
      :nv "0" #'anki-editor-reset-cloze-number
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
  :desc "search project/dir" "sp" #'consult-ripgrep
  :desc "search project/dir" "sd" #'consult-ripgrep
  :desc "search buffer"  "ss" #'consult-line
  :desc "equate window sizes" "we" #'balance-windows
  :desc "minimize window" "wmm" #'minimize-window
  :desc "minimize window" "wO" #'minimize-window
  :desc "maximize window" "wmM" #'doom/window-maximize-buffer
  :desc "switch to buffer" "bb" #'consult-buffer
  :desc "buffer to new window" "bB" #'consult-buffer-other-window)

(map! :map org-mode-map :localleader
  ("x" (lambda ()
         (interactive)
         (evil-org-beginning-of-line)
         (evil-visual-char)
         (end-of-line))))

(map! :localleader
      (:map matlab-shell-mode-map
       :n "~" #'+workspace/close-window-or-workspace
       :n "ESC" #'+workspace/close-window-or-workspace)

      (:map python-mode-map
       :desc "eval buffer" :n "eb" #'python-shell-send-buffer
       :desc "eval file" :n "ef" #'python-shell-send-file
       :desc "eval function" :n "ed" #'python-shell-send-defun
       :desc "eval region" :n "er" #'python-shell-send-region)
      (:map matlab-mode-map
       :desc "eval buffer" :n "eb" #'(lambda () (interactive) (evil-goto-first-line) (evil-visual-line) (evil-goto-line) (matlab-shell-run-region))
       :desc "eval line" :n "el" #'(lambda () (interactive) (evil-visual-line) (matlab-shell-run-region))
       :desc "eval region" :n "er" #'matlab-shell-run-region
       :n "f" #'matlab-shell-help-at-point
       :n "s" #'matlab-shell
       ))

(map! :leader
        (:prefix ("j" . "navigation")
        :desc "avy timer" "j" 'evil-avy-goto-char-timer
        :desc "avy line" "l" 'evil-avy-goto-line)

        ;; (:line ("yank" . "y")
        ;;  :desc "header content" "y" #'my/visual-inside-org-header)

        (:prefix ("b")
               :desc "reload buffer" "r" #'my/revert-buffer-no-confirm
               :desc "revert buffer" "R" #'revert-buffer
          )
        (:prefix ("i" . "insert stuff")
                :desc "make evil-mc-cursor here" "c" #'my/make-cursor-here
                :desc "add line above" "k" #'+evil/insert-newline-above
                :desc "add line below" "j" #'+evil/insert-newline-below
                 ;; :desc "surround object with bold"  "sb" (kbd "jkysio*"))
                (:prefix ("a" . "anki cloze")
                     :map org-mode-map
                     :nv "0" #'anki-editor-reset-cloze-number
                     :nv "C" #'anki-editor-cloze-region-auto-incr
                     :nv "c" #'anki-editor-cloze-region-dont-incr
                     :nv "w" #'anki-editor-cloze-word-under-cursor-auto-incr
                 )
                (:prefix ("l" . "latex symbols")
                  :desc "right double arrow"  "r" (kbd "$\\Rightarrow$"))
                (:prefix ("s" . "surround stuff")
                 :desc "surround object with bold"  "*" (kbd "jkysio*")
                 :desc "surround object with quotes"  "\"" (kbd "jkysio\"")
                 :desc "surround object with single quotes"  "\'" (kbd "jkysio\'")
                 :desc "surround object with parens" "\)" (kbd "jkysio\)")
                 :desc "surround object with brackets" "\]" (kbd "jkysio\]")
                ))

        (:prefix ("k" . "my commands")
        :desc "embark act" "a" #'embark-act
        :desc "select header content" "y" #'my/visual-inside-org-header
        :desc "copy header content" "h" #'my/yank-org-headline
        :desc "orgnv" "g" #'orgnv-browse
        :desc "orgnv + rebuild DB" "G" #'(lambda () (interactive) (my/orgnv-update-db) (orgnv-browse))
        :desc "kill all other windows" "o" 'delete-other-windows
        :desc "resize window to small" "f" 'my/make-small-frame
        :desc "make new frame" "F" 'make-frame-command
        :desc "writeroom mode" "w" #'writeroom-mode
        :desc "kill buffer and window" "W" '+workspace/close-window-or-workspace
        :desc "kill buffer" "d" 'kill-current-buffer
        :desc "switch to previous buffer" "k" 'evil-switch-to-windows-last-buffer
        :desc "search and replace vim style" "s" #'(lambda () (interactive) (evil-ex "%s/"))
        :desc "search and replace vim style - in region" "S" #'my/search-replace-in-region
        :desc "refile subtree" "R" 'org-refile
        :desc "paste from kill-ring" "p" 'consult-yank-from-kill-ring
        ;; :desc "paste from kill-ring" "p" 'helm-show-kill-ring
        ;; :desc "helm org rifle" "R" 'helm-org-rifle
        :desc "run macro" "e" #'kmacro-end-and-call-macro
        :desc "generate laTex previews" "L" #'org-latex-preview
        (:prefix ("r" . "rectangle operations")
         "r" #'replace-rectangle
         :desc "paste rectangle" "p" #'yank-rectangle
         :desc "copy rectangle" "y"  #'copy-rectangle-as-kill
         :desc "cut rectangle" "x"  #'kill-rectangle
         :desc "push rectangle right" "r"  #'open-rectangle
         :desc "delete rectangle" "d"  #'clear-rectangle
         )
         (:prefix ("b" . "references")

                :desc "refresh bibliography" "r" #'citar-refresh
                :desc "open bibliography" "b" #'citar-open
                )
                ;; (:prefix ("i" . "insert stuff")
                ;;         (:prefix ("l" . "latex symbols")
                ;;          :desc "right double arrow"  "R" (kbd "$\\Rightarrow$")))
        ))

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

(map! :map org-mode-map
   :nvi "C-c  C-y" #'evil-yank
   :nvi "C-c  C-x" #'evil-delete
   :nvi "C-c  C-d" #'evil-delete
   :nvi "C-c  c" #'evil-yank
   :nvi "C-c  y" #'evil-yank
   :nvi "C-c  v" #'consult-yank-from-kill-ring
   :nvi "C-c  p" #'evil-paste-after
   :i "C-M i" #'completion-at-point
   ;; :i "C-SPC" #'completion-at-point
   :n "zc" #'+org/toggle-fold
   :n "zC" #'+org/close-fold
   )
(map!
   :nvi "C-;" #'embark-act
   :nvi "C-c  c" #'evil-yank
   :nvi "C-c  v" #'consult-yank-from-kill-ring
   ;; :nv "C-v" #'evil-paste-after
   :i "C-v" #'evil-paste-before
   :nvi "C-c  y" #'evil-yank
   :nvi "C-c  p" #'evil-paste-after
   :nvi "C-c  P" #'evil-paste-before
   :nvi "M-p" #'evil-paste-pop
   :nvi "C-c  C-r" #'evil-redo
   :nvi "C-c  C-d" #'evil-delete
   :nvi "C-c  x" #'evil-delete
   :nvi "C-x  x" #'evil-delete


   ;; :nvi "C-c  c" #'org-capture
   :nvi "C-c  m" #'my/evil-mc-make-vertical-cursors
   :nvi "C-c  H" #'my/visual-inside-org-header
   :nvi "C-c  h" #'org-toggle-heading
   :nvi "C-c  i" #'org-toggle-item
   ;; :nvi "C-c  i" #'(lambda () (interactive) ((org-toggle-item) (org-end-of-line)))
   :nvi "C-c  a" #'(lambda () (interactive) (org-capture nil "a"))
   :nvi "C-c  A" #'(lambda () (interactive) (org-capture nil "A"))
   :nvi "C-c  o" #'(lambda () (interactive) (org-agenda nil "o"))
   ;; :i "C-c p" #'consult-yank-from-kill-ring
   ;; :i "C-c y" #'evil-yank
   :ni "C-c I" #'org-cite-insert
   ;; :ni "C-c I" #'org-ref-insert-cite-link
   :ni "C-c ]" #'org-roam-node-insert
   ;; :ni "C-c I" #'org-cite-insert

   :n "C-S-j" #'evil-mc-make-cursor-move-next-line
   :n "C-S-k" #'evil-mc-make-cursor-move-prev-line
   :nvi "M-j" #'drag-stuff-down
   :nvi "M-k" #'drag-stuff-up
 )

  (map! :map vertico-map
        "C-." #'embark-act
        "C-," #'embark-become
        "C-/" #'embark-export
        "C-a" #'embark-act
        "C-b" #'embark-become
        "C-e" #'embark-export
        "C-j" #'vertico-previous
        "C-j" #'vertico-next)

;; (map! :map org-mode-map
;;       :nvi "C-c p h" 'org-hide-properties
;;       :nvi "C-c p s" 'org-show-properties
;;       :nvi "C-c p t" 'org-toggle-properties)

(setq scroll-preserve-screen-position 1)

(defun make-bold()
(interactive)
(if (use-region-p) (evil-surround-region (region-beginning) (region-end) t *)))

(map!
 (:when (featurep! :editor multiple-cursors)
  :prefix "g"
  :nv "z" #'my/mc-hydra/body))

(map!
      "C-n" nil
      "C-p" nil
      "C-SPC" nil)

(map! :map corfu-map
      ;; "M-d" #'corfu-show-documentation
      ;; "M-l" #'corfu-show-location
      "C-n"  #'corfu-next
      "C-p"  #'corfu-previous
      "C-j"  #'corfu-next
      "C-k"  #'corfu-previous
      ;; "TAB"  #'corfu-next
      ;; "S-TAB"  #'corfu-previous
      "C-SPC"  #'completion-at-point
      "ESC"  #'corfu-quit
      "#"  #'corfu-insert-separator)
      ;; "C-SPC"  #'corfu-insert-separator)

(map! :i "C-SPC" #'completion-at-point)
(map! :map org-mode-map :in "C-c u" #'org-previous-visible-heading)
(map! :map org-mode-map :in "C-c U" #'outline-up-heading)
