defmodule Exercise.Repo.Migrations.AddHotelsTable do
  use Ecto.Migration

  def change do
    alter table (:hotels) do
      add :breakfast, :string
    end
  end
end
