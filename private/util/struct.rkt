#lang racket/base

(provide struct)

;; --------------------------------------------------------------------------
;;
;; This is just a shortcut to make all of our PRNG structs both serializable
;; and transparent.
;;
;; --------------------------------------------------------------------------

(require racket/serialize)

(define-syntax-rule (struct id (expr ...) kw ...)
  (serializable-struct id (expr ...) kw ...
                       #:transparent))