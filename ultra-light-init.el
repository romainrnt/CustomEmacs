;;LIGHT emacs file. No hooks except those pre packaged (lisp, CC...). All modes installed callable
;;it doesn't load anything except color theme

;;to recompile all .el files to .elc files: emacs --batch --eval '(byte-recompile-directory "~/.emacs.d/" 0)' ;;to achieve faster loads

;;**** applying theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(setq custom-safe-themes t)
(load-theme 'eonos t);;light coloring in 'eonos-light

;;**** basic settings
(tool-bar-mode 0);;specific to emacs UI
(scroll-bar-mode 0);;specific to emacs UI
(menu-bar-mode 0)
(setq inhibit-startup-message t)
(setq column-number-mode t)
(setq line-number-mode t)
(setq truncate-partial-width-windows nil)
(setq ring-bell-function 'ignore)

;;clipboard
(setq x-select-enable-primary nil)
(setq x-select-enable-clipboard t);;if UI (classic emacs with X interface, no -nw)

;;customize mode line
(display-time-mode t)
(display-battery-mode t)
(size-indication-mode 0)

;;clear shell cmd for toto
(defun clear-shell ()
  (interactive)
  (let ((old-max comint-buffer-maximum-size))
    (setq comint-buffer-maximum-size 0)
    (comint-truncate-buffer)
    (setq comint-buffer-maximum-size old-max)))

;;binding
(global-set-key  (kbd "\C-x c")'clear-shell)

;;**** callable modes
(add-to-list 'load-path "~/.emacs.d/lisp/") 
;;rainbow-mode ;;call it even if not loaded by another file before
(defun mrainbow() "Hex color show" (interactive) (require 'rainbow-mode) (rainbow-turn-on) (rainbow-mode) )
(defun mweb () "Web mode" (interactive) (require 'web-mode) (web-mode) )
(defun mjs2 () "JS mode" (interactive) (require 'js2-mode) (js2-mode) )
(defun mjs () "JS mode" (interactive) (require 'js2-mode) (js2-mode) )
(defun mcss () "CSS mode" (interactive) (require 'css-mode) (css-mode) )
(defun mcsv () "CSV mode" (interactive) (require 'csv-mode);;ok except first column coloring
  (custom-set-variables '(csv-header-lines 1))
  (custom-set-variables '(csv-separators '(";" "\t" ",")))
  (custom-set-variables '(csv-field-quotes '("\"" "'")))
  (font-lock-add-keywords nil '(("^\\([^;]*\\);" 1 'font-lock-comment-face)))
  (font-lock-add-keywords nil '(("^\\(.*\\)$/m" 1 'font-lock-comment-face)));;attempt to color the header
  (csv-align-fields nil (buffer-end -1) (buffer-end +1));;prettify, if we open csv in emacs we want it clean (not cat -A)
  (csv-mode)
  )
(defun mlisp () "Lisp mode" (interactive) (require 'lisp-mode) (lisp-mode) );;ok even if automatically loaded too
(defun mR () "R mode" (interactive)
       (add-to-list 'load-path "~/.emacs.d/lisp/ESS/lisp") (autoload 'R-mode "ess-site.el" "" t) (R-mode) )
(defun mautocomp ();;works fine
  "autocomplete mode" (interactive) (add-to-list 'load-path "~/.emacs.d/lisp/auto-complete") (require 'auto-complete-config)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/lisp/auto-complete/dict/") ;;where the dictionaries are (can be completed)
  (ac-config-default) (auto-complete) )
(defun msml () "smart mode line mode" (interactive) ;;ok
       ;;fancy bar in themeing
       (add-to-list 'load-path "~/.emacs.d/lisp/smartmodeline") (require 'smart-mode-line)
       (setq sml/no-confirm-load-theme t) (setq sml/theme 'nil)
       ;;more sml settings
       (setq sml/shorten-directory t) (setq sml/shorten-modes t) (sml/setup))
 
;;c-modes are part of emacs core and automatically hooked
;;(defun mc () "C mode" (interactive) (add-to-list 'load-path "~/.emacs.d/lisp/cc-mode/") (require 'c-mode) )
;;(defun mc++ () "C++ mode" (interactive) (add-to-list 'load-path "~/.emacs.d/lisp/cc-mode/") (require 'c++-mode) (c++-mode) )
;;(defun mjava () "Java mode" (interactive) (add-to-list 'load-path "~/.emacs.d/lisp/cc-mode/") (require 'java-mode) (java-mode) )


;;**** extenders IRC, slime, elfeed
;;slime
(defun slime (&optional command coding-system)
  "Start an inferior^_superior Lisp and connect to its Swank server."
  (interactive);;allows to call it with M-x
  (add-to-list 'load-path "~/.emacs.d/lisp/slime")
  (require 'slime-autoloads)
  (setq inferior-lisp-program "sbcl")
  (slime-setup '(slime-fancy))
  (let ((inferior-lisp-program (or command inferior-lisp-program))
	(slime-net-coding-system (or coding-system slime-net-coding-system)))
    (slime-start* (cond ((and command (symbolp command))
			 (slime-lisp-options command))
			(t (slime-read-interactive-args))))))

;; M-x start-irc
(defun irc (nick)
  "Connect to IRC."
  (interactive "snickname: ")
  (require 'erc)
  (require 'erc-log)
  (require 'erc-notify)
  ;;(add-to-list 'erc-modules 'notifications)
  (require 'tls)
  ;;irc ssl startup
  (setq tls-program '("openssl s_client -connect %h:%p -no_ssl2 -ign_eof -cert ~/.ssl/eonos.pem"
		      "gnutls-cli --priority secure256 --x509certfile ~/.ssl/eonos.pem -p %p %h"
		      "gnutls-cli --priority secure256 -p %p %h"))

  ;;add keywords
  (setq erc-keywords '(("ping") ("Ping") ("shout") ("ring")))
  (erc-match-mode 1);;required for it to work!

  (defun idlep (&optional secs)
    "Return a boolean whether emacs has been idle for more than 'secs', defaults to 20."
    (< (or secs 20) (float-time (or (current-idle-time) '(0 0 0)))))

  ;; Notify on keyword
  (defun erc-global-notify (match-type nick msg)
    (interactive) ;;match-type is keyword or current-nick
    ;;(when (and (idlep) (eq match-type 'keyword)) (start-process "name" "bufname" "~/deployconf/notif.sh" "idled")
    (when (and (eq match-type 'keyword)
	       ;; don't want erc server stuff
	       (null (string-match "\\`\\([sS]erver\\|localhost\\)" nick))
	       ;; or bots
	       (null (string-match "\\(bot\\|serv\\)!" nick))
	       ;;(shell-command "notify-send -t  -c \"test\" \"test\"")))
	       ;;(shell-command "~/deployconf/notif.sh test"))))
	       (start-process "name" "bufname" "notif" "IRC ping received"))))

  (add-hook 'erc-text-matched-hook 'erc-global-notify)

  ;;add autojoin
  (erc-autojoin-mode t)
  (setq erc-autojoin-channels-alist '(("irc.eonos.com" "#sygteam")))

  ;;erc custom channel prompt
  (setq erc-prompt (lambda ()
		     (if (and (boundp 'erc-default-recipients) (erc-default-target))
			 (erc-propertize (concat (erc-default-target) ">") 'read-only t 'rear-nonsticky t 'front-nonsticky t)
		       (erc-propertize (concat "yo>") 'read-only t 'rear-nonsticky t 'front-nonsticky t))))
  (erc-tls :server "149.202.74.168" :port 6697 :nick (format "%s" nick) :full-name (format "%s" nick) :password "eonosittest")
  )

;;elfeed setup (newsticker sucks)
(defun elfeed ()
  "Enter elfeed."
  (interactive)
  (add-to-list 'load-path "~/.emacs.d/lisp/elfeed")
  (require 'shr)
  (require 'elfeed)
  (setq elfeed-add-feed '("http://www.reddit.com/r/unixporn/.rss" "http://www.reddit.com/r/MechanicalKeyboards/.rss"))
  (setq elfeed-feeds '("http://www.reddit.com/r/unixporn/.rss" "http://www.reddit.com/r/MechanicalKeyboards/.rss"))
  (switch-to-buffer (elfeed-search-buffer))
  (unless (eq major-mode 'elfeed-search-mode)
    (elfeed-search-mode)))


;;**** TODO utilities (wrap bashrc stuff + browsers)

;;launch firefox url
(defun firefox (url)
  "Launch firefox"
  (interactive "surl:")
  (if (buffer-file-name)
      (let ((filename (buffer-file-name)))
	(shell-command (concat "firefox --target tab " (format "%s" url))) )))

 
