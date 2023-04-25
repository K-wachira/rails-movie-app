require 'movie_module'
class CommentsController < ApplicationController
  include CommonMovieMethods

  def new
    @comment = Comment.new
  end

  def get_comment
    @movie_comments = Comment.find_by(movie_id: params["format"])
  end

  def add_comment
    new_comment = Comment.new(comment_params)
    if new_comment.save
      respond_to do |format|
        format.html { redirect_to request.referrer, notice: "Comment added!!!" }
      end
    else
      redirect_to root_path, alert: "Well that did not go according to plan"
    end
  end

  def comment_params
    @params = params.as_json.dup
    if @params.include? '=>'
      @params.gsub! '=>', ':'
    end

    {
      comment_text: @params['comment_text'][0],
      spoiler_alert: @params['comment']['has_spoiler'] == 'yes'? true : false,
      user_id: Current.user.id,
      movie_id: get_movie_by_imdbID(@params['imdbID'].as_json.keys[0]).id,
    }
  end
end
