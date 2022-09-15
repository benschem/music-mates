class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :group
  enum :status, {
    pending: 0,
    accepted: 1,
    declined: 2
  }
  validates :user, uniqueness: {scope: :group}
end
