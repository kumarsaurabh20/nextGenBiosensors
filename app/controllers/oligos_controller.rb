class OligosController < AuthController
  
 respond_to :html,:json
  
  protect_from_forgery :except => [:post_data]
  
  # Don't forget to edit routes if you're using RESTful routing
  # 
  #resources :oligos,:only => [:index] do
  #   collection do
  #     post "post_data"
  #   end
  # end


  def post_data
    message=""
    oligo_params = { :id => params[:id],:code => params[:code],:oligo_id => params[:oligo_id],:gal_header_id => params[:gal_header_id],:gal_block_id => params[:gal_block_id],:row_number => params[:row_number],:column_number => params[:column_number],:microarraygal_id => params[:microarraygal_id] }
    case params[:oper]
    when 'add'
      if params["id"] == "_empty"
        oligo = Oligo.create(oligo_params)
        message << ('add ok') if oligo.errors.empty?
      end
      
    when 'edit'
      oligo = Oligo.find(params[:id])
      message << ('update ok') if oligo.update_attributes(oligo_params)
    when 'del'
      Oligo.destroy_all(:id => params[:id].split(","))
      message <<  ('del ok')
    when 'sort'
      oligos = Oligo.all
      oligos.each do |oligo|
        oligo.position = params['ids'].index(oligo.id.to_s) + 1 if params['ids'].index(oligo.id.to_s) 
        oligo.save
      end
      message << "sort ak"
    else
      message <<  ('unknown action')
    end
    
    unless (oligo && oligo.errors).blank?  
      oligo.errors.entries.each do |error|
        message << "<strong>#{Oligo.human_attribute_name(error[0])}</strong> : #{error[1]}<br/>"
      end
      render :json =>[false,message]
    else
      render :json => [true,message] 
    end
  end


  def index
#	   @oligos = Oligo.all
           @title = "List of oligos in GAL file"

#    if params[:id].present?
#        logger.warn("#{Time.now} - oligo filtered by: #{params[:id]}")
        
#        oligos = Oligo.find(:all, :conditions => [ "microarraygal_id = ?", params[:id]]) do
#            paginate :page => params[:page], :per_page => params[:rows]      
#            order_by "#{params[:sidx]} #{params[:sord]}"
#           end

#         respond_to do |format|
#        format.html 
#        format.json { render :json => oligos.to_jqgrid_json([:id,"act","oligo","edit"], params[:page], params[:rows], oligos.total_entries) }			
#      end
      
    
#    else
        
#	  oligos = Oligo.find(:all) do

#			if params[:_search] == "true"
#			   microarraygal.id =~ "%#{params[:gal_o_code]}%" if params[:gal_o_code].present?
#			   #oligo_sequence.id =~ "%#{params[:oligo_id]}%" if params[:oligo_id].present?
#			   oligo_sequence.code =~ "%#{params[:oligo]}%" if params[:oligo].present?
			   
#			end

#	       paginate :page => params[:page], :per_page => params[:rows]
#	       order_by "#{params[:sidx]} #{params[:sord]}" 

#		       if params[:sidx] == "gal_o_code"
#			  order_by "microarraygals.id #{params[:sord]}"
#		      # elsif params[:sidx] == "oligo_id"
#			  #order_by "oligo_sequences.id #{params[:sord]}"
#		       elsif params[:sidx] == "oligo"
#			  order_by "oligo_sequences.code #{params[:sord]}"    
#		       end  
#    
#       end
#		respond_to do |format|
#		format.html 
#		format.json { render :json => oligos.to_jqgrid_json([:id,"act","gal_o_code","array_info","oligo","oligo_upload_date","edit"], params[:page], params[:rows], oligos.total_entries) }			
#	      end
#    end


   index_columns ||= [:id,:act,:gal_o_code,:array_info,:oligo,:oligo_upload_date,:edit]
    current_page = params[:page] ? params[:page].to_i : 1
    rows_per_page = params[:rows] ? params[:rows].to_i : 10

    conditions={:page => current_page, :per_page => rows_per_page}
    conditions[:order] = params["sidx"] + " " + params["sord"] unless (params[:sidx].blank? || params[:sord].blank?)
    
    if params[:_search] == "true"
      conditions[:conditions]=filter_by_conditions(index_columns)
    end
    
    @oligos=Oligo.paginate(conditions)
    total_entries=@oligos.total_entries
    
    respond_with(@oligos) do |format|
      format.json { render :json => @oligos.to_jqgrid_json(index_columns, current_page, rows_per_page, total_entries)}  
    end
      
  end

  def show
          @oligo = Oligo.find(params[:id])

	    respond_to do |format|
	    format.html # show.html.erb
	    format.xml  { render :xml => @oligo }
	  end
  end

  def edit
      @oligo = Oligo.find(params[:id])
  end

  def update
        @oligo = Oligo.find(params[:id])

	    respond_to do |format|
	      if @oligo.update_attributes(params[:oligo])
		format.html { redirect_to(@oligo, :notice => 'Oligos was successfully updated.') }
		format.xml  { head :ok }
	      else
		format.html { render :action => "edit" }
		format.xml  { render :xml => @oligo.errors, :status => :unprocessable_entity }
	      end
	    end
  end

  def destroy
      if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to oligos_path
    else

        @mg = Microarraygal.find(:first, :conditions => [ "oligo_id = ?", params[:id]])
        if !@mg.nil?
          flash[:error] = "This entry cannot be deleted until used by another entries in the system..."
          redirect_to :action => "index"
          return
        end

        @oligo = Oligo.find(params[:id])
        @oligo.destroy

        respond_to do |format|
          format.html { redirect_to(oligo_url) }
          format.xml  { head :ok }
         end
      end
  end

end
