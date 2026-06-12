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
(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-hard t)) 

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

;; ORG MODE
(use-package org
  :ensure nil
  :custom
  (org-startup-indented t)
  (org-hide-leading-stars t)
  (org-hide-emphasis-markers t)
  (org-startup-folded 'content))

;; anki integration
(use-package anki-editor
  :after org
  :config
  (setq anki-editor-default-deck "German-Wordlist"))

