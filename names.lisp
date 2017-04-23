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


(defparameter *orig* "names.db")
(defparameter *remaining* "results.db")

(defvar *db* '())


(defun save-db (filename)
  "Save current *db* to file."
  (with-open-file (out filename
                       :direction :output
                       :if-exists :supersede)
    (with-standard-io-syntax
      (print *db* out))))

(defun random-elt (choices)
  "Choose an element from a list at random."
  (elt choices (random (length choices))))

(defun one-of (set)
  "Pick one element of set, and make a list of it."
  (list (random-elt set)))


(defun get-file (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))


(defun print-n-names (n)
  (print n))


(defun remove-from-db (item)
  (setf *db* (remove item *db* :test #'string-equal)))

(defun start ()
  (setf *db* (get-file *orig*)))

(defun main (&optional n &rest argv)
  (declare (ignore argv))
  (when n
    (let ((res (remove-duplicates (histgrep n) :test #'equalp)))
      (when res
        (format t "~&~{~A ~&~}" (butlast res))
        (uiop:quit 0))))
  (uiop:quit 1))

