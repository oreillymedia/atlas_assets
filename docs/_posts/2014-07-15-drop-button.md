---
layout: default
title:  "Drop Button"
---

Drop Button
===========

<div class="dropbutton"></div>

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
