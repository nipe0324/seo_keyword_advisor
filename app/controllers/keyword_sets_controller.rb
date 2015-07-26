class KeywordSetsController < ApplicationController
  def index
    @keyword_sets = KeywordSet.all
  end

  def new
    @keyword_set = KeywordSet.new
  end

  def create
    ActiveRecord::Base.transaction do
      @keyword_set = KeywordSet.new keyword_set_params
      keywords.each do |k|
        @keyword_set.keywords.build(name: k)
      end
    end

    if @keyword_set.save
      ScrapeSearchResultsJob.perform_later(@keyword_set)
      redirect_to keyword_sets_url, notice: '入力したキーワードで分析を開始しました。少々お待ち下さい。'
    else
      render :new
    end
  end

  private

    def keyword_set_params
      params.require(:keyword_set).permit(:name)
    end

    def keywords
      params.fetch(:keywords, '').split(/\r\n/)
    end
end
