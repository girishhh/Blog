class ApplicationController < ActionController::Base
  protect_from_forgery
  Devise::Controllers::Helpers#stored_location_for


  def after_sign_in_path_for(resource_or_scope)
  	new_post_path
	end

  def after_sign_out_path_for(resource_or_scope)
    #request.referrer
    new_post_path
  end

  def after_update_path_for(resource_or_scope)
    new_post_path
  end
end
