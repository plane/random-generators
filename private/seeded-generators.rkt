#lang racket/base

(provide msvc-rand/current-time
         splitmix64/current-time
         xoshiro128++/current-time
         xoshiro256++/current-time)

;; --------------------------------------------------------------------------

(require "generic-interface.rkt"
         "util/current-time.rkt"
         "util/numeric.rkt")

(require "generators/msvc-rand.rkt"
         "generators/splitmix64.rkt"
         "generators/xoshiro128++.rkt"
         "generators/xoshiro256++.rkt")

(define (msvc-rand/current-time)
  (msvc-rand (current-milliseconds/32-bit)))

(define (splitmix64/current-time)
  (splitmix64 (current-milliseconds)))

(define (xoshiro128++/current-time)
  (define seed-generator (splitmix64/current-time))
  (xoshiro128++ (mask-to-32-bits (random! seed-generator))
                (mask-to-32-bits (random! seed-generator))
                (mask-to-32-bits (random! seed-generator))
                (mask-to-32-bits (random! seed-generator))))

(define (xoshiro256++/current-time)
  (define seed-generator (splitmix64/current-time))
  (xoshiro256++ (random! seed-generator)
                (random! seed-generator)
                (random! seed-generator)
                (random! seed-generator)))

