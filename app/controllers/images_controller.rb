class ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def new
    @image = Image.new
  end

  def create
      @image = Image.new(params_image)
      if @image.save
      flash[:notice] = "Success Add Records"
      redirect_to action: 'index'
      else
        flash[:error] = "data not valid"
        render 'new'
      end
  end

  def update
    @image = Image.find_by_id(params[:id])
  
    if @image.update(params_image)
      flash[:notice] = 'Image was successfully updated.'
      redirect_to action: 'index'
    else
      flash[:error] = 'Image not valid'
      render 'edit'
    end 
  end

  def destroy
    @image = Image.find(params[:id])
    if @image.destroy
      flash[:notice] = "Deleted"
      redirect_to action: 'index'
    else
      flash[:notice] = "fails delete a records"
      render 'edit'
    end 
  end

  def edit
    @image = Image.find_by_id(params[:id])
  end

  def show
    @image = Image.find_by_id(params[:id])
  end

  def params_image
    params.require(:image).permit(:title, :url, :description)
  end

end
