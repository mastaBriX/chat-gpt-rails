require 'openai'

class ChatController < ApplicationController
  before_action :authorize, :init_openai_client,
  def index
  end

  def message
    session[:chatHistory] ||= {}
    session[:chatHistory][session[:user_id]] ||= []
    session[:chatHistory][session[:user_id]].push({time:  Time.now.to_i.to_s, role: 'user', content:chat_params[:message]})

    data = session[:chatHistory][session[:user_id]].map do |history|
      {role:history[:role], content:history[:content]}
    end

    session[:chatHistory][session[:user_id]].push({time:  Time.now.to_i.to_s, role: 'assistant', content: get_response_from_openai(data)})
    redirect_to chat_path
  end

  def clear_history
    session.delete(:chatHistory)
    redirect_to chat_path
  end

  def get_history
    render json: {history: session[:chatHistory]}
  end

  private
  def init_openai_client
    @client = OpenAI::Client.new
  end

  def chat_params
    params.permit(:message)
  end
  def get_response_from_openai(message)
    @client.chat(
      parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: message, # Required.
        temperature: 0.7,
      }).dig("choices", 0, "message", "content")
  end
end
