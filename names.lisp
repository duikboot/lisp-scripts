#!/bin/sh
#|-*- mode:lisp -*-|#
#| 
exec ros -Q -- $0 "$@"
|#

(unless (find-package :iterate)
  (ql:quickload '(:uiop) :silent t))

(defpackage :ros.script.names.3685353031
  (:use :cl))

(in-package :ros.script.names.3685353031)


(defun get-file (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))

(defun main (&optional n &rest argv)
  (declare (ignore argv))
  (when n
    (let ((res (remove-duplicates (histgrep n) :test #'equalp)))
      (when res
        (format t "~&~{~A ~&~}" (butlast res))
        (uiop:quit 0))))
  (uiop:quit 1))

