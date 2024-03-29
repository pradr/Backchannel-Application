class MicropostsController < ApplicationController
  before_filter :authenticate  , :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  def new
    @title = "Microposts"
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    @micropost.weight = 1000
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
       @feed_items = []
       render 'micropost'
    end
  end

  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end

  private
    def authorized_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end
end
