class User < ApplicationRecord
  has_secure_password
  validates :mail, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a vaid email address" }
end
