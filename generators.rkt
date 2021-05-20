#lang racket/base

;; --------------------------------------------------------------------------
;;
;; List of available generators
;;
;; --------------------------------------------------------------------------

(provide msvc-rand
         splitmix64
         xoshiro128++
         xoshiro256++)

(require "private/generators/msvc-rand.rkt"
         "private/generators/splitmix64.rkt" 
         "private/generators/xoshiro128++.rkt"
         "private/generators/xoshiro256++.rkt")


;; --------------------------------------------------------------------------
;;
;; Convenience functions which create generators seeded with the current time
;;
;; --------------------------------------------------------------------------

(provide msvc-rand/current-time
         splitmix64/current-time
         xoshiro128++/current-time
         xoshiro256++/current-time)

(require "private/seeded-generators.rkt")

