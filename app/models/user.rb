# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  ROLES = %w[admin student teacher].freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :role, presence: true, inclusion: { in: ROLES }
  validates :email, presence: true
end
