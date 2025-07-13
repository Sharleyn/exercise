defmodule Exercise.HotelsTest do
  use Exercise.DataCase

  alias Exercise.Hotels

  describe "hotels" do
    alias Exercise.Hotels.Hotel

    import Exercise.HotelsFixtures

    @invalid_attrs %{name: nil, location: nil, stars: nil}

    test "list_hotels/0 returns all hotels" do
      hotel = hotel_fixture()
      assert Hotels.list_hotels() == [hotel]
    end

    test "get_hotel!/1 returns the hotel with given id" do
      hotel = hotel_fixture()
      assert Hotels.get_hotel!(hotel.id) == hotel
    end

    test "create_hotel/1 with valid data creates a hotel" do
      valid_attrs = %{name: "some name", location: "some location", stars: 42}

      assert {:ok, %Hotel{} = hotel} = Hotels.create_hotel(valid_attrs)
      assert hotel.name == "some name"
      assert hotel.location == "some location"
      assert hotel.stars == 42
    end

    test "create_hotel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hotels.create_hotel(@invalid_attrs)
    end

    test "update_hotel/2 with valid data updates the hotel" do
      hotel = hotel_fixture()
      update_attrs = %{name: "some updated name", location: "some updated location", stars: 43}

      assert {:ok, %Hotel{} = hotel} = Hotels.update_hotel(hotel, update_attrs)
      assert hotel.name == "some updated name"
      assert hotel.location == "some updated location"
      assert hotel.stars == 43
    end

    test "update_hotel/2 with invalid data returns error changeset" do
      hotel = hotel_fixture()
      assert {:error, %Ecto.Changeset{}} = Hotels.update_hotel(hotel, @invalid_attrs)
      assert hotel == Hotels.get_hotel!(hotel.id)
    end

    test "delete_hotel/1 deletes the hotel" do
      hotel = hotel_fixture()
      assert {:ok, %Hotel{}} = Hotels.delete_hotel(hotel)
      assert_raise Ecto.NoResultsError, fn -> Hotels.get_hotel!(hotel.id) end
    end

    test "change_hotel/1 returns a hotel changeset" do
      hotel = hotel_fixture()
      assert %Ecto.Changeset{} = Hotels.change_hotel(hotel)
    end
  end
end
