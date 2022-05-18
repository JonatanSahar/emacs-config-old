(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-digit-bound-motions '(evil-beginning-of-visual-line))
 '(helm-ag-base-command "rg --no-heading")
 '(helm-ag-success-exit-status '(0 2))
 '(matlab-shell-command-switches '("-nodesktop -nosplash -nodisplay")))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#fafafa" :foreground "#383a42" :weight regular :height 180 :width normal :foundry "GOOG" :family "RobotoMono"))))
 '(line-number ((t (:inherit default :foreground "#6599bf" :weight normal :height 170 :width normal :foundry "GOOG" :family "RobotoMono"))))
 '(line-number-current-line ((t (:inherit (hl-line default) :foreground "#bbc2cf" :weight normal :height 170 :width normal :foundry "GOOG" :family "RobotoMono"))))
 '(org-default ((t (:inherit variable-pitch :weight Light :height 1.0 :family "NotoSans"))))
 '(org-document-title ((t (:inherit default :weight normal :family "NotoSans" :height 1.0 :underline nil))))
 '(org-level-1 ((t (:inherit default :weight semibold :family "NotoSans" :height 0.93))))
 '(org-level-2 ((t (:inherit default :weight semibold :family "NotoSans" :height 0.93))))
 '(org-level-3 ((t (:inherit default :weight normal :family "NotoSans" :height 0.95))))
 '(org-level-4 ((t (:inherit default :weight normal :family "NotoSans" :height 0.95))))
 '(org-level-5 ((t (:inherit default :weight normal :family "NotoSans" :height 0.95))))
 '(org-level-6 ((t (:inherit default :weight normal :family "NotoSans" :height 0.95))))
 '(org-level-7 ((t (:inherit default :weight normal :family "NotoSans" :height 0.95))))
 '(org-level-8 ((t (:inherit default :weight normal :family "NotoSans" :height 0.95))))
 '(org-list-dt ((t (:foreground "#4078f2" :weight normal :height 1.0))))
 '(org-roam-link ((t (:inherit default :foreground "#e8c24f" :strike-through nil :underline nil :slant normal :weight normal :width normal :foundry "ADBO" @variable-tuple))))
 '(org-roam-link-current ((t (:inherit default :foreground "#e8c24f" :strike-through nil :underline nil :slant normal :weight normal :width normal :foundry "ADBO" @variable-tuple))))
 '(term-bold ((t (:weight bold :height 1.0 :foundry "GOOG" :family "Noto Sans")))))
