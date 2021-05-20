#lang racket/base

(provide with)

;; --------------------------------------------------------------------------
;;
;; 'with' - This allows us to avoid typing the name of the struct over and 
;; over in our generic methods.  Uses Jay McCarthy's struct-define
;;
;; --------------------------------------------------------------------------

(require struct-define)

(define-syntax-rule (with type id expr ...)
  (let ()
    (struct-define type id)
    (begin expr ...)))

