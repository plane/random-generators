#lang racket/base

(provide msvc-rand)

;; --------------------------------------------------------------------------
;;
;; LCG(2^31,214013,2531011)
;;
;; A low-quality linear congruential generator used in
;; Microsoft's Visual Studio rand() implementation
;;
;; DO NOT USE in new programs, only to reproduce the
;; behavior of old programs which rely on this rand()
;;
;; --------------------------------------------------------------------------

(require rackunit
         "generic-interface.rkt"
         "util/struct.rkt"
         "util/with.rkt")

(require
  (only-in "util/numeric.rkt"
           [add/32-bit +]
           [multiply/32-bit *]
           shift-right))

(struct msvc-rand ([seed #:mutable])
  #:methods gen:pseudo-random-number-generator

  ((define (get-seed this)
     (with msvc-rand this
       seed))

   (define (set-seed! this new-seed)
     (with msvc-rand this
       (set! seed new-seed)))

   (define (random! this)
     (with msvc-rand this
       (set! seed (+ 2531011 (* 214013 seed)))
       (bitwise-and #x7FFF (shift-right seed 16))))))

(module+ test
  (define prng (msvc-rand 123456789))
  (check-equal? (for/list ([i 10])
                  (random! prng))
                (list 13259
                      26974
                      13551
                      30354
                      18709
                      15861
                      16906
                      21981
                      8603
                      12911)))

