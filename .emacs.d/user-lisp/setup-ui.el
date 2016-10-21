(require 'use-package)

;; Themes
(use-package alect-themes    :defer t)
(use-package solarized-theme :defer t)
(use-package zenburn-theme   :defer t)
(load-theme 'leuven)

;; Fonts

(setq thblt/base-font-size 090)
(when (string-prefix-p  "rudiger" system-name)
  (setq thblt/base-font-size 120)
  )

(setq default-frame-alist '((font . "DejaVu Sans Mono for Powerline Nerd Font")))
(set-face-attribute 'default t :height thblt/base-font-size)

;; UI elements

(unless (string= 'system-type 'darwin) (menu-bar-mode -1))
(tool-bar-mode -1)
(scroll-bar-mode -1)

(use-package god-mode
  :bind (("<escape>" . god-local-mode)
         :map god-local-mode-map
         ("z"        . repeat)
         ("i"        . god-local-mode)
         )
  :config
  (defun my-update-cursor ()
    (setq cursor-type (if (or god-local-mode buffer-read-only)
                          'box
                        'bar)))

(add-hook 'god-mode-enabled-hook 'my-update-cursor)
(add-hook 'god-mode-disabled-hook 'my-update-cursor)

  )

(use-package hydra)

(use-package neotree                    ; FS sidebar à la NERDTree
  :bind ("<f2>" . neotree-toggle)
  )

(use-package windmove
  :init (windmove-default-keybindings)
  )

(defun startup-echo-area-message ()
  "I'm ready!") ; Because SpongeBob.

(provide 'setup-ui)
