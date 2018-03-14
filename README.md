# args
Provides the macro `with-args' to help manage command line arguments

```
$ sbcl --load args.lisp --eval "(in-package :macleod.args)"
This is SBCL 1.4.0, an implementation of ANSI Common Lisp.
...
* (setf sb-ext:*posix-argv* '("sbcl" "Hello," "swap-between" "World!"))

("sbcl" "Hello," "swap-between" "World!")
* (with-args (sym1 "swap-between" sym2)
    (format t "~a <-- --> ~a~%" sym2 sym1))
World! <-- --> Hello,
NIL
```
