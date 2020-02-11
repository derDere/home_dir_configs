; package --- summary:
;  all-the-icons      20190320.1809 installed             A library for inserting Developer icons
;  all-the-icons-d... 20170418.2131 installed             Shows icons for each file in dired mode
;  auto-complete      20170125.245  installed             Auto Completion for GNU Emacs
;  auto-complete-c... 20150912.323  installed             An auto-complete source for C/C++ header files
;  dashboard          20190721.504  installed             A startup screen extracted from Spacemacs
;  flycheck           20190213.1525 installed             On-the-fly syntax checking
;  flymake-cursor     20120322.1757 installed             Show flymake messages in the minibuffer after delay
;  flymake-google-... 20140205.1325 installed             Help to comply with the Google C++ Style Guide
;  google-c-style     20180130.1736 installed             Google's C/C++ style for c-mode
;  hlinum             20180422.412  installed             Extension for linum.el to highlight current line number
;  iedit              20181114.950  installed             Edit multiple regions in the same way simultaneously.
;  magit              20191008.727  installed             A Git porcelain inside Emacs.
;  neotree            20181121.2026 installed             A tree plugin like NerdTree for Vim
;  treemacs           20191008.1937 installed             A tree style file explorer package
;  treemacs-magit     20190731.540  installed             Magit integration for treemacs
;  yasnippet          20181015.1212 installed             Yet another snippet extension for Emacs.
;  yasnippet-snippets 20191009.625  installed             Collection of yasnippet snippets

