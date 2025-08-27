module Api
  module Quizzes
    class QuizzesController < ApplicationController
      before_action :authorize_teacher!, except: [:index]

      def index
        if current_user&.teacher?
          quizzes = quizzes_for_teacher
          return render_assignment_error if quizzes.nil?

          render json: quizzes.as_json(
            only: %i[id title description deadline time_limit assignment_id],
            include: {
              questions: {
                only: %i[id question_text point_value],
                include: {
                  options: {
                    only: %i[id text is_correct]
                  }
                }
              }
            }
          )
        elsif current_user&.student?
          quizzes = quizzes_for_student
          return render_assignment_error if quizzes.nil?

          render json: quizzes.as_json(
            only: %i[id title description deadline time_limit assignment_id],
            include: {
              questions: {
                only: %i[id question_text point_value],
                include: {
                  options: {
                    only: %i[id text]
                  }
                }
              }
            }
          )
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end

      def create
        assignment = SchoolClassSubject.find_by(id: quiz_params[:assignment_id])
        return unauthorized_response unless authorized_teacher?(assignment)

        quiz = build_quiz

        ActiveRecord::Base.transaction do
          quiz.save!
          create_questions_with_options(quiz)
        end

        render json: { message: 'Quiz created successfully' }, status: :created
      rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
      end

      def destroy
        quiz = ::Quiz::Quiz.find_by(id: params[:id])

        return render json: { error: 'Quiz not found' }, status: :not_found unless quiz

        unless quiz.assignment.teacher_id == current_user.id
          return render json: { error: 'Not authorized to delete this quiz' }, status: :unauthorized
        end

        quiz.destroy
        render json: { message: 'Quiz deleted successfully' }, status: :ok
      end

      private

      def authorized_teacher?(assignment)
        assignment&.teacher_id == current_user.id
      end

      def quizzes_for_teacher
        if params[:assignment_id]
          assignment = SchoolClassSubject.find_by(id: params[:assignment_id])
          return nil unless assignment
          return nil unless authorized_teacher?(assignment)

          ::Quiz::Quiz.where(assignment_id: assignment.id)
        else
          teacher_assignment_ids = SchoolClassSubject.where(teacher_id: current_user.id).pluck(:id)
          ::Quiz::Quiz.where(assignment_id: teacher_assignment_ids)
        end
      end

      def quizzes_for_student
        if params[:subject_id]
          quizzes_by_subject
        elsif params[:assignment_id]
          quizzes_by_assignment
        else
          quizzes_for_entire_class
        end
      end

      def quizzes_by_subject
        SchoolClassSubject
          .where(subject_id: params[:subject_id], school_class_id: current_user.school_class_id)
          .includes(:quizzes)
          .flat_map(&:quizzes)
      end

      def quizzes_by_assignment
        assignment = SchoolClassSubject.find_by(id: params[:assignment_id])
        return nil unless assignment&.school_class_id == current_user.school_class_id

        ::Quiz::Quiz.where(assignment_id: assignment.id)
      end

      def quizzes_for_entire_class
        assignment_ids = SchoolClassSubject
                         .where(school_class_id: current_user.school_class_id)
                         .pluck(:id)

        ::Quiz::Quiz.where(assignment_id: assignment_ids)
      end

      def unauthorized_response
        render json: { error: 'Not authorized to create quizzes for this assignment' },
               status: :unauthorized
      end

      def unauthorized_response_student
        render json: { error: 'Not authorized to access this quiz' },
               status: :unauthorized
      end

      def render_assignment_error
        render json: { error: 'Assignment not found or unauthorized' }, status: :not_found
      end

      def build_quiz
        ::Quiz::Quiz.new(quiz_params.except(:questions))
      end

      def create_questions_with_options(quiz)
        questions_params.each do |q|
          question = quiz.questions.create!(
            question_text: q[:question_text],
            point_value: q[:point_value]
          )

          q[:options].each do |opt|
            question.options.create!(
              text: opt[:text],
              is_correct: opt[:is_correct]
            )
          end
        end
      end

      def quiz_params
        params.require(:quiz).permit(
          :title, :description, :deadline, :time_limit, :assignment_id,
          questions: [
            :question_text, :point_value,
            options: %i[text is_correct]
          ]
        )
      end

      def questions_params
        quiz_params[:questions] || []
      end

      def authorize_teacher!
        return if current_user&.role == 'teacher'

        render json: { error: 'Unauthorized: Teachers only' }, status: :unauthorized
      end
    end
  end
end
