class KeywordSet < ActiveRecord::Base
  enum status: { working: 0, success: 1, failed: 2 }

  has_many :keywords

  validates :keywords, presence: true
  validates :name, presence: true

  def success!
    update!(analysed_at: Time.zone.now, status: self.class.statuses[:success])
  end

  def fail!
    update!(analysed_at: Time.zone.now, status: self.class.statuses[:failed])
  end
end
