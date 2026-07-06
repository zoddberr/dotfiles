;; -*- lexical-binding: t; -*-

;; BASIC SETTINGS
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)

(blink-cursor-mode -1)

(setq ring-bell-function 'ignore)

;; For the very first frame
(add-to-list 'initial-frame-alist '(font . "UbuntuMono Nerd Font-15"))

;; For all subsequent frames you open (e.g., emacsclient)
(add-to-list 'default-frame-alist '(font . "UbuntuMono Nerd Font-15"))

;; redirect automatic UI customizations to a separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; no junk files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; smooth scrolling
(setq scroll-margin 8)
(setq scroll-conservatively 101)

;; enable line numbers globally
(global-display-line-numbers-mode t)

;; automatically reload files if they change
(global-auto-revert-mode t)

(setq split-window-preferred-direction 'right)

;; PACKAGE MANAGER
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))

;; ensure that every package we define later is automatically downloaded
(setq use-package-always-ensure t)

;; CUSTOM FUNCTIONS
(defun my/anki-insert-flat-german-note ()
"Insert a flat German-Reading note structure using direct field properties."
(interactive)
(let ((word (read-string "German Word (Front): "))
	(translation (read-string "Translation (Back): "))
	(sentence (read-string "Example Sentence (Sentence): ")))
    (insert (format "*** %s\n" word))
    (insert ":PROPERTIES:\n")
    (insert (format ":ANKI_DECK: %s\n" anki-editor-default-deck))
    (insert ":ANKI_NOTE_TYPE: German-Reading\n")
    (insert (format ":ANKI_FIELD_SENTENCE: %s\n" sentence))
    (insert ":END:\n")
    (insert (format "%s\n" translation))))

