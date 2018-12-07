(global-linum-mode t)
(setq linum-format "%4d ")

; start package.el with emacs
(require 'package)
; add MELPA to repository list
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
; initialize package.el
(package-initialize)

; start auto-complete with emacs
(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

; start yasnipped with emacs
(require 'yasnippet)
(yas-global-mode 1)

; a function that initializes auto-complete-c-headers and gets caller dor c/c++ hooks
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/include")
  (add-to-list 'achead:include-directories '"/usr/include/c++/7")
  (add-to-list 'achead:include-directories '"/usr/include/x86_64-linux-gnu/c++/7")
  (add-to-list 'achead:include-directories '"/usr/include/c++/7/backward")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/7/include")
  (add-to-list 'achead:include-directories '"/usr/local/include")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/7/include-fixed")
  (add-to-list 'achead:include-directories '"/usr/include/x86_64-linux-gnu")
  )
; call this function from c/c++ hooks
(add-hook 'c-mode-common-hook 'my:ac-c-header-init)
;; (add-hook 'c++-mode-hook 'my:ac-c-header-init)
;; (add-hook 'c-mode-hook 'my:ac-c-header-init)

; fix iedit keybinding for german keyboards
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;; ; define flymake init function
;; (defun my:flymake-google-init ()
;;   (require 'flymake-google-cpplint)
;;   (custom-set-variables
;;    '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
;;   (flymake-google-cpplint-load)
;; )
;; (add-hook 'c-mode-hook 'my:flymake-google-init)
;; (add-hook 'c++-mode-hook 'my:flymake-google-init)

(global-flycheck-mode)

;; ; show neotree on startup
;; (defun my:show-neo-tree-on-c-modes()
;;   (interactive)
;;   (neotree-show)
;;   (call-interactively 'other-window)
;;   )
;; (add-hook 'after-init-hook 'my:show-neo-tree-on-c-modes)
(global-set-key [f8] 'neotree-toggle)

;; ; start google-c-style with emacs
;; (require 'google-c-style)
;; (add-hook 'c-mode-common-hook 'google-c-style)
;; (add-hook 'c-mode-common-hook 'google-make-newline-indent)

; turn on semantic mode
(semantic-mode 1)

; add semantic to suggestion backend to auto complete and hock it to c-mode-common
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
  )
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
;(add-hook 'c-mode-hook 'my:add-semantic-to-autocomplete)
;(add-hook 'c++-mode-hook 'my:add-semantic-to-autocomplete)










; ==========================================================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-google-cpplint-command "/usr/local/bin/cpplint")
 '(package-selected-packages
   (quote
    (flycheck google-c-style flymake-cursor flymake-google-cpplint iedit neotree auto-complete-c-headers yasnippet-snippets yasnippet auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; mouse stuff
(xterm-mouse-mode)
(defvar alternating-scroll-down-next t)
(defvar alternating-scroll-up-next t)

(defun alternating-scroll-down-line ()
  (interactive "@")
  (when alternating-scroll-down-next
					;      (run-hook-with-args 'window-scroll-functions )
    (scroll-down-line 5))
  (setq alternating-scroll-down-next (not alternating-scroll-down-next)))

(defun alternating-scroll-up-line ()
  (interactive "@")
  (when alternating-scroll-up-next
					;      (run-hook-with-args 'window-scroll-functions)
    (scroll-up-line 5))
  (setq alternating-scroll-up-next (not alternating-scroll-up-next)))

(global-set-key (kbd "<mouse-4>") 'alternating-scroll-down-line)
(global-set-key (kbd "<mouse-5>") 'alternating-scroll-up-line)

(defun track-mouse (e))
(setq mouse-sel-mode t)
(setq mouse-wheel-follow-mouse 't)
