;;; phpcbf.el --- Format PHP code in Emacs using PHP_CodeSniffer's phpcbf

;;; Copyright (c) 2015 nishimaki10

;; Author: nishimaki10
;; URL: https://github.com/nishimaki10/emacs-phpcbf
;; Version: 0.9
;; Keywords: tools, php

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Please check the GitHub
;; (https://github.com/nishimaki10/emacs-phpcbf)
;; for more information.

;;; Code:

(defgroup phpcbf nil
  "Format code using phpcbf"
  :prefix "phpcbf:"
  :group 'tools)

(defcustom phpcbf:executable (executable-find "phpcbf")
  "Location of the phpcbf executable."
  :group 'phpcbf
  :type 'string)

(defcustom phpcbf:standard "PEAR"
  "The name or path of the coding standard to use.
Available standards: Generic, MySource, PEAR, PHPCS, PSR1, PSR2, Squiz, Zend.
And more your custom standards."
  :group 'phpcbf
  :type 'string)

(defcustom phpcbf:encoding "iso-8859-1"
  "The encoding of the files being fixed (default is iso-8859-1).
iso-8859-1 is PEAR standards."
  :group 'phpcbf
  :type 'string)

;;;###autoload
(defun phpcbf ()
  "Format the current buffer according to the phpcbf."
  (interactive)
  (let ((temp-file (make-temp-file "phpcbf"))
        (now-point (point)))
    (unwind-protect
        (let ((status)
              (stderr)
              (keep-stderr (list t temp-file)))

          (setq status
                (call-process-region
                 (point-min) (point-max) phpcbf:executable
                 t keep-stderr t
                 (concat "--standard=" phpcbf:standard)
                 (concat "--encoding=" phpcbf:encoding)))

          (setq stderr
                (with-temp-buffer
                  (insert-file-contents temp-file)
                  (when (> (point-max) (point-min))
                    (insert ": "))
                  (buffer-substring-no-properties
                   (point-min) (line-end-position))))

          (cond
           ((stringp status)
            (error "`phpcbf` killed by signal %s%s" status stderr))
           ((not (equal 1 status))
            (error "`phpcbf` failed with code %d%s" status stderr))
           (t (message "phpcbf format succeed.")))
          ))
    (delete-file temp-file)
    (goto-char now-point)))

;;;###autoload
(defun phpcbf:before-save ()
  "Add this to .emacs to run phpcbf on the current buffer when saving:
\(add-hook 'before-save-hook 'phpcbf:before-save\).
Note that this will cause php-mode to get loaded the first time
you save any file, kind of defeating the point of autoloading."
  (interactive)
  (when (eq major-mode 'php-mode) (phpcbf)))

(provide 'phpcbf)

;;; phpcbf.el ends here
