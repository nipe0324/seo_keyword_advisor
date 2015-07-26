class Result < ActiveRecord::Base
  belongs_to :keyword

  validates :url, presence: true
  validates :domain, presence: true
  validates :title, presence: true
  validates :desc, presence: true
end
