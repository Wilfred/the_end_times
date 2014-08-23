#!gsi-script

;; The Computer Language Benchmarks Game
;; http://shootout.alioth.debian.org/
;;
;; Derived by Bradley Lucier from the Ikarus variant
;; derived by Michael D. Adams from the MzScheme variant

(declare (standard-bindings)(extended-bindings)(block)(mostly-fixnum)(not safe))

(define-macro (let-values bindings . body)
  ;; good enough for our purposes here
  `(call-with-values
       (lambda () ,(cadar bindings))
     (lambda ,(caar bindings)
       ,@body)))

(define (floor_ev q r s t x)
  (quotient (+ (* q x) r) (+ (* s x) t)))

(define (comp q r s t  q2 r2 s2 t2)
  (values (+ (* q q2) (* r s2))
          (+ (* q r2) (* r t2))
          (+ (* s q2) (* t s2))
          (+ (* s r2) (* t t2))))

(define out (current-output-port))
(define (next q r s t) (floor_ev q r s t 3))
(define (safe? q r s t n) (= n (floor_ev q r s t 4)))
(define (prod q r s t n) (comp 10 (fx* -10 n) 0 1  q r s t))
(define (mk q r s t k) (comp q r s t k (fx* 2 (fx+ 1 (fx* 2 k))) 0 (fx+ 1 (fx* 2 k))))

(define (digit k q r s t n row col)
  (if (> n 0)
      (let ([y (next q r s t)])
        (if (safe? q r s t y)
            (let-values ([(q r s t) (prod q r s t y)])
                        (if (= col 10)
                            (let ([row (fx+ row 10)])
                              (display "\t:" out) (display row out)
                              (display "\n" out) (display y out)
                              (digit k q r s t (fx- n 1) row 1))
                            (begin
			      (display y out)
                              (digit k q r s t (fx- n 1) row (fx+ 1 col)))))
            (let-values ([(q r s t) (mk q r s t k)])
                        (digit (fx+ 1 k) q r s t n row col))))
      (begin
        (display (make-string (fx- 10 col) #\space) out) (display "\t:" out)
        (display (+ row col) out) (write-char #\newline out))))

(define (digits n)
  (digit 1 1 0 0 1 n 0 0))

(define (main . args)
  (digits (string->number (car args)))
  (force-output out))
