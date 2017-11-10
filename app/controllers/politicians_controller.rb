class PoliticiansController < ApplicationController
  before_action :filterAccess, except: [:index, :show]
  before_action :set_politician, only: [:show, :edit, :update, :destroy]

  # GET /politicians
  # GET /politicians.json
  def index
    @politicians = Politician.all
  end

  # GET /politicians/1
  # GET /politicians/1.json
  def show
    @listOfPoliticianProjects = @politician.loadProjectsOnPoliticianPage
  end

  # GET /politicians/new
  def new
    @politician = Politician.new
    load_charges
    load_states
    load_parties
  end

  # GET /politicians/1/edit
  def edit
    load_charges
    load_states
    load_parties
  end

  # POST /politicians
  # POST /politicians.json
  def create
    
    @politician = Politician.new(politician_params)
    respond_to do |format|
      if @politician.save
        format.html { redirect_to politicians_path, notice: 'Politician was successfully created.' }
        format.json { render :show, status: :created, location: @politician }
      else
        format.html { render :new }
        format.json { render json: @politician.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /politicians/1
  # PATCH/PUT /politicians/1.json
  def update
    respond_to do |format|
      if @politician.update(politician_params)
        format.html { redirect_to politicians_path, notice: 'Politician was successfully updated.' }
        format.json { render :show, status: :ok, location: @politician }
      else
        format.html { render :edit }
        format.json { render json: @politician.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /politicians/1
  # DELETE /politicians/1.json
  def destroy
    @politician.law_projects.destroy_all if !@politician.law_projects.empty?
    @politician.destroy
    respond_to do |format|
      format.html { redirect_to politicians_url, notice: 'Politician was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def filterAccess!
    redirect_to "/" unless (!current_user.nil? && isAdmin?)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_politician
      @politician = Politician.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def politician_params
      params.require(:politician).permit(:name, :birthdate, :party_id, :photo, :charge_id, :state_id)
    end
end
