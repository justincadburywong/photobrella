class PicturesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_picture, only: [:update, :destroy]

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
    @tags = params[:tags].split(" ")
    @picture.tags = []
    @tags.each{|t| @picture.tags << t}

    # if @picture.update_attributes(picture_params)
    if @picture.save
      flash[:notice] = "Picture #{@picture.id} updated!"
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

  def destroy
    p @picture
    @picture.destroy
    flash[:notice] = "Picture #{@picture.id} deleted!"
    redirect_to root_path
  end

  private

   def picture_params
     params.require(:picture).permit(:tags, :id)
   end

   def find_picture
     @picture = Picture.find(params[:id])
   end
end
