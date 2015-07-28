class ScrapeSearchResultsJob < ActiveJob::Base
  queue_as :default

  def perform(keyword_set)
    keyword_set.scrape
  end
end
