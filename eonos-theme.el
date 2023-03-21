;;Implementation based on Bbatsov implementation of Jani Nurminen's zenburn theme
(deftheme eonos "EonOS color theme")

;;Comment out to get the rainbow-mode
;;(setq enable-local-variables nil);;suppress the unsafe eval prompt 
;;; Color Palette

;;loading the colors extracted from the .Xresources file
(load "~/.emacs.d/themes/current-colors.el")

;;good testfiles: extract_url.pl, thewall.html, csum.cpp, csum.h, lithpload.c
(defvar eonos-default-colors-alist
  '(("eonos-fg"       .  fg)  ;;fg  : main text color
    ("eonos-bg-1"     .  bblk);;bblk: highlight/match/selection
    ("eonos-bg"       .  nil) ;;nil : even if the same as .Xresource the diff is noticable so we just inherit
    ("eonos-bg+1"     .  blk) ;;blk : not very necessary
    ("eonos-red"      .  red) ;;red : quotes
    ("eonos-red-1"    .  bred);;bred: errors/html tag names
    ("eonos-orange"   .  ylw) ;;ylw : variables
    ("eonos-yellow"   .  bylw);;bylw: declarations/keywords (var, if, struct, for, while...)
    ("eonos-green+1"  .  grn) ;;grn : multiple greens mostly for jsdoc
    ("eonos-green"    .  bgrn);;bgrn: comments/packages
    ("eonos-cyan"     .  cyn) ;;cyn : function names, accessors
    ("eonos-blue"     .  blu) ;;blu : includes/preprocessor, object properties
    ("eonos-blue-1"   .  bblu);;bblu: data types
    ("eonos-magenta"  .  mag));;mag: practically useless (JS keywords)
  "List of Eonos colors."
  )

