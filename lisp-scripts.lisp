#!/bin/sh
#|-*- mode:lisp -*-|#
#| <Put a one-line description here>
exec ros -Q -- $0 "$@"
|#

; (in-package #:lisp-scripts)

;;; "lisp-scripts" goes here. Hacks and glory await!


;; Loading dependencies
(unless (find-package :uiop)
  (ql:quickload '(:uiop) :silent t))


(defun ls (s)
  (inferior-shell:run/lines
    `(inferior-shell:pipe (ls)
                          (grep ,s))))

(defun main (n &rest argv)
  (ls n))
