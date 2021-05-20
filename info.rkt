#lang info

(define collection "random-generators")
(define pkg-authors '("crystal@panix.com"))
(define version "0.2")
(define scribblings
 '(("random-generators.scrbl" () (library) "random-generators")))
(define pkg-desc "Various random number generators")
(define deps '("base"
               "threading-lib"
               "struct-define"
               "reprovide-lang-lib"))
(define build-deps '("rackunit-lib"
                     "racket-doc"
                     "scribble-lib"))
(define compile-omit-paths '("examples"))

