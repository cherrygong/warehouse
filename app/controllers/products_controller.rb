class ProductsController < ApplicationController

  before_action :load_brand

  def index
    @products = @brand.products.all
  end

  def show
    @product = @brand.products.find(params[:id])
  end

  def new
    @product = @brand.products.new
  end

  def edit
    @product = @brand.products.find(params[:id])
  end

  def create
    @product = @brand.products.new(product_params)

    if @product.save
      redirect_to brand_products_path(@brand)
    else
      render 'new'
    end

  end

  def update
    @product = @brand.products.find(params[:id])

    if @product.update_attributes(product_params)
      redirect_to brand_products_path
    else
      render 'edit'
    end
  end


  def destroy
    @brand = Brand.find(params[:brand_id])
    @product = @brand.products.find(params[:id])
    @product.destroy
    redirect_to brand_path(@brand)
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :brand_id, :description, :stock)
    end

    def load_brand
      @brand = Brand.find(params[:brand_id])
    end
end