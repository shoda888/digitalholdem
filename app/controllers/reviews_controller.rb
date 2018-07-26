class ReviewsController < ApplicationController
  before_action :authenticate_player

  def new
    @community = Community.find(params[:community_id])
    @review = Review.new(community_id: @community.id)
  end

  def create
    @community = Community.find(params[:community_id])
    @review = Review.new(community_id: @community.id)
    @review.attributes = review_params
    if @review.save
      @game = @current_player.game
      @community = @game.communities.last
      redirect_to community_path(@community)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:confidence)
  end
end
