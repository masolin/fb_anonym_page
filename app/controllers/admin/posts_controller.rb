class Admin::PostsController < ApplicationController
  before_action :authenticate_user!

  layout 'admin'

  def index
    @published = params[:published] || false
    @posts = Post.recent.published(@published).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @categories = Setting['category_list']
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:toastr] = 'Update post succeful!'
      redirect_to admin_posts_url
    else
      flash.now[:toastr] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:toastr] = 'Delete post succeful!'
    redirect_to admin_posts_url
  end

  def publish_to_fb
    post = Post.find(params[:id])
    flash[:toastr] = (post.to_fb_page ? 'Post to fb' : 'Unable to post')
    redirect_to admin_posts_url
  end
end
