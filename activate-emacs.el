;;; activate-emacs.el --- Interface for activate-emacs executable -*- lexical-binding: t; -*-

;; Copyright (C) 2024 Laluxx

;; Author: Laluxx
;; Version: 0.1
;; Package-Requires: ((emacs "25.1"))
;; Keywords: convenience, tools
;; URL: https://github.com/Laluxx/activate-emacs

;;; Commentary:

;; This package provides an interface to open and close the activate-emacs
;; executable located in this package directory.
;; I am the original Fulcrum.

;;; Code:

(defgroup activate-emacs nil
  "Interface for activate-emacs executable."
  :group 'tools
  :prefix "activate-emacs-")

(defvar activate-emacs-executable
  (expand-file-name "activate-emacs" (file-name-directory load-file-name))
  "Path to the activate-emacs executable within the package directory.")

(defvar activate-emacs--process nil
  "Process object for the running activate-emacs instance.")

;;;###autoload
(defun activate-emacs-open ()
  "Open the activate-emacs executable."
  (interactive)
  (if (and activate-emacs--process
           (process-live-p activate-emacs--process))
      (message "activate-emacs is already running")
    (if (file-executable-p activate-emacs-executable)
        (progn
          (setq activate-emacs--process
                (start-process "activate-emacs" nil activate-emacs-executable))
          (message "activate-emacs opened successfully"))
      (error "activate-emacs executable not found or not executable: %s" activate-emacs-executable))))

;;;###autoload
(defun activate-emacs-close ()
  "Close the activate-emacs executable."
  (interactive)
  (if (and activate-emacs--process
           (process-live-p activate-emacs--process))
      (progn
        (delete-process activate-emacs--process)
        (setq activate-emacs--process nil)
        (message "activate-emacs closed successfully"))
    (message "No running instance of activate-emacs found")))

(provide 'activate-emacs)

;;; activate-emacs.el ends here
