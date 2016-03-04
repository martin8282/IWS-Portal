class FeatureRequestController < ApplicationController
  def index
    @products = Product.all.to_a.collect{ |client| [ client.name, client.id ] }
    @clients = Client.all.to_a.collect{ |client| [ client.name, "#{client.id}:#{client.feature_requests.size + 1}" ] }.insert(0, [ 'All clients', "-1:0" ])
    @selected_client_id = session[:selected_client_id] || @clients.first[1]
    @feature_request = FeatureRequest.new
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
    flash[:notice] = 'Feature request created successfully'
  rescue Exception => ex
    flash[:alert] = ex.message
  ensure
    redirect_to action: :index
  end
end
