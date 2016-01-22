;________________________________________________________________________LICENSE
;    Use of this software and  associated  documentation  files  (the
;    "Software"), is governed by the Creative Commons  Public  Domain
;    License(the "License"). You may obtain a copy of the License at:
;        https://creativecommons.org/licenses/publicdomain/
;______________________________________**Alan Kay's Eval/Apply Einstein Moment**

;Alan Kay said that [by finding the 1 and only bug in the code on page 13 of the Lisp 1.5 manual, it helped him understand Computer Science by a factor of 100 better](https://youtu.be/HAT4iewOHDs?t=3m18s).

;The code in question is the 1st release of `eval` & `apply` that looks anything remotely like modern lisp(that I'm aware of). So I have taken the following translation steps listed under the `synonomous` comment sections to make it more familiar to everyone using a modern lisp. I found a copy of the code @[http://www.softwarepreservation.org/projects/LISP/book/LISP%201.5%20Programmers%20Manual.pdf](http://www.softwarepreservation.org/projects/LISP/book/LISP%201.5%20Programmers%20Manual.pdf)

;Since the correct answer is likely known but lost(my google fu is decent and I've searched for 20 mins at least),  
;I will award the 1st correct answer(I will be looking at edit times so don't try to cheat) a 250 point bounty As Soon As Possible,  

;I would suggest others contribute to the bounty as well,  
;remember from the video above [Alan Kay](https://en.wikipedia.org/wiki/Alan_Kay) said this stuff is reminiscent of the the environment [Einstein](https://en.wikipedia.org/wiki/Albert_Einstein) was in when he discovered the [Theory of Relativity](https://en.wikipedia.org/wiki/Theory_of_relativity)
;______________________________________________________Initializing for McCarthy
;Data storage and retrieval -http://goo.gl/0NA6pa
(label mc.cons (lambda (x y) (λ (m) (m x y))))
(label mc.car (lambda (z) (z (λ (p q) p))))
(label mc.cdr (lambda (z) (z (λ (p q) q))))
;STILL NEEDS:
;quote, atom, eq, cond
;______________________________________Lisp Meta-Circular Evaluator S-Expression
;this code is written in the order it appears on pages 10-13 in the Lisp 1.5 Manual 
;and is translated from the m-expressions into s-expressions

(label mc.equal (lambda (x y)
	(mc.cond
		((atom x) ((mc.cond ((atom y) (eq x y)) ((quote t) (quote f)))))
		((equal (car x)(car y)) (equal (cdr x) (cdr y)))
		((quote t) (quote f)))))

(label mc.subst (lambda (x y z)
	(mc.cond
		((equal y z) (x))
		((atom z) (z))
		((quote t) (cons (subst x y (car z))(subst x y (cdr z)))))))

(label mc.append (lambda (x y)
	(mc.cond 
		((null x) (y))
		((quote t) (cons (car x)) (append (cdr x) y)))))

(label mc.member (lambda (x y)
	(mc.cond ((null y) (quote f))
	((equal x (car y)) (quote t))
	((quote t) (member x (cdr y))))))

(label mc.pairlis (lambda (x  y  a)
	(mc.cond ((null x) (a)) ((quote t) (cons (cons (car x)(car y))
	(pairlis (cdr x)(cdr y) a)))))

(label mc.assoc (lambda (x a)
	(mc.cond ((equal (caar a) x) (car a)) ((quote t) (assoc x (cdr a))))))

(label mc.sub2 (lambda (a z)
	(mc.cond ((null a) (z)) (((eq (caar a) z)) (cdar a)) ((quote t) (
	sub2 (cdr a) z)))))

(label mc.sublis (lambda (a y)
	(mc.cond ((atom y) (sub2 a y)) ((quote t) (cons (sublis a (car y))))
	(sublis a (cdr y)))))

(label mc.evalquote (lambda (fn x)
	(apply fn x nil)))

(label mc.apply (lambda (fn x a)
	(mc.cond ((atom fn) (
		(mc.cond
			((eq fn car) (caar x))
			((eq fn cdr) (cdar x))
			((eq fn cons) (cons (car x)(cadr x)))
			((eq fn atom) (atom (car x)))
			((eq fn eq) (eq (car x)(cadr x)))
			((quote t) (apply (eval (fn a)x a))))))
		((eq (car fn) lambda) (eval (caddr fn) (parlis (cadr fn) x a)))
		((eq (car fn) label) (apply (caddr (fn)x cons (cons (cadr (fn)))
			(caddr fn))a)))))

(label mc.eval (lambda (e a)
	(mc.cond
		((atom e) (cdr (assoc e a)))
		((atom (car e)) (mc.cond
			((eq (car e) quote) (cadr e))
			((eq (car e) cond) (evcon (cdr e) a))
			((quote t) (apply (car e) (evlis (cdr e) a) a))))
		((quote t) (apply (car e) (evlis (cdr e) a) a))))))

(label mc.evcon (lambda (c a)
	(mc.cond 
		((eval (caar c) a) (eval (cadar c) a))
		((quote t) (evcon (cdr c) a)))))

(label mc.evlis (lambda (m a)
	(mc.cond
		((null m) (nil))
		((quote t) (cons (eval (car m) a) (evlis (cdr m) a)))))))
