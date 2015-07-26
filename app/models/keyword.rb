class Keyword < ActiveRecord::Base
  belongs_to :keyword_set
  has_one    :result

  validates :keyword_set, presence: true
  validates :name, presence: true
end
