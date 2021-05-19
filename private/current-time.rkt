#lang racket/base

(provide current-milliseconds/32-bit)

;; --------------------------------------------------------------------------

(require "util/numeric.rkt")

(define (current-milliseconds/32-bit)
  (mask-to-32-bits (current-milliseconds)))
