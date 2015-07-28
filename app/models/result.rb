class Result < ActiveRecord::Base
  belongs_to :keyword

  validates :url, presence: true
  validates :domain, presence: true
  validates :title, presence: true

  def self.summarize(keywords)
    results = keywords.map { |k| k.results }.flatten
    domain_count_hash = count_up_domain(results)
    sort_domain_hash(domain_count_hash)
  end

  private

    def self.count_up_domain(results)
      domain_count_hash = {}
      results.each do |r|
        domain_count_hash[r.domain] ||= 0
        domain_count_hash[r.domain] += 1
      end
      domain_count_hash
    end

    def self.sort_domain_hash(domain_count_hash)
      domain_count_hash.sort_by { |_domain, count| count }.reverse
    end
end
