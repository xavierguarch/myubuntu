(require 'package)
(add-to-list 'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/") t)

; From https://github.com/spotify/dockerfile-mode below
(add-to-list 'load-path "~/.emacs.d/dockerfile-mode")
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

; From http://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/ below
(add-to-list 'load-path "~/.emacs.d/golang")
(require 'go-mode-autoloads)

(setq backup-directory-alist
  `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
  `((".*" ,temporary-file-directory t)))


