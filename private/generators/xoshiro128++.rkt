#lang racket/base

(provide xoshiro128++)

;; --------------------------------------------------------------------------
;;
;; A high quality generator created by David Blackman and Sebastiano Vigna
;; in 2019, based on the source code linked below:
;;
;; https://prng.di.unimi.it/xoshiro128plusplus.c
;;
;; --------------------------------------------------------------------------

(require racket/match
         rackunit
         "../generic-interface.rkt"
         "../util/apply-values.rkt"
         "../util/struct.rkt"
         "../util/with.rkt")

(require
  (only-in "../util/numeric.rkt"
           [add/32-bit +]
           [shift-left/32-bit shift-left]
           shift-right))

(struct xoshiro128++ ([s0 #:mutable]
                      [s1 #:mutable]
                      [s2 #:mutable]
                      [s3 #:mutable])
  #:methods gen:pseudo-random-number-generator

  ((define (get-seed this)
     (with xoshiro128++ this
       (list s0 s1 s2 s3)))

   (define (set-seed! this new-seed)
     (with xoshiro128++ this
       (match new-seed
         [(list i0 i1 i2 i3)
          (set! s0 i0)
          (set! s1 i1)
          (set! s2 i2)
          (set! s3 i3)])))

   ;; jump ahead 2^64 values
   (define (seed-jump this)
     
     (define jump-table #x77f2db5b6fa035c3f542d2d38764000b)
     (define jump-table-bits (integer-length jump-table))
     
     (define copy-of-this ; mutate a copy, not the original
       (struct-copy xoshiro128++ this))
     
     (with xoshiro128++ copy-of-this
       (apply-values xoshiro128++
                     (for/fold ([new0 0]
                                [new1 0]
                                [new2 0]
                                [new3 0])
                               ([bit-num jump-table-bits])
                       (begin0
                         (if (bitwise-bit-set? jump-table bit-num)
                                   (values (bitwise-xor new0 s0)
                                           (bitwise-xor new1 s1)
                                           (bitwise-xor new2 s2)
                                           (bitwise-xor new3 s3))
                                   (values new0
                                           new1
                                           new2
                                           new3))
                         (random! copy-of-this))))))

   (define (random! this)
     (with xoshiro128++ this
       (define result (+ s0 (rotate-left (+ s0 s3) 7)))
       (define t (shift-left s1 9))
       (set! s2 (bitwise-xor s2 s0))
       (set! s3 (bitwise-xor s3 s1))
       (set! s1 (bitwise-xor s1 s2))
       (set! s0 (bitwise-xor s0 s3))
       (set! s2 (bitwise-xor s2 t))
       (set! s3 (rotate-left s3 11))
       result))))

(define (rotate-left x k)
  (bitwise-ior (shift-left x k)
               (shift-right x (- 32 k))))

(module+ test
  (define prng (xoshiro128++ 123456789
                             234567890
                             345678901
                             456789012))
  (check-equal? (for/list ([i 10])
                  (random! prng))
                (list 1380475302
                      2989506144
                      2388869771
                      3028260506
                      2641434154
                      1654852617
                      2179746616
                      1031713641
                      1850081078
                      724899641))
  (define jumped (seed-jump prng))
  (check-equal? (for/list ([i 10])
                  (random! jumped))
                (list 199074115
                      2797948254
                      2204260840
                      20869236
                      221397048
                      1490129443
                      501366263
                      1514137670
                      4154120006
                      2588889898)))

