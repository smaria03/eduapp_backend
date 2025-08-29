module Quiz
  class Quiz < ApplicationRecord
    self.table_name = 'quizzes'

    belongs_to :assignment,
               class_name: 'SchoolClassSubject',
               inverse_of: :quizzes
    has_many :questions, class_name: 'Quiz::QuizQuestion',
                         dependent: :destroy
    has_many :submissions, class_name: 'Quiz::QuizSubmission',
                           dependent: :destroy

    validates :title, presence: true
    validates :deadline, presence: true
  end
end
