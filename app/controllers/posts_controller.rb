require 'open-uri'

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :search]

  def index
    @post_last = Post.order(created_at: :desc).first
    @post_all = Post.order(created_at: :desc).paginate(:page => params[:page], :per_page => 3)

    if params[:search]
      @post_search = Post.where("title like ?", "#{params[:search]}%").paginate(:page => params[:page], :per_page => 5)
    else
      @post_search = Post.order(created_at: :desc).paginate(:page => params[:page], :per_page => 5)
    end
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
    if @post.user_id != current_user.id
      flash[:danger] = "This post can't be edited or destroyed by this User."
      redirect_to post_path(@post)
    end
  end

  def create
    @post = Post.new(post_params)

    #Assigning current user to post.
    @post.user = current_user

    respond_to do |format|
      if @post.save
        flash[:success] = 'Successfully created.'
        format.html { redirect_to @post}
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        flash[:success] = 'Successfully edited.'
        format.html { redirect_to @post}
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      flash[:success] = 'Successfully destroyed.'
      format.html { redirect_to posts_url}
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :briefing, :text, :user_id, :avatar)
    end
end
