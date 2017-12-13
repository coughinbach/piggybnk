$('.Count').each(function () {
  var $this = $(this);
  jQuery({ Counter: 0 }).animate({ Counter: $this.text() }, {
    duration: 6000,
    easing: 'swing',
    step: function (i) {
      $this.text(Math.ceil(i));
    }
  });
});
