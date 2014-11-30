class SessionsController < ApplicationController
  force_ssl except: [:destroy]

  skip_before_action :login_required
  skip_before_action :verify_authenticity_token


  # GET /session/new
  def new
  end

  # POST /session
  def create
    user_detail = UserDetail.authenticate(params[:login], params[:password])

    if user_detail
      self.current_user = user_detail
      uri = session[:original_uri]
      session[:original_uri] = nil

      render :json => user_detail
    else

      render :json => {error: 'Invalid Credentials'}, :status => :unprocessable_entity

    end
  end

  #DELETE /session
  def destroy
    session[:user_id] = nil
    render :json => {:status => 200}
  end

end
