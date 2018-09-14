class ReviewsController < ApplicationController
  before_filter :current_user?

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.create(review_params)
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product)
    else
      render 'show'
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = @product.reviews.find(params[:id])
    @review.destroy
    redirect_to product_path(@product)
  end

  def current_user?
    defined? current_user
  end

  private

  def review_params
    params.require(:review).permit(
      :description,
      :rating
    )
  end

end
