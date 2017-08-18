class AcceptancesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_acceptance, only: [:show, :edit, :update, :destroy]

  # GET /acceptances
  # GET /acceptances.json
  def index
    @acceptances = Acceptance.all
  end

  # GET /acceptances/1
  # GET /acceptances/1.json
  def show
  end

  # GET /acceptances/new
  def new
    @acceptance = Acceptance.new
  end

  # GET /acceptances/1/edit
  def edit
  end

  def acceptancesInterceptor
    
    acceptance = Acceptance.new
    interaction = Interaction.new
    
    interaction.user = current_user
    interaction.law_project = LawProject.find(params[:law_project])

    interaction.save
    
    acceptance.like = params[:like]
    acceptance.interaction = interaction
    acceptance.save    
  end
  # POST /acceptances
  # POST /acceptances.json
  def create
    @acceptance = Acceptance.new(acceptance_params)

    respond_to do |format|
      if @acceptance.save
        format.html { redirect_to @acceptance, notice: 'Acceptance was successfully created.' }
        format.json { render :show, status: :created, location: @acceptance }
      else
        format.html { render :new }
        format.json { render json: @acceptance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acceptances/1
  # PATCH/PUT /acceptances/1.json
  def update
    respond_to do |format|
      if @acceptance.update(acceptance_params)
        format.html { redirect_to @acceptance, notice: 'Acceptance was successfully updated.' }
        format.json { render :show, status: :ok, location: @acceptance }
      else
        format.html { render :edit }
        format.json { render json: @acceptance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acceptances/1
  # DELETE /acceptances/1.json
  def destroy
    @acceptance.destroy
    respond_to do |format|
      format.html { redirect_to acceptances_url, notice: 'Acceptance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acceptance
      @acceptance = Acceptance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acceptance_params
      params.require(:acceptance).permit(:like)
    end
end
