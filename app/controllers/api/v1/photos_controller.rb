class Api::V1::PhotosController < ApiController
  before_action :authenticate_user!, except: :index
  def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find_by(id: params[:id])
    if !@photo
      render json: {
        message: "Can't find the photo!",
        status: 400
      }
    else
      render "api/v1/photos/show"
    end
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      render json: {
        message: "Photo created successfully!",
        result: @photo
      }
    else
      render json: {
        errors: @photo.errors
      }
    end 
  end  

  def update
    @photo = Photo.find_by(id: params[:id])
    if @photo.update(photo_params)
      render json: {
        message: "Photo updated successfully!",
        result: @photo
      }
    else
      render json: {
      errors: @photo.errors
      }
    end
  end

  def destroy
    @photo = Photo.find_by(id: params[:id])
    @photo.destroy
      render json: {
        message: "Photo destry successfully!"
      }
  end
 
  private

  def photo_params
    params.permit(:title, :date, :description, :file_location)
  end
end
