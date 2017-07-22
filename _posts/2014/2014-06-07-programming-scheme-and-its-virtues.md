---
layout:
title: "[Programming] Scheme and it's virtues"
date: 2014-06-07 11:17 -0400
categories: [Coding]
tags: blogger
status: publish
type: post
published: true
meta:
  geo_public: '0'
  _edit_last: '7257748'
  _publicize_pending: '1'


excerpt_separator: <!--more-->

---
<p>I took this class, that was a survey of different programming languages. PHP, Ruby, Perl, Python, Scheme, and Java (Android Development). It was fast and fun, at the end of every week, depending on concept you either knew the languge enough to write symple code about it, or were taught a programming concept from it.</p>
<p>After the class I continued trying to solve different mathematical problems with scheme using extremely large inputs.</p>
<p>This is a simple problem, convert a decimal to a hexadecimal. The code is self explanatory but here's a list of my lessons learned through this excercise.</p>
<p>Scheme is a <a title="Functions" href="http://htdp.org/2003-09-26/Book/curriculum-Z-H-6.html#node_sec_3.1">Functional </a>Programming language.</p>
{% gist 6fbcf16d689c6c4c1876 %}
<p>1- Types are essential.<br />
this function accepts a number, or an integer. Both types aren't mutually exclusive, depending on your implementation this fact is gold. the returning type is also what allows for the recursion to take place, hence funtion expecting same input type at every iteration</p>
<p>2- error checking<br />
the success of the simple function is checking for errors, on input, and making it separate from the recursion process</p>
<p>3- recursion<br />
you do not appreciate a base case, until you have a complex scheme problem to solve. Your base case is everything. In this example. I append the remainder to the result. getHex is a simple function that prints a Hex character, or numbers, for each iteration until it has reached it's base case.</p>
<p>4- variables<br />
this also teaches you discipline. In other forms of programming, you have the luxury of saving the quotient and using it at every iteration, but the scheme methodology is to calculate the quotient recursively over the remainder, backwards.</p>
<p>5- design<br />
How can you append recursively backwards? Most classic recursions examples move forward, now in this example, I create a two argument function, that places the hex digit first in the output but also recognizes, the dec variable needs to remain a number through the iterations.</p>
