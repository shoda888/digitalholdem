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
    if !@current_player.normal?
      @community = @game.communities.create#コミュニティー作成
      @cards = shuffle(build) #シャッフルされた52枚のカード

      community_cards = drawCard([['s',1],['c',7],['s',3],['c',9],['s',5]]) #コミュニティカード作成 #指定
      # community_cards = drawCard(5) #コミュニティカード作成 #ランダム
      community_cards.each do |c|
        @community.cards.create(suit:c.suit, number:c.number)
      end
      #被験者のホールカード決定
      @normal = @game.players.find_by(role: 'normal')
      @hole = @normal.holes.create(community_id: @community.id)
      hole_cards = drawCard([['s',4],['s',2]]) #ホールカード作成 #ランダム
      hole_cards.each do |c|
        @hole.cards.create(suit:c.suit, number:c.number)
      end
      targetcards = @community.cards + @hole.cards
      @hole.hand = hand_judge(targetcards)
      @hole.save

      #サクラのホールカード決定
      @game.players.each do |player|
        next if !player.dealer?
        @hole = player.holes.create(community_id: @community.id)
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
    @player_holes = []
    @community.holes.each do |hole|
      # if !hole.player.normal?
      #   @admin_hole = hole
      #   @admin = @admin_hole.player
      #   @admin_cards = @admin_hole.cards
      #   @admin_name = @admin.name
      # else
      @player_holes << hole
      # end
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
