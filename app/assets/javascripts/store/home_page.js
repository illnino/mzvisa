// Can also be used with $(document).ready()
$(window).load(function() {
  $('.flexslider').flexslider({
    animation: "slide",
    animationLoop: true,
    itemWidth: 100,
    itemMargin: 0,
    minItems: 2,
    maxItems: 6
  });
});