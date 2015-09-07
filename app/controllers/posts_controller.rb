class PostsController < ApplicationController
  layout 'admin', except: :new

  def index
    @posts = params[:published] ? Post.recent.published : Post.recent.published(false)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:toastr] = ['Add post succeful!']
      redirect_to root_url
    else
      flash.now[:toastr] = @post.errors.full_messages
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:toastr] = ['Update post succeful!']
      redirect_to posts_url
    else
      flash.now[:toastr] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:toastr] = ['Delete post succeful!']
    redirect_to posts_url
  end

  def publish_to_fb
    post = Post.find(params[:id])
    post.to_fb_page
    redirect_to posts_url
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
