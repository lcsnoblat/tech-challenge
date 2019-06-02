defmodule ConversionApi.Repo.Migrations.CreateCoins do
  use Ecto.Migration

  def change do
    create table(:coins) do
      add :name, :string
      add :rate, :integer

      timestamps()
    end

  end
end
