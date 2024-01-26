;; -*- coding: utf-8; lexical-binding: t; -*-
;; basic gnu emacs settings. Everything in this file is for plain gnu emacs only.
;; for emacs 28 or later.
;; Version: 2023-09-05

;; Emacs: Init File Tutorial
;; http://xahlee.info/emacs/emacs/emacs_init_file.html


;; UTF-8 as default encoding
;; http://xahlee.info/emacs/emacs/emacs_file_encoding.html
;; http://xahlee.info/emacs/emacs/emacs_encoding_decoding_faq.html

(set-language-environment "utf-8")
(set-default-coding-systems 'utf-8-unix)
;; (set-terminal-coding-system 'utf-8-unix)
;; (set-keyboard-coding-system 'utf-8-unix)

;; initial window and default window
;; http://xahlee.info/emacs/emacs/emacs_customize_default_window_size.html

(setq inhibit-startup-screen t)

(setq default-frame-alist
      (if (display-graphic-p)
          '((tool-bar-lines . 0)
            (background-color . "honeydew"))
        '((tool-bar-lines . 0))))

;; backup
;; http://xahlee.info/emacs/emacs/emacs_set_backup_into_a_directory.html

(setq make-backup-files t)

;; make multiple versions, ending in ~1~ ~2~ etc
(setq version-control t)

;; make sure hard link and creation date, owner, etc is preserved
(setq backup-by-copying t)

;; make backup even in git controlled dir
(setq vc-make-backup-files t)

;; silently delete old backup
(setq delete-old-versions :no) ; default nil
;; t means silent delete
;; nil means ask
;; other values means do not delet

;; (setq kept-old-versions 2) ; default 2
;; (setq kept-new-versions 2) ; default 2

;; function that decide a file should be backed up
;; (setq backup-enable-predicate 'normal-backup-enable-predicate )

;; a alist (regex . dir) to decide where to place backup
;; (setq backup-directory-alist '(("." . "~/.emacs.d/backup")))

;;; real auto save

;; Emacs: Real Automatic Save File
;; http://xahlee.info/emacs/emacs/emacs_auto_save.html

;; (when (>= emacs-major-version 26)
;;   (auto-save-visited-mode 1)
;;   (setq auto-save-visited-interval 30) ; default 5
;;   )

(defun xah-save-all-unsaved ()
  "Save all unsaved files. no ask.
Version 2019-11-05"
  (interactive)
  (save-some-buffers t ))

(when (>= emacs-major-version 27)
  (setq after-focus-change-function 'xah-save-all-unsaved)
  ;; to undo this, run
  ;; (setq after-focus-change-function 'ignore)
  )

;; Emacs: auto-save (filename with #hashtag#)
;; http://xahlee.info/emacs/emacs/emacs_auto-save_backup.html
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; Emacs: Bookmark Init
;; http://xahlee.info/emacs/emacs/emacs_bookmark_init.html

;; save bookmark on change
(setq bookmark-save-flag 1)

;; file related

;; auto refresh
;; http://xahlee.info/emacs/emacs/emacs_refresh_file.html
(global-auto-revert-mode 1)

;; Emacs: Open Recently Opened File
;; http://xahlee.info/emacs/emacs/emacs_recentf.html
(require 'recentf)
(recentf-mode 1)

(progn
  ;; (desktop-save-mode 1)
  (setq desktop-restore-frames t)
  (setq desktop-auto-save-timeout 300)
  (setq desktop-globals-to-save nil)
  ;; (setq desktop-globals-to-save '(desktop-missing-file-warning tags-file-name tags-table-list search-ring regexp-search-ring register-alist file-name-history))
  (setq desktop-save t))

;; user interface

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

(column-number-mode 1)
(blink-cursor-mode 0)
;; (setq use-dialog-box nil)

(progn
  ;; no need to warn
  (put 'narrow-to-region 'disabled nil)
  (put 'narrow-to-page 'disabled nil)
  (put 'upcase-region 'disabled nil)
  (put 'downcase-region 'disabled nil)
  (put 'erase-buffer 'disabled nil)
  (put 'scroll-left 'disabled nil)
)

(setq mouse-highlight nil)

(if (version< emacs-version "28.1")
    nil
  (setq mode-line-compact t))

;; Emacs: Dired Customization
;; http://xahlee.info/emacs/emacs/emacs_dired_tips.html

;; copy, move, rename etc to the other pane
(setq dired-dwim-target t)

;; allow copy dir with subdirs
(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

(cond
 ((string-equal system-type "gnu/linux") (setq dired-listing-switches "-al --time-style long-iso"))
 ((string-equal system-type "darwin") (setq dired-listing-switches "-alh")))

(put 'dired-find-alternate-file 'disabled nil)

;; some goodies
(require 'dired-x)


(progn
  ;; minibuffer setup
  (setq enable-recursive-minibuffers t)
  (savehist-mode 0)
  ;; big minibuffer height, for ido to show choices vertically
  (setq max-mini-window-height 0.5)
  ;; minibuffer, stop cursor going into prompt
  (customize-set-variable
   'minibuffer-prompt-properties
   (quote (read-only t cursor-intangible t face minibuffer-prompt))))

(when (>= emacs-major-version 28)
  (progn
    (setq completion-styles '(flex))
    (icomplete-vertical-mode 1)))


;; remember cursor position
(when (>= emacs-major-version 25) (save-place-mode 1))


;;; editing related

;; make typing delete/overwrites selected text
(delete-selection-mode 1)

;; disable shift select
(setq shift-select-mode nil)

(electric-pair-mode 1)

;; for isearch-forward, make these equivalent: space newline tab hyphen underscore
(setq search-whitespace-regexp "[-_ \t\n]+")

(setq composition-break-at-point t)

(setq hippie-expand-try-functions-list
      '(
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        ;; try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol
        try-complete-file-name-partially
        try-complete-file-name
        ;; try-expand-all-abbrevs
        ;; try-expand-list
        ;; try-expand-line
        ))

;; 2015-07-04 bug of pasting in emacs.
;; http://debbugs.gnu.org/cgi/bugreport.cgi?bug=16737#17
;; http://xahlee.info/emacs/misc/emacs_bug_cant_paste_2015.html
;; (setq x-selection-timeout 300)
;; (setq save-interprogram-paste-before-kill t)
;; (setq x-select-enable-clipboard-manager nil)


;; editing, mark

;; Emacs: Jump to Previous Position
;; http://xahlee.info/emacs/emacs/emacs_jump_to_previous_position.html

;; repeated C-u set-mark-command move cursor to previous mark in current buffer
(setq set-mark-command-repeat-pop t)

(setq mark-ring-max 10)
(setq global-mark-ring-max 10)


;;; rendering related for coding/editting

;; force line wrap to wrap at word boundaries
;; http://xahlee.info/emacs/emacs/emacs_toggle-word-wrap.html
(setq-default word-wrap t)

;; set highlighting brackets
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)


;; Emacs: Tab/Indent Setup
;; http://xahlee.info/emacs/emacs/emacs_tabs_space_indentation_setup.html

(electric-indent-mode 0)

(set-default 'tab-always-indent 'complete)

;; no mixed tab space
(setq-default indent-tabs-mode nil)
 ; gnu emacs at least 23.1 to 28 default is t

;; gnu emacs default to 8. tooo big. but problem of diff value is that some elisp source code in gnu emacs expected 8 to look nice, cuz they use mixed tab and space. but in golang, 8 is too much. also, python and others, standardize to 4
(setq-default tab-width 4)

(setq sentence-end-double-space nil )


;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "https://melpa.org/packages/")
   t))

(progn
  ;; Make whitespace-mode with very basic background coloring for whitespaces.
  ;; http://xahlee.info/emacs/emacs/whitespace-mode.html
  (setq whitespace-style (quote (face spaces tabs newline space-mark tab-mark newline-mark)))

  ;; Make whitespace-mode and whitespace-newline-mode use â€œÂ¶â€ for end of line char and â€œâ–·â€ for tab.
  (setq whitespace-display-mappings
        ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
        '((space-mark 32 [183] [46]) ; SPACE 32 ã€Œ ã€, 183 MIDDLE DOT ã€ŒÂ·ã€, 46 FULL STOP ã€Œ.ã€
          (newline-mark 10 [182 10]) ; LINE FEED,
          (tab-mark 9 [9655 9] [92 9]) ; tab
          )))

(if (version< emacs-version "28.1")
    (defalias 'yes-or-no-p 'y-or-n-p)
  (setq use-short-answers t))

;; 2021-12-21. fuck Alan Mackenzie
;; Emacs Lisp Doc String Curly Quote Controversy
;; http://xahlee.info/emacs/misc/emacs_lisp_curly_quote_controversy.html
(setq text-quoting-style 'grave)

;; 2023-08-04 turn off byte compile warning on unescaped single quotes
(setq byte-compile-warnings '(not docstrings) )

(setq byte-compile-docstring-max-column 999)

;; up/down arrow move based on logical lines (newline char) or visual line
(setq line-move-visual nil)
;; default is t
;; http://xahlee.info/emacs/emacs/emacs_arrow_down_move_by_line.html



;; (global-tab-line-mode)

(tooltip-mode -1)



;; 2023-01-24 apache per dir config file
(add-to-list 'auto-mode-alist '("\\.htaccess\\'" . conf-unix-mode))

;; 2023-01-24 pdf mode is super slow. should use dedicated app
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . fundamental-mode))



;; In China, the network is blocked by GFW
(setq package-archives '(
                          ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                          ("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                          ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
                          ("nogpu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                          ))

(package-initialize)

;;(load-theme 'modus-vivendi)

(use-package company
   :ensure t)

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

(use-package cmake-mode
  :ensure t
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'")
  :hook (cmake-mode . eglot-ensure))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))
