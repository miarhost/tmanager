class Task < ApplicationRecord

  belongs_to :project
  scope :sort_by_priority, -> { order(priority: :acs) }


end
