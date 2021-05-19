#lang racket/base

(provide random!
         get-seed
         set-seed!
         seed-jump)

(provide gen:pseudo-random-number-generator
         pseudo-random-number-generator?
         pseudo-random-number-generator/c)

;; --------------------------------------------------------------------------

(require racket/generic)

(define-generics pseudo-random-number-generator
  (get-seed  pseudo-random-number-generator)
  (set-seed! pseudo-random-number-generator new-seed)
  (seed-jump pseudo-random-number-generator)
  (random!   pseudo-random-number-generator))
