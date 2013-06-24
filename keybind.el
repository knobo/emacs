(defun get-key-combo (key)
  "Just return the key combo entered by the user"
  (interactive "kKey combo: ")
  key)

;;; Maybe this is better:
;;; (with-selected-window (minibuffer-window) (read-key-sequence-vector "Enter key combo: " nil t t t))
  

;;(defun keymap-unset-key (key keymap)
;;    "Remove binding of KEY in a keymap
;;    KEY is a string or vector representing a sequence of keystrokes."
;;    (interactive
;;     (list (call-interactively #'get-key-combo)
;;           (completing-read "Which map: " minor-mode-map-alist nil t)))
;;    (let ((map (rest (assoc (intern keymap) minor-mode-map-alist))))
;;      (when map
;;        (define-key map key nil)
;;        (message  "%s unbound for %s" key keymap))))
        

(defun keymap-symbol (keymap)
  "Return the symbol to which KEYMAP is bound, or nil ifn o such symbol exists."
  (catch 'gotit
    (mapatoms (lambda (sym)
                (and (boundp sym)
                     (eq (symbol-value sym) keymap)
                     (not (eq sym 'keymap))
                     (throw 'gotit sym))))))


(defun keymaps-with-key (key)
  (reduce 
   (lambda (rest map) 
     (if (lookup-key (rest map) key)
	 (list* (first map) rest)
       rest))
   minor-mode-map-alist
   :initial-value nil))

(defun completing-read-symbol (prompt collection)
"Collection takes a list of symbols. (not an alist)"
  (intern (completing-read prompt (mapcar (lambda (name) (cons (symbol-name name) nil)) collection) nil t)))

(defun keymap-unset-key (key keymap)
  "Remove binding of KEY in a KEYMAP
KEY is a string or vector representing a sequence of keystrokes."
  (interactive
   (let ((key (with-selected-window (minibuffer-window)
		 (read-key-sequence-vector "Enter key combo: " nil t t t))))
     (list key (completing-read-symbol "Which map: " (keymaps-with-key key)))))
  (let ((map (rest (assoc keymap minor-mode-map-alist))))
    (if map
	(progn 
	  (define-key map key nil)
	  (message "%s unbound for %s" key keymap))
      (message "no key binding %s for keymap %s" key keymap))))



;;; Example: 

;(keymap-unset-key  '[C-M-left]   "paredit-mode")
;; Will remove the [C-M-left] keybinding from paredit-mode
;; (I use the C/M-{} keys insted)
;; Maybe there is another better way of doign this, but I just made this as fast as looking for any other solution
