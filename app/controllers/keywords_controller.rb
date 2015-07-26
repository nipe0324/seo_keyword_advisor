class KeywordsController < ApplicationController
  def index
    @keyword_set = KeywordSet.includes(keywords: :result).find(params[:keyword_set_id])
  end
end
