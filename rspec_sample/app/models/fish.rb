class Fish < ApplicationRecord
  validates :time, uniqueness: { scope: [:date, :locate, :title, :person, :link] }

end
