class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build_with_user review_params, current_user

    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        if user_signed_in?
          redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
        else
          redirect_to new_user_session_path, alert: 'Please sign in'
        end
      else
        render :new
      end
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if current_user.reviews.include? @review
      @review.update(review_params)
      redirect_to '/restaurants'
    else
      redirect_to '/restaurants', alert: "Not your review"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = 'Review deleted successfully'
    redirect_to '/restaurants'
  end

  private
  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
