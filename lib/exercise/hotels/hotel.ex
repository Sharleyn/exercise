defmodule Exercise.Hotels.Hotel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "hotels" do
    field :name, :string
    field :location, :string
    field :stars, :integer
    field :breakfast, :string


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(hotel, attrs) do
    hotel
    |> cast(attrs, [:name, :location, :stars, :breakfast])
    |> validate_required([:name, :location, :stars])
  end
end
