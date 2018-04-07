class PicturesController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @pictures = Picture.sorted
  end

  def create
    # Dropzone will send each file inside of the `:file` param.
    @picture = Picture.create(file: params[:file])

    # Return a json response of the partial `_picture.html.erb` so Dropzone can append the uploaded image to the dom if the `@picture` object was successfully created.
    if @picture
      # Reuse existing partial
      picture_partial = render_to_string(
        'pictures/_picture',
        layout: false,
        formats: [:html],
        locals: { picture: @picture }
      )

      render json: { picture: picture_partial }, status: 200
    else
      render json: @picture.errors, status: 400
    end
  end

end
