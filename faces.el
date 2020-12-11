;;; ~/.doom.d/faces.el -*- lexical-binding: t; -*-


(setq variable-tuple (cond
                            ((x-family-fonts "Alef")    '(:family "Alef"))
                            ((x-family-fonts "Fira Code Retina")    '(:family "Fira Code Retina"))
                            ((x-family-fonts "Source Sans Pro")    '(:family "Source Sans Pro"))
                            (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))
                            )

      base-font-color     (face-foreground 'default nil 'default)
      headline           `(:inherit default :weight normal :foreground ,base-font-color))

;; "#3f444a"
                        ;; `(line-number ((t (:inherit default :foreground "#9fa6b" :strike-through nil :underline nil :slant normal :weight normal :height 174 :width normal :foundry "ADBO" :family "Source Code Pro"))))
                        ;; `(line-number-current-line ((t (:inherit (hl-line default) :foreground "#bbc2cf" :strike-through nil :underline nil :slant normal :weight normal :height 174 :width normal :foundry "ADBO" :family "Source Code Pro"))))
(custom-theme-set-faces 'user
                        `(line-number ((t (:inherit default :foreground "#9fa6b" :strike-through nil :underline nil :slant normal :weight normal :height 174 :width normal :foundry "ADBO" :family "Source Code Pro"))))
                        `(line-number-current-line ((t (:inherit (hl-line default) :foreground "#bbc2cf" :strike-through nil :underline nil :slant normal :weight normal :height 174 :width normal :foundry "ADBO" :family "Source Code Pro"))))
)
(custom-theme-set-faces 'user
                        `(org-level-8 ((t (,@headline ,@variable-tuple :height 1.01))))
                        `(org-level-7 ((t (,@headline ,@variable-tuple :height 1.01))))
                        `(org-level-6 ((t (,@headline ,@variable-tuple :height 1.01))))
                        `(org-level-5 ((t (,@headline ,@variable-tuple :height 1.01))))
                        `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.01))))
                        `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.01))))
                        `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.01))))
                        `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.01))))
                        `(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :underline nil)))))

;; (face-remap-add-relative 'default :family "alef" :height 190)
