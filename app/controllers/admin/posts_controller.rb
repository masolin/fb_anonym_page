class Admin::PostsController < ApplicationController
  layout 'admin'

  def index
    @posts = params[:published] ? Post.recent.published : Post.recent.published(false)
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
      flash[:toastr] = ['Update post succeful!']
      redirect_to admin_posts_url
    else
      flash.now[:toastr] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:toastr] = ['Delete post succeful!']
    redirect_to admin_posts_url
  end

  def publish_to_fb
    post = Post.find(params[:id])
    post.to_fb_page
    redirect_to admin_posts_url
  end
end
