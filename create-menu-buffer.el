					; https://github.com/ch11ng/exwm/wiki/Configuration-Example
					; https://github.com/timor/spacemacsOS/blob/master/files/exwm-start
					; https://github.com/ch11ng/exwm/wiki/EXWM-User-Guide


(defun button-pressed (button)
  (message (format "Button pressed!"))
  (kill-buffer (current-buffer)))
button-pressed



(define-button-type 'custom-button
  'action 'button-pressed
  'follow-link t
  'help-echo "Click Button"
  'help-args "test")

(defun test ()
  (setq mybuf (get-buffer-create "foo"))
 
  (with-current-buffer mybuf
    (erase-buffer)
    (insert-button "tssssest1" :type 'custom-button)
    ;(read-only-mode)
    )
  
  (display-buffer mybuf)
)


(test)
