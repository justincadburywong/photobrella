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
  showTagForm();
  editTags();
}

function search(){
  $('#search').on('input', function(e){
    var searchTags, tags, filter, tags, i;
    searchTags = this.value.split(" ");
    console.log(searchTags);
    tags = document.getElementByClass('tags');
    filter = searchTags.value.toLowerCase();
    // ul = document.getElementById("myUL");
    // li = ul.getElementsByTagName('li');

    // Loop through all list items, and hide those who don't match the search query
    for (i = 0; i < tags.length; i++) {
        selectedTag = tags[i].getElementsByClass(tags)[0];
        if (a.innerHTML.toUpperCase().indexOf(filter) > -1) {
            tags[i].style.display = "";
        } else {
            tags[i].style.display = "none";
        }
    }
  });
};

// show the edit tag form
function showTagForm(){
  $('.fa-edit').on('click', function(e){
    var edit = $(this).siblings('form');
    edit.toggle();
  })
}

 // submit a tag to an image
var editTags = function(){
  $('.tags').on('submit', function(e){
    e.preventDefault();
    var tags, postUrl, data;
    tags = $(this);
    postUrl = $(this).attr('action');
    data = $(this).children(':first').serialize();
    $.ajax({
    	url: postUrl,
    	method: 'PUT',
      data: data
    }).done(function(data) {
			tags.toggle();
			$('.tag-value').empty();
			$('.tag-value').prepend(data);
    });
  })
};

function slideShow(){
  $('#slideshow').on('click', function(e){
    e.preventDefault();
    // $(".lazyload").width("100%")
    $('#picture_dropzone').css("display", "none");
    $('#pictures').slick({
      slidesToShow: 80,
      slidesToScroll: 1,
      centerMode: true,
      arrows: false,
      // variableWidth: true,
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
