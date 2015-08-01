class Result < ActiveRecord::Base
  belongs_to :keyword

  validates :url, presence: true
  validates :domain, presence: true
  validates :title, presence: true

  def self.summarize_countup(keywords)
    results = keywords.map { |k| k.results }.flatten
    domain_count_hash = countup_domain(results)
    sort_domain_hash(domain_count_hash)
  end

  def self.summarize_weight(keywords)
    results = keywords.map { |k| k.results }.flatten
    weights = ResultWeight.all_results
    domain_weight_hash = put_weight_domain(results, weights)
    sort_domain_hash(domain_weight_hash)
  end

  private

    def self.countup_domain(results)
      domain_count_hash = {}
      results.each do |r|
        domain_count_hash[r.domain] ||= 0
        domain_count_hash[r.domain] += 1
      end
      domain_count_hash
    end

    def self.put_weight_domain(results, weights)
      domain_weight_hash = {}
      results.each do |r|
        weight = weights.to_a.find { |w| r.position == w.position }.try(:weight)
        domain_weight_hash[r.domain] ||= 0
        domain_weight_hash[r.domain] += (weight || ResultWeight.unknown_weight)
      end
      domain_weight_hash
    end

    def self.sort_domain_hash(domain_count_hash)
      domain_count_hash.sort_by { |_domain, count| count }.reverse
    end
end
