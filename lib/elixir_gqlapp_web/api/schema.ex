defmodule ElixirGqlappWeb.Api.Schema do

  use Absinthe.Schema

  query do
    field :hello, :string do
      resolve fn _, _ -> {:ok, "hello world!"} end
    end
  end
end
