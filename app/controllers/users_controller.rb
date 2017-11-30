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
          coordinates.push(calculateCoordinatesForLike(partyOrientation, like))
        else
          coordinates.push(calculateCoordinatesForDislike(partyOrientation, like))
        end
      end
      
      coordinatesAverage(coordinates)

    end
  end

  def calculateCoordinatesForLike(orientation, like)
    
    scores = Array.new
    economic = orientation.split.first(2)
    social = orientation.split.last(2)

    if economic.first.eql?("DIREITA")
      scores.push(4)
    else
      scores.push(2)
    end

    scores = checkOrientationLevel(economic.second, scores, 0)
    
    if social.first.eql?("LIBERTARIO")
      scores.push(2)
    else
      scores.push(4)
    end    

    scores = checkOrientationLevel(social.second, scores, 1)

    return scores
  end

  def checkOrientationLevel(orientation, scores, index)
    # if orientation.eql?("CENTRALIZADA")
    #   scores[index]<0 ? scores[index]-=1 : scores[index]+=1
    # elsif orientation.eql?("MODERADA")
    #   scores[index]<0 ? scores[index]-=3 : scores[index]+=3
    # else
    #   scores[index]<0 ? scores[index]-=5 : scores[index]+=5
    # end

    if orientation.eql?("CENTRALIZADA")
      scores[index]<3 ? scores[index]-=0 : scores[index]+=0
    elsif orientation.eql?("MODERADA")
      scores[index]<3 ? scores[index]-=1 : scores[index]+=1
    else
      scores[index]<3 ? scores[index]-=2 : scores[index]+=2
    end
    
    return scores
  end

  def calculateCoordinatesForDislike(orientation, like)
    
    scores = Array.new
    economic = orientation.split.first(2)
    social = orientation.split.last(2)

    if economic.first.eql?("DIREITA")
      scores.push(2)
    else
      scores.push(4)
    end

    scores = checkOrientationLevel(economic.second, scores, 0)

    if social.first.eql?("LIBERTARIO")
      scores.push(4)
    else
      scores.push(2)
    end    

    scores = checkOrientationLevel(social.second, scores, 1)
    
    return scores
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
    
    startHash = [{
      "question": "Ideologia política",
      "answer": "Some answer",
      "value": x.round(2),
      "consequence": y.round(2)
    }]

    mountSpectreFile(startHash.to_json)
  end

  def mountSpectreFile(array)

    file = File.new "public/spectreData.json", "w"

    if ( !(array.empty?) &&  !(array.nil?) )
      
      file.puts array

      file.close
    end
  end

  def check_privileges!
    redirect_to "/" unless (!current_user.nil? && isAdmin?)
  end

  def show_change_password
    redirect_to "/" if current_user.nil?
  end

  def change_password
    user = current_user
    user.password = params[:password]

    redirect_to home_path if user.save
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
