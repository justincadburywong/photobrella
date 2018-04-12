Dropzone.autoDiscover = false;

$(function() {
  var pictureDropzone = new Dropzone('#picture_dropzone', {
    url: $('#picture_dropzone').data('url'),
    previewTemplate: $('#dropzone_preview_template').html(),
    previewsContainer: '#dropzone_previews_container',
    acceptedFiles: 'image/*',
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    },
    maxFileSize: 15
  });

  pictureDropzone.on('success', function(file, response) {
    $('#pictures').append(response.picture);

    setTimeout(function() {
      pictureDropzone.removeFile(file)
    }, 3500);
  });
});