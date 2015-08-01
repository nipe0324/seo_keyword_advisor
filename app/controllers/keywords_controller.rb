class KeywordsController < ApplicationController
  def index
    @keyword_set = KeywordSet.includes(keywords: :results)
                             .find(params[:keyword_set_id])
    @summary_countup = Result.summarize_countup(@keyword_set.keywords)
    @summary_weight = Result.summarize_weight(@keyword_set.keywords)
  end
end
