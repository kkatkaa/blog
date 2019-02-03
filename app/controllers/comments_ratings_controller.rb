class CommentsRatingsController < ApplicationController
  def create
    raiting = CommentsRaiting.new(comment_id: params[:comment_id], raiting: params[:raiting], user: current_user)
    raiting.save
    redirect_to article_path(raiting.comment.article)
  end

  def destroy
    raiting = CommentsRaiting.find(params[:id])
    raiting.destroy
    redirect_to article_path(raiting.comment.article)
  end
end
