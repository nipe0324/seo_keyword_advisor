class ScrapeSearchResultsJob < ActiveJob::Base
  queue_as :default

  rescue_from Exception do |exception|
    keyword_set.fail!
    Rails.resque_logger.error exception.backtrace
  end

  def perform(keyword_set)
    Rails.resque_logger.info 'Start ScrapeSearchResultsJob#perform'
    ActiveRecord::Base.transaction do
      keyword_set.keywords.each do |keyword|
        ScrapeSearchResultService.new(keyword).call
      end
      keyword_set.success!
      Rails.resque_logger.info 'Success ScrapeSearchResultsJob#perform'
    end
  end
end
