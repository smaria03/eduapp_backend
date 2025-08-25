module Quiz
  class QuizAnswer < ApplicationRecord
    self.table_name = 'quiz_answers'

    belongs_to :submission, class_name: 'Quiz::QuizSubmission', foreign_key: 'quiz_submission_id',
                            inverse_of: :answers
    belongs_to :question, class_name: 'Quiz::QuizQuestion', foreign_key: 'quiz_question_id',
                          inverse_of: :answers

    validates :selected_option_ids, presence: true
  end
end
