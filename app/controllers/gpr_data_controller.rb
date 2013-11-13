class GprDataController < AuthController

  respond_to :html,:json
  
  protect_from_forgery :except => [:post_data]
  
  # Don't forget to edit routes if you're using RESTful routing
  # 
  #resources :gpr_data,:only => [:index] do
  #   collection do
  #     post "post_data"
  #   end
  # end

  def post_data
    message=""
    gpr_data_params = { :id => params[:id],:microarraygpr_id => params[:microarraygpr_id],:gpr_header_id => params[:gpr_header_id],:gal_block_id => params[:gal_block_id],:oligo_row => params[:oligo_row],:oligo_column => params[:oligo_column],:oligo_id => params[:oligo_id],:oligo_name => params[:oligo_name],:x => params[:x],:y => params[:y],:dia => params[:dia],:f635_median => params[:f635_median],:f635_mean => params[:f635_mean],:f635_sd => params[:f635_sd],:f635_cv => params[:f635_cv],:b635 => params[:b635],:b635_Median => params[:b635_Median],:b635_mean => params[:b635_mean],:b635_sd => params[:b635_sd],:b635_cv => params[:b635_cv],:percent_b635_1_sd => params[:percent_b635_1_sd],:percent_b635_2_sd => params[:percent_b635_2_sd],:f635_perc_sat => params[:f635_perc_sat],:f532_median => params[:f532_median],:f532_mean => params[:f532_mean],:f532_sd => params[:f532_sd],:f532_cv => params[:f532_cv],:b532 => params[:b532],:b532_median => params[:b532_median],:b532_mean => params[:b532_mean],:b532_sd => params[:b532_sd],:b532_cv => params[:b532_cv],:percent_b532_1_sd => params[:percent_b532_1_sd],:percent_b532_2_sd => params[:percent_b532_2_sd],:f532_perc_sat => params[:f532_perc_sat],:ratio_of_medians => params[:ratio_of_medians],:ratio_of_means => params[:ratio_of_means],:median_of_ratios => params[:median_of_ratios],:mean_of_ratios => params[:mean_of_ratios],:ratios_sd => params[:ratios_sd],:rgn_ratio => params[:rgn_ratio],:rgn_r2 => params[:rgn_r2],:f_pixels => params[:f_pixels],:b_pixels => params[:b_pixels],:circularity => params[:circularity],:sum_of_medians => params[:sum_of_medians],:sum_of_means => params[:sum_of_means],:log_ratio => params[:log_ratio],:f635_median_minus_b635 => params[:f635_median_minus_b635],:f532_median_minus_b635 => params[:f532_median_minus_b635],:f635_mean_minus_b635 => params[:f635_mean_minus_b635],:f532_mean_minus_b635 => params[:f532_mean_minus_b635],:f635_total_intensity => params[:f635_total_intensity],:f532_total_intensity => params[:f532_total_intensity],:snr_635 => params[:snr_635],:snr_532 => params[:snr_532],:flags => params[:flags],:normalize => params[:normalize],:autoflag => params[:autoflag] }
    case params[:oper]
    when 'add'
      if params["id"] == "_empty"
        gpr_data = GprData.create(gpr_data_params)
        message << ('add ok') if gpr_data.errors.empty?
      end
      
    when 'edit'
      gpr_data = GprData.find(params[:id])
      message << ('update ok') if gpr_data.update_attributes(gpr_data_params)
    when 'del'
      GprData.destroy_all(:id => params[:id].split(","))
      message <<  ('del ok')
    when 'sort'
      gpr_data = GprData.all
      gpr_data.each do |gpr_data|
        gpr_data.position = params['ids'].index(gpr_data.id.to_s) + 1 if params['ids'].index(gpr_data.id.to_s) 
        gpr_data.save
      end
      message << "sort ak"
    else
      message <<  ('unknown action')
    end
    
    unless (gpr_data && gpr_data.errors).blank?  
      gpr_data.errors.entries.each do |error|
        message << "<strong>#{GprData.human_attribute_name(error[0])}</strong> : #{error[1]}<br/>"
      end
      render :json =>[false,message]
    else
      render :json => [true,message] 
    end
  end


 def index
#	   @gpr_datas = GprData.all
           @title = "GenePix result data"

        
