class PostsController < ApplicationController

  def new
    @post = Post.new
    @categories = Setting['category_list']
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      if Setting.is_auto_post? && @post.to_fb_page
        flash[:toastr] = 'Add post succefully!'
      else
        flash[:toastr] = 'Add post and wait for review!'
      end
      redirect_to root_url
    else
      flash.now[:toastr] = @post.errors.full_messages
      render :new
    end
  end
end
