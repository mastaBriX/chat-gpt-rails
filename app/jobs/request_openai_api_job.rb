class RequestOpenaiApiJob < ApplicationJob
  queue_as :default

  def perform(data, current_user, redis_key)
    @client ||= OpenAI::Client.new
    @redis ||= Redis.new(ENV.fetch('REDIS_URL_SESSION'))

    response = { time: Time.now.to_i.to_s, role: 'assistant', content: get_response_from_openai(data) }

    session = load_session(redis_key)
    session["chatHistory"][current_user.id] << response
    save_session(session, redis_key)

    Turbo::StreamsChannel.broadcast_append_to "chat-messages-#{current_user.id}", target: "chat-messages", partial: "chat/message", locals: { msg: response,from:'Chat-GPT', msg_id: SecureRandom.uuid }

  end

  private

  def load_session(redis_key)
    Marshal.load(@redis.get(redis_key))
  end

  def save_session(session, redis_key)
    @redis.set(redis_key, Marshal.dump(session))
  end

  def get_response_from_openai(message)
    @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: message,
        temperature: 0.7,
      }).dig("choices", 0, "message", "content")
    # "test"
  end
end
