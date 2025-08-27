module Quiz
  class QuizSubmission < ApplicationRecord
    self.table_name = 'quiz_submissions'

    belongs_to :quiz, class_name: 'Quiz::Quiz'
    belongs_to :student, class_name: 'User'

    has_many :answers, class_name: 'Quiz::QuizAnswer',
                       inverse_of: :submission,
                       dependent: :destroy

    accepts_nested_attributes_for :answers
    validates_associated :answers
  end
end
