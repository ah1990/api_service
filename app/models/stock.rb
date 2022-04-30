class Stock < ApplicationRecord
  belongs_to :bearer

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, conditions: -> { without_deleted }}

  scope :without_deleted, -> { where(deleted_at: nil) }
end
