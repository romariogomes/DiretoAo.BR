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
  
    if current_user

      if (!check_acceptance_existent)

        acceptance = Acceptance.new
        create_interaction_acceptance

        acceptance.like = params[:like]
        acceptance.interaction = @interaction

        acceptance.save
        
      else
        
        if params[:to_delete].nil?
          
          if @loadedAcceptance.first.like
            Acceptance.update(@loadedAcceptance.first.id, like: false)
          else
            Acceptance.update(@loadedAcceptance.first.id, like: true) 
          end

        else
          Acceptance.destroy(@loadedAcceptance.first.id)
          Interaction.destroy(@loadedAcceptance.first.interaction_id)
        end
        
      end
    end
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

  def check_acceptance_existent
  
    interactions = Interaction.where(user_id: current_user.id, law_project_id: params[:law_project])

    if interactions.blank?
      return false
    else
      
      interactions.each do |i|
        
        if ((!i.acceptance.nil?) && (i.law_project_id.eql?(params[:law_project].to_i)))
          @acceptanceInteraction = i
        end
      end
      
      if @acceptanceInteraction.nil?
        return false
      else
        @loadedAcceptance = Acceptance.where(interaction_id: @acceptanceInteraction)
      end
      
    end
    
    if @loadedAcceptance.blank?
      return false
    else
      return true
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
