require 'openai'

class ChatController < ApplicationController
  before_action :authorize, :init_openai_client,

    def index
    end

  def message
    session[:chatHistory] ||= {}
    session[:chatHistory][session[:user_id]] ||= []
    session[:chatHistory][session[:user_id]].push({ time: Time.now.to_i.to_s, role: 'user', content: chat_params })

    turbo_stream.append(
      "chat-messages",
      partial: "message",
      locals: { msg: session[:chatHistory][session[:user_id]].last }
    )

    Thread.new do
      data = session[:chatHistory][session[:user_id]].map do |history|
        { role: history[:role], content: history[:content] }
      end

      session[:chatHistory][session[:user_id]].push({ time: Time.now.to_i.to_s, role: 'assistant', content: get_response_from_openai(data) })

      turbo_stream.append(
        "chat-messages",
        partial: "message",
        locals: { msg: session[:chatHistory][session[:user_id]].last }
      )
    end

    head :no_content
    # respond_to do |format|
    #   format.html { redirect_to chat_path }
    #   format.json { render json: { chatHistory: session[:chatHistory][session[:user_id]] } }
    # end
  end

  def clear
    session.delete(:chatHistory)
    redirect_to chat_path
  end

  def get_history
    render json: { history: session[:chatHistory] }
  end

  private

  def init_openai_client
    @client = OpenAI::Client.new
  end

  def chat_params
    params.require(:message)
  end

  def get_response_from_openai(message)
    # @client.chat(
    #   parameters: {
    #     model: "gpt-3.5-turbo",
    #     messages: message,
    #     temperature: 0.7,
    #   }).dig("choices", 0, "message", "content")
    "test"
  end
end
