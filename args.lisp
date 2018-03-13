(in-package :cl-user)

(defpackage :macleod.args
  (:use :common-lisp)
  (:export :with-arg))

(in-package :macleod.args)

;;; Drops elements off the start of xs until it reaches str
(defun drop-until-string= (str xs)
  (loop for x on xs
        when (string= str (car x))
        return x))

;;; Matches xs against arg-list, binding any symbols in arg-list.
;;;
;;; The following initializes `topic' with the string "my-command"
;;;
;;;     (with-match '("--help" "my-command") ("--help" topic)
;;;       (format t "Here's some help with ~a~%" topic))
(defmacro with-match (xs arg-list &body body)
  (let* ((arg-match (car arg-list))
         (params-match (cdr arg-list))
         (params (drop-until-string= arg-match (eval xs))))
    (if params
      `(let ,(loop for param in (cdr params)
                   for param-match in params-match
                   collect `(,param-match ,param))
         ,@body))))

;;; Matches command line arguments against arg-list, see `with-match' for details.
(defmacro with-arg (arg-list &body body)
  `(with-match sb-ext:*posix-argv* ,arg-list
     ,@body))
