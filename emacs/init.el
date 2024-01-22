;; In China, the network is blocked by GFW
(setq package-archives '(
                          ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                          ("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                          ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
                          ("nogpu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                          ))

(package-initialize)

;; (use-package company
  ;; :ensure t)

(when (and (eq system-type 'darwin) (display-graphic-p))
  (progn
    ;; stop open new frame when use OS X's open
    (setq ns-pop-up-frames nil)
    ;; scroll settings for NS port
    (setq scroll-conservatively 10000
          mouse-wheel-scroll-amount '(2 ((shift) . 1)) ;; one line at a time
          mouse-wheel-progressive-speed nil ;; don't accelerate scrolling
          mouse-wheel-follow-mouse 't ;; scroll window under mouse
          )
    (setq visible-bell nil))

  ;; Mac Key mode by Xu Xin <railwaycat@gmail.com>
  ;; usage: M-x mac-switch-meta
  ;;   switch meta between option and command on a Mac Keyboard

  ;; Keybonds
  (global-set-key [(hyper a)] 'mark-whole-buffer)
  (global-set-key [(hyper v)] 'yank)
  (global-set-key [(hyper c)] 'kill-ring-save)
  (global-set-key [(hyper s)] 'save-buffer)
  (global-set-key [(hyper l)] 'goto-line)
  (global-set-key [(hyper w)] 'delete-frame)
  (global-set-key [(hyper n)] 'make-frame-command)
  (global-set-key [(hyper z)] 'undo)
  (global-set-key [(hyper x)] 'kill-region)
  (global-set-key [(hyper o)] 'find-file)
  (global-set-key [(hyper f)] 'isearch-forward)
  ;; (global-set-key [(hyper g)] 'isearch-repeat-forward)
  ;; (global-set-key [(hyper .)] 'keyboard-quit)
  ;; (global-set-key [(hyper q)] 'save-buffers-kill-emacs)
  (global-set-key [(hyper m)] 'suspend-frame)
  ;; (global-set-key [(hyber n)] 'make-frame-command)
  (global-set-key [(hyper {)] 'previous-buffer)
  (global-set-key [(hyper })] 'next-buffer)
  (global-set-key [(hyper r)] 'revert-buffer)


  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'hyper)


  (defun mac-switch-meta nil
    "switch meta between Option and Command"
    (interactive)
    (if (eq mac-option-modifier nil)
        (progn
          (setq mac-option-modifier 'meta
                mac-command-modifier 'hyper))
      (progn
        (setq mac-option-modifier nil
              mac-command-modifier 'meta))))
)



;;; https://gist.github.com/EMPAT94/691526ebe01bf74cdee479d92ec4f058
;; I installed emacs today and wanted to bind some functions to cmd key.
;; That simple objective somehow ended with me noting down all default keybindings.
;; Sharing here so you don't have to go on this side quest like me. :)

;; For letters, if a corresponding capital letter is missing, 
;; it means it calls the same function as its small case form

;;(global-set-key (kbd "s-`") 'other-frame)
;;(global-set-key (kbd "s-~") 'ns-prev-frame)
;;(global-set-key (kbd "s-1,2,3,4,5,6,7,8,9") ) ;; grouped together
;;(global-set-key (kbd "s-0") 'text-scale-adjust)
;;(global-set-key (kbd "s-!,@,#,$") )
;;(global-set-key (kbd "s-%") ) ;; global screenshot utility
;;(global-set-key (kbd "s-^") 'kill-some-buffers)
;;(global-set-key (kbd "s-&") 'kill-current-buffer)
;;(global-set-key (kbd "s-*,(") 'iconify-frame)
;;(global-set-key (kbd "s-)") 'iconify-frame)
;;(global-set-key (kbd "s--") 'text-scale-adjust)
;;(global-set-key (kbd "s-_") )
;;(global-set-key (kbd "s-=") 'text-scale-adjust)
;;(global-set-key (kbd "s-+") 'text-scale-adjust)
;;(global-set-key (kbd "s-<backspace>") )

;;(global-set-key (kbd "s-q") 'save-buffers-kill-emacs) ;; s-Q => Quits everything
;;(global-set-key (kbd "s-w") 'delete-frame)
;;(global-set-key (kbd "s-e") 'isearch-yank-kill)
;;(global-set-key (kbd "s-E") 'edit-abbrevs)
;;(global-set-key (kbd "s-r") )
;;(global-set-key (kbd "s-t") 'ns-popup-font-panel) 
;;(global-set-key (kbd "s-y") 'ns-paste-secondary)
;;(global-set-key (kbd "s-u") 'revert-buffer)
;;(global-set-key (kbd "s-i") )
;;(global-set-key (kbd "s-o") 'ns-open-file-using-panel) 
;;(global-set-key (kbd "s-p") 'ns-print-buffer)
;;(global-set-key (kbd "s-[") )
;;(global-set-key (kbd "s-{") )
;;(global-set-key (kbd "s-]") )
;;(global-set-key (kbd "s-}") )

;;(global-set-key (kbd "s-a") 'mark-whole-buffer))
;;(global-set-key (kbd "s-s") 'ns-write-file-using-panel)
;;(global-set-key (kbd "s-d") 'isearch-repeat-backward)
;;(global-set-key (kbd "s-D") 'dired)
;;(global-set-key (kbd "s-f") 'isearch-forward)
;;(global-set-key (kbd "s-g") 'isearch-repeat-forward)
;;(global-set-key (kbd "s-h") 'ns-do-hide-emacs)
;;(global-set-key (kbd "s-H") 'ns-do-hide-others)
;;(global-set-key (kbd "s-j") 'exchange-point-and-mark)
;;(global-set-key (kbd "s-k") 'kill-current-buffer)
;;(global-set-key (kbd "s-l") 'goto-line)
;;(global-set-key (kbd "s-L") 'shell-command)
;;(global-set-key (kbd "s-;") )
;;(global-set-key (kbd "s-:") 'ispell)
;;(global-set-key (kbd "s-'") 'next-window-any-frame)
;;(global-set-key (kbd "s-"") 'next-window-any-frame)

;;(global-set-key (kbd "s-z") 'undo)
;;(global-set-key (kbd "s-x") 'kill-region)
;;(global-set-key (kbd "s-c") 'ns-copy-including-secondary)
;;(global-set-key (kbd "s-C") 'ns-popup-color-panel)
;;(global-set-key (kbd "s-v") 'yank)
;;(global-set-key (kbd "s-b") )
;;(global-set-key (kbd "s-n") 'make-frame)
;;(global-set-key (kbd "s-m") 'iconify-frame)
;;(global-set-key (kbd "s-M") 'manual-entry)
;;(global-set-key (kbd "s-,") 'customize)
;;(global-set-key (kbd "s-<") )
;;(global-set-key (kbd "s-.") )
;;(global-set-key (kbd "s->") )


(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  )

(use-package sudo-edit
  :defer t)

(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;; https://clangd.llvm.org/installation.html
(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))
