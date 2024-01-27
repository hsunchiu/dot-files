;; In China, the network is blocked by GFW
(setq package-archives '(
                          ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                          ("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                          ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
                          ("nogpu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                          ))

(package-initialize)

(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  )

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;; https://book.emacs-china.org/#org1ebaa5d
;; easy tempo
(require 'org-tempo)  
;; close `<' auto completion
(setq electric-pair-inhibit-predicate
      `(lambda (c)
	 (if (char-equal c ?\<) t (,electric-pair-inhibit-predicate c))))
(add-hook 'org-mode-hook
	  (lambda ()
	    (setq-local electric-pair-inhibit-predicate
			`(lambda (c)
			   (if (char-equal c ?\<) t (,electric-pair-inhibit-predicate c))))))

(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

