class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  def updateComment
    Comment.update(params[:comment_id], description: params[:comment])

    respond_to do |format|
      format.html { redirect_to '/law_projects/'+params[:law_project].to_s }
    end
  end
  
  # POST /comments
  # POST /comments.json
  def create
    
    create_interaction

    @comment = Comment.new(comment_params)
    @comment.interaction = @interaction
    
    respond_to do |format|
      if @comment.save
        # format.html { redirect_to law_projects_path, notice: 'Comment was successfully created.' }
        format.html { redirect_to '/law_projects/'+@interaction.law_project_id.to_s}
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to '/law_projects/'+@comment.interaction.law_project_id.to_s, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to '/law_projects/'+@comment.interaction.law_project_id.to_s}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      
      @comment = Comment.find(params[:id])
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:description, :comment_father, :comment_url, :interaction_id)
    end
end
