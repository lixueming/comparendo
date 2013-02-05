class ProjectOption < ActiveRecord::Base
  belongs_to :project
  belongs_to :option, class_name: "Answer", foreign_key: "answer_id"

  attr_accessible :project, :answer_id

  def to_s
  	"#{option.question} - #{option}"
  end
end
