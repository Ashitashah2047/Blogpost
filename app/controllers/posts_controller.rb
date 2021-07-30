class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:show, :index]

  # GET /posts or /posts.json
  def index    
    @posts = Post.all

    if params[:title]
      @title = params[:title]
      @posts = @posts.title(params[:title])
    end

    if params[:body]
      @body = params[:body]
      @posts = @posts.body(params[:body])
    end
    
    if params[:start_date]
      @start_date = params[:start_date]
      @posts = @posts.startdate(params[:start_date])
    end

    if params[:end_date]
      @end_date = params[:end_date]
      @posts = @posts.enddate(params[:end_date])
    end
  end

  # GET /posts/1 or /posts/1.json
  def show

    @posts = Post.find(params[:id])

    @comment = Comment.new
    @comments = @post.comments

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Post Pdf",
               template: "posts/show.html.erb",
               layout: 'pdf.html'# Excluding ".pdf" extension.
      end
    end

  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.users.clear
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :start_date, :end_date,:image, :remove_image, :image_cache)
    end
end
