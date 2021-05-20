#lang racket/base

(provide make-jump-generator-list)

;; --------------------------------------------------------------------------

(require "generic-interface.rkt"
	 "util/apply-repeatedly.rkt")

(define (make-jump-generator-list generator repeat-num)
  (apply-repeatedly seed-jump generator repeat-num))

