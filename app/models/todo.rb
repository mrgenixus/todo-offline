class Todo < ApplicationRecord
  scope :active, -> { where(active: true) }
end
