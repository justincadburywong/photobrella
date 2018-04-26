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
    respond_to do |format|
      format.json { head :no_content, notice: "Picture #{@picture.id} updated."}
      format.html { redirect_to root_path, notice: "Picture #{@picture.id} updated." }
    end
  end

  def destroy
    @picture.file[:original].delete
    @picture.file[:thumbnail].delete
    @picture.destroy
    respond_to do |format|
      format.json { head :no_content, notice: "Picture #{@picture.id} was successfully destroyed."}
      format.html { redirect_to root_path, notice: "Picture #{@picture.id} was successfully destroyed." }
    end
  end

  private

   def picture_params
     params.require(:picture).permit(:file, :tags, :id)
   end

   def find_picture
     @picture = Picture.find(params[:id])
   end
end
