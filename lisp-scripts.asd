;;;; lisp-scripts.asd

(asdf:defsystem #:lisp-scripts
  :description "Describe lisp-scripts here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :depends-on (#:inferior-shell)
  :serial t
  :components ((:file "package")
               (:file "lisp-scripts")))

