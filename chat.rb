require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))


message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant."
  }
]

input = ""
linebreak = "_"*50

while input != "bye"
  puts "How can I help you today?"
  puts linebreak
  input = gets.chomp
    if input != "buy"
      message_list.push({"role" => "user", "content" => input})
      api_response = client.chat(
        parameters: {
        model: "gpt-3.5-turbo",
        messages: message_list
        }
      )

      parsed_response = api_response.fetch("choices").at(0).fetch("message").fetch("content").to_s
      puts parsed_response
      puts linebreak
      message_list.push({"role" => "system", "content" => parsed_response})
    end
end
