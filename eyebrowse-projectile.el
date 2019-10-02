;;; eyebrowse-projectile -- summary

;;; Commentary:
;; eyebrowse tag match projectile uuid or something
;; map eyebrowse to one project
;; map project to multiple eyebrowse

;;; Code:
(require 'projectile)
(require 'eyebrowse)

(setq projmap '())

;; Projectile hooks
(add-hook 'projectile-before-switch-project-hook
          (lambda ()
            (eyebrowse-create-window-config)))

(add-hook 'projectile-after-switch-project-hook
          (lambda ()
            (eyebrowse-rename-window-config
             (eyebrowse--get 'current-slot)
             (projectile-project-name))))

(defun eyebrowse-projectile-delete-window ()
  "On single window remove eyebrowse kill project."
  (interactive)
  (if (eq 1 (count-windows))
      (eyebrowse-close-window-config)
    (delete-window))
  )

(defun eyebrowse-projectile-kill-buffer-and-window ()
  "On single window remove eyebrowse and kill project."
  (interactive)
  (if (eq 1 (count-windows))
      (eyebrowse-close-window-config)
    (kill-buffer-and-window)))


;; Eyebrowse hooks
;; Eyebrowse adivce
(defun eyebrowse-projectile-remove-project ()
  "Function remove projectile window on kill project."
  ;; check if projectile has that project
  ;; if not then skip, if present then present menu
  (if (string-equal
       (projectile-project-name)
       (nth 2 (assoc (eyebrowse--get 'last-slot)
                     (eyebrowse--get 'window-configs))))
      (progn
        (projectile-kill-buffers))))

(add-hook 'eyebrowse-pre-window-delete-hook 'eyebrowse-projectile-remove-project)

(provide 'eyebrowse-projectile)
;;; eyebrowse-projectile.el ends here
