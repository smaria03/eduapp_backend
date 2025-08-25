module Quiz
  class QuizSubmission < ApplicationRecord
    self.table_name = 'quiz_submissions'

    belongs_to :quiz, class_name: 'Quiz::Quiz'
    belongs_to :student, class_name: 'User'
    has_many :answers, class_name: 'Quiz::QuizAnswer',
                       dependent: :destroy
  end
end
