module Api
  module Quizzes
    class QuizSubmissionsController < ApplicationController
      before_action :authorize_student!

      def index
        submissions = ::Quiz::QuizSubmission
                      .includes(quiz: :assignment)
                      .where(student_id: current_user.id)

        if params[:subject_id].present?
          submissions = submissions.select do |s|
            s.quiz.assignment&.subject_id.to_s == params[:subject_id].to_s
          end
        end

        render json: submissions.as_json(
          only: %i[id raw_score final_score submitted_at],
          include: {
            quiz: {
              only: %i[id title],
              include: {
                assignment: {
                  only: %i[id subject_id]
                }
              }
            }
          }
        )
      end

      def create
        @quiz = ::Quiz::Quiz.includes(questions: :options).find_by(id: params[:quiz_id])
        return render_quiz_not_found unless @quiz

        return render_forbidden unless student_can_access_quiz?(@quiz)
        return render_already_submitted if @quiz.submissions.exists?(student_id: current_user.id)

        submission = build_submission
        return unless submission

        if submission.save
          create_grade_from_submission(submission)
          render json: {
            message: 'Quiz submitted successfully',
            raw_score: submission.raw_score,
            final_score: submission.final_score
          }, status: :created
        else
          render json: { error: submission.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        submission = ::Quiz::QuizSubmission.find_by(id: params[:id], student_id: current_user.id)
        unless submission
          return render json: { error: 'Submission not found or not yours' },
                        status: :not_found
        end

        submission.destroy

        render json: { message: 'Submission and associated answers deleted successfully' },
               status: :ok
      end

      private

      def authorize_student!
        return if current_user&.role == 'student'

        render json: { error: 'Unauthorized: Students only' }, status: :unauthorized
      end

      def student_can_access_quiz?(quiz)
        quiz.assignment&.school_class_id == current_user.school_class_id
      end

      def answers_params
        params.require(:answers)
      end

      def render_quiz_not_found
        render json: { error: 'Quiz not found' }, status: :not_found
      end

      def render_forbidden
        render json: { error: 'You are not authorized to solve this quiz' }, status: :forbidden
      end

      def render_already_submitted
        render json: { error: 'Quiz already submitted' }, status: :unprocessable_entity
      end

      def build_submission
        submission = ::Quiz::QuizSubmission.new(
          quiz: @quiz,
          student: current_user,
          submitted_at: Time.current
        )

        total_score = 0

        answers_params.each do |answer_param|
          result = process_answer_param(submission, answer_param)
          return nil unless result[:ok]

          total_score += result[:points]
        end

        raw_score = total_score + 1
        final_score = compute_final_score(raw_score)

        submission.raw_score = raw_score
        submission.final_score = final_score

        submission
      end

      def process_answer_param(submission, answer_param)
        question = find_question(answer_param)
        return { ok: false } unless question

        selected_ids = extract_selected_option_ids(answer_param)
        return { ok: false } unless valid_selected_options?(question, selected_ids)

        is_correct = correct_answer?(question, selected_ids)
        submission.answers.build(question: question, selected_option_ids: selected_ids)

        { ok: true, points: is_correct ? question.point_value : 0 }
      end

      def find_question(answer_param)
        question_id = answer_param[:question_id].to_i
        question = @quiz.questions.find { |q| q.id == question_id }

        unless question
          render json: { error: "Question #{question_id} does not belong to this quiz" },
                 status: :unprocessable_entity
          return nil
        end

        question
      end

      def extract_selected_option_ids(answer_param)
        Array(answer_param[:selected_option_ids]).map(&:to_i).sort
      end

      def valid_selected_options?(question, selected_ids)
        valid_option_ids = question.options.pluck(:id).sort
        if (selected_ids - valid_option_ids).any?
          render json: { error: "Invalid option(s) selected for question #{question.id}" },
                 status: :unprocessable_entity
          return false
        end
        true
      end

      def correct_answer?(question, selected_ids)
        correct_ids = question.options.select(&:is_correct).map(&:id).sort
        selected_ids == correct_ids
      end

      def compute_final_score(raw_score)
        score = raw_score >= (raw_score + 0.5).floor ? raw_score.round : raw_score.ceil
        score.clamp(1, 10)
      end

      def create_grade_from_submission(submission)
        assignment = submission.quiz.assignment
        return unless assignment

        Grade.create!(
          value: submission.final_score,
          student_id: current_user.id,
          teacher_id: assignment.teacher_id,
          subject_id: assignment.subject_id
        )
      end
    end
  end
end
