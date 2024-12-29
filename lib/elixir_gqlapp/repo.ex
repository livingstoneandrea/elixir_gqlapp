defmodule ElixirGqlapp.Repo do
  use Ecto.Repo,
    otp_app: :elixir_gqlapp,
    adapter: Ecto.Adapters.Postgres
end
