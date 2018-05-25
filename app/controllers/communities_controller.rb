class CommunitiesController < ApplicationController
  before_action :authenticate_player
  include CreateDeck
  include HandJudgement

  def index
  end

  def new
    @game = @current_player.game
  end

  def create
    @game = @current_player.game
    if @current_player.admin?
      @community = @game.communities.create#コミュニティー作成
      @cards = shuffle(build) #シャッフルされた52枚のカード

      community_cards = drawCard(5) #コミュニティカード作成
      community_cards.each do |c|
        @community.cards.create(suit:c.suit, number:c.number)
      end

      @game.players.each do |player|
        @hole = player.holes.create
        hole_cards = drawCard(2) #ホールカード作成
        hole_cards.each do |c|
          @hole.cards.create(suit:c.suit, number:c.number)
        end
        targetcards = @community.cards + @hole.cards
        @hole.hand = hand_judge(targetcards)
        @hole.save
      end
      CommunityChannel.broadcast_to(@current_player.game, { message: 'start' })
    else
      @community = @game.communities.last
    end
    redirect_to community_path(@community)
  end

  def show
    @community = Community.find(params[:id])
    @game = @community.game
    @holes = []
    @game.players.each do |player|
      @holes << player.holes.last
    end
  end

  def update
  end
  def destroy
    @current_player.game_id = nil
    @current_player.save
    redirect_to games_path
  end
end
