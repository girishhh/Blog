class PostsController < ApplicationController
before_filter :authenticate_user!


  def new
    @current_user = current_user
    @post = Post.new
    render layout: "layout3"
  end

  def index
    if params[:tag]
    @post = Post.tagged_with(params[:tag])
    else
    @post = Post.all
    end
    render layout: "layout4"
  end


  def edit
    @post = Post.find(params[:id])
    if(@post.user_id != current_user.id)
      return redirect_to posts_path flash[:notice] = "you are not permitted to edit this post::it belongs to other user "
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

  def create_comment    
    @text_id=Time.now
    @post_id=params[:id]
    @content=params[:content]    
    comment=Comment.new(post_id: params[:id].to_i,content: params[:content],user_id: current_user.id)
    comment.save!
  end

  def create_and_get_like_count
    @flag=0
    like_or_not=Like.find_by_post_id_and_user_id(params[:post_id],current_user.id)
    if like_or_not.present?
      like_or_not.destroy
      @flag=1
    else
      like=Like.new(post_id: params[:post_id],user_id: current_user.id)    
      like.save!            
    end
    @post_id=params[:post_id]
    @like_count=Like.where(post_id: params[:post_id]).count    
  end

  def get_liked_users_for_post    
    @post_id=params[:post_id]
  end

  def get_liked_users_hover
    usrs=Like.where(post_id: params[:id].to_i).collect(&:user_id)
    arr=[]
    User.find_each do |usr|
      arr<<User.find(usr).email
    end    
    respond_to do |format|
      format.js {render :json=>arr}
    end
  end


  private
  def post_params
    params.require(:post).permit(:title, :body, :user_id,:image,:video,:tag_list)
  end
end
