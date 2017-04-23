#!/bin/sh
#|-*- mode:lisp -*-|#
#| Choose name
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
  (random-elt set))


(defun get-file (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))

(defun take-n-names (n)
  (let ((names '()))
   (dotimes (i n)
     (push (one-of *db*) names))
   names))

(defun print-n-names (n)
  (let ((names (take-n-names n)))
    (dotimes (i n)
      (format t "(~2d) ~A~%" (1+ i) (nth i names)))
    names))

(defun keep (n names)
  (dotimes (i (length names))
    (when (not (= i n))
      (remove-from-db (nth i names)))))

(defun choose (n)
  (let ((names (print-n-names n)))
   (format *query-io* "Choose a number: ")
   (force-output *query-io*)
   (keep (1- (read)) names)
   (format t "~A names left" (length *db*))))


(defun remove-from-db (item)
  (setf *db* (remove item *db* :test #'string-equal)))

(defun start ()
  (setf *db* (get-file *remaining*)))

(defun main (&optional n &rest argv)
  (declare (ignore argv))
  (when n
    (let ((res (remove-duplicates (histgrep n) :test #'equalp)))
      (when res
        (format t "~&~{~A ~&~}" (butlast res))
        (uiop:quit 0))))
  (uiop:quit 1))
