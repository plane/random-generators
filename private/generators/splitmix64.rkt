#lang racket/base

(provide splitmix64)

;; --------------------------------------------------------------------------
;;
;; Original algorithm from "../Fast splittable pseudorandom number generators"
;; by Guy L. Steele, Doug Lea, and Christine H. Flood.  See:
;;
;;   https://doi.org/10.1145/2660193.2660195
;;
;; This implementation is based on code by Sebastiano Vigna written in 2015:
;;
;;   https://prng.di.unimi.it/splitmix64.c
;;
;; --------------------------------------------------------------------------

(require threading
         "../generic-interface.rkt"
         "../util/struct.rkt"
         "../util/with.rkt")

(require
  (only-in "../util/numeric.rkt"
           [add/64-bit +]
           [multiply/64-bit *]
           shift-right))

(struct splitmix64 ([seed #:mutable])
  #:methods gen:pseudo-random-number-generator

  ((define (get-seed this)
     (with splitmix64 this
       seed))

   (define (set-seed! this new-seed)
     (with splitmix64 this
       (set! seed new-seed)))

   (define (rand-max this) 
     18446744073709551615)

   (define (random! this)
     (with splitmix64 this
       (set! seed (+ seed #x9e3779b97f4a7c15))
       (~> seed
           (xor-with-shift 30)
           (* #xbf58476d1ce4e5b9)
           (xor-with-shift 27)
           (* #x94d049bb133111eb)
           (xor-with-shift 31))))))

(define (xor-with-shift value bits)
  (bitwise-xor value (shift-right value bits)))

(module+ test
  (require rackunit)
  (define prng (splitmix64 12345678))
  (check-equal? (for/list ([i 10])
                  (random! prng))
                (list 1285161397399512697
                      7146091996086701242
                      11283735336711330924
                      1694233733035357502
                      18000419399511061515
                      482139788976776422
                      13649562693550383856
                      6194478348723198655
                      245608599888150637
                      2220856872654072569)))
