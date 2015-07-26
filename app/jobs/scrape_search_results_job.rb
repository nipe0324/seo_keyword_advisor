class ScrapeSearchResultsJob < ActiveJob::Base
  queue_as :default

  rescue_from StandardError do |exception|
    keyword_set.fail
    Rails.logger.error exception.backtrace
  end

  def perform(keyword_set)
    sleep 30 # scrape
    keyword_set.success
  end
end
