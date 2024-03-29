defmodule Natureba.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string
      add :body, :text
      add :price, :float

      timestamps()
    end

  end
end
