class Post < ApplicationRecord
  validates :title, uniqueness: { scope: [:date, :locate, :person, :link] }
end
