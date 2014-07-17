---
layout: default
title:  "Drop Button"
---

Drop Button
===========

<div class="dropbutton"></div>

Use this drop button when you want to have one main button but also maybe sometimes a few other actions that are useful to have but you don't think will get used often.


~~~javascript
$(function () {
    window.dropbutton = new classes.DropButtonView({ 
        models: [{
            label: "Main option",
            main: true,
            onclick: "http://google.com"
        },
        {
            label: "Secondary option",
            onclick: function () {
                alert("You clicked the secondary option")
            },
            className: "secondary"
        },
        {
            label: "Tertiary option",
            onclick: "/colors.html"
        },
        {
            label: "Quaternary?",
            onclick: "/tabs.html",
            className: "quaternary warning"
        }]
    })
    $('.dropbutton').html(dropbutton.render().el)
})
~~~

Custom CSS:

~~~css
.quaternary.warning {
    background-color: red;
}

.secondary a {
    color: green;
}
~~~

<style>
.quaternary.warning {
    background-color: red;
}

.secondary a {
    color: green;
}
</style>

<script type="text/javascript">
$(function () {
    window.dropbutton = new classes.DropButtonView({ 
        models: [{
            label: "Main option",
            main: true,
            onclick: "http://google.com"
        },
        {
            label: "Secondary option",
            onclick: function () {
                alert("You clicked the secondary option")
            },
            className: "secondary"
        },
        {
            label: "Tertiary option",
            onclick: "/colors.html"
        },
        {
            label: "Quaternary?",
            onclick: "/tabs.html",
            className: "quaternary warning"
        }]
    })
    $('.dropbutton').html(dropbutton.render().el)
})
</script>
