
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-digit-bound-motions '(evil-beginning-of-visual-line))
 '(helm-ag-base-command "rg --no-heading")
 '(helm-ag-success-exit-status '(0 2))
 '(linum-format (quote "%7d"))
 '(matlab-shell-command-switches '("-nodesktop -nosplash -nodisplay")))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

 '(default ((t (:inherit nil :extend nil :stipple nil  :weight regular :height 130 :width normal :foundry "GOOG" :family "NotoMono"))))
 ;; '(default ((t (:inherit nil :extend nil :stipple nil  :weight regular :height 180 :width normal :foundry "GOOG" :family "RobotoMono"))))
 '(line-number ((t (:inherit default :foreground "#6599bf" :weight normal :height 130 :width normal :foundry "GOOG" :family "RobotoMono"))))
 '(line-number-current-line ((t (:inherit (hl-line default) :foreground "#bbc2cf" :weight normal :height 130 :width normal :foundry "GOOG" :family "RobotoMono"))))
 '(org-default ((t (:inherit variable-pitch :weight Light :height 120 :family "NotoSans"))))
 '(org-document-title ((t (:inherit org-default :weight normal :family "NotoSans" :height 150 :underline nil))))
 '(org-level-1 ((t (:inherit org-default :weight semibold :family "NotoSans" :height 140))))
 '(org-level-2 ((t (:inherit org-default :weight semibold :family "NotoSans" :height 140))))
 '(org-level-3 ((t (:inherit org-default :weight normal :family "NotoSans" :height 145))))
 '(org-level-4 ((t (:inherit org-default :weight normal :family "NotoSans" :height 145))))
 '(org-level-5 ((t (:inherit org-default :weight normal :family "NotoSans" :height 145))))
 '(org-level-6 ((t (:inherit org-default :weight normal :family "NotoSans" :height 145))))
 '(org-level-7 ((t (:inherit org-default :weight normal :family "NotoSans" :height 145))))
 '(org-level-8 ((t (:inherit org-default :weight normal :family "NotoSans" :height 145))))
 '(org-list-dt ((t (:foreground "#4078f2" :weight normal :height 130))))
 ;; '(org-drawer ((t (:foreground "#84888b" :weight normal :height 130))))
 ;; '(org-special-keyword ((t (:foreground "#84888b" :weight normal :height 130))))
 '(org-roam-link ((t (:inherit org-default :foreground "#e8c24f" :strike-through nil :underline nil :slant normal :weight normal :width normal :foundry "ADBO" @variable-tuple))))
 '(org-roam-link-current ((t (:inherit org-default :foreground "#e8c24f" :strike-through nil :underline nil :slant normal :weight normal :width normal :foundry "ADBO" @variable-tuple))))
 '(term-bold ((t (:weight bold :height 1.0 :foundry "GOOG" :family "Noto Sans")))))
