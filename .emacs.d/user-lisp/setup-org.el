;;; Code:

(use-package org-bullets)

(use-package toc-org
  :init (add-hook 'org-mode-hook 'toc-org-enable)
  )

(eval-after-load "org-mode"
  (progn
    (setq org-catch-invisible-edits t ; Avoid editing folded contents
          org-hide-leading-stars t
          org-hide-emphasis-markers t
          org-src-fontify-natively t  ; Syntax highlighting in src blocks. Kind of a lighter MMM.
          )
    (add-hook 'org-mode-hook (lambda ()
                               (flyspell-mode t)
                               (org-indent-mode t)
                               (visual-line-mode t)
                               )
              )
    )
  )

(provide 'setup-org)