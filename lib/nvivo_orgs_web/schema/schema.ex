defmodule NvivoOrgsWeb.Schema do
  use Absinthe.Schema

  @items [
    %{id: 1, name: "Item 1"},
    %{id: 2, name: "Item 2"},
    %{id: 3, name: "Item 3"}
  ]

  query do
    field :items, list_of(:item) do
      resolve(fn _, _ ->
        {:ok, @items}
      end)
    end

    field :item, :item do
      arg :id, non_null(:id)

      resolve(fn %{id: id}, _ ->
        case Enum.find(@items, fn item -> item.id == String.to_integer(id) end) do
          nil -> {:error, "Item not found"}
          item -> {:ok, item}
        end
      end)
    end
  end

  object :item do
    field :id, non_null(:id)
    field :name, non_null(:string)
  end
end
