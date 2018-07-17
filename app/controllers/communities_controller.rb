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

      community_cards = drawCard(decide_community_cards(@community.id)) #コミュニティカード作成 #指定
      # community_cards = drawCard(5) #コミュニティカード作成 #ランダム
      community_cards.each do |c|
        @community.cards.create(suit:c.suit, number:c.number)
      end
      #被験者のホールカード決定
      @tester = @game.players.find_by(role: 'tester')
      @hole = @tester.holes.create(community_id: @community.id)
      # hole_cards = drawCard([['s',4],['s',2]]) #ホールカード作成
      hole_cards = drawCard(decide_tester_cards(@community.id)) #ホールカード作成
      hole_cards.each do |c|
        @hole.cards.create(suit:c.suit, number:c.number)
      end
      targetcards = @community.cards + @hole.cards
      @hole.hand = hand_judge(targetcards)
      @hole.save

      #サクラのホールカード決定
      @game.players.each do |player|
        next if !player.participants?
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
      @player_holes << hole
    end
  end
  def update
  end
  def destroy
    @current_player.game_id = nil
    @current_player.save
    redirect_to games_path
  end

  private
  def decide_community_cards(id)
    case id % 10
    when 1
      return [['s',1],['c',7],['h',3],['c',9],['d',5]]
    when 2
      return [['s',1],['c',7],['s',3],['c',9],['s',5]]
    when 3
      return [['s',1],['c',7],['h',3],['c',9],['d',5]]
    when 4
      return [['s',1],['c',7],['s',3],['c',9],['s',5]]
    when 5
      return [['s',1],['c',7],['h',3],['c',9],['d',5]]
    when 6
      return [['s',1],['c',7],['s',3],['c',9],['s',5]]
    when 7
      return [['s',1],['c',7],['h',3],['c',9],['d',5]]
    when 8
      return [['s',1],['c',7],['s',3],['c',9],['s',5]]
    when 9
      return [['s',1],['c',7],['h',3],['c',9],['d',5]]
    when 0
      return [['s',1],['c',7],['s',3],['c',9],['s',5]]
    end
  end

  def decide_tester_cards(id)
    case id % 10
    when 1
      return [['s',4],['s',3]]
    when 2
      return [['s',4],['s',2]]
    when 3
      return [['s',4],['s',3]]
    when 4
      return [['s',4],['s',2]]
    when 5
      return [['s',4],['s',3]]
    when 6
      return [['s',4],['s',2]]
    when 7
      return [['s',4],['s',3]]
    when 8
      return [['s',4],['s',2]]
    when 9
      return [['s',4],['s',2]]
    when 0
      return [['s',4],['s',2]]
    end
  end

end
