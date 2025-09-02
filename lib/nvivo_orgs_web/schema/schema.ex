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
  end

  object :item do
    field :id, non_null(:id)
    field :name, non_null(:string)
  end
end