(defvar eonos-override-colors-alist
  '()
  "Place to override default theme colors.

You can override a subset of the theme's default colors by
defining them in this alist before loading the theme.")

(defvar eonos-colors-alist
  (append eonos-default-colors-alist eonos-override-colors-alist))

(defmacro eonos-with-color-variables (&rest body)
  "`let' bind all colors defined in `eonos-colors-alist' around BODY.
Also bind `class' to ((class color) (min-colors 89))."
  (declare (indent 0))
  `(let ((class '((class color) (min-colors 89)))
         ,@(mapcar (lambda (cons)
                     (list (intern (car cons)) (cdr cons)))
                   eonos-colors-alist))
     ,@body))

;;; Theme Faces
(eonos-with-color-variables
  (custom-theme-set-faces
   'eonos
;;;; Built-in
;;;;; basic coloring
   '(button ((t (:underline t))))
   `(link ((t (:foreground ,eonos-yellow :underline t :weight bold))))
   `(link-visited ((t (:foreground ,eonos-orange :underline t :weight normal))))
   `(default ((t (:foreground ,eonos-fg :background nil))))
   `(cursor ((t (:foreground ,eonos-fg :background ,eonos-fg))))
   `(escape-glyph ((t (:foreground ,eonos-yellow :weight bold))))
   `(fringe ((t (:foreground ,eonos-fg :background ,eonos-bg+1))))
   `(header-line ((t (:foreground ,eonos-yellow
                                  :background ,eonos-bg-1
                                  :box (:line-width -1 :style released-button)))))
   `(highlight ((t (:background ,eonos-bg-1))))
   `(success ((t (:foreground ,eonos-green :weight bold))))
   `(warning ((t (:foreground ,eonos-orange :weight bold))))
   `(tooltip ((t (:foreground ,eonos-fg :background ,eonos-bg+1))))
;;;;; compilation
   `(compilation-column-face ((t (:foreground ,eonos-yellow))))
   `(compilation-enter-directory-face ((t (:foreground ,eonos-green))))
   `(compilation-error-face ((t (:foreground ,eonos-red-1 :weight bold :underline t))))
   `(compilation-face ((t (:foreground ,eonos-fg))))
   `(compilation-info-face ((t (:foreground ,eonos-blue))))
   `(compilation-info ((t (:foreground ,eonos-green+1 :underline t))))
   `(compilation-leave-directory-face ((t (:foreground ,eonos-green))))
   `(compilation-line-face ((t (:foreground ,eonos-yellow))))
   `(compilation-line-number ((t (:foreground ,eonos-yellow))))
   `(compilation-message-face ((t (:foreground ,eonos-blue))))
   `(compilation-warning-face ((t (:foreground ,eonos-orange :weight bold :underline t))))
   `(compilation-mode-line-exit ((t (:foreground ,eonos-green :weight bold))))
   `(compilation-mode-line-fail ((t (:foreground ,eonos-red :weight bold))))
   `(compilation-mode-line-run ((t (:foreground ,eonos-yellow :weight bold))))
;;;;; completions
   `(completions-annotations ((t (:foreground ,eonos-fg))))
;;;;; grep
   `(grep-context-face ((t (:foreground ,eonos-fg))))
   `(grep-error-face ((t (:foreground ,eonos-red-1 :weight bold :underline t))))
   `(grep-hit-face ((t (:foreground ,eonos-blue))))
   `(grep-match-face ((t (:foreground ,eonos-orange :weight bold))))
   `(match ((t (:background ,eonos-bg-1 :foreground ,eonos-orange :weight bold))))
;;;;; info
   `(Info-quoted ((t (:inherit font-lock-constant-face))))
;;;;; isearch
   `(isearch ((t (:foreground ,eonos-orange :weight bold :background ,eonos-bg+1))))
   `(isearch-fail ((t (:foreground ,eonos-fg :background ,eonos-red-1))))
   `(lazy-highlight ((t (:foreground ,eonos-orange :weight bold :background ,eonos-bg-1))))

   `(menu ((t (:foreground ,eonos-fg :background ,eonos-bg))))
   `(minibuffer-prompt ((t (:foreground ,eonos-blue))))
   `(mode-line
     ((,class (:foreground ,eonos-green+1
                           :background ,eonos-bg-1
                           :box (:line-width -1 :style released-button)))
      (t :inverse-video t)))
   `(mode-line-buffer-id ((t (:foreground ,eonos-yellow :weight bold))))
   `(mode-line-inactive
     ((t (:foreground ,eonos-green+1
                      :background ,eonos-bg-1
                      :box (:line-width -1 :style released-button)))))
   `(region ((,class (:background ,eonos-bg-1))
             (t :inverse-video t)))
   `(secondary-selection ((t (:background ,eonos-bg+1))))
   `(trailing-whitespace ((t (:background ,eonos-red))))
   `(vertical-border ((t (:foreground ,eonos-fg))))
;;;;; font lock
   `(font-lock-builtin-face ((t (:foreground ,eonos-fg :weight bold))))
   `(font-lock-comment-face ((t (:foreground ,eonos-green))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,eonos-green+1))))
   `(font-lock-constant-face ((t (:foreground ,eonos-green+1))))
   `(font-lock-doc-face ((t (:foreground ,eonos-green))))
   `(font-lock-function-name-face ((t (:foreground ,eonos-cyan))))
   `(font-lock-keyword-face ((t (:foreground ,eonos-yellow :weight bold))))
   `(font-lock-negation-char-face ((t (:foreground ,eonos-yellow :weight bold))))
   `(font-lock-preprocessor-face ((t (:foreground ,eonos-blue))))
   `(font-lock-regexp-grouping-construct ((t (:foreground ,eonos-yellow :weight bold))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground ,eonos-green :weight bold))))
   `(font-lock-string-face ((t (:foreground ,eonos-red))))
   `(font-lock-type-face ((t (:foreground ,eonos-blue-1))))
   `(font-lock-variable-name-face ((t (:foreground ,eonos-orange))))
   `(font-lock-warning-face ((t (:foreground ,eonos-orange :weight bold))))

   `(c-annotation-face ((t (:inherit font-lock-constant-face))))
;;;; Third-party
;;;;; auctex
   `(font-latex-bold-face ((t (:inherit bold))))
   `(font-latex-warning-face ((t (:foreground nil :inherit font-lock-warning-face))))
   `(font-latex-sectioning-5-face ((t (:foreground ,eonos-red :weight bold ))))
   `(font-latex-sedate-face ((t (:foreground ,eonos-yellow))))
   `(font-latex-italic-face ((t (:foreground ,eonos-cyan :slant italic))))
   `(font-latex-string-face ((t (:inherit ,font-lock-string-face))))
   `(font-latex-math-face ((t (:foreground ,eonos-orange))))
;;;;; auto-complete
   `(ac-candidate-face ((t (:background ,eonos-bg+1 :foreground ,eonos-bg))))
   `(ac-selection-face ((t (:background ,eonos-blue :foreground ,eonos-fg))))
   `(popup-tip-face ((t (:background ,eonos-orange :foreground ,eonos-bg))))
   `(popup-menu-mouse-face ((t (:background ,eonos-orange :foreground ,eonos-bg))))
   `(popup-summary-face ((t (:background ,eonos-bg+1 :foreground ,eonos-bg))))
   `(popup-scroll-bar-foreground-face ((t (:background ,eonos-blue))))
   `(popup-scroll-bar-background-face ((t (:background ,eonos-bg-1))))
   `(popup-isearch-match ((t (:background ,eonos-bg :foreground ,eonos-fg))))
;;;;; context-coloring
   `(context-coloring-level-0-face ((t :foreground ,eonos-fg)))
   `(context-coloring-level-1-face ((t :foreground ,eonos-cyan)))
   `(context-coloring-level-2-face ((t :foreground ,eonos-green+1)))
   `(context-coloring-level-3-face ((t :foreground ,eonos-yellow)))
   `(context-coloring-level-4-face ((t :foreground ,eonos-orange)))
   `(context-coloring-level-5-face ((t :foreground ,eonos-magenta)))
   `(context-coloring-level-6-face ((t :foreground ,eonos-blue)))
   `(context-coloring-level-7-face ((t :foreground ,eonos-green)))
   `(context-coloring-level-8-face ((t :foreground ,eonos-orange)))
   `(context-coloring-level-9-face ((t :foreground ,eonos-red)))
;;;;; debbugs
   `(debbugs-gnu-done ((t (:foreground ,eonos-fg))))
   `(debbugs-gnu-handled ((t (:foreground ,eonos-green))))
   `(debbugs-gnu-new ((t (:foreground ,eonos-red))))
   `(debbugs-gnu-pending ((t (:foreground ,eonos-blue))))
   `(debbugs-gnu-stale ((t (:foreground ,eonos-orange))))
   `(debbugs-gnu-tagged ((t (:foreground ,eonos-red))))
;;;;; diff
   `(diff-added          ((t (:background "#335533" :foreground ,eonos-green))))
   `(diff-changed        ((t (:background "#555511" :foreground ,eonos-orange))))
   `(diff-removed        ((t (:background "#553333" :foreground ,eonos-red-1))))
   `(diff-refine-added   ((t (:background "#338833" :foreground ,eonos-green+1))))
   `(diff-refine-change  ((t (:background "#888811" :foreground ,eonos-yellow))))
   `(diff-refine-removed ((t (:background "#883333" :foreground ,eonos-red))))
   `(diff-header ((,class (:background ,eonos-bg+1))
                  (t (:background ,eonos-fg :foreground ,eonos-bg))))
   `(diff-file-header
     ((,class (:background ,eonos-bg+1 :foreground ,eonos-fg :weight bold))
      (t (:background ,eonos-fg :foreground ,eonos-bg :weight bold))))
;;;;; elfeed
   `(elfeed-log-error-level-face ((t (:foreground ,eonos-red))))
   `(elfeed-log-info-level-face ((t (:foreground ,eonos-blue))))
   `(elfeed-log-warn-level-face ((t (:foreground ,eonos-yellow))))
   `(elfeed-search-date-face ((t (:foreground ,eonos-orange :underline t
                                              :weight bold))))
   `(elfeed-search-tag-face ((t (:foreground ,eonos-green))))
   `(elfeed-search-feed-face ((t (:foreground ,eonos-cyan))))
;;;;; emacs-w3m
   `(w3m-anchor ((t (:foreground ,eonos-yellow :underline t
                                 :weight bold))))
   `(w3m-arrived-anchor ((t (:foreground ,eonos-orange
                                         :underline t :weight normal))))
   `(w3m-form ((t (:foreground ,eonos-red-1 :underline t))))
   `(w3m-header-line-location-title ((t (:foreground ,eonos-yellow
                                                     :underline t :weight bold))))
   '(w3m-history-current-url ((t (:inherit match))))
   `(w3m-lnum ((t (:foreground ,eonos-green :background ,eonos-bg))))
   `(w3m-lnum-match ((t (:background ,eonos-bg-1
                                     :foreground ,eonos-orange
                                     :weight bold))))
   `(w3m-lnum-minibuffer-prompt ((t (:foreground ,eonos-yellow))))
;;;;; erc
   `(erc-action-face ((t (:inherit erc-default-face))))
   `(erc-bold-face ((t (:weight bold))))
   `(erc-current-nick-face ((t (:foreground ,eonos-blue :weight bold))))
   `(erc-dangerous-host-face ((t (:inherit font-lock-warning-face))))
   `(erc-default-face ((t (:foreground ,eonos-fg))))
   `(erc-direct-msg-face ((t (:inherit erc-default-face))))
   `(erc-error-face ((t (:inherit font-lock-warning-face))))
   `(erc-fool-face ((t (:inherit erc-default-face))))
   `(erc-highlight-face ((t (:inherit hover-highlight))))
   `(erc-input-face ((t (:foreground ,eonos-blue))))
   `(erc-keyword-face ((t (:foreground ,eonos-red :weight bold))))
   `(erc-nick-default-face ((t (:foreground ,eonos-cyan :weight bold))))
   `(erc-my-nick-face ((t (:foreground ,eonos-red :weight bold))))
   `(erc-nick-msg-face ((t (:inherit erc-default-face))))
   `(erc-notice-face ((t (:foreground ,eonos-green))))
   `(erc-pal-face ((t (:foreground ,eonos-orange :weight bold))))
   `(erc-prompt-face ((t (:foreground ,eonos-magenta :background ,eonos-bg :weight bold))))
   `(erc-timestamp-face ((t (:foreground ,eonos-green+1))))
   `(erc-underline-face ((t (:underline t))))
;;;;; eshell
   `(eshell-prompt ((t (:foreground ,eonos-yellow :weight bold))))
   `(eshell-ls-archive ((t (:foreground ,eonos-red-1 :weight bold))))
   `(eshell-ls-backup ((t (:inherit font-lock-comment-face))))
   `(eshell-ls-clutter ((t (:inherit font-lock-comment-face))))
   `(eshell-ls-directory ((t (:foreground ,eonos-blue :weight bold))))
   `(eshell-ls-executable ((t (:foreground ,eonos-red :weight bold))))
   `(eshell-ls-unreadable ((t (:foreground ,eonos-fg))))
   `(eshell-ls-missing ((t (:inherit font-lock-warning-face))))
   `(eshell-ls-product ((t (:inherit font-lock-doc-face))))
   `(eshell-ls-special ((t (:foreground ,eonos-yellow :weight bold))))
   `(eshell-ls-symlink ((t (:foreground ,eonos-cyan :weight bold))))
;;;;; guide-key
   `(guide-key/highlight-command-face ((t (:foreground ,eonos-blue))))
   `(guide-key/key-face ((t (:foreground ,eonos-green))))
   `(guide-key/prefix-command-face ((t (:foreground ,eonos-green+1))))
;;;;; ido-mode
   `(ido-first-match ((t (:foreground ,eonos-yellow :weight bold))))
   `(ido-only-match ((t (:foreground ,eonos-orange :weight bold))))
   `(ido-subdir ((t (:foreground ,eonos-yellow))))
   `(ido-indicator ((t (:foreground ,eonos-yellow :background ,eonos-red-1))))
;;;;; js2-mode
   `(js2-warning ((t (:underline ,eonos-orange))))
   `(js2-error ((t (:foreground ,eonos-red :weight bold))))
   `(js2-jsdoc-tag ((t (:foreground ,eonos-green+1))))
   `(js2-jsdoc-type ((t (:foreground ,eonos-green))))
   `(js2-jsdoc-value ((t (:foreground ,eonos-green+1))))
   `(js2-function-param ((t (:foreground, eonos-cyan))))
   `(js2-external-variable ((t (:foreground ,eonos-blue))))
;;;;; additional js2 mode attributes for better syntax highlighting
   `(js2-instance-member ((t (:foreground ,eonos-green+1))))
   `(js2-jsdoc-html-tag-delimiter ((t (:foreground ,eonos-orange))))
   `(js2-jsdoc-html-tag-name ((t (:foreground ,eonos-red-1))))
   `(js2-object-property ((t (:foreground ,eonos-blue))))
   `(js2-magic-paren ((t (:foreground ,eonos-blue))))
   `(js2-private-function-call ((t (:foreground ,eonos-cyan))))
   `(js2-function-call ((t (:foreground ,eonos-cyan))))
   `(js2-private-member ((t (:foreground ,eonos-blue-1))))
   `(js2-keywords ((t (:foreground ,eonos-magenta))))
;;;;; linum-mode
   `(linum ((t (:foreground ,eonos-green :background ,eonos-bg))))
;;;;; lispy
   `(lispy-command-name-face ((t (:background ,eonos-bg-1 :inherit font-lock-function-name-face))))
   `(lispy-cursor-face ((t (:foreground ,eonos-bg :background ,eonos-fg))))
   `(lispy-face-hint ((t (:inherit highlight :foreground ,eonos-yellow))))
;;;;; ruler-mode
   `(ruler-mode-column-number ((t (:inherit 'ruler-mode-default :foreground ,eonos-fg))))
   `(ruler-mode-fill-column ((t (:inherit 'ruler-mode-default :foreground ,eonos-yellow))))
   `(ruler-mode-goal-column ((t (:inherit 'ruler-mode-fill-column))))
   `(ruler-mode-comment-column ((t (:inherit 'ruler-mode-fill-column))))
   `(ruler-mode-tab-stop ((t (:inherit 'ruler-mode-fill-column))))
   `(ruler-mode-current-column ((t (:foreground ,eonos-yellow :box t))))
   `(ruler-mode-default ((t (:foreground ,eonos-green :background ,eonos-bg))))
;;;;; macrostep
   `(macrostep-gensym-1
     ((t (:foreground ,eonos-green :background ,eonos-bg-1))))
   `(macrostep-gensym-2
     ((t (:foreground ,eonos-red :background ,eonos-bg-1))))
   `(macrostep-gensym-3
     ((t (:foreground ,eonos-blue :background ,eonos-bg-1))))
   `(macrostep-gensym-4
     ((t (:foreground ,eonos-magenta :background ,eonos-bg-1))))
   `(macrostep-gensym-5
     ((t (:foreground ,eonos-yellow :background ,eonos-bg-1))))
   `(macrostep-expansion-highlight-face
     ((t (:inherit highlight))))
   `(macrostep-macro-face
     ((t (:underline t))))
;;;;; message-mode
   `(message-cited-text ((t (:inherit font-lock-comment-face))))
   `(message-header-name ((t (:foreground ,eonos-green+1))))
   `(message-header-other ((t (:foreground ,eonos-green))))
   `(message-header-to ((t (:foreground ,eonos-yellow :weight bold))))
   `(message-header-cc ((t (:foreground ,eonos-yellow :weight bold))))
   `(message-header-newsgroups ((t (:foreground ,eonos-yellow :weight bold))))
   `(message-header-subject ((t (:foreground ,eonos-orange :weight bold))))
   `(message-header-xheader ((t (:foreground ,eonos-green))))
   `(message-mml ((t (:foreground ,eonos-yellow :weight bold))))
   `(message-separator ((t (:inherit font-lock-comment-face))))
;;;;; mic-paren
   `(paren-face-match ((t (:foreground ,eonos-cyan :background ,eonos-bg :weight bold))))
   `(paren-face-mismatch ((t (:foreground ,eonos-bg :background ,eonos-magenta :weight bold))))
   `(paren-face-no-match ((t (:foreground ,eonos-bg :background ,eonos-red :weight bold))))
;;;;; nav
   `(nav-face-heading ((t (:foreground ,eonos-yellow))))
   `(nav-face-button-num ((t (:foreground ,eonos-cyan))))
   `(nav-face-dir ((t (:foreground ,eonos-green))))
   `(nav-face-hdir ((t (:foreground ,eonos-red))))
   `(nav-face-file ((t (:foreground ,eonos-fg))))
   `(nav-face-hfile ((t (:foreground ,eonos-red-1))))
;;;;; outline
   `(outline-1 ((t (:foreground ,eonos-orange))))
   `(outline-2 ((t (:foreground ,eonos-green+1))))
   `(outline-3 ((t (:foreground ,eonos-blue-1))))
   `(outline-4 ((t (:foreground ,eonos-orange))))
   `(outline-5 ((t (:foreground ,eonos-cyan))))
   `(outline-6 ((t (:foreground ,eonos-green))))
   `(outline-7 ((t (:foreground ,eonos-red-1))))
   `(outline-8 ((t (:foreground ,eonos-blue))))
;;;;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground ,eonos-fg))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground ,eonos-green+1))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground ,eonos-orange))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground ,eonos-cyan))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground ,eonos-green))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground ,eonos-blue))))
   `(rainbow-delimiters-depth-7-face ((t (:foreground ,eonos-orange))))
   `(rainbow-delimiters-depth-8-face ((t (:foreground ,eonos-green+1))))
   `(rainbow-delimiters-depth-9-face ((t (:foreground ,eonos-blue))))
   `(rainbow-delimiters-depth-10-face ((t (:foreground ,eonos-orange))))
   `(rainbow-delimiters-depth-11-face ((t (:foreground ,eonos-green))))
   `(rainbow-delimiters-depth-12-face ((t (:foreground ,eonos-blue))))
