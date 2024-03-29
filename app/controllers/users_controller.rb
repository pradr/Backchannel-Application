class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index,:edit, :update ,:destroy ]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy


def home
	#home page of a user
	#redirect_to :controller=>'post', :action=>'list_posts'
  render 'pages/home'
	return
end

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end




  def new
    @user = User.new
    @title = "Sign up"
  end


  def create
    @user = User.new(params[:user])
    if @user.save
       sign_in @user
       flash[:success] = "Welcome to the Reality!"
      redirect_to @user
      # Handle a successful save.
    else
      @title = "Sign up"
      render 'new'
    end
  end


  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end

   def update
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
   end

  def destroy
    user = User.find(params[:id])
    if user == current_user
            flash[:error] = "Sorry..Not permitted."
    else
            user.destroy
            flash[:success] = "User destroyed."
    end
    redirect_to users_path
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @comment = Comment.new
    @title = @user.name
  end

  private


    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

     def admin_user
      redirect_to(root_path) unless current_user.admin?
     end


end
