class ProductsController < ApplicationController
  def index
    @products = Product.all
    @denominations = Denomination.all.order(created_at: :asc)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: "Product created successfully"
    else
      render :new, alert: "Failed to create product"
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path, notice: "Product updated successfully"
    else
      render :edit, alert: "Failed to update product"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: "Product deleted successfully"
  end

  private

  def product_params
    params.require(:product).permit(
      :name, :product_code, :unit_price, :tax_percentage, :stock_quantity
    )
  end
end
