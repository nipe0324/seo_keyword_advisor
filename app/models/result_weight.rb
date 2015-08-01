class ResultWeight < ActiveRecord::Base
  UNKNOWN = 999 # for if don't exist result weight position

  validates :position, presence: true, uniqueness: true
	validates :weight,   presence: true, numericality: true

  def self.all_results
    order(:position)
  end

  # for view methods
  def position_desc
    return '検索順位にマッチしない場合' if position == UNKNOWN
    position
  end

end
