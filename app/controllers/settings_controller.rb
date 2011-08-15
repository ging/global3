	class SettingsController < InheritedResources::Base

  #before_filter :authenticate_user!
  
  def show
	
  end

  def update_relation
     receiver = Actor.find params[:id]
     relations = params['manage']
	logger.info "antes del each"
	relations.each do |x,y|
             relation_id = y 
	     contacto=Contact.where(["sender_id="+current_subject.id.to_s+" and receiver_id="+receiver.id.to_s])
		logger.info "cs:"+current_subject.name+"receiver:"+receiver.name
	     tie_a_editar=contacto.first.ties
		logger.info "antes del if"
	     tie_x=tie_a_editar.first
	     if tie_x != nil
		logger.info "dentro del if"
		   tie_x.relation_id=relation_id
		   tie_x.save
		logger.info "luego del save"
	     else 
		logger.info "dentro del else"
		   nuevo_tie=Tie.new
		   nuevo_tie.contact_id=contacto.first.id
		   nuevo_tie.relation_id=relation_id 
		   nuevo_tie.save
	     end	     
	end 
     redirect_to "/settings/show"
  end

end
