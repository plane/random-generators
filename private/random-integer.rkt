#lang racket/base

(provide random-integer!)

;; --------------------------------------------------------------------------
;;
;; random-integer!
;;
;; You can call this function two ways:
;;
;;     (random-integer! max)     - provide a random integer from [0..max)
;;     (random-integer! min max) - provide a random integer from [min..max)
;;
;; Either way, it's a half-open interval; `max` is never included.
;;
;; --------------------------------------------------------------------------

(require racket/match
         racket/math
	 "random-real.rkt")

(define/match (random-integer! this m [n #f])
  [(this max #f)  (random-integer!* this 0   max)]
  [(this min max) (random-integer!* this min max)])

(define (random-integer!* this min max)
  (exact-truncate
    (random-real! this min max)))

