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
      ScrapeSearchResultsJob.perform_later(@keyword_set)
      redirect_to keyword_sets_url, notice: '入力したキーワードで分析を開始しました。少々お待ち下さい。'
    else
      render :new
    end
  end

  def update
    @keyword_set = KeywordSet.find(params[:id])
    ScrapeSearchResultsJob.perform_later(@keyword_set)
    @keyword_set.working!
    redirect_to keyword_sets_url, notice: '再度分析を開始しました。少々お待ち下さい。'
  end

  private

    def keyword_set_params
      params.require(:keyword_set).permit(:name)
    end

    def keywords
      params.fetch(:keywords, '').split(/\r\n/)
    end
end
