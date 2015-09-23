class PostsController < ApplicationController

  def new
    @post = Post.new
    @categories = Setting['category_list']
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      @post.to_fb_page if Setting.is_auto_post?
      flash[:toastr] = ['Add post succeful!']
      redirect_to root_url
    else
      flash.now[:toastr] = @post.errors.full_messages
      render :new
    end
  end
end
