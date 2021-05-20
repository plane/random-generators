#lang racket/base

(provide make-jump-generator-list)

;; --------------------------------------------------------------------------

(require "generic-interface.rkt"
         "util/iterate.rkt")

(define (make-jump-generator-list generator 
                                  repeat-num)
  (iterate seed-jump
           generator 
           repeat-num))

