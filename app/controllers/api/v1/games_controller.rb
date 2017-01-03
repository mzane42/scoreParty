class Api::V1::GamesController < ApplicationController
  before_action :set_game, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /games
  def index
    @games = Game.all
    render json: @games
  end

  # GET /games/1
  def show
    render json: @game
  end

  # POST /games
  # Access Key ID:
  #AKIAIVZPLKLGULYSBDAA
  #Secret Access Key:
   #                 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
  def create
    proof = params[:game][:proof_file][:data] if params[:game][:proof_file]
    destination = GlobalHelper::upload_to_s3_from_base64(proof)
    proof_url = GlobalHelper::get_s3_url(destination)
    if proof_url.present?
      verified = true
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
      params.fetch(:game, {}).permit(:opposing_player, :verified, :score_home, :score_away).merge(user_id: current_user.id)
    end
=begin
  def game_params
    params.require(:game)
        .permit(:player_home_id, :player_away_id, :verified, :score_home, :score_away)
  end
=end
end
