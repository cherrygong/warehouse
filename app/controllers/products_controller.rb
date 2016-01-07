class ProductsController < ApplicationController

  before_action :load_brand, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def list
    @products = Product.all

    @products = Product.paginate(:page => params[:page], :per_page => 10)


    if params[:search]
      @products = @products.search(params[:search]).order("created_at DESC").paginate(:per_page => 10, :page => params[:page])
    else
      @products = @products.order('created_at DESC')
    end

    # if params[:search]
    #   @products = Product.search(params[:search]).order('created_at DESC').paginate(:per_page => 2, :page => params[:page])
    #
    # else
    #   @products = Product.order('created_at DESC')
    # end
    # # if params[:search]
    # @products = Product.all
    #
    # if params[:search]
    #   @products = Product.search(params[:search]).order("created_at DESC")
    #   Product.paginate(:page => params[:page], :per_page => 2)
    # else
    #   @products = Product.order('created_at DESC')
    # end

  end

  def show_details
  end

  def index
    @products = @brand.products.all

    if params[:search]
      @products = @brand.products.search(params[:search]).order("created_at DESC")
    else
      @products = @brand.products.order('created_at DESC')
    end
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
      redirect_to brand_products_path, notice: 'Product was successfully created!'
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
    redirect_to :back, notice: 'Product was successfully destroyed!'
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :brand_id, :description, :stock, brands_attributes:[:brandname])
    end

    def load_brand
      @brand = Brand.find(params[:brand_id])
    end

end