;;;;; re-builder
   `(reb-match-0 ((t (:foreground ,eonos-bg :background ,eonos-magenta))))
   `(reb-match-1 ((t (:foreground ,eonos-bg :background ,eonos-blue))))
   `(reb-match-2 ((t (:foreground ,eonos-bg :background ,eonos-orange))))
   `(reb-match-3 ((t (:foreground ,eonos-bg :background ,eonos-red))))
;;;;; regex-tool
   `(regex-tool-matched-face ((t (:background ,eonos-blue :weight bold))))
;;;;; sh-mode
   `(sh-heredoc     ((t (:foreground ,eonos-yellow :weight bold))))
   `(sh-quoted-exec ((t (:foreground ,eonos-red))))
;;;;; show-paren
   `(show-paren-mismatch ((t (:foreground ,eonos-red :background ,eonos-bg+1 :weight bold))))
   `(show-paren-match ((t (:background ,eonos-bg+1 :weight bold))))
;;;;; smart-mode-line
   ;; use (setq sml/theme nil) to enable Eonos for sml
   `(sml/global ((,class (:foreground ,eonos-fg :weight bold))))
   `(sml/modes ((,class (:foreground ,eonos-yellow :weight bold))))
   `(sml/minor-modes ((,class (:foreground ,eonos-fg :weight bold))))
   `(sml/filename ((,class (:foreground ,eonos-cyan :weight bold))))
   `(sml/line-number ((,class (:foreground ,eonos-blue :weight bold))))
   `(sml/col-number ((,class (:foreground ,eonos-blue :weight bold))))
   `(sml/position-percentage ((,class (:foreground ,eonos-blue-1 :weight bold))))
   `(sml/prefix ((,class (:foreground ,eonos-green))))
   `(sml/git ((,class (:foreground ,eonos-green+1))))
   `(sml/process ((,class (:weight bold))))
   `(sml/sudo ((,class  (:foreground ,eonos-orange :weight bold))))
   `(sml/read-only ((,class (:foreground ,eonos-red-1))))
   `(sml/outside-modified ((,class (:foreground ,eonos-blue))))
   `(sml/modified ((,class (:foreground ,eonos-red))))
   `(sml/vc-edited ((,class (:foreground ,eonos-green))))
   `(sml/charging ((,class (:foreground ,eonos-green+1))))
   `(sml/discharging ((,class (:foreground ,eonos-red))))
