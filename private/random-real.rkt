#lang racket/base

(provide random-real!)

;; --------------------------------------------------------------------------
;;
;; random-real!
;;
;; You can call this function three ways:
;;
;;     (random-real!)         - provide a random integer from [0..1.0)
;;     (random-real! max)     - provide a random integer from [0..max)
;;     (random-real! min max) - provide a random integer from [min..max)
;;
;; Regardless, it's a half-open interval; `max` is never included.
;;
;; --------------------------------------------------------------------------

(require racket/match
         "generic-interface.rkt")

(define/match (random-real! this [m #f] [n #f])
  [(this #f  #f)  (random-real!* this 0   1.0)]
  [(this max #f)  (random-real!* this 0   max)]
  [(this min max) (random-real!* this min max)])

(define (random-real!* this min max)
  (define range (- max min))
  (exact->inexact
    (+ min
       (* range
          (normalized-random!* this)))))

(define (normalized-random!* this)
  (/ (random! this)
     (add1 (rand-max this))))

