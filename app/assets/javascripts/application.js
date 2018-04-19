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
  preventEnter();
}

function preventEnter(){
  $(window).keydown(function(e){
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

function findMatches() {
  return $('.column').filter('div:visible');
}

function slideShow(){
  $('#slideshow').on('click', function(e){
    e.preventDefault();
    // loop over all pictures to build <img> tags with AWS links as source, data-lazy
    // creat <img> tags and nest under #slideshow
    const matchArray = findMatches(this.value);
    console.log(matchArray);
    var arrayLength = matchArray.length;
    const html = matchArray.map(function(){
      const originalUrl = $(this).find( "a" ).attr('href')
      return `
        <img data-lazy='${originalUrl}'/img>
      `;
    }).join('');

    // hide the rest of the thumbnails
    $('#picture-dom').css("display", "none");

    // add the new images to the DOM
    $('#slideshow-dom').innerHTML = html;

    // start the slideshow
    // $('#slideshow-dom').slick({
    //   slidesToShow: arrayLength,
    //   slidesToScroll: 1,
    //   centerMode: true,
    //   arrows: false,
    //   // variableWidth: true,
    //   adaptiveHeight: true,
    //   dots: false,
    //   infinite: true,
    //   lazyLoad: 'ondemand',
    //   autoplay: true,
    //   autoplaySpeed: 3000,
    //   fade: true,
    //   speed: 500,
    //   cssEase: 'linear'
    // });

  });
};
