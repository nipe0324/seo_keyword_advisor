class KeywordsController < ApplicationController
  def index
    @keyword_set = KeywordSet.includes(keywords: :results)
                             .find(params[:keyword_set_id])
  end
end
