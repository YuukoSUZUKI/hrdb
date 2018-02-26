class TarentsController < ApplicationController
  before_action :set_tarent, only: [:show, :edit, :update, :destroy]

  # GET /tarents
  # GET /tarents.json
  def index
    @tarents = Tarent.all
  end

  # GET /tarents/1
  # GET /tarents/1.json
  def show
  end

  # GET /tarents/new
  def new
    @tarent = Tarent.new
  end

  # GET /tarents/1/edit
  def edit
  end

  # POST /tarents
  # POST /tarents.json
  def create
    @tarent = Tarent.new(tarent_params)

    respond_to do |format|
      if @tarent.save
        format.html { redirect_to @tarent, notice: 'Tarent was successfully created.' }
        format.json { render :show, status: :created, location: @tarent }
      else
        format.html { render :new }
        format.json { render json: @tarent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tarents/1
  # PATCH/PUT /tarents/1.json
  def update
    respond_to do |format|
      if @tarent.update(tarent_params)
        format.html { redirect_to @tarent, notice: 'Tarent was successfully updated.' }
        format.json { render :show, status: :ok, location: @tarent }
      else
        format.html { render :edit }
        format.json { render json: @tarent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tarents/1
  # DELETE /tarents/1.json
  def destroy
    @tarent.destroy
    respond_to do |format|
      format.html { redirect_to tarents_url, notice: 'Tarent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tarent
      @tarent = Tarent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tarent_params
      params.require(:tarent).permit(:learning_level, :user_id, :skill_id)
    end
end
