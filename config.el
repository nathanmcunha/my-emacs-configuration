(add-to-list 'load-path "~/.config/emacs/scripts/")

(require 'elpaca-setup)
;;(require 'buffer-move)
;;(require 'app-launcher)

;; Expands to: (elpaca evil (use-package evil :demand t))
(use-package evil
    :init      ;; tweak evil's configuration before loading it
    (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
    (setq evil-want-keybinding nil)
    (setq evil-vsplit-window-right t)
    (setq evil-split-window-below t)
    (evil-mode))
  (use-package evil-collection
    :after evil
    :config
    (setq evil-collection-mode-list '(dashboard dired ibuffer))
    (evil-collection-init))
  (use-package evil-tutor)

(use-package general
    :config
    (general-evil-setup)

    ;; set up 'SPC' as the global leader key
    (general-create-definer nathan/leader-keys
      :states '(normal insert visual emacs)
      :keymaps 'override
      :prefix "SPC" ;; set leader
      :global-prefix "M-SPC") ;; access leader in insert mode

    (nathan/leader-keys
    "SPACE" '(:ignore t :wk "buffer")
      "." '(find-file :wk "Find file")
      "f c" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Edit emacs config")
      "f r" '(counsel-recentf :wk "Find recent files")
      "TAB TAB" '(comment-line :wk "Comment lines"))

    (nathan/leader-keys
      "b" '(:ignore t :wk "buffer")
      "b b" '(consult-buffer :wk "Switch buffer")
      "b i" '(ibuffer :wk "Ibuffer")
      "b k" '(kill-this-buffer :wk "Kill this buffer")
      "b n" '(next-buffer :wk "Next buffer")
      "b p" '(previous-buffer :wk "Previous buffer")
      "b r" '(revert-buffer :wk "Reload buffer"))

    (nathan/leader-keys
      "e" '(:ignore t :wk "Eshell/Evaluate")    
      "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
      "e d" '(eval-defun :wk "Evaluate defun containing or after point")
      "e e" '(eval-expression :wk "Evaluate and elisp expression")
      "e h" '(counsel-esh-history :which-key "Eshell history")
      "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
      "e r" '(eval-region :wk "Evaluate elisp in region")
      "e s" '(eshell :which-key "Eshell"))

   (nathan/leader-keys
      "h" '(:ignore t :wk "Help")
      "h f" '(describe-function :wk "Describe function")
      "h v" '(describe-variable :wk "Describe variable")
      ;;"H r r" '((lambda () (interactive) (load-file "~/.config/emacs/init.el")) :wk "Reload emacs config"))
      "h r r" '(reload-init-file :wk "Reload emacs config"))

    (nathan/leader-keys
      "m" '(:ignore t :wk "Org")
      "m a" '(org-agenda :wk "Org agenda")
      "m e" '(org-export-dispatch :wk "Org export dispatch")
      "m i" '(org-toggle-item :wk "Org toggle item")
      "m t" '(org-todo :wk "Org todo")
      "m B" '(org-babel-tangle :wk "Org babel tangle")
      "m T" '(org-todo-list :wk "Org todo list"))

    (nathan/leader-keys
      "m b" '(:ignore t :wk "Tables")
      "m b -" '(org-table-insert-hline :wk "Insert hline in table"))

    (nathan/leader-keys
      "m d" '(:ignore t :wk "Date/deadline")
      "m d t" '(org-time-stamp :wk "Org time stamp"))

    (nathan/leader-keys
      "p" '(projectile-command-map :wk "Projectile"))

    (nathan/leader-keys
      "t" '(:ignore t :wk "Toggle")
      "t e" '(eshell-toggle :wk "Toggle eshell")
      "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
      "t t" '(visual-line-mode :wk "Toggle truncated lines")
      "t v" '(vterm-toggle :wk "Toggle vterm"))

    (nathan/leader-keys
      "w" '(:ignore t :wk "Windows")
      ;; Window splits
      "w c" '(evil-window-delete :wk "Close window")
      "w n" '(evil-window-new :wk "New window")
      "w s" '(evil-window-split :wk "Horizontal split window")
      "w v" '(evil-window-vsplit :wk "Vertical split window")
      ;; Window motions
      "w h" '(evil-window-left :wk "Window left")
      "w j" '(evil-window-down :wk "Window down")
      "w k" '(evil-window-up :wk "Window up")
      "w l" '(evil-window-right :wk "Window right")
      "w w" '(evil-window-next :wk "Goto next window")
      ;; Move Windows
      "w H" '(buf-move-left :wk "Buffer move left")
      "w J" '(buf-move-down :wk "Buffer move down")
      "w K" '(buf-move-up :wk "Buffer move up")
      "w L" '(buf-move-right :wk "Buffer move right"))

    (nathan/leader-keys 
  "o" '(:ignore t)
  "o t" '(treemacs-add-and-display-current-directory
))
  )

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))
(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(use-package diminish)

(use-package flycheck
  :ensure t
  :defer t
  :diminish
  :init (global-flycheck-mode))

(set-face-attribute 'default nil
  :font "JetBrains Mono"
  :height 110
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "Ubuntu"
  :height 120
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "JetBrains Mono"
  :height 110
  :weight 'medium)
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "JetBrains Mono-11"))

;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(use-package company
  :defer 2
  :diminish
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "/home/dt/.config/emacs/images/emacs-dash.png")  ;; use custom image as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  :custom
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

;; Enable vertico
  (use-package vertico
  :ensure t
    :bind
(:map vertico-map 
         ("C-j" . vertico-next) 
         ("C-k" . vertico-previous) 

)
    :init
    (vertico-mode)
    ;; Different scroll margin
    ;; (setq vertico-scroll-margin 0)

    ;; Show more candidates
    ;; (setq vertico-count 20)

    ;; Grow and shrink the Vertico minibuffer
     (setq vertico-resize t)

    ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
     (setq vertico-cycle t)
    )

;; Optionally use the `orderless' completion style.
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
:ensure t
      :bind (("C-s" . consult-line)
             ("C-M-l" . consult-imenu)
             ("C-M-j" . persp-switch-to-buffer*)
             :map minibuffer-local-map
             ("C-r" . consult-history))
      :config
      (consult-preview-mode))

(use-package marginalia
      :after vertico
      :ensure t
:custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))    
:init
      (marginalia-mode))

    (use-package embark
      :ensure t
      :bind
      (("C-." . embark-act)         ;; pick some comfortable binding
       ("C-;" . embark-dwim)        ;; good alternative: M-.
       ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
      :init
      ;; Optionally replace the key help with a completing-read interface
      (setq prefix-help-command #'embark-prefix-help-command)

      ;; Show the Embark target at point via Eldoc. You may adjust the
      ;; Eldoc strategy, if you want to see the documentation from
      ;; multiple providers. Beware that using this can be a little
      ;; jarring since the message shown in the minibuffer can be more
      ;; than one line, causing the modeline to move up and down:

      ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
      ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

      :config

      ;; Hide the mode line of the Embark live/completions buffers
      (add-to-list 'display-buffer-alist
                   '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                     nil
                     (window-parameters (mode-line-format . none)))))

    ;; Consult users will also want the embark-consult package.
    (use-package embark-consult
      :ensure t ; only need to install it, embark loads it after consult if found
      :hook
      (embark-collect-mode . consult-preview-at-point-mode))



(global-set-key [escape] 'keyboard-escape-quit)

(use-package minions
  :hook (doom-modeline-mode . minions-mode))

(use-package doom-modeline
  :after eshell     ;; Make sure it gets hooked after eshell
  :hook (after-init . doom-modeline-init)
  :custom-face
  (mode-line ((t (:height 0.85))))
  (mode-line-inactive ((t (:height 0.85))))
  :custom
  (doom-modeline-height 15)
  (doom-modeline-bar-width 6)
  (doom-modeline-lsp t)
  (doom-modeline-github nil)
  (doom-modeline-minor-modes t)
  (doom-modeline-persp-name nil)
  (doom-modeline-buffer-file-name-style 'truncate-except-project)
  (doom-modeline-major-mode-icon nil))

(global-set-key [escape] 'keyboard-escape-quit)

(use-package toc-org
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(electric-indent-mode -1)

(require 'org-tempo)

(use-package rainbow-mode
  :hook 
  ((org-mode prog-mode) . rainbow-mode))
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package projectile
  :config
  (projectile-mode 1))

(defun reload-init-file ()
  (interactive)
  (load-file user-init-file)
  (load-file user-init-file))

(use-package eshell-syntax-highlighting
    :after esh-mode
    :config
    (eshell-syntax-highlighting-global-mode +1))

  ;; eshell-syntax-highlighting -- adds fish/zsh-like syntax highlighting.
  ;; eshell-rc-script -- your profile for eshell; like a bashrc for eshell.
  ;; eshell-aliases-file -- sets an aliases file for the eshell.

   ;; eshell-rc-script (concat user-emacs-directory "eshell/profile")
   ;;      eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
   ;; (se
(setq   eshell-history-size 5000
        eshell-buffer-maximum-lines 5000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t
        eshell-destroy-buffer-when-process-dies t
        eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))

;; (use-package vterm
;; :config
;; (setq shell-file-name "/bin/zsh"
;;       vterm-max-scrollback 5000))

;; (use-package vterm-toggle
;;   :after vterm
;;  :config
;;   (setq vterm-toggle-fullscreen-p nil)
;;   (setq vterm-toggle-scope 'project)
;;   (add-to-list 'display-buffer-alist
;;                '((lambda (buffer-or-name _)
;;                      (let ((buffer (get-buffer buffer-or-name)))
;;                        (with-current-buffer buffer
;;                          (or (equal major-mode 'vterm-mode)
;;                              (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
;;                   (display-buffer-reuse-window display-buffer-at-bottom)
;;                   ;;(display-buffer-reuse-window display-buffer-in-direction)
;;                   ;;display-buffer-in-direction/direction/dedicated is added in emacs27
;;                   ;;(direction . bottom)
;;                   ;;(dedicated . t) ;dedicated is supported in emacs27
;;                   (reusable-frames . visible)
;;                   (window-height . 0.3))))

(use-package sudo-edit
  :config
    (nathan/leader-keys
      "fu" '(sudo-edit-find-file :wk "Sudo find file")
      "fU" '(sudo-edit :wk "Sudo edit file")))

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
(load-theme 'light-kiss t)

(use-package which-key
  :init
    (which-key-mode 1)
  :config
  (setq which-key-side-window-location 'bottom
	which-key-sort-order #'which-key-key-order-alpha
	which-key-sort-uppercase-first nil
	which-key-add-column-padding 1
	which-key-max-display-columns nil
	which-key-min-display-lines 6
	which-key-side-window-slot -10
	which-key-side-window-max-height 0.25
	which-key-idle-delay 0.8
	which-key-max-description-length 25
	which-key-allow-imprecise-window-fit t
	which-key-separator " → " ))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))
