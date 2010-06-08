class ActivityVerb < ActiveRecord::Base
  validates_uniqueness_of :name

  class << self
    def [] name
      find_by_name(name)
    end
  end
end
