#lang racket/base

(provide get-seed
	 set-seed!
	 random!)

(provide gen:pseudo-random-number-generator
	 pseudo-random-number-generator?
	 pseudo-random-number-generator/c)

;; --------------------------------------------------------------------------

(require racket/generic)

(define-generics pseudo-random-number-generator
  (get-seed pseudo-random-number-generator)
  (set-seed! pseudo-random-number-generator new-seed)
  (random! pseudo-random-number-generator))
