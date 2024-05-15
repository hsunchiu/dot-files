;;; init.el --- emacs config
;;; Commentary:
;;;

;; In China, the network is blocked by GFW, I use TUNA.
(setq package-archives '(("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                          ("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                          ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
                          ("nogpu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")))
;; (add-to-list 'package-archives '("melpa" . "xxxx"))
(package-initialize)

;; Some ui config
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Settings for company, auto-complete only for coding.
(use-package company
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'company-mode))

;; Flymake, syntax check
(use-package flymake
  :hook (prog-mode . flymake-mode)
  :init
  (add-hook 'prog-mode-hook 'flymake-mode)
  :bind (("M-n" . #'flymake-goto-next-error)
	 ("M-p" . #'flymake-goto-prev-error)))

;; Format, don't using lsp
;; use ditorconfig to format project
(use-package editorconfig
  :ensure t
  :init
  (add-hook 'prog-mode 'editorconfig-mode))

;; auto install treesit libs
;; `treesit-auto-install-all`
(use-package treesit-auto
  :ensure t
  :config
  (global-treesit-auto-mode))

;; elgot for lsp client
(use-package eglot
  :init
  (add-hook 'prog-mode-hook #'eglot-ensure))

;; C/C++ lsp-server: clangd (`brew install llvm` in macos)
(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
(add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
(add-to-list 'major-mode-remap-alist '(c-or-c++-mode . c-or-c++-ts-mode))

;;TODO: Rust lsp-server: rust-analyzer

;; show keymapping to hint
(use-package which-key
  :ensure t
  :init
  (which-key-mode))

;; https://book.emacs-china.org/#org1ebaa5d
;; easy tempo
(require 'org-tempo)

(use-package evil
  :ensure t
  :config
  (define-key evil-normal-state-map (kbd "C-p") #'evil-previous-line)
  (define-key evil-normal-state-map (kbd "C-n") #'evil-next-line)
  (define-key evil-normal-state-map (kbd "C-z") #'suspend-emacs)
  (define-key evil-insert-state-map (kbd "C-z") #'suspend-emacs)
  :init
  (evil-mode 1))


(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))





;;; init.el
