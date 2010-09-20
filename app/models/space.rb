class Space < ActiveRecord::Base
  validates_presence_of :name

  def logo
    "spaces/#{ id % 5 + 1 }.png"
  end
end
