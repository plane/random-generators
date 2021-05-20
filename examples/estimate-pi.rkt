#lang racket/base

;; --------------------------------------------------------------------------
;;
;; Estimate pi using Monte Carlo, inaccurately and slowly
;;
;; --------------------------------------------------------------------------

(require "../main.rkt")

(define-syntax-rule 
  (for/count (for-clause ...)
     body-or-break ...
     body)
  (for/sum (for-clause ...)
     body-or-break ...
     (if body 1 0)))

(define (in-quarter-circle? x y)
  (< (+ (* x x)
        (* y y))
     1))

(define (count-dots-in-quarter-circle trial-num)
  (define rng (xoshiro128++/current-time))
  (for/count ([_ trial-num])
    (in-quarter-circle? (random-real! rng)
                        (random-real! rng))))

(define (estimate-pi trial-num)
  (define dots-in-quarter-circle
    (count-dots-in-quarter-circle trial-num))
  (define ratio-in-quarter-circle
    (/ dots-in-quarter-circle trial-num))
  (define ratio-in-circle
    (* 4 ratio-in-quarter-circle))
  (exact->inexact ratio-in-circle))

(module+ main
  (define trial-num 100000)
  (estimate-pi trial-num))

