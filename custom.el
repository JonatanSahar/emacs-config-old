(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-digit-bound-motions '(evil-beginning-of-visual-line))
 '(helm-ag-base-command "rg --no-heading")
 '(helm-ag-success-exit-status '(0 2))
 '(linum-format 'dynamic)
 '(matlab-shell-command-switches '("-nodesktop -nosplash -nodisplay"))
 '(package-selected-packages '(emacsql-sqlite3 emacsql-sqlite all-the-icons)))
(setq org-font "NotoMono")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :weight regular :height 150 :width normal :family "Roboto Mono"))))
 '(bold ((t (:inherit default :weight semi-bold :height 0.97))))
 '(line-number ((t (:inherit default :foreground "#6599bf" :weight normal :height 140 :width normal :foundry "GOOG" :family "Roboto Mono"))))
 '(line-number-current-line ((t (:inherit (hl-line default) :foreground "#bbc2cf" :weight normal :height 140 :width normal :foundry "GOOG" :family "Roboto Mono"))))
 '(org-default ((t (:weight light :height 180 :family "Heebo"))))
 '(org-document-title ((t (:inherit org-default :weight semi-light :family "Heebo" :height 163 :underline nil))))
 '(org-level-1 ((t (:inherit org-default :weight medium :family "Heebo" :height 0.95))))
 '(org-level-2 ((t (:inherit org-default :weight medium :family "Heebo" :height 0.95))))
 '(org-level-3 ((t (:inherit org-default :weight medium :family "Heebo" :height 0.95))))
 '(org-level-4 ((t (:inherit org-default :weight medium :family "Heebo" :height 0.95))))
 '(org-level-5 ((t (:inherit org-default :weight medium :family "Heebo" :height 0.95))))
 '(org-level-6 ((t (:inherit org-default :weight medium :family "Heebo" :height 0.95))))
 '(org-level-7 ((t (:inherit org-default :weight medium :family "Heebo" :height 0.95))))
 '(org-level-8 ((t (:inherit org-default :weight medium :family "Heebo" :height 0.95))))
 '(org-link ((t (:inherit org-default :weight semi-light :family "Heebo" :height 1.0 :foreground "#4078f2"))))
 '(org-list-dt ((t (:foreground "#4078f2" :weight normal :height 1.0))))
 '(org-roam-link ((t (:inherit org-default :foreground "#e8c24f" :strike-through nil :underline nil :slant normal :weight normal :width normal :foundry "ADBO" @variable-tuple))))
 '(org-roam-link-current ((t (:inherit org-default :foreground "#e8c24f" :strike-through nil :underline nil :slant normal :weight normal :width normal :foundry "ADBO" @variable-tuple))))
 '(term-bold ((t (:weight bold :height 1.0 :foundry "GOOG" :family "Noto Sans")))))