(defun my/reload-theme ()
(interactive)
(disable-theme 'voidstar)
(load-file (expand-file-name "themes/voidstar-theme.el" user-emacs-directory))
(load-theme 'voidstar t))

(global-set-key (kbd "<f5>") 'my/reload-theme)

;; EVIL MODE
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :init
  (setq evil-collection-key-blacklist '("SPC"))
  :config
  (evil-collection-init))

;; THEME
(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
(load-theme 'modus-vivendi t)

;; BINDINGS
(use-package general
  :after evil
  :config
  (general-create-definer my/bindings
			  :keymaps '(normal visual emacs)
			  :prefix "SPC"
			  :global-prefix "C-SPC"
			  :override t)
  (my/bindings

   ;; files
   "f" 'find-file

   ;; search
   "s" 'consult-line
   "g" 'consult-grep

   ;; buffers
   "bb" 'consult-buffer
   "bd" 'kill-current-buffer
   "bn" 'next-buffer
   "bp" 'previous-buffer

   ;; windows
   "wv" 'split-window-right
   "ws" 'split-window-below

   "wd" 'delete-window
   "wo" 'delete-other-windows
   
   "wh" 'evil-window-left
   "wj" 'evil-window-down
   "wk" 'evil-window-up
   "wl" 'evil-window-right

   "wH" 'evil-window-move-far-left
   "wJ" 'evil-window-move-very-bottom
   "wK" 'evil-window-move-very-top
   "wL" 'evil-window-move-far-right

   ;; passwords (pass)
   "py" 'password-store-copy
   "pg" 'password-store-generate-no-symbols
   "pe" 'password-store-edit

   ;; compile / code
   "cc" 'compile
   "cr" 'recompile
   "ck" 'kill-compilation

   ;; dired
   "dj" 'dired-jump
   :major-modes 'dired-mode
   "r" 'wdired-change-to-wdired-mode

   ;; org
   "na" 'org-agenda
   "nc" 'org-capture

   ;; anki
   :major-modes 'org-mode
   "ai" 'my/anki-insert-flat-german-note
   "ap" 'anki-editor-push-notes))

;; MINIBUFFER
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package vertico
  :init
  (vertico-mode 1)

  :custom
  (vertico-cycle t)

  :config
  (define-key vertico-map (kbd "C-j") 'vertico-next)
  (define-key vertico-map (kbd "C-k") 'vertico-previous)

  (define-key vertico-map (kbd "DEL") #'vertico-directory-delete-char))

(use-package marginalia
  :init
  (marginalia-mode 1))

(use-package consult
  :after vertico)

;; CORFU
(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.2)
  (corfu-auto-prefix 2)
  (corfu-quit-no-match t)
  (corfu-cycle t)
  :init
  (global-corfu-mode))

;; PASS
(use-package pass)

;; ask for encryption password inside emacs
(setq epa-pinentry-mode 'loopback)

;; DIRED
(use-package dired
  :ensure nil
  :custom
  (dired-listing-switches "-alh --group-directories-first")
  (dired-kill-when-opening-new-dired-buffer t)
  (dired-dwim-target t))

;; ORG MODE
(use-package org
  :ensure nil
  :custom

  (org-directory "~/Notes/")
  (org-agenda-files '("~/Notes/agenda.org"
		      "~/Notes/habits.org"))
  (org-default-notes-file "~/Notes/inbox.org")
  
  (org-startup-indented t)
  (org-hide-leading-stars t)
  (org-hide-emphasis-markers t)
  (org-startup-folded 'content))

(with-eval-after-load 'org
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-show-habits t)
  (setq org-return-follows-link t)

  (setq org-preview-latex-default-process 'dvisvgm)
  (plist-put org-format-latex-options :scale 1.8)
  (setq org-startup-with-latex-preview t)

  (setq org-capture-templates
	'(("t" "Task" :entry
	   (file+headline "~/Notes/inbox.org" "Inbox")
	   "* TODO %?\n %U"))))

(use-package org-fragtog
  :ensure t
  :after org
  :hook (org-mode . org-fragtog-mode))

(use-package org-bullets
  :after org
  :custom
  (org-bullets-bullet-list '("§" "*" "*" "*" "*" "*"))
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; anki integration
(use-package anki-editor
  :after org
  :config
  (setq anki-editor-default-deck "German-Wordlist"))

;; MAGIT
(use-package magit
  :commands magit-status)

;; PDF-TOOLS
(use-package pdf-tools
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page)
  :hook
  (pdf-view-mode . (lambda ()
                     (display-line-numbers-mode -1))))

;;;; C
;;(defun my/c-mode-setup()
;;  (c-set-style "linux"))
;;
;;(add-hook 'c-mode-hook #'my/c-mode-setup)
;;(add-hook 'c-mode-hook #'eglot-ensure)
;;
;;(use-package eglot
;;  :ensure nil
;;  :custom
;;  (eglot-autoshutdown t)
;;  (eglot-ignored-server-capabilities '(:inlayHintProvider
;;				       :documentFormattingProvider
;;				       :documentRangeFormattingProvider
;;				       :documentOnTypeFormattingProvider)))

;; C
(setq c-default-style '((c-mode . "linux")
                        (c++-mode . "linux")
                        (other . "gnu")))
(use-package citre
  :init
  (require 'citre-config)
  :config
  (add-hook 'find-file-hook #'citre-auto-enable-citre-mode))

(electric-pair-mode 1)

(use-package eglot
  :ensure nil
  :hook ((c-mode c++-mode) . eglot-ensure)
  :custom
  (eglot-autoshutdown t)
  (eglot-ignored-server-capabilities
   '(:inlayHintProvider
     :documentFormattingProvider
     :documentRangeFormattingProvider
     :documentOnTypeFormattingProvider))
  :config
  (add-to-list
   'eglot-server-programs
   '((c-mode c++-mode)
     . ("clangd"
        "--background-index"
        "--header-insertion=never"
        "--clang-tidy"))))

(add-to-list 'display-buffer-alist
	     '("\\*compilation\\*"
	       (display-buffer-reuse-window display-buffer-at-bottom)
	       (window-height . 0.25)))
