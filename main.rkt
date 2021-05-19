#lang racket/base

;; --------------------------------------------------------------------------
;;
;; Interface used for all pseudo-random number generators
;;
;; --------------------------------------------------------------------------

(provide gen:pseudo-random-number-generator
         get-seed
         set-seed!
         random!)

(require "private/generic-interface.rkt")


;; --------------------------------------------------------------------------
;;
;; List of available PRNGs
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


;; --------------------------------------------------------------------------
;;
;; Utility function to help with seeding RNGs with 32-bit state values
;;
;; --------------------------------------------------------------------------

(provide current-milliseconds/32-bit)

(require "private/util/current-time.rkt")

