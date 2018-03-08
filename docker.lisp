
(defpackage cl-docker
  (:use cl)
  (:import-from :cl-ppcre :split)
  (:export :ps))

(in-package :cl-docker)

(defun ps ()
  (let ((output (uiop:run-program '("docker" "ps") :output :string)))
    (loop for line in (rest (cl-ppcre:split "(\\n+)" output))
      collect (cl-ppcre:split "(\\s\\s+)" line))))
