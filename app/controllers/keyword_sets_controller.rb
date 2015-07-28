class KeywordSetsController < ApplicationController
  def index
    @keyword_sets = KeywordSet.order(created_at: :desc)
  end

  def new
    @keyword_set = KeywordSet.new
  end

  def create
    @keyword_set = KeywordSet.new(keyword_set_params)
    keywords.each do |keyword|
      @keyword_set.keywords.build(name: keyword)
    end

    if @keyword_set.save
      # For heroku free usage, don't use resque
      # ScrapeSearchResultsJob.perform_later(@keyword_set)
      @keyword_set.scrape
      redirect_to keyword_sets_url, notice: '入力したキーワードで分析をしました。'
    else
      render :new
    end
  end

  def update
    @keyword_set = KeywordSet.find(params[:id])
    # For heroku free usage, don't use resque
    # ScrapeSearchResultsJob.perform_later(@keyword_set)
    # @keyword_set.working!
    @keyword_set.scrape
    redirect_to keyword_sets_url, notice: '再度分析をしました。'
  end

  def destroy
    @keyword_set = KeywordSet.find(params[:id])
    @keyword_set.destroy
    redirect_to keyword_sets_url, notice: '削除しました。'
  end

  private

    def keyword_set_params
      params.require(:keyword_set).permit(:name)
    end

    def keywords
      params.fetch(:keywords, '').split(/\r\n/)
    end
end
