
;; (iswitchb-mode)

(defun iswitchb-cycle ()
  (interactive)
  (iswitchb-next-match)
  (display-buffer (first iswitchb-buflist) t))

(defun iswitchb-kill-buffer-display ()
  (interactive)
  (iswitchb-kill-buffer)
  (if (> (length iswitchb-matches) 1)
      (display-buffer (second iswitchb-matches) t))
  (setq iswitchb-rescan t))

(defun iswitchb-exclude-nonmatching()
    "Make iswitchb work on only the currently matching names."
    (interactive)
    (setq iswitchb-buflist iswitchb-matches)
    (setq iswitchb-rescan t)
    (delete-minibuffer-contents))

(eval-after-load 
    "iswitchb"
  '(add-hook 'iswitchb-define-mode-map-hook
             (lambda ()
               (define-key iswitchb-mode-map (kbd "M-c") 'iswitchb-cycle)
               (define-key iswitchb-mode-map (kbd "M-q") 'iswitchb-kill-buffer-display)
	       (define-key iswitchb-mode-map (kbd "M-o") 'iswitchb-exclude-nonmatching))))
