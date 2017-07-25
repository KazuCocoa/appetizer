# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :appetizer, Appetizer.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "b+VT/VGA0Dt5WVC1t8WJqz5XCFY6mVJDXkR25FO9VQ6vbZLVNhvel9k+R44IW229",
  render_errors: [view: Appetizer.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Appetizer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ex_aws,
  access_key_id: ["access_key_id", :instance_role],
  secret_access_key: ["secret_access_key", :instance_role],
  s3: [
    scheme: "https://",
    host: "my-elixir-example.s3.amazonaws.com",
    region: "ap-northeast-1"
  ]
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
