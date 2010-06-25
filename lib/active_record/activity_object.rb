require 'active_support/concern'

module ActiveRecord
  module ActivityObject
    extend ActiveSupport::Concern

    included do
      belongs_to :activity_object
      has_many   :activity_boject_activities, :through => :activity_object

      alias_method_chain :create_activity_object, :type
      before_create :create_activity_object
    end

    module InstanceMethods
      def create_activity_object_with_type(attributes = {})
        create_activity_object_without_type attributes.update(:object_type => self.class.to_s)
      end
    end
  end
end