;;;;; smartparens
   `(sp-show-pair-mismatch-face ((t (:foreground ,eonos-red :background ,eonos-bg+1 :weight bold))))
   `(sp-show-pair-match-face ((t (:background ,eonos-bg+1 :weight bold))))
;;;;; sml-mode-line
   '(sml-modeline-end-face ((t :inherit default :width condensed)))
;;;;; SLIME
   `(slime-repl-output-face ((t (:foreground ,eonos-red))))
   `(slime-repl-inputed-output-face ((t (:foreground ,eonos-green))))
   `(slime-error-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,eonos-red)))
      (t
       (:underline ,eonos-red))))
   `(slime-warning-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,eonos-orange)))
      (t
       (:underline ,eonos-orange))))
   `(slime-style-warning-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,eonos-yellow)))
      (t
       (:underline ,eonos-yellow))))
   `(slime-note-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,eonos-green)))
      (t
       (:underline ,eonos-green))))
   `(slime-highlight-face ((t (:inherit highlight))))
;;;;; Web-mode
   `(web-mode-builtin-face ((t (:inherit ,font-lock-builtin-face))))
   `(web-mode-comment-face ((t (:inherit ,font-lock-comment-face))))
   `(web-mode-constant-face ((t (:inherit ,font-lock-constant-face))))
   `(web-mode-css-at-rule-face ((t (:foreground ,eonos-blue ))))
   `(web-mode-css-prop-face ((t (:foreground ,eonos-blue-1))))
   `(web-mode-css-pseudo-class-face ((t (:foreground ,eonos-green+1 :weight bold))))
   `(web-mode-css-rule-face ((t (:foreground ,eonos-blue))))
   `(web-mode-doctype-face ((t (:inherit ,font-lock-comment-face))))
   `(web-mode-folded-face ((t (:underline t))))
   `(web-mode-function-name-face ((t (:foreground ,eonos-blue))))
   `(web-mode-html-attr-name-face ((t (:foreground ,eonos-blue-1))))
   `(web-mode-html-attr-value-face ((t (:inherit ,font-lock-string-face))))
   `(web-mode-html-tag-face ((t (:foreground ,eonos-cyan))))
   `(web-mode-keyword-face ((t (:inherit ,font-lock-keyword-face))))
   `(web-mode-preprocessor-face ((t (:inherit ,font-lock-preprocessor-face))))
   `(web-mode-string-face ((t (:inherit ,font-lock-string-face))))
   `(web-mode-type-face ((t (:inherit ,font-lock-type-face))))
   `(web-mode-variable-name-face ((t (:inherit ,font-lock-variable-name-face))))
   `(web-mode-server-background-face ((t (:background ,eonos-bg))))
   `(web-mode-server-comment-face ((t (:inherit web-mode-comment-face))))
   `(web-mode-server-string-face ((t (:inherit web-mode-string-face))))
   `(web-mode-symbol-face ((t (:inherit font-lock-constant-face))))
   `(web-mode-warning-face ((t (:inherit font-lock-warning-face))))
   `(web-mode-whitespaces-face ((t (:background ,eonos-red))))
;;;;; whitespace-mode
   `(whitespace-space ((t (:background ,eonos-bg+1 :foreground ,eonos-bg+1))))
   `(whitespace-hspace ((t (:background ,eonos-bg+1 :foreground ,eonos-bg+1))))
   `(whitespace-tab ((t (:background ,eonos-red-1))))
   `(whitespace-newline ((t (:foreground ,eonos-bg+1))))
   `(whitespace-trailing ((t (:background ,eonos-red))))
   `(whitespace-line ((t (:background ,eonos-bg :foreground ,eonos-magenta))))
   `(whitespace-space-before-tab ((t (:background ,eonos-orange :foreground ,eonos-orange))))
   `(whitespace-indentation ((t (:background ,eonos-yellow :foreground ,eonos-red))))
   `(whitespace-empty ((t (:background ,eonos-yellow))))
   `(whitespace-space-after-tab ((t (:background ,eonos-yellow :foreground ,eonos-red))))
;;;;; which-func-mode
   `(which-func ((t (:foreground ,eonos-green+1))))
   ))

