; pidigits: chicken version
; Sven Hartrumpf 2005-04-06
; Implements 'Spigot' algorithm origionally due to Stanly Rabinowitz.
; This program is based on an implementation for SCM by Aubrey Jaffer and
; Jerry D. Hedden.

(define (pi n d)
  (let* ((r (do ((s 1 (* 10 s)) (i d (- i 1))) ((zero? i) s))) ; chicken: this line is faster
         (p (+ (quotient n d) 1))
         (m (quotient (* p d 3322) 1000))
         (a (make-vector (+ m 1) 2))
         (digits 0))
    (vector-set! a m 4)
    (do ((j 1 (+ j 1))
         (q 0 0)
         (b 2 (remainder q r)))
        ((> j p))
      (do ((k m (- k 1)))
          ((zero? k))
        (set! q (+ q (* (vector-ref a k) r)))
        (let ((t (+ (* k 2) 1))) ; maybe use something like bit-lsh
          (vector-set! a k (remainder q t)) ; quotient/remainder like in mzscheme would speedup this and the the next line
          (set! q (* k (quotient q t)))))
      (let* ((s (number->string (+ b (quotient q r))))
             (l (string-length s)))
        (cond ((and (> l 2) ; chicken: needs this cond because it uses floats for d>5 (leads to appended . or .0), for version after 1.89 use 2, before 1.89 use 1 in this line and the following 2 lines
                    (char=? (string-ref s (- l 2)) #\.))
               (set! l (- l 2))))
        (cond ((> j 1)
               (do ((l l (+ l 1)))
                   ((>= l d))
                 (cond ((< digits n)
                        (write-char #\0)
                        (set! digits (+ digits 1))
                        (cond ((zero? (modulo digits 10))
                               (display " :") (write digits) (newline))))))))
        (do ((i 0 (+ i 1)))
            ((= i l))
          (cond ((< digits n)
                 (write-char (string-ref s i))
                 (set! digits (+ digits 1))
                 (cond ((zero? (modulo digits 10))
                        (display " :") (write digits) (newline))))))))))

; chicken: d maximally 10 (when using inexact->exact in r calculation: 9), d minimally (still with correct results) 3

(pi (string->number (car (command-line-arguments))) 10); implements the shootout benchmark
