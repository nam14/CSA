class SessionsController < ApplicationController
  force_ssl except: [:destroy]

  skip_before_action :login_required
  skip_before_action :verify_authenticity_token

  respond_to :json

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

      #redirect_to(uri || home_url)
      #flash[:notice] = I18n.t('sessions.login-success')
    else

      #flash[:error] = I18n.t('sessions.login-failure') + " #{params[:login]}"
      #redirect_to new_session_url
    end
  end

  #DELETE /session
  def destroy
    session[:user_id] = nil
    render :json => {:status => 200}
    #redirect_to home_url
  end

end
