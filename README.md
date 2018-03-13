# args
Provides the macro `with-arg' to help manage command line arguments

```
$ cat test
#!/bin/sbcl --script

(in-package :cl-user)

(load "args.lisp")

(defpackage :macleod.test
  (:use :common-lisp
        :macleod.args))

(in-package :macleod.test)

(with-arg ("--test-two" sym1 sym2)
  (format t "~a ~a~%" sym1 sym2))

(with-arg ("--ok")
  (with-arg ("--ok-message" message)
    (format t "ok-message: ~a~%" message)))
$ ./test --test-two a b
a b
$ ./test --ok-message "Hello, world!"
$ ./test --ok-message "Hello, world!" --ok
ok-message: Hello, world!
```
