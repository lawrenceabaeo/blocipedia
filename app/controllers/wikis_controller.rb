class WikisController < ApplicationController
  def index
    @wikis =Wiki.all
  end

  def show
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
  end

  private 

  def wiki_params
    # params.require(:wiki).permit(:title, :user_id, :public_access, :body)
    params.require(:wiki).permit(:title, :body)
  end
end
