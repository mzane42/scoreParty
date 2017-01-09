class Api::V1::GamesController < ApplicationController
  before_action :set_game, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /games
  def index
    @games = Game.select('games.*, sum(games.score_home - games.score_away) as diff_score').group(:id).where(user_id: current_user.id).all.order(created_at: :desc)
    render json: @games.to_json(:include => [:user, :game_type])
  end

  # Dirty codes ...
  def friend_game
    friend_ids = []
    # Controller action should call one model method other an initial find or new
    friends = Friend.where(user_id: current_user.id).all
    friends.each_with_index do |friend, i|
      friend_ids[i] = friend.friend_id
    end
    @games = Game.select('games.*, sum(games.score_home - games.score_away) as diff_score').group(:id).where(user_id: friend_ids).all.order('created_at DESC')
    render json: @games.to_json(:include => [:user, :game_type])
  end

  # End Dirty codes ...
  # GET /games/1
  def show
    render json: @game
  end

  # POST /games
  def create
    proof = params[:game][:proof_file][:data] if params[:game][:proof_file]
    if proof.present?
      destination = GlobalHelper::upload_to_s3_from_base64(proof)
      proof_url = GlobalHelper::get_s3_url(destination)
      if proof_url.present?
        verified = true
      end
    end
    @game = Game.new(game_params.merge(proof_url: proof_url, verified: verified ))

    if @game.save
      render json: @game, status: :created
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      render json: @game, status: :ok
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def game_params
      params.fetch(:game, {}).permit(:opposing_player, :verified, :score_home, :score_away, :description,:game_type_id).merge(user_id: current_user.id)
    end
end
