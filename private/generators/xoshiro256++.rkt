#lang racket/base

(provide xoshiro256++)

;; --------------------------------------------------------------------------
;;
;; A high quality generator created by David Blackman and Sebastiano Vigna
;; in 2019, based on the source code linked below:
;;
;; https://prng.di.unimi.it/xoshiro256plusplus.c
;;
;; --------------------------------------------------------------------------

(require racket/match
         "../generic-interface.rkt"
         "../util/apply-values.rkt"
         "../util/struct.rkt"
         "../util/with.rkt")

(require
  (only-in "../util/numeric.rkt"
           [add/64-bit +]
           [shift-left/64-bit shift-left]
           shift-right))

(struct xoshiro256++ ([s0 #:mutable]
                      [s1 #:mutable]
                      [s2 #:mutable]
                      [s3 #:mutable])
  #:methods gen:pseudo-random-number-generator

  ((define (get-seed this)
     (with xoshiro256++ this
       (list s0 s1 s2 s3)))

   (define (set-seed! this new-seed)
     (with xoshiro256++ this
       (match new-seed
         [(list i0 i1 i2 i3)
          (set! s0 i0)
          (set! s1 i1)
          (set! s2 i2)
          (set! s3 i3)])))

   (define (rand-max this) 
     18446744073709551615)

   ;; jump ahead 2^128 values
   (define (seed-jump this)
     
     (define jump-table #x39abdc4529b1661ca9582618e03fc9aad5a61266f0c9392c180ec6d33cfd0aba)
     (define jump-table-bits (integer-length jump-table))
       
     (define copy-of-this ; mutate a copy, not the original
       (struct-copy xoshiro256++ this))
     
     (with xoshiro256++ copy-of-this
       (apply-values xoshiro256++
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
     (with xoshiro256++ this
       (define result (+ s0 (rotate-left (+ s0 s3) 23)))
       (define t (shift-left s1 17))
       (set! s2 (bitwise-xor s2 s0))
       (set! s3 (bitwise-xor s3 s1))
       (set! s1 (bitwise-xor s1 s2))
       (set! s0 (bitwise-xor s0 s3))
       (set! s2 (bitwise-xor s2 t))
       (set! s3 (rotate-left s3 45))
       result))))

(define (rotate-left x k)
  (bitwise-ior (shift-left x k)
               (shift-right x (- 64 k))))

(module+ test
  (require rackunit)
  (define prng (xoshiro256++ 12345678901234567
                             56712345678901234
                             90123456712345678
                             34567123456789012))
  (check-equal? (for/list ([i 10])
                  (random! prng))
                (list 8730184168495619804
                      13325717367847442677
                      11685827732425745907
                      5917460415815047405
                      7392855844041603889
                      16771689184366542401
                      8689174432762134405
                      12554713842009165222
                      3178718541026691128
                      7282369145994424250))
  (define jumped (seed-jump prng))
  (check-equal? (for/list ([i 10])
                  (random! jumped))
                (list 7955042531670892814
                      982302844903164379
                      11561224321829555360
                      12263258568219831510
                      3579098356910936288
                      7280155255297171497
                      12835435643884134189
                      4458675324967753691
                      8051493048826794243
                      13415052397045340149)))

