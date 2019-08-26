class Task < ApplicationRecord
  belongs_to :user

  validates :name, :description, presence: true
  validates :end_time, presence: true

  enum status: [:created, :development, :test, :accept, :refused, :finished]

  default_scope -> { where(deleted_at: nil) }

  before_validation :set_status, on: :create

  def soft_delete
    self.update(deleted_at: Time.current)
  end

  private

  def set_status
    self.status = :created
  end

end
