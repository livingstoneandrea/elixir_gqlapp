defmodule ElixirGqlapp.TodosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirGqlapp.Todos` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        completed_at: ~U[2024-12-28 17:29:00Z],
        content: "some content"
      })
      |> ElixirGqlapp.Todos.create_item()

    item
  end
end
