(in-package :cl-user)

(defpackage :macleod.args
  (:use :common-lisp)
  (:export :with-arg))

(in-package :macleod.args)

(defun drop-until-string= (str xs)
  (loop for x on xs
        when (string= str (car x))
        return x))

(defmacro with-match (xs arg-list &body body)
  (let* ((arg-match (car arg-list))
         (params-match (cdr arg-list))
         (params (drop-until-string= arg-match (eval xs))))
    (if params
      `(let ,(loop for param in (cdr params)
                   for param-match in params-match
                   collect `(,param-match ,param))
         ,@body))))

(defmacro with-arg (arg-list &body body)
  `(with-match sb-ext:*posix-argv* ,arg-list
     ,@body))
