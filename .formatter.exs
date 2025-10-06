[
  import_deps: [
    :ash_ai,
    :ash_state_machine,
    :ash_oban,
    :oban,
    :ash_admin,
    :ash_postgres,
    :ash_graphql,
    :absinthe,
    :ash_phoenix,
    :ash,
    :reactor,
    :ecto,
    :ecto_sql,
    :phoenix
  ],
  subdirectories: ["priv/*/migrations"],
  plugins: [Absinthe.Formatter, Spark.Formatter, Phoenix.LiveView.HTMLFormatter],
  inputs: ["*.{heex,ex,exs}", "{config,lib,test}/**/*.{heex,ex,exs}", "priv/*/seeds.exs"]
]
