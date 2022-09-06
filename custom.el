(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-digit-bound-motions '(evil-beginning-of-visual-line))
 '(flycheck-python-pycompile-executable "/c/Python310/python")
 '(helm-ag-base-command "rg --no-heading")
 '(helm-ag-success-exit-status '(0 2))
 '(linum-format 'dynamic)
 '(matlab-shell-command-switches '("-nodesktop -nosplash -nodisplay"))
 '(org-outline-path-complete-in-steps nil)
 '(org-refile-use-outline-path 'file)
 '(package-selected-packages '(emacsql-sqlite3 emacsql-sqlite all-the-icons)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(line-number ((t (:inherit default :foreground "steel blue" :strike-through nil :underline nil :slant normal :weight semi-bold :family "Roboto Mono"))))
 '(line-number-current-line ((t (:inherit (hl-line default) :foreground "light steel blue" :strike-through nil :underline nil :slant normal :weight semi-bold :family "Roboto Mono"))))
 '(org-default ((t (:family "Heebo"))))
 '(org-document-title ((t (:foreground "dark sea green" :weight bold))))
 '(outline-1 ((t (:extend t :foreground "dark green" :weight normal))))
 '(outline-2 ((t (:extend t :foreground "cadet blue" :weight normal))))
 '(outline-3 ((t (:extend t :foreground "sea green" :weight bold))))
 '(term-bold ((t (:weight bold :height 1.0 :family "Noto Sans")))))


