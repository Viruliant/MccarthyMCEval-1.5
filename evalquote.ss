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
;______________________________________Lisp Meta-Circular Evaluator S-Expression