#        gpr_datas = GprData.find(:all) do
#            paginate :page => params[:page], :per_page => params[:rows]      
#            order_by "#{params[:sidx]} #{params[:sord]}"
#           end
#
#         respond_to do |format|
#        format.html 
#        format.json { render :json => gpr_datas.to_jqgrid_json##([:id,"act","gpr_code","array_info",:x,:y,
#:dia,:f635_median,:f635_mean,:f635_sd,:f635_cv,:b635,:b635_Median,:b635_mean,:b635_sd,:b635_cv,
#:percent_b635_1_sd,:percent_b635_2_sd,:f635_perc_sat,:f532_median,:f532_mean,:f532_sd,:f532_cv,:b532,
#:b532_median,:b532_mean,:b532_sd,:b532_cv,:percent_b532_1_sd,:percent_b532_2_sd,:f532_perc_sat,
#:ratio_of_medians,:ratio_of_means,:median_of_ratios,:mean_of_ratios,:ratios_sd,:rgn_ratio,:rgn_r2,
#:f_pixels,:b_pixels,:circularity,:sum_of_medians,:sum_of_means,:log_ratio,:f635_median_minus_b635,
#:f532_median_minus_b635,:f635_mean_minus_b635,:f532_mean_minus_b635,:f635_total_intensity,
#:f532_total_intensity,:snr_635,:snr_532,:flags,:normalize,:autoflag,"edit"], params[:page], params#[:rows], gpr_datas.total_entries) }			
#      end 

  index_columns ||= [:id,"act","gpr_code","array_info",:x,:y,
:dia,:f635_median,:f635_mean,:f635_sd,:f635_cv,:b635,:b635_Median,:b635_mean,:b635_sd,:b635_cv,
:percent_b635_1_sd,:percent_b635_2_sd,:f635_perc_sat,:f532_median,:f532_mean,:f532_sd,:f532_cv,:b532,
:b532_median,:b532_mean,:b532_sd,:b532_cv,:percent_b532_1_sd,:percent_b532_2_sd,:f532_perc_sat,
:ratio_of_medians,:ratio_of_means,:median_of_ratios,:mean_of_ratios,:ratios_sd,:rgn_ratio,:rgn_r2,
:f_pixels,:b_pixels,:circularity,:sum_of_medians,:sum_of_means,:log_ratio,:f635_median_minus_b635,
:f532_median_minus_b635,:f635_mean_minus_b635,:f532_mean_minus_b635,:f635_total_intensity,
:f532_total_intensity,:snr_635,:snr_532,:flags,:normalize,:autoflag,"edit"]
    current_page = params[:page] ? params[:page].to_i : 1
    rows_per_page = params[:rows] ? params[:rows].to_i : 10

    conditions={:page => current_page, :per_page => rows_per_page}
    conditions[:order] = params["sidx"] + " " + params["sord"] unless (params[:sidx].blank? || params[:sord].blank?)
    
    if params[:_search] == "true"
      conditions[:conditions]=filter_by_conditions(index_columns)
    end
    
    @gpr_datas=GprData.paginate(conditions)
    total_entries=@gpr_datas.total_entries
    
    respond_with(@gpr_datas) do |format|
      format.json { render :json => @gpr_datas.to_jqgrid_json(index_columns, current_page, rows_per_page, total_entries)}  
    end
     
  end



  def show
          @gpr_data = GprData.find(params[:id])

	    respond_to do |format|
	    format.html # show.html.erb
	    format.xml  { render :xml => @gpr_data }
	  end
  end

  def edit
      @gpr_data = GprData.find(params[:id])
  end

  

  def update
        @gpr_data = GprData.find(params[:id])

	    respond_to do |format|
	      if @gpr_data.update_attributes(params[:GprData])
		format.html { redirect_to(@gpr_data, :notice => 'GprData is successfully updated.') }
		format.xml  { head :ok }
	      else
		format.html { render :action => "edit" }
		format.xml  { render :xml => @gpr_data.errors, :status => :unprocessable_entity }
	      end
	    end
  end

  def destroy
      if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to gpr_datas_path
    else

        @mg = Microarraygpr.find(:first, :conditions => [ "gpr_data_id = ?", params[:id]])
        if !@mg.nil?
          flash[:error] = "This entry cannot be deleted until used by another entries in the system..."
          redirect_to :action => "index"
          return
        end

        @gpr_data = GprData.find(params[:id])
        @gpr_data.destroy

        respond_to do |format|
          format.html { redirect_to(gpr_data_url) }
          format.xml  { head :ok }
         end
      end
  end






end
