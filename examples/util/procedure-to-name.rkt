#lang racket/base

(provide procedure->name)

;; --------------------------------------------------------------------------
;;
;; Convert a procedure to the name of that procedure
;;
;; --------------------------------------------------------------------------

(require racket/format)

(define (procedure->name f)
  (~a (object-name f)))

