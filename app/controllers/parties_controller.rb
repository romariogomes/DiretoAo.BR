class PartiesController < ApplicationController
  before_action :filterAccess, except: [:index, :show]
  before_action :load_ideologies, only: [:new, :edit]
  before_action :set_party, only: [:show, :edit, :update, :destroy]

  # GET /parties
  # GET /parties.json
  def index
    @parties = Party.all
  end

  # GET /parties/1
  # GET /parties/1.json
  def show
  end

  # GET /parties/new
  def new
    @party = Party.new
  end

  # GET /parties/1/edit
  def edit
  end

  # POST /parties
  # POST /parties.json
  def create
    
    @party = Party.new
    @party.name = party_params[:name]
    @party.orientation = party_params[:economic_orientation] + ' ' + party_params[:social_orientation]

    respond_to do |format|
      if @party.save
        format.html { redirect_to @party, notice: 'Party was successfully created.' }
        format.json { render :show, status: :created, location: @party }
      else
        format.html { render :new }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parties/1
  # PATCH/PUT /parties/1.json
  def update
    respond_to do |format|
      if @party.update(party_params)
        format.html { redirect_to @party, notice: 'Party was successfully updated.' }
        format.json { render :show, status: :ok, location: @party }
      else
        format.html { render :edit }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parties/1
  # DELETE /parties/1.json
  def destroy
    @party.destroy
    respond_to do |format|
      format.html { redirect_to parties_url, notice: 'Party was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def filterAccess
    redirect_to "/" unless (!current_user.nil? && isAdmin?)
  end

  def load_ideologies
    @economicIdeologies = ['DIREITA CENTRALIZADA', 'DIREITA MODERADA', 'DIREITA EXTREMA', 'ESQUERDA CENTRALIZADA', 'ESQUERDA MODERADA', 'ESQUERDA EXTREMA' ]
    @socialIdeologies = ['AUTORITARIO CENTRALIZADA', 'AUTORITARIO MODERADA', 'AUTORITARIO EXTREMA', 'LIBERTARIO CENTRALIZADA', 'LIBERTARIO MODERADA', 'LIBERTARIO EXTREMA' ]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_party
      @party = Party.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def party_params
      params.require(:party).permit(:name, :orientation, :social_orientation, :economic_orientation)
    end
end
