class ScrapeSearchResultsJob < ActiveJob::Base
  queue_as :default

  rescue_from Exception do |exception|
    @keyword_set.fail!
  end

  def perform(keyword_set)
    @keyword_set = keyword_set
    ActiveRecord::Base.transaction do
      @keyword_set.keywords.each do |keyword|
        ScrapeSearchResultService.new(keyword).call
      end
      @keyword_set.success!
    end
  end
end
