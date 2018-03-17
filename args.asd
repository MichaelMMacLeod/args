(in-package :cl-user)

(defpackage :macleod.args-system
  (:use :common-lisp :asdf))

(in-package :macleod.args-system)

(defsystem "args"
           :description "args - defines with-args to handle command line arguments"
           :version "0.1"
           :author "Michael MacLeod <michaelmmacleod@gmail.com>"
           :license "Unlicense"
           :components ((:file "args")))
