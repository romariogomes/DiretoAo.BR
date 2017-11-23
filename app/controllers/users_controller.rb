class UsersController < ApplicationController
  before_action :check_privileges!, only: [:index]
  before_action :filterAccess, only: [:show, :edit]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      
      if @user.save
        
        if logged_in?

          format.html { redirect_to users_path, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else

          format.html { redirect_to home_path, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
          sign_in(@user)
        end

      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def politicSpectre

    if (!current_user.nil?)

      coordinates = Array.new

      rankingController = RankingController.new
      rankingController.request = request
      rankingController.response = response
      
      userAcceptances = rankingController.load_all_user_acceptances

      userAcceptances.each do |ua|

        partyOrientation = ua.interaction.law_project.politicians.first.party.orientation
        like = ua.like

        if like
          coordinates = calculateCoordinatesForLike(partyOrientation, like)
        else
          coordinates = calculateCoordinatesForDislike(partyOrientation, like)
        end
      end

      generateSpectreCoordinates(x, y)
    end
  end

  def calculateCoordinatesForLike(orientation, like)
    
    scores = Array.new
    economic = orientation.split.first(2)
    social = orientation.split.last(2)

    if economic.first.eql?("DIREITA")
      scores.push([1])
    else
      scores.push([-1])
    end

    checkOrientationLevelForLike(economic.second, scores[0])

    if social.first.eql?("LIBERTARIO")
      scores.push([-1])
    else
      scores.push([1])
    end    

    checkOrientationLevelForLike(social.second, scores[1])

    return scores
  end

  def checkOrientationLevelForLike(orientation, scores)

    if orientation.eql?("CENTRALIZADA")
      scores[0] =+1
    elsif orientation.eql?("MODERADA")
      scores[0] =+3
    else
      scores[0] =+5
    end
    
  end

  def calculateCoordinatesForDislike(orientation, like)
    
    scores = Array.new
    economic = orientation.split.first(2)
    social = orientation.split.last(2)

    if economic.first.eql?("DIREITA")
      scores.push([-1])
    else
      scores.push([1])
    end

    checkOrientationLevelForDislike(economic.second, scores[0])

    if social.first.eql?("LIBERTARIO")
      scores.push([1])
    else
      scores.push([-1])
    end    

    checkOrientationLevelForDislike(social.second, scores[1])
    
    return scores
  end

  def checkOrientationLevelForDislike(orientation, scores)

    if orientation.eql?("CENTRALIZADA")
      scores[0] =+1
    elsif orientation.eql?("MODERADA")
      scores[0] =-3
    else
      scores[0] =-5
    end
    
  end

  def coordinatesAverage(coordinates)
    economicLine = 0
    socialLine = 0

    coordinates.each do |c|
      economicLine += c[0]
      socialLine += c[1]
    end

    generateSpectreCoordinates(economicLine.to_f/coordinates.size, socialLine.to_f/coordinates.size)
    
  end

  def generateSpectreCoordinates(x, y)
    
    startHash = {
      "question": "Ideologia política",
      "answer": "Some answer",
      "value": x,
      "consequence": y
    }
    
    coordinates = Array.new
    coordinates.push(startHash)

    mountSpectreFile(coordinates)
  end

  def mountSpectreFile(array)

    file = File.new "public/spectreData.json", "w"

    if ( !(lines.empty?) &&  !(lines.nil?) )
      
      lines.each do |a|         
        file.puts a
      end

      file.close
    end
  end

  def check_privileges!
    redirect_to "/" unless (!current_user.nil? && isAdmin?)
  end

  def filterAccess
    if !current_user.nil?
      if !isAdmin?
        if params[:id] != current_user.id.to_s
          redirect_to "/users/"+current_user.id.to_s  
        end  
      end
    else
      redirect_to "/"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :password_digest)
    end
  
end
