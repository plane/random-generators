#lang racket/base

;; --------------------------------------------------------------------------
;;
;; Make a list of N generators from an existing generator using its jump
;; function, if available
;;
;; --------------------------------------------------------------------------

(provide make-jump-generator-list)

(require "private/make-jump-generator-list.rkt")

