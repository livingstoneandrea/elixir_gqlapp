defmodule ElixirGqlapp.TodosTest do
  use ElixirGqlapp.DataCase

  alias ElixirGqlapp.Todos

  describe "items" do
    alias ElixirGqlapp.Todos.Item

    import ElixirGqlapp.TodosFixtures

    @invalid_attrs %{content: nil, completed_at: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Todos.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Todos.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{content: "some content", completed_at: ~U[2024-12-28 17:29:00Z]}

      assert {:ok, %Item{} = item} = Todos.create_item(valid_attrs)
      assert item.content == "some content"
      assert item.completed_at == ~U[2024-12-28 17:29:00Z]
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todos.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{content: "some updated content", completed_at: ~U[2024-12-29 17:29:00Z]}

      assert {:ok, %Item{} = item} = Todos.update_item(item, update_attrs)
      assert item.content == "some updated content"
      assert item.completed_at == ~U[2024-12-29 17:29:00Z]
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.update_item(item, @invalid_attrs)
      assert item == Todos.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Todos.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Todos.change_item(item)
    end
  end
end
