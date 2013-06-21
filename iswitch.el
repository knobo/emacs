
;; '(iswitchb-mode t)

(defun iswitchb-cycle ()
  (interactive)
  (iswitchb-next-match)
  (display-buffer (first iswitchb-buflist) t))


(defun iswitchb-kill-buffer ()
  (interactive)
  (kill-buffer (first iswitchb-buflist))
  (setq iswitchb-buflist (rest iswitchb-buflist))
  (display-buffer (first iswitchb-buflist) t)
  (setq iswitchb-rescan t))

(eval-after-load 
    "iswitchb"
  '(add-hook 'iswitchb-define-mode-map-hook
             (lambda ()
               (define-key iswitchb-mode-map (kbd "M-c") 'iswitchb-cycle)
               (define-key iswitchb-mode-map (kbd "M-q") 'iswitchb-kill-buffer))))
               
