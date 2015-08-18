class PostsController < ApplicationController
before_filter :authenticate_user!


  def new
    @current_user = current_user
    @post = Post.new
    render layout: "layout3"
  end

  def index
    @post = Post.all
    render layout: "layout4"
  end


  def edit
    @post = Post.find(params[:id])
    if(@post.user_id != current_user.id)
      redirect_to posts_path flash[:notice] = "you are not permitted to edit this post::it belongs to other user "
    end
    render layout: "layout5"
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to posts_path :notice=>"your post has been updated"
    else
      render 'edit'
    end
  end


  def destroy
    @post = Post.find(params[:id])
    if(@post.user_id == current_user.id)
      @post.destroy
      redirect_to posts_path
    else
       redirect_to posts_path  flash[:notice] = "you are not permitted to delete this post::it belongs to other user "
    end
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    @post=Post.find(params[:id])

  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :user_id,:image,:video)
  end
end
