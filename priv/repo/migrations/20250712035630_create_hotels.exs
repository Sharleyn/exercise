defmodule Exercise.Repo.Migrations.CreateHotels do
  use Ecto.Migration

  def change do
    create table(:hotels) do
      add :name, :string
      add :location, :string
      add :stars, :integer
      add :category, :string

      timestamps(type: :utc_datetime)
    end
  end
end
