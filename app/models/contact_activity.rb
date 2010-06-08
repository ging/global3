class ContactActivity < ActiveRecord::Base
  belongs_to :activity
  belongs_to :contact
end
