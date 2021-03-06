class BrandsController < ApplicationController


  before_action :set_brand, only: [:show, :edit, :update, :destroy]


  def index
    @brands = Brand.all

    @brands = Brand.paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  def new
    @brand = Brand.new
    @brand.products.build
  end

  def edit
    @brand = Brand.find(params[:id])
    @product = @brand.products.build
  end


  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      redirect_to @brand, notice: 'Brand was successfully created!'
    else
      render 'new'
    end
  end

  def update
    @brand = Brand.find(params[:id])


    if @brand.update(brand_params)
       redirect_to brands_path
    else
       render 'edit'
    end
  end

  def destroy
    @brand.destroy
    redirect_to :back, notice: 'Brand was successfully destroyed!'
  end


  private
    def set_brand
      @brand = Brand.find(params[:id])
    end

    # strong parameter for protect project safe,
    # tell rails which parameter can be used in controller
    def brand_params
      params.require(:brand).permit(:brandname, :image, products_attributes:[:id, :name])
    end


end
