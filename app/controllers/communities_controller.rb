class CommunitiesController < ApplicationController
  include CreateDeck
  include HandJudgement

  def index
  end

  def new
  end

  def create
    @community = Community.create(game_id: @current_player.game_id) #コミュニティー作成
    @cards = shuffle(build) #シャッフルされた52枚のカード

    @community.game.players.each do |player|
      player_cards = drawCard(2) #ホールカード作成
      player_cards.each do |c|
        player.cards.create(suit:c.suit, number:c.number)
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
    @hide_counter = StatusConverter[@community.aasm_state.to_sym] #communityのステータスによって表示カードを決定
  end

  def update
    @community = Community.find(params[:id])
    case @community.aasm_state
    when 'preflop'
      @community.to_flop
    when 'flop'
      @community.to_turn
    when 'turn'
      @community.to_river
    when 'river'
      @community.to_showtime
    when 'showtime'
      @community.game.players.each do |player|
        targetcards = @community.cards + player.cards
        player.hand = hand_judge(targetcards)
        player.save
      end

      @community.finish
    end
    @community.save
    redirect_to community_path(@community)
  end
end
