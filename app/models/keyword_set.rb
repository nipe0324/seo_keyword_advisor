class KeywordSet < ActiveRecord::Base
  has_many :keywords

  validates :keywords, presence: true
  validates :name, presence: true
end
