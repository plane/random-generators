#lang racket/base

(provide gen:pseudo-random-number-generator
         get-seed
         set-seed!
         random!)

(require "private/generic-interface.rkt")

(provide msvc-rand
         splitmix64
         xoshiro128++
         xoshiro256++)

(require "private/msvc-rand.rkt"
         "private/splitmix64.rkt" 
         "private/xoshiro128++.rkt"
         "private/xoshiro256++.rkt")
