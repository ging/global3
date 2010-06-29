require 'active_support/concern'

module ActiveRecord
  module ActivityObject
    extend ActiveSupport::Concern

    included do
      attr_accessor :_activity_contact_id
      attr_accessor :_activity_parent_id

      belongs_to :activity_object
      has_many   :activity_object_activities, :through => :activity_object

      alias_method_chain :create_activity_object, :type
      before_create :create_activity_object

      before_create :create_post_activity
      before_update :create_update_activity

      validates_presence_of :_activity_contact
    end

    module InstanceMethods
      def create_activity_object_with_type(attributes = {})
        create_activity_object_without_type attributes.update(:object_type => self.class.to_s)
      end

      def _activity_contact
        @_activity_contact ||= Contact.find(_activity_contact_id)
      end

      private

      def create_post_activity
        create_activity "post"
      end

      def create_update_activity
        create_activity "update"
      end

      def create_activity(verb)
        activity_object.activities.create! :verb      => verb,
                                           :contact   => _activity_contact,
                                           :parent_id => _activity_parent_id
      end
    end
  end
end
