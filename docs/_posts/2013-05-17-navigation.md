---
layout: default
title:  "Navigation"
date:   2013-05-17 23:24:04
---

Navigation
==========

Basic Navbar
-------------

<div class="navbar">
	<div class="navbar-inner">
		<a class="brand" href="/">Brand</a>
		<ul class="nav">
		  <li><a href="#">Item 1</a></li>
		  <li><a href="#">Item 2</a></li>
		</ul>
	</div>
</div>

~~~html
<div class="navbar">
	<div class="navbar-inner">
		<a class="brand" href="/">Brand</a>
		<ul class="nav">
		  <li><a href="#">Item 1</a></li>
		  <li><a href="#">Item 2</a></li>
		</ul>
	</div>
</div>
~~~

### Alignment

You can align a `.nav` to the right by appending a `.pull-right` class.

<div class="navbar">
	<div class="navbar-inner">
		<a class="brand" href="/">Brand</a>
		<ul class="nav pull-right">
		  <li><a href="#">Item 1</a></li>
		  <li><a href="#">Item 2</a></li>
		</ul>
	</div>
</div>

~~~html
<ul class="nav pull-right">
  <li><a href="#">Item 1</a></li>
  <li><a href="#">Item 2</a></li>
</ul>
~~~

### Input

<div class="navbar">
	<div class="navbar-inner">
		<a class="brand" href="/">Brand</a>
		<ul class="nav pull-right">
		  <li><form><input type="text" placeholder="Search ..." /></form></li>
		</ul>
	</div>
</div>

~~~html
<ul class="nav pull-right">
  <li><form><input type="text" placeholder="Search ..." /></form></li>
</ul>
~~~

Footer
------

The gem also includes style for a footer. It can be used with `.row` and `.spanNUM` classes. `<ul>` elements in the footer will automatically get styled without bullets, and with a special header font applied to the first `<li>`. The footer should be used outside the `.container` class, with a `.container` element inside the footer.

<footer>
	<div class="row">
		<div class="span3 offset1">
			This is a footer
			<p class="small">All trademarks and registered trademarks appearing on oreilly.com are the property of their respective owners.</p>
		</div>
		<div class="span3 offset1">
			<ul>
					<li>About O'Reilly</li>
					<li><a href="#">Academic Solutions</a></li>
					<li><a href="#">Jobs</a></li>
					<li><a href="#">Contact</a></li>
      </ul>
		</div>
	</div>
</footer>
<br />

~~~html
<footer>
	<div class="row">
		<div class="span3 offset1">
			This is a footer
			<p class="small">All trademarks and registered trademarks appearing on oreilly.com are the property of their respective owners.</p>
		</div>
		<div class="span3 offset1">
			<ul>
				<li>About O'Reilly</li>
				<li><a href="#">Academic Solutions</a></li>
				<li><a href="#">Jobs</a></li>
				<li><a href="#">Contact</a></li>
      </ul>
		</div>
	</div>
</footer>
~~~