class ScrapeSearchResultsJob < ActiveJob::Base
  queue_as :default

  rescue_from StandardError do |exception|
    keyword_set.fail!
    Rails.logger.error exception.backtrace
  end

  def perform(keyword_set)
    ActiveRecord::Base.transaction do
      keyword_set.keywords.each do |keyword|
        ScrapeSearchResultService.new(keyword).call
      end
      keyword_set.success!
    end
  end
end
