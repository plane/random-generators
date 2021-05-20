#lang at-exp racket/base

;; --------------------------------------------------------------------------
;;
;; Estimate pi using Monte Carlo, inaccurately and slowly
;;
;; --------------------------------------------------------------------------

(require racket/list
         racket/math
         random-generators
         threading
         "util/for-count.rkt"
         "util/procedure-to-name.rkt")

(define (in-quarter-circle? x y)
  (< (+ (* x x)
        (* y y))
     1))

(define (count-dots-in-quarter-circle generator trials)
  (for/count ([_ trials])
             (in-quarter-circle? (random-real! generator)
                                 (random-real! generator))))

(define (estimate-pi generator trials)
  (~> (count-dots-in-quarter-circle generator trials)
      (/ trials)
      (* 4)
      (exact->inexact)))

;; --------------------------------------------------------------------------

(module+ main
  (define trials 1000000)
  (define all-generators (list msvc-rand/current-time
                               splitmix64/current-time
                               xoshiro128++/current-time
                               xoshiro256++/current-time))
  
  (printf @string-append{

       Pi fight!  Which PRNG will win?

    })

  (define results 
    (for/list ([generator all-generators])
      (define generator-name (procedure->name generator))
      (define estimated-pi (estimate-pi (generator) trials))
      (define error (abs (- estimated-pi pi)))
      (printf @string-append{

            Generator: ~a
            Estimated: ~a
                Error: ~a

        } generator-name estimated-pi error)
      (hash 'generator-name generator-name
            'estimated-pi   estimated-pi
            'error          error)))

  (define winner
    (argmin (λ (result)
              (hash-ref result 'error))
            results))

  (define winner-name
    (hash-ref winner 'generator-name))

  (printf @string-append{

        And the winner is . . . ~a!  Congratulations, ~a!

    } winner-name winner-name))
