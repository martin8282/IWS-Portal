class FeatureRequestController < ApplicationController
  def index
    init_details(nil)
    init_lists(session[:selected_client_id], session[:selected_date])
    load_records
  end

  def list
    init_lists(params[:id], params[:date])
    load_records
    render partial: 'list'
  end

  def details
    id = params[:id].to_i
    init_details(id)
    init_lists(session[:selected_client_id], session[:selected_date], id > 0 ? 0 : 1)
    render partial: 'modal_details'
  end

  def update
    id = params[:frm_feature_request][:id].to_i
    if id > 0
      feature = FeatureRequest.where(id: id).first
      fail 'Feature not found' unless feature
    else
      feature = FeatureRequest.new
    end
    assign_attributes(feature, params[:frm_feature_request], %w(id))
    feature.save!
    feature.recalculate_priorities

    flash[:notice] = id > 0 ? 'Feature request updated successfully' : 'Feature request created successfully'
  rescue Exception => ex
    flash[:alert] = ex.message
  ensure
    redirect_to action: :index
  end

  private

  def init_details(feature_request_id)
    id = feature_request_id.is_a?(Numeric) ? feature_request_id : feature_request_id.to_i
    @feature_request = id > 0  ? FeatureRequest.find(id) : FeatureRequest.new
  end

  def init_lists(selected_client_id, selected_date, step_priority = 1)
    @products = Product.order(:name).to_a
      .collect{ |client| [ client.name, client.id ] }

    @clients = Client.order(:name).to_a
      .collect{ |client| [ client.name, client.id, client.feature_requests.size + step_priority ] }
      .insert(0, [ 'All clients', 0, 0 ])

    @selected_client_id = selected_client_id.is_a?(Numeric) ? selected_client_id : selected_client_id.to_i
    @selected_date = selected_date.is_a?(Date) ? selected_date : (Date.strptime(selected_date, '%m/%d/%Y') rescue nil)

    session[:selected_client_id] = @selected_client_id
    session[:selected_date] = @selected_date
  end

  def load_records
    @records = FeatureRequest.select('feature_requests.*, clients.name as client, products.name as product')
      .joins(:client)
      .joins(:product)
      .order('clients.name, client_priority')

    @records = @records.where(client_id: @selected_client_id) if @selected_client_id > 0
    @records = @records.where('target_date >= ?', @selected_date) if @selected_date
  end
end
