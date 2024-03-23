require 'siwe'
require 'json'

class SessionsController < ApplicationController
  def index
    @login_msg = "You are signed in as #{current_user.address}." if current_user
  end

  def sign_in
    message = Siwe::Message.from_json_string session[:message]

    begin
      message&.verify(params.require(:signature), message.domain, message.issued_at, message.nonce)
      session[:message] = nil
      session[:ens] = params[:ens]
      session[:address] = message.address

      @user = User.find_or_create_by(address: message.address)
      @login_msg = "You are signed in as #{message.address}."
    rescue StandardError => e
      @login_msg = "Sign in failed. Please try again."
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

  def message
    nonce = Siwe::Util.generate_nonce
    message = Siwe::Message.new(
      request.host_with_port,
      params[:address],
      "#{request.protocol}#{request.host_with_port}",
      '1',
      {
        statement: 'Welcome to Loic\'s web3 app. Click "Sign" to sign in. No password needed !',
        nonce: nonce,
        chain_id: params[:chainId]
      }
    )

    session[:message] = message.to_json_string

    render plain: message.prepare_message
  end

  def sign_out
    if current_user
      session[:ens] = nil
      session[:address] = nil
      @login_msg = "You are signed out."
    end
    respond_to do |format|
      format.turbo_stream
    end
  end
end