#lang racket/base

(provide apply-repeatedly)

;; --------------------------------------------------------------------------
;;
;; `apply-repeatedly`
;;
;; Make a list with n entries, with elements:
;;
;;    ~> x
;;    ~> x f
;;    ~> x f f
;;    ~> x f f f
;;    ...
;;
;; The purpose of this function is to create a list of PRNGs which can be
;; used in parallel, using the `jump-seed` function (which skips ahead by
;; a large number of values in a PRNG sequence).
;;
;; --------------------------------------------------------------------------

(define (apply-repeatedly f x n)
  (reverse
    (for/fold ([acc (list x)])
              ([_ (sub1 n)])
      (cons (f (car acc)) acc))))

