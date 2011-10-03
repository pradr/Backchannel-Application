class VotesController < ApplicationController

        def new
        end

        def create
                if (params[:option] == "1") 
                      @post = Micropost.find_by_id(params[:post_id])
                      @vote  = @post.votes.find_by_user_id(current_user.id)
                      if(@vote == nil)
                              flash[:success] = "Post Voted !"
                              @post.weight += 100
                              @post.save
                              @vote = Vote.new
                              @vote.user_id = current_user.id
                              @vote.micropost_id = params[:post_id]
                              @vote.save
                        redirect_to root_path
                      else
                              flash[:error] = "You already voted for this post !"
                              redirect_to root_path
                      end

                elsif (params[:option] == "2")

                      @comment = Comment.find_by_id(params[:comment_id])
                      @vote  = @comment.votes.find_by_user_id(current_user.id)
                      if(@vote == nil)
                              flash[:success] = "Comment Voted !"
                              @vote = Vote.new
                              @vote.user_id = current_user.id
                              @vote.comment_id = params[:comment_id]
                              @vote.save
                              redirect_to root_path
                      else
                              flash[:error] = "You already voted for this comment !"
                              redirect_to root_path
                      end
                end

  
        end
end
