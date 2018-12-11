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
      @id = @community.id
      @game_id = @game.id
      @cards = shuffle(build) #シャッフルされた52枚のカード

      if @game_id == 0
        community_cards = drawCard(5) #コミュニティカード作成 #ランダム
        hole_cards = drawCard(2) #ホールカード作成
      else
        community_cards = drawCard(decide_community_cards(@id)) #コミュニティカード作成 #指定
        hole_cards = drawCard(decide_tester_cards(@id)) #ホールカード作成
      end
      community_cards.each do |c|
        @community.cards.create(suit:c.suit, number:c.number)
      end
      #被験者のホールカード決定
      @tester = @game.players.find_by(role: 'tester')
      @hole = @tester.holes.create(community_id: @id)

      hole_cards.each do |c|
        @hole.cards.create(suit:c.suit, number:c.number)
      end
      targetcards = @community.cards + @hole.cards
      @hole.hand = hand_judge(targetcards)
      @hole.save

      #サクラのホールカード決定
      @game.players.each do |player|
        next if !player.participants?
        @hole = player.holes.create(community_id: @id)
        if @game_id == 0
          hole_cards = drawCard(2)
        else
          if player.name == 'player0'
            hole_cards = drawCard(decide_player0_cards(@id)) #ホールカード作成
          elsif player.name == 'player1'
            hole_cards = drawCard(decide_player1_cards(@id)) #ホールカード作成
          end
        end
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
      @community.created_at = Time.now
      @community.save
    end
    redirect_to community_path(@community)
  end

  def show
    @community = Community.find(params[:id])
    @player_holes = []
    @community.holes.each do |hole|
      @player_holes[2] = hole if hole.player.tester?
      @player_holes[1] = hole if hole.player.name == 'player0'
      @player_holes[0] = hole if hole.player.name == 'player1'
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
  def decide_player0_cards(id)
    case id % 15
    when 1 # 3ワンペア
      return [['s',4],['h',11]]
    when 2 # ノーペア
      return [['h',10],['s',12]]
    when 3 # ノーペア
      return [['c',5],['h',2]]
    when 4 # 4 ワンペア
      return [['h',11],['s',7]]
    when 5 # 3 10 ツーペア
      return [['h',12],['c',2]]
    when 6 # 4 ワンペア
      return [['d',9],['h',4]]
    when 7 # ノーペア
      return [['c',1],['s',10]]
    when 8 # 5 7 ツーペア
      return [['d',10],['d',3]]
    when 9 # 2 ワンペア
      return [['c',7],['s',7]]
    when 10 # 8ハイフルハウス
      return [['c',10],['h',10]]
    when 11 # 11 ワンペア
      return [['h',8],['s',11]]
    when 12 # 9 ストレート
      return [['h',13],['s',6]]
    when 13 # ノーペア
      return [['d',1],['h',13]]
    when 14 #ダイヤフラッシュ
      return [['c',8],['s',2]]
    when 0 # 10 ワンペア
      return [['h',3],['h',2]]
    end
  end
  def decide_player1_cards(id)
    case id % 15
    when 1 # 3ワンペア
      return [['c',6],['d',10]]
    when 2 # ノーペア
      return [['c',7],['s',6]]
    when 3 # ノーペア
      return [['s',8],['h',11]]
    when 4 # 4 ワンペア
      return [['d',2],['d',5]]
    when 5 # 3 10 ツーペア
      return [['d',4],['h',6]]
    when 6 # 4 ワンペア
      return [['h',12],['s',10]]
    when 7 # ノーペア
      return [['d',9],['d',13]]
    when 8 # 5 7 ツーペア
      return [['c',4],['c',9]]
    when 9 # 2 ワンペア
      return [['h',12],['h',2]]
    when 10 # 8ハイフルハウス
      return [['c',12],['d',6]]
    when 11 # 11 ワンペア
      return [['c',2],['c',5]]
    when 12 # 9 ストレート
      return [['s',8],['d',10]]
    when 13 # ノーペア
      return [['h',9],['s',7]]
    when 14 #ダイヤフラッシュ
      return [['d',1],['d',5]]
    when 0 # 10 ワンペア
      return [['c',11],['c',1]]
    end
  end
  def decide_community_cards(id)
    case id % 15
    when 1 # 3ワンペア
      return [['h',13],['d',3],['h',7],['s',5],['s',3]]
    when 2 # ノーペア
      return [['d',7],['h',11],['h',1],['h',6],['s',13]]
    when 3 # ノーペア
      return [['h',1],['d',5],['c',8],['d',4],['s',13]]
    when 4 # 4 ワンペア
      return [['h',7],['h',1],['c',6],['c',8],['s',2]]
    when 5 # 3 10 ツーペア
      return [['c',11],['s',3],['s',10],['c',9],['d',6]]
    when 6 # 4 ワンペア
      return [['c',11],['s',9],['d',13],['c',4],['s',5]]
    when 7 # ノーペア
      return [['d',2],['s',5],['s',11],['c',9],['d',1]]
    when 8 # 5 7 ツーペア
      return [['d',13],['h',7],['h',5],['d',5],['h',4]]
    when 9 # 2 ワンペア
      return [['s',12],['s',2],['s',3],['d',2],['h',1]]
    when 10 # 8ハイフルハウス
      return [['d',8],['c',5],['c',8],['s',1],['s',5]]
    when 11 # 11 ワンペア
      return [['h',4],['h',11],['h',7],['d',11],['d',6]]
    when 12 # 9 ストレート
      return [['h',6],['c',9],['d',11],['d',7],['h',9]]
    when 13 # ノーペア
      return [['s',12],['h',2],['d',5],['h',7],['c',11]]
    when 14 #ダイヤフラッシュ
      return [['h',12],['d',3],['d',6],['d',13],['c',6]]
    when 0 # 10 ワンペア
      return [['h',4],['s',3],['d',12],['d',5],['s',10]]
    end
  end
  def decide_tester_cards(id)
    case id % 15
    when 1
      return [['h',5],['h',9]]
    when 2
      return [['h',4],['c',10]]
    when 3
      return [['s',6],['h',13]]
    when 4
      return [['h',4],['c',4]]
    when 5
      return [['d',3],['c',10]]
    when 6
      return [['s',4],['c',7]]
    when 7
      return [['d',7],['h',3]]
    when 8
      return [['c',7],['s',10]]
    when 9
      return [['c',4],['c',10]]
    when 10
      return [['s',12],['h',8]]
    when 11
      return [['d',9],['c',3]]
    when 12
      return [['c',5],['d',8]]
    when 13
      return [['d',10],['d',8]]
    when 14
      return [['d',12],['d',11]]
    when 0
      return [['c',10],['d',7]]
    end
  end

end
