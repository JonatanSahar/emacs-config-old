;;; ~/.doom.d/keybindings.el -*- lexical-binding: t; -*-

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
    :i "C-S-L" nil)

(map!
 :nvi "C-h" nil
 :nvi "C-j" nil
 :nvi "C-k" nil
 :nvi "C-l" nil
 )

(map! :map ivy-minibuffer-map
      "C-j" 'ivy-next-line
      "C-k" 'ivy-previous-line)

(map!
 :map pdf-view-mode-map
 :vin "gl" nil)

(map!
 :nvi "C-\\" #'toggle-input-method
 :nvi "C-s" #'save-buffer
 :i "S-SPC" #'evil-force-normal-state
 :map evil-org-mode-map
 :i "C-l" #'org-roam-insert
 :i "C-S-L" #'org-ref-insert-link)

(map!
 :map helm-map
 "C-j" #'helm-next-line
 "C-k" #'helm-previous-line)


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
      :nvi "i" #'org-noter-insert-precise-note
      :nvi "I" #'org-noter-insert-note)

(map! :leader
      :nv
      :desc "B" "bb" nil
      :desc "helm-bibtex"  "nb" #'helm-bibtex
      :desc "Org Noter"  "nN" #'org-noter
      (:when (featurep! :completion helm)
        :desc "M-x" :n "SPC" #'helm-M-x))

(map!
 :n "gO" #'+evil/insert-newline-above
 :n "go" #'+evil/insert-newline-below
 :n "gK" #'+evil/insert-newline-above
 :n "gJ" #'+evil/insert-newline-below

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

 :nv "E" #'evil-end-of-line-or-visual-line
 :nv "W" #'evil-beginning-of-visual-line

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

 :n "gf" #'evil-repeat
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
      :nv "l" #'evil-next-flyspell-error
      :nv "Z" #'evil-next-flyspell-error
      :nv "z" #'evil-prev-flyspell-error
      :nv "c" #'anki-editor-cloze-region-auto-incr
       )

(map! :leader
  :nv
  "sp" #'counsel-ag
  "sd" #'counsel-ag
  "ss" #'swiper
  :desc "switch to buffer" "bb" #'helm-mini
  :desc "add line above" "ik" #'+evil/insert-newline-above
  :desc "add line below" "ij" #'+evil/insert-newline-below)

(map! :map org-mode-map :localleader
  ("x" (lambda ()
         (interactive)
         (evil-org-beginning-of-line)
         (evil-visual-char)
         (end-of-line))))

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

      (:prefix ("y" . "yank")
       :desc "header content" "h" #'(lambda ()
                                      (interactive)
                                      (evil-middle-of-visual-line)
                                      (evil-org-beginning-of-line)
                                      (evil-visual-char)
                                      (end-of-line)))

      (:prefix ("k" . "my commands")
       :desc "kill all other windows" "o" 'delete-other-windows
       :desc "kill buffer and window" "w" '+workspace/close-window-or-workspace
       :desc "kill buffer and window" "d" 'kill-current-buffer
       :desc "switch to previous buffer" "k" 'evil-switch-to-windows-last-buffer
       :desc "search and replace vim style" "s" #'(lambda ()
                                                    (interactive)
                                                    (evil-ex "%s/")
                                                    )
       :desc "save current buffer" "S" 'save-buffer
       :desc "refile subtree" "r" 'org-refile
       :desc "helm org rifle" "r" 'helm-org-rifle
       :desc "run macro" "e" #'kmacro-end-and-call-macro


       (:prefix ("b" . "references")
        :desc "crossref search for refernce" "r" 'doi-utils-add-entry-from-crossref-query
        :desc "add refernce from doi" "d" 'doi-utils-add-bibtex-entry-from-doi
        )))

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

(map! :leader "w." 'hydra-window/body)

(define-key evil-normal-state-map (kbd "J") 'evil-join)
(define-key evil-normal-state-map (kbd "K") 'join-line)

(setq key-chord-two-keys-delay 0.1)
(key-chord-define evil-insert-state-map "jk" #'evil-force-normal-state)
(key-chord-define evil-visual-state-map "jk" #'evil-force-normal-state)
(key-chord-define evil-insert-state-map "kk" #'evil-execute-in-normal-state)

;; (key-chord-define-global  "zh" #'windmove-left)
;; (key-chord-define-global  "zl" #'windmove-right)
;;
;; (key-chord-define-global  "zk" #'windmove-up)
;; (key-chord-define-global  "zj" #'windmove-down)

(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
(define-key evil-normal-state-map (kbd "'") 'evil-goto-mark)
(define-key evil-normal-state-map (kbd "`") 'evil-goto-mark-line)

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