;  #+BEGIN_SRC emacs-lisp
;    (defun list-packages-and-versions ()
;      "Returns a list of all installed packages and their versions"
;      (mapcar
;  	(lambda (pkg)
;  	  `(,pkg ,(package-desc-version
;  		     (cadr (assq pkg package-alist)))))
;  	package-activated-list))
;  
;  	(list-packages-and-versions)
;  #+END_SRC



;;; Commentary:



;;; Code:



; Maximise window in startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))



; Hide Toolbar Menubar and Tooltips
(if (display-graphic-p)
    (tool-bar-mode 0)
)
(tooltip-mode 0)
(menu-bar-mode 0)



; show line numbers
(global-linum-mode t)
;   ;(setq linum-format "%4d ")
;   ;(setq linum-format (concat linum-format " "))



; disables the creation of those extra files
(setq create-lockfiles nil)
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files



; start package.el with emacs
(require 'package)
; add MELPA to repository list
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
; initialize package.el
(package-initialize)



; activate powerline
(require 'powerline)
(powerline-default-theme)



; activate ido-mode [[http://ergoemacs.org/emacs/emacs_ido_mode.html]]
(ido-mode)



; create fast buffer keybindings
(defun switch-to-buffer-dashboard ()
  "Switch to the *dashboard* Buffer, if open."
  (interactive)
  (switch-to-buffer (get-buffer "*dashboard*")))
(defun switch-to-buffer-todos-org ()
  "Switch to the ToDos.org Buffer, if open."
  (interactive)
  (switch-to-buffer (get-buffer "ToDos.org")))
(defun switch-to-buffer-notes-org ()
  "Switch to the Notes.org Buffer, if open."
  (interactive)
  (switch-to-buffer (get-buffer "Notes.org")))
(defun switch-to-buffer-zeit-org ()
  "Switch to the Zeit.org Buffer, if open."
  (interactive)
  (switch-to-buffer (get-buffer "Zeit.org")))
(define-key global-map (kbd "C-0") 'switch-to-buffer-dashboard)
(define-key global-map (kbd "C-1") 'switch-to-buffer-todos-org)
(define-key global-map (kbd "C-2") 'switch-to-buffer-notes-org)
(define-key global-map (kbd "C-3") 'switch-to-buffer-zeit-org)



; use font-lock and inherit icons into dired mode
(require 'font-lock)
(require 'all-the-icons)
(setq inhibit-compacting-font-caches t)
;(use-package all-the-icons)
;(use-package all-the-icons-dred
;	     :hook (dired-mode . all-the-icons-dired-mode))
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)



; show Current Line
(require 'hlinum)
(hlinum-activate)



; treemacs
(require 'treemacs)
; Create Treemacs Shurtcut
(global-set-key (kbd "C-q") 'treemacs)
(global-set-key (kbd "<f7>") 'treemacs)
; set iconsize for treemacs
(defvar treemacs--icon-size 16)
(treemacs-resize-icons 16)



; opening Dashboard on startup
(require 'dashboard)
;; Set the title
(setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
;; Set the banner
(setq dashboard-startup-banner 'official)
;(setq recentf-exclude (org-agenda-files)) ;Doesn'T Work!!!!!!
(setq recentf-exclude '("~/.emacs.d/*"))
;; Value can be
;; 'official which displays the official emacs logo
;; 'logo which displays an alternative emacs logo
;; 1, 2 or 3 which displays one of the text banners
;; "path/to/your/image.png" which displays whatever image you would prefer

;; Content is not centered by default. To center, set
;(setq dashboard-center-content t)

;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts nil)
; add icons to the widget headings and their items
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)

;(setq dashboard-set-navigator t)

(dashboard-setup-startup-hook)



; start auto-complete with emacs
(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)



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



; start yasnipped with emacs
(require 'yasnippet)
(yas-global-mode 1)



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
(add-to-list 'ac-modes 'org-mode)


; Activates org-bullets-mode at org-mode
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (js . t)
   (shell . t)
   (emacs-lisp . t)))

; activate auto closed date creation on done todo
(setq org-log-done 'time)

; org agenda key map
(global-set-key (kbd "C-c a") 'org-agenda)

; finding Org Folder
(defvar ORG_DIR (getenv "ORG"))

; setting org default notes file
(setq org-default-notes-file (concat ORG_DIR "/ToDos.org"))

; add agenda files
(defvar NOTES_LOCATION "F:/Users/Phillip/Documents/Notes.org")
(if (not (file-exists-p NOTES_LOCATION))
    (setq NOTES_LOCATION "~/Documents/Notes.org"))
(setq org-agenda-files (list NOTES_LOCATION
			     (concat ORG_DIR "/ToDos.org")))

; setting org archive location
(setq org-archive-location (concat ORG_DIR
				   "/Done/Done_"
                                   (format-time-string "%Y" (current-time))
                                   ".org_archive::"))
; extending TODO states
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))

; force utf-8 for org-exports
(setq org-export-coding-system 'utf-8)

; org captures
;   org captures key map
(define-key global-map "\C-cc" 'org-capture)
;   org capture templates
(setq org-capture-templates
      '(("t"              ;hotkey
	"Todo list item" ; name
	entry            ;type
	; heading tyoe and title
	(file+headline org-default-notes-file "Uncategorized")
	"* TODO %?\n  %i\n  Source: %a") ; template
	))


; prettyfy org mode
(add-hook 'org-mode-hook (lambda ()
   "Beautify Org Checkbox Symbol"
   (push '("[ ]" .  "☐") prettify-symbols-alist)
   (push '("[X]" . "☑" ) prettify-symbols-alist)
   (push '("[-]" . "❍" ) prettify-symbols-alist)
   (push '("#+BEGIN_SRC" . "λ" ) prettify-symbols-alist)
   (push '("#+END_SRC" . "λ" ) prettify-symbols-alist)
   (push '("#+RESULTS:" . "ƒ" ) prettify-symbols-alist)
   ;(push '("#+BEGIN_SRC" . "┌── λ : " ) prettify-symbols-alist)
   ;(push '("#+END_SRC" . "└── λ ────────────" ) prettify-symbols-alist)
   ;(push '("-----" . "────────────") prettify-symbols-alist)
   ;(push '("#+RESULTS:" . "#=RESULT:" ) prettify-symbols-alist)
   (prettify-symbols-mode)))











; ==========================================================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (wombat)))
 '(diff-hl-side (quote right))
 '(flymake-google-cpplint-command "/usr/local/bin/cpplint")
 '(line-number-mode nil)
 '(package-selected-packages
   (quote
    (powerline ac-php ac-math htmlize org-bullets all-the-icons all-the-icons-dired treemacs treemacs-magit dashboard magit hlinum flycheck google-c-style flymake-cursor flymake-google-cpplint iedit neotree auto-complete-c-headers yasnippet-snippets yasnippet auto-complete)))
 '(scroll-bar-mode nil)
 '(tooltip-mode nil))
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
