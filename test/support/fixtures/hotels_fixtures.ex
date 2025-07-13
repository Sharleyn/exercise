defmodule Exercise.HotelsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Exercise.Hotels` context.
  """

  @doc """
  Generate a hotel.
  """
  def hotel_fixture(attrs \\ %{}) do
    {:ok, hotel} =
      attrs
      |> Enum.into(%{
        location: "some location",
        name: "some name",
        stars: 42
      })
      |> Exercise.Hotels.create_hotel()

    hotel
  end
end
