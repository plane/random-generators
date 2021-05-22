#lang racket/base

(provide apply-values)

;; --------------------------------------------------------------------------
;;
;; 'apply-values' - Allow you to call a function with multiple values as
;; separate arguments, instead of passing them as one argument
;;
;; --------------------------------------------------------------------------

(define-syntax-rule (apply-values function values)
  (call-with-values (lambda () values) function))

(module+ test
  (require rackunit)
  (check-equal? (apply-values + (values 1 2 3 4 5))
                15))
