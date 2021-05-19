#lang racket/base

(provide mask-to-64-bits
         mask-to-32-bits
         shift-left
         shift-right
         add/32-bit
         add/64-bit
         multiply/32-bit
         multiply/64-bit
         shift-left/32-bit
         shift-left/64-bit)

;; --------------------------------------------------------------------------
;;
;; In Racket, numbers can go well beyond 2^32 or 2^64.  We actually *want*
;; those limits in the generator algorithms, though.  These functions help
;; with that.
;;
;; --------------------------------------------------------------------------

(define (mask-to-32-bits value)
  (bitwise-and value #xFFFFFFFF))

(define (mask-to-64-bits value)
  (bitwise-and value #xFFFFFFFFFFFFFFFF))

(define (shift-left value bits)
  (arithmetic-shift value bits))

(define (shift-right value bits)
  (arithmetic-shift value (- bits)))

(define (add/32-bit a b)
  (mask-to-32-bits (+ a b)))

(define (add/64-bit a b)
  (mask-to-64-bits (+ a b)))

(define (multiply/32-bit a b)
  (mask-to-32-bits (* a b)))

(define (multiply/64-bit a b)
  (mask-to-64-bits (* a b)))

(define (shift-left/32-bit value bits)
  (mask-to-32-bits (shift-left value bits)))

(define (shift-left/64-bit value bits)
  (mask-to-64-bits (shift-left value bits)))

