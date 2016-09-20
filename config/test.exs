use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sample_microservice, SampleMicroservice.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :sample_microservice, SampleMicroservice.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "",
  database: "sample_microservice_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
