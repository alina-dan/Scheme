(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (cons-all first rests)
    (map (lambda (rest) (cons first rest)) rests)
)

(define (zip pairs)
    (list (map car pairs) (map cadr pairs)))

;; Problem 17
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 17
  (define (enumerate-helper s n)
    (cond ((null? s) nil)
    (else (cons (cons n (cons (car s) nil)) (enumerate-helper (cdr s) (+ n 1))))))
  (enumerate-helper s 0)
  )
  ; END PROBLEM 17

;; Problem 18
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 18
   (cond ((null? denoms) nil)
        ((> (car denoms) total) (list-change total (cdr denoms)))
        ((= (car denoms) total) (cons (list (car denoms)) (list-change total (cdr denoms))))
        (else (define with-helper (list-change (- total (car denoms)) denoms))
              (define without-helper (list-change total (cdr denoms)))
              (append (cons-all (car denoms) with-helper) without-helper))))
  ; END PROBLEM 18

;; Problem 19
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (append (list form params) (map let-to-lambda body)) 
           ; END PROBLEM 19
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (cons (list 'lambda (car (zip values)) (car (map let-to-lambda body))) (map let-to-lambda (cadr (zip values))))
           ; END PROBLEM 19
           ))
        (else
         ; BEGIN PROBLEM 19
         (map let-to-lambda expr)
         ; END PROBLEM 19
         )))
