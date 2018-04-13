class PicturesController < ApplicationController
  before_action :authenticate_user!

  def index
    @pictures = User.find(current_user.id).pictures.sorted
    # additional 'into groups of 4 logic here'
  end

  def create
    # Dropzone will send each file inside of the `:file` param.
    @picture = Picture.create(file: params[:file], user_id: current_user.id)

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

  def update
    @picture = Picture.find(params[:id])
    @tags = params[:tags].split(" ")
    if !@picture.tags
      @picture.tags = []
    end
    @tags.each{|t| @picture.tags << t unless @picture.tags.include?(t)}

    # if @picture.update_attributes(picture_params)
    if @picture.save
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

  private

   def picture_params
     params.require(:picture).permit(:tags, :file_data, :user_id, :id)
   end
end
