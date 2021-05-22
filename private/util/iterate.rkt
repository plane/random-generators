#lang racket/base

(provide iterate)

;; --------------------------------------------------------------------------
;;
;; `iterate`
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
;; This implementation uses srfi-41 streams instead of `racket/stream`
;; because `stream-iterate` is missing from the Racket library.
;;
;; --------------------------------------------------------------------------

(require srfi/41)

(define (iterate f x n)
  (stream->list n (stream-iterate f x)))

(module+ test
  (require rackunit)
  (define (sqr x) (* x x))
  (check-equal? (iterate sqr 2 6)
                (list 2 4 16 256 65536 4294967296)))
