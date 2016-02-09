require "sinatra"
require "net/http"
require "json"
require "uri"

post "/" do
  p params

  if params["token"] != ENV["INTEGRATION_TOKEN"]
    halt 401
  end

  message = "@here: Message from #{params["user_name"]} in ##{params["channel_name"]}:\n\n#{params["text"]}"

  webhook_body = JSON.dump({ "text" => message })

  Net::HTTP.post_form(URI(ENV["WEBHOOK_URL"]), "payload" => webhook_body)

  "Your message has been forwarded to the admins, we'll get in touch as soon as possible."
end

run Sinatra::Application
