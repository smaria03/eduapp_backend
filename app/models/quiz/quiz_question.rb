module Quiz
  class QuizQuestion < ApplicationRecord
    self.table_name = 'quiz_questions'

    belongs_to :quiz, class_name: 'Quiz::Quiz'
    has_many :options, class_name: 'Quiz::QuizOption',
                       dependent: :destroy
    has_many :answers, class_name: 'Quiz::QuizAnswer',
                       inverse_of: :question,
                       dependent: :destroy

    validates :question_text, :point_value, presence: true
  end
end
