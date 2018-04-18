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
  filter();
  showTagForm();
  editTags();
}

function filter(){
  // $('#filter').on('input', function(e){
  //   var searchTags, imageTags;
  //   searchTags = this.value;
  //   $('.tag-value').each(function(){
      // console.log(searchTags);
      // console.log($(this).text());

      // if($(this).text().toUpperCase().indexOf(searchTags.toUpperCase()) != -1){
      //      $(this).hide();
      //    }


       $('#filter').on('input', function () {
           var filter_array = new Array();
           var filter = this.value.toLowerCase();  // no need to call jQuery here
           filter_array = filter.split(' '); // split the user input at the spaces
           // console.log("words " + filter_array);
           var arrayLength = filter_array.length; // Get the length of the filter array
           // console.log("array length " + arrayLength)
           $('.column').each(function() {
               /* cache a reference to the current .column (you're using it twice) */
               var div = $(this);
               var title = div.find('.tag-value').val().toLowerCase();
               console.log(title);
               // title and filter are normalized in lowerCase letters for a case insensitive search

               var hidden = 0; // Set a flag to see if a div was hidden

               // Loop through all the words in the array and hide the div if found
               for (var i = 0; i < arrayLength; i++) {
                    if (title.indexOf(filter_array[i]) < 0) {
                       div.hide();
                       hidden = 1;
                   }
               }
               // If the flag hasn't been tripped show the div
               if (hidden == 0)  {
                  div.show();
               }
           });
        });
  //
  //   };
  // });
};

// show the edit tag form
function showTagForm(){
  $('.fa-edit').on('click', function(e){
    var edit = $(this).siblings('form');
    edit.toggle();
  })
}

 // submit a tag to an image
function editTags(){
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
