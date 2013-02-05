class Question < ActiveRecord::Base
	AVAILABLE_TYPES = %w(one many custom)

	belongs_to :subcategory
	has_many :answers

	validates :description, presence: true
    validates :question_type, presence: true, inclusion: {in: AVAILABLE_TYPES}

    attr_accessible :description, :question_type, :name, :subcategory

  def select?
  	question_type == 'one'
  end

  def checkbox?
  	question_type == 'many'
  end

  def custom?
  	question_type == 'custom'
  end

  def to_s
    self.description
  end
end
