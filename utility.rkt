#lang racket/base

;; --------------------------------------------------------------------------
;;
;; Utility function to help with seeding RNGs with 32-bit state values
;;
;; --------------------------------------------------------------------------

(provide current-milliseconds/32-bit)

(require "private/util/current-time.rkt")

