require 'openai'

class ChatController < ApplicationController
  before_action :authorize

    def index
      session[:chatHistory] ||= {}
      session[:chatHistory][@current_user.id] ||= []
      puts session.id
    end

  def message
    session[:chatHistory][@current_user.id] << { time: Time.now.to_i.to_s, role: 'user', content: chat_params }

    data = session[:chatHistory][@current_user.id].map { |history| { role: history[:role], content: history[:content] } }

    Turbo::StreamsChannel.broadcast_append_to "chat-messages-#{@current_user.id}", target: "chat-messages", partial: "chat/message", locals: { msg: session[:chatHistory][@current_user.id].last, from:@current_user.username, msg_id: SecureRandom.uuid }

    # 向openai api发送请求获取返回
    RequestOpenaiApiJob.perform_later(data, @current_user, "session:#{session.id.private_id}")

    render json: {status: :ok, data: { time: Time.now.to_i.to_s, role: @current_user.username, content: chat_params }}
  end

  def clear
    session.delete(:chatHistory)
    redirect_to chat_path
  end

  def get_history
    render json: { history: session[:chatHistory] }
  end

  private
  def chat_params
    params.require(:message)
  end


end
