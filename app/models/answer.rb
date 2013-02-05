class Answer < ActiveRecord::Base
  belongs_to :question

  attr_accessible :question, :description, :question_id

  validates :question, presence: true
  validates :description, presence: true

  def to_s
    self.description
  end
end
