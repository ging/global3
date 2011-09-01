class ActivitiesController < InheritedResources::Base
  belongs_to_subjects
  actions :index

  respond_to :js

  def documents
    logger.info("aqui ")
    object_types = params[:types]
    
    @activities=ActivityObject.where("object_type in :list",:list=> object_types).order("updated_at DESC").
                          page(params[:page]).
                          per(params[:per])    
    #@activities = profile_subject.wall(:profile,
    #                       :for => current_subject,
    #                       :object_type => object_types).#Array(self.class.index_object_type)).
    #                      page(params[:page]).
    #                      per(params[:per])    
  end

  protected

  def collection
    rel = params[:section].to_i if params[:section].present?

    # should be activities.page(params[:page], :count => { :select => 'activity.id', :distinct => true }) but it is not working in Rails 3.0.3 
    @activities ||= association_chain[-1].
                      wall(:profile,
                           :for => current_subject,
                           :relation => rel).
                      page(params[:page])
  end
end
