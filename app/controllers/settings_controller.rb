	class SettingsController < InheritedResources::Base

  #before_filter :authenticate_user!
  
  def show

#	@cs_ = Actor.joins('INNER JOIN contacts ON contacts.receiver_id = actors.id INNER JOIN ties ON ties.contact_id = contacts.id INNER JOIN relations ON relations.id = ties.relation_id').where(:subject_type => ['User', 'Group', 'Event'], :contacts=>{:sender_id => current_subject}, :relations=>{:type => 'Relation::Custom'}).page(params[:page]).per(10)

	@cs = current_subject.contact_subjects(:direction => :sent)
	@cs = Kaminari.paginate_array(@cs).page(params[:page]).per(10)
#	@cs_page = Paginator.new(self, cs.length, 10, 1)
#	@offset = 0
#	@cs= cs[offset..(offset + 10 -1)]

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
