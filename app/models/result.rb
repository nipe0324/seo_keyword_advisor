class Result < ActiveRecord::Base
  belongs_to :keyword

  validates :url, presence: true
  validates :domain, presence: true
  validates :title, presence: true

  def self.summarize(keywords)
    all_results = keywords.map { |k| k.results }.flatten
    domain_count_hash = {}
    all_results.each do |r|
      domain_count_hash[r.domain] ||= 0
      domain_count_hash[r.domain] += 1
    end

    domain_count_hash
  end
end
