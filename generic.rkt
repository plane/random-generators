#lang racket/base

;; --------------------------------------------------------------------------
;;
;; Interface used for all pseudo-random number generators
;;
;; --------------------------------------------------------------------------

(provide random!
         random-integer!
         random-real!
         get-seed
         set-seed!
         seed-jump)

(provide gen:pseudo-random-number-generator
         pseudo-random-number-generator?
         pseudo-random-number-generator/c)

(require "private/generic-interface.rkt"
         "private/random-integer.rkt"
         "private/random-real.rkt")

