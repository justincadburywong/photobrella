// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require dropzone
//= require popper
//= require bootstrap
//= require rails-ujs
//= require turbolinks
//= require_tree ./features


$(document).ready(function(){
  eventListeners();
})

function eventListeners(){
  slideShow();
  search();
}

function search(){
  $('#search').on('keyup', function(e){
    console.log(this.value);
  });
};

function slideShow(){
  $('#slideshow').on('click', function(e){
    e.preventDefault();
    $('#picture_dropzone').css("display", "none");
    $('#pictures').slick({
      slidesToShow: 80,
      slidesToScroll: 80,
      centerMode: true,
      arrows: false,
      variableWidth: true,
      // adaptiveHeight: true,
      dots: false,
      infinite: true,
      lazyLoad: 'ondemand',
      autoplay: true,
      autoplaySpeed: 3000,
      fade: true,
      speed: 500,
      cssEase: 'linear'
    });
  });
};
