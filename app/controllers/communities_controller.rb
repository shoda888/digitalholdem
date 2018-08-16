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

      if @game.id == 0
        community_cards = drawCard(5) #コミュニティカード作成 #ランダム
        hole_cards = drawCard(2) #ホールカード作成
      else
        community_cards = drawCard(decide_community_cards(@community.id)) #コミュニティカード作成 #指定
        hole_cards = drawCard(decide_tester_cards(@community.id)) #ホールカード作成
      end
      pp community_cards
      community_cards.each do |c|
        @community.cards.create(suit:c.suit, number:c.number)
      end
      #被験者のホールカード決定
      @tester = @game.players.find_by(role: 'tester')
      @hole = @tester.holes.create(community_id: @community.id)

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
      @player_holes[0] = hole if hole.player.tester?
      @player_holes[1] = hole if hole.player.name == 'player0'
      @player_holes[2] = hole if hole.player.name == 'player1'
    end
    pp @player_holes
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
      return [['s',4],['c',9],['h',3],['c',13],['d',5]]
    when 2
      return [['s',1],['h',8],['s',9],['c',13],['s',12]]
    when 3
      return [['c',1],['d',12],['d',3],['c',9],['d',5]]
    when 4
      return [['h',2],['c',7],['s',3],['s',12],['c',5]]
    when 5
      return [['d',1],['c',7],['h',10],['c',9],['d',6]]
    when 6
      return [['s',10],['c',7],['s',3],['c',4],['s',5]]
    when 7
      return [['s',2],['c',7],['h',3],['c',9],['d',1]]
    when 8
      return [['s',8],['c',2],['s',9],['c',6],['d',8]]
    when 9
      return [['s',13],['c',13],['h',3],['c',10],['d',5]]
    when 0
      return [['d',10],['c',2],['s',3],['s',1],['s',5]]
    end
  end

  def decide_tester_cards(id)
    case id % 10
    when 1
      return [['s',13],['h',13]] #Kのスリーカード(フロップ)
    when 2
      return [['d',4],['s',2]] #ノーペア
    when 3
      return [['s',11],['c',3]] #ワンペア
    when 4
      return [['c',12],['d',12]] #Qのスリーカード(フロップ)
    when 5
      return [['s',7],['h',8]] #ストレート(フロップ)
    when 6
      return [['h',4],['d',9]] #ワンペア
    when 7
      return [['s',1],['h',1]] #Aのスリーカード(フロップ)
    when 8
      return [['c',7],['h',10]] #ストレート(フロップ)
    when 9
      return [['d',7],['c',2]] #ノーペア(フロップ〜ターン)
    when 0
      return [['s',8],['s',11]] #フラッシュ(フロップ)
    end
  end

end
