(defun get-key-combo (key)
  "Just return the key combo entered by the user"
  (interactive "kKey combo: ")
  key)

;;; Maybe this is better:
;;; (with-selected-window (minibuffer-window) (read-key-sequence-vector "Enter key combo: " nil t t t))
  

(defun keymap-unset-key (key keymap)
    "Remove binding of KEY in a keymap
    KEY is a string or vector representing a sequence of keystrokes."
    (interactive
     (list (call-interactively #'get-key-combo)
           (completing-read "Which map: " minor-mode-map-alist nil t)))
    (let ((map (rest (assoc (intern keymap) minor-mode-map-alist))))
      (when map
        (define-key map key nil)
        (message  "%s unbound for %s" key keymap))))
        
        
;;; Example: 

;(keymap-unset-key  '[C-M-left]   "paredit-mode")
;; Will remove the [C-M-left] keybinding from paredit-mode
;; (I use the C/M-{} keys insted)
;; Maybe there is another better way of doign this, but I just made this as fast as looking for any other solution
