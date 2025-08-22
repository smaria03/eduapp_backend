module Quiz
  class QuizOption < ApplicationRecord
    self.table_name = 'quiz_options'

    belongs_to :question, class_name: 'Quiz::QuizQuestion', foreign_key: 'quiz_question_id',
                          inverse_of: :options

    validates :text, presence: true
  end
end
