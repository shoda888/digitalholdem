class CommunitiesController < ApplicationController
  include CreateDeck
  include HandJudgement

  def index
  end

  def new
  end

  def create
    @community = Community.create(game_id: @current_player.game_id) #コミュニティー作成
    @hole = Hole.create(player_id: @current_player.id)
    @cards = shuffle(build) #シャッフルされた52枚のカード

    @community.game.players.each do |player|
      hole_cards = drawCard(2) #ホールカード作成
      hole_cards.each do |c|
        @hole.cards.create(suit:c.suit, number:c.number)
      end
    end
    community_cards = drawCard(5) #コミュニティカード作成
    community_cards.each do |c|
      @community.cards.create(suit:c.suit, number:c.number)
    end
    redirect_to community_path(@community)
  end

  def show
    @community = Community.find(params[:id])
    @hole = @current_player.holes.last
    @hide_counter = StatusConverter[@community.aasm_state.to_sym] #communityのステータスによって表示カードを決定
  end

  def update
    @community = Community.find(params[:id])
    @hole = @current_player.holes.last
    case @community.aasm_state
    when 'preflop'
      @community.to_flop
    when 'flop'
      @community.to_turn
    when 'turn'
      @community.to_river
    when 'river'
      @community.open
    when 'showdown'
      targetcards = @community.cards + @hole.cards
      @hole.hand = hand_judge(targetcards)
      @hole.save
      @community.finish
    when 'finished'
    end
    @community.save
    redirect_to community_path(@community)
  end
end
