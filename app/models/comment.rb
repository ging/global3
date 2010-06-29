class Comment < ActiveRecord::Base
  include ActiveRecord::ActivityObject

  validates_presence_of :text
end
