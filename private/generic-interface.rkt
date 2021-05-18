#lang racket/base

(provide gen:pseudo-random-number-generator
         get-seed
         set-seed!
         random!)

;; --------------------------------------------------------------------------

(require racket/generic)

(define-generics pseudo-random-number-generator
  (get-seed pseudo-random-number-generator)
  (set-seed! pseudo-random-number-generator new-seed)
  (random! pseudo-random-number-generator))
