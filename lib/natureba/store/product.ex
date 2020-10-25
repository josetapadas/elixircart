defmodule Natureba.Store.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :body, :string
    field :price, :float
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title, :body, :price])
    |> validate_required([:title, :body, :price])
  end
end
