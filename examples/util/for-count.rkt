#lang racket/base

(provide for/count)

;; --------------------------------------------------------------------------

(define-syntax-rule
  (for/count (for-clause ...)
     body-or-break ...
     body)
  (for/sum (for-clause ...)
     body-or-break ...
     (if body 1 0)))

