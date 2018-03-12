(in-package :cl-user)

(defpackage :michaelmmacleod.args
  (:use :common-lisp)
  (:export :with-args))

(in-package :michaelmmacleod.args)

(defun argument-p (x)
  (and (> (length x) 2)
       (string-equal x "--" :end1 2)
       (subseq x 2)))

(defun get-args ()
  (cdr sb-ext:*posix-argv*))

(defun make-arg (x)
  (format nil "--~a" x))

(defun collect-until (test xs)
  (loop for x in xs
        if (funcall test x)
            return ys
        else
            collect x into ys
        finally (return ys)))

(defun drop-until (test xs)
  (loop for x on xs
        when (funcall test (first x))
        return x))

(defun get-parameters-for (argument xs)
  (collect-until 
    #'argument-p
    (cdr (drop-until
           #'(lambda (x) (string-equal argument x))
           xs))))

(defmacro with-args ((&rest syms) &body body)
  `(let ,(mapcar #'(lambda (x)
                     (let ((arg (make-arg (symbol-name x)))
                           (cmd-args (get-args)))
                       `(,x (get-parameters-for ,arg ',cmd-args))))
                 syms)
     ,@body))
