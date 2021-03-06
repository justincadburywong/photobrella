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
//= require jquery
//= require jquery-migrate-min
//= require dropzone
//= require popper
//= require bootstrap
//= require rails-ujs
//= require turbolinks
//= require_tree ./features

$(document).on('turbolinks:load', function(){
  eventListeners();
});

function eventListeners(){
  slideShow();
  filter();
  showTagForm();
  submitTags();
  editAllTags();
  deleteImage();
  preventEnterOnFilter();
}

function preventEnterOnFilter(){
  $('#filter').keydown(function(e){
    if(e.keyCode == 13) {
      e.preventDefault();
      return false;
    }
  });
}

function filter(){
  $('#filter').on('input', function () {
    var filter_array = new Array();
    var filter = this.value.toLowerCase();  // no need to call jQuery here
    filter_array = filter.split(' '); // split the user input at the spaces
    var arrayLength = filter_array.length; // Get the length of the filter array
    $('.column').each(function() {
      /* cache a reference to the current .column (you're using it twice) */
      var div = $(this);
      var title = div.find('.tag-value').val().toLowerCase();
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
};

// toggle all edit tag forms
function editAllTags(){
  var counter = 0
  $('#all-tags-button').on('click', function(e){
    if(counter == 0){
      $('.tags').show();
      $('.del').show()
      counter = 1
    }else{
      $('.tags').hide();
      $('.del').hide();
      counter = 0
    };
  })
}

// show the edit tag form
function showTagForm(){
  $('.edit').on('click', function(e){
    $(this).siblings('.tags').toggle();
    $(this).siblings('.del').toggle();
    $('.tag-value').focus();
  })
}

 // submit a tag to an image
function submitTags(){
  $('.tags').on('submit', function(e){
    e.preventDefault();
    $(this).siblings('.del').toggle();
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

function deleteImage(){
  $('.del').on('click', function(e){
    e.preventDefault();
    var postUrl = "/pictures/" + $(this).parent().attr('id').match(/\d+/)
    $.ajax({
      url: postUrl,
      method: 'DELETE'
    }).done(function(data){
      // delete image div
      $(e.target).parent().remove();
    })
  })
};

function findMatches() {
  return $('.column').filter('div:visible');
};

function slide(arrayLength){
  // start the slideshow
  return $('#slideshow-dom').slick({
    slidesToShow: arrayLength,
    slidesToScroll: 1,
    arrows: false,
    // variableWidth: true,
    // adaptiveHeight: true,
    dots: false,
    infinite: true,
    lazyLoad: 'progressive',
    autoplay: true,
    autoplaySpeed: 5000,
    fade: true,
    speed: 1500,
    cssEase: 'linear'
  });
};

function slideShow(){
  $('#slideshow').on('click', function(e){
    e.preventDefault();
    // loop over all pictures to build <img> tags with AWS links as source, data-lazy
    // creat <img> tags and nest under #slideshow
    const matchArray = findMatches(this.value);
    var arrayLength = matchArray.length;
    const html = matchArray.map(function(){
      const originalUrl = $(this).find( "a" ).attr('href')
      return `
        <div>
          <img data-lazy="${originalUrl}"/img>
        </div>
      `;
    }).toArray().join('');
    // hide the rest of the thumbnails
    $('#picture-dom').css("display", "none");

    // add the new images to the DOM
    $('#slideshow-dom').html(html).promise().done(slide(arrayLength));
  });
};
