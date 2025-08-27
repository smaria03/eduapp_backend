# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  ROLES = %w[admin student teacher].freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :role, presence: true, inclusion: { in: ROLES }
  validates :email, presence: true

  belongs_to :school_class, optional: true

  has_many :grades_given, class_name: 'Grade', foreign_key: 'teacher_id', inverse_of: :teacher,
                          dependent: :destroy
  has_many :grades_received, class_name: 'Grade', foreign_key: 'student_id', inverse_of: :teacher,
                             dependent: :destroy

  def teacher?
    role == 'teacher'
  end

  def student?
    role == 'student'
  end
end
