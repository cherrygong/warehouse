class BrandsController < ApplicationController

  before_action :set_brand, only: [:show, :edit, :update, :destroy]


  def index
    @brands = Brand.all
  end

  def show
  end

  def new
    @brand = Brand.new
  end

  def edit
  end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      redirect_to brands_path
    else
      render 'new'
    end
  end

  def update
    if @brand.update(brand_params)
       redirect_to brands_path
    else
       render 'edit'
    end
  end

  def destroy
    @brand.destroy
    redirect_to brands_path
  end


  private
    def set_brand
      @brand = Brand.find(params[:id])
    end

    # strong parameter for protect project safe,
    # tell rails which parameter can be used in controller
    def brand_params
      params.require(:brand).permit(:brandname)
    end


end
