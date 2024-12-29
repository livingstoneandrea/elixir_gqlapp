defmodule ElixirGqlappWeb.Api.Schema do

  use Absinthe.Schema
  alias ElixirGqlapp.Todos

  object :todo_item do
    field :id, non_null(:id) #ID!
    field :content, non_null(:string)
    field :is_completed, non_null(:boolean) do
      resolve (fn %{completed_at: completed_at}, _, _ -> {:ok, !is_nil(completed_at)} end)
    end
  end


  mutation do
    field :create_todo_item, :todo_item do
      arg(:content, non_null(:string))

      resolve(fn %{content: content}, _ ->
        case Todos.create_item(%{content: content}) do
          {:ok, item} ->
            {:ok, item}

          {:error, error} ->
            {:error, error}
        end
      end)
    end

    field :toggle_todo_item, :todo_item do
      arg(:id, non_null(:id))

      resolve(fn %{id: item_id}, _ ->
        Todos.toggle_item_by_id(item_id)
      end)
    end
  end

  query do
    field :hello, :string do
      resolve (fn %{completed_at: completed_at}, _, _ -> {:ok, !is_nil(completed_at)} end)
    end

    field :todo_items, non_null(list_of(:todo_item)) do #[TodoItem!]!
      resolve fn _, _, _ -> {:ok, Todos.list_items()} end
    end
  end
end
