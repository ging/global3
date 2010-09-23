class Space < ActiveRecord::Base
  validates_presence_of :name

  scope :alphabetic, includes(:actor).order('actors.name')

  def logo
    "spaces/#{ id % 5 + 1 }.png"
  end
end
