class Keyword < ActiveRecord::Base
  belongs_to :keyword_set
  has_many   :results, dependent: :destroy

  validates :keyword_set, presence: true
  validates :name, presence: true

  def empty?
    name.blank?
  end
end