;;; Theme Variables
(eonos-with-color-variables
  (custom-theme-set-variables
   'eonos
;;;;; ansi-color
   `(ansi-color-names-vector [,eonos-bg ,eonos-red ,eonos-green ,eonos-yellow
                                          ,eonos-blue ,eonos-magenta ,eonos-cyan ,eonos-fg])
;;;;; fill-column-indicator
   `(fci-rule-color ,eonos-bg-1)
;;;;; pdf-tools
   `(pdf-view-midnight-colors '(,eonos-fg . ,eonos-bg-1))
   ))

;;; Rainbow Support

(declare-function rainbow-mode 'rainbow-mode)
(declare-function rainbow-colorize-by-assoc 'rainbow-mode)

(defvar eonos-add-font-lock-keywords nil
  "Whether to add font-lock keywords for eonos color names.
In buffers visiting library `eonos-theme.el' the eonos
specific keywords are always added.  In all other Emacs-Lisp
buffers this variable controls whether this should be done.
This requires library `rainbow-mode'.")

(defvar eonos-colors-font-lock-keywords nil)

;; (defadvice rainbow-turn-on (after eonos activate)
;;   "Maybe also add font-lock keywords for eonos colors."
;;   (when (and (derived-mode-p 'emacs-lisp-mode)
;;              (or eonos-add-font-lock-keywords
;;                  (equal (file-name-nondirectory (buffer-file-name))
;;                         "eonos-theme.el")))
;;     (unless eonos-colors-font-lock-keywords
;;       (setq eonos-colors-font-lock-keywords
;;             `((,(regexp-opt (mapcar 'car eonos-colors-alist) 'words)
;;                (0 (rainbow-colorize-by-assoc eonos-colors-alist))))))
;;     (font-lock-add-keywords nil eonos-colors-font-lock-keywords)))

;; (defadvice rainbow-turn-off (after eonos activate)
;;   "Also remove font-lock keywords for eonos colors."
;;   (font-lock-remove-keywords nil eonos-colors-font-lock-keywords))

;;; Footer

;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(provide-theme 'eonos)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; eval: (when (require 'rainbow-mode nil t) (rainbow-mode 1))
;; End:
;;; eonos-theme.el ends here
