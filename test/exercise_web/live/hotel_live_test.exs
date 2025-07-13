defmodule ExerciseWeb.HotelLiveTest do
  use ExerciseWeb.ConnCase

  import Phoenix.LiveViewTest
  import Exercise.HotelsFixtures

  @create_attrs %{name: "some name", location: "some location", stars: 42}
  @update_attrs %{name: "some updated name", location: "some updated location", stars: 43}
  @invalid_attrs %{name: nil, location: nil, stars: nil}

  defp create_hotel(_) do
    hotel = hotel_fixture()
    %{hotel: hotel}
  end

  describe "Index" do
    setup [:create_hotel]

    test "lists all hotels", %{conn: conn, hotel: hotel} do
      {:ok, _index_live, html} = live(conn, ~p"/hotels")

      assert html =~ "Listing Hotels"
      assert html =~ hotel.name
    end

    test "saves new hotel", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/hotels")

      assert index_live |> element("a", "New Hotel") |> render_click() =~
               "New Hotel"

      assert_patch(index_live, ~p"/hotels/new")

      assert index_live
             |> form("#hotel-form", hotel: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#hotel-form", hotel: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/hotels")

      html = render(index_live)
      assert html =~ "Hotel created successfully"
      assert html =~ "some name"
    end

    test "updates hotel in listing", %{conn: conn, hotel: hotel} do
      {:ok, index_live, _html} = live(conn, ~p"/hotels")

      assert index_live |> element("#hotels-#{hotel.id} a", "Edit") |> render_click() =~
               "Edit Hotel"

      assert_patch(index_live, ~p"/hotels/#{hotel}/edit")

      assert index_live
             |> form("#hotel-form", hotel: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#hotel-form", hotel: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/hotels")

      html = render(index_live)
      assert html =~ "Hotel updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes hotel in listing", %{conn: conn, hotel: hotel} do
      {:ok, index_live, _html} = live(conn, ~p"/hotels")

      assert index_live |> element("#hotels-#{hotel.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#hotels-#{hotel.id}")
    end
  end

  describe "Show" do
    setup [:create_hotel]

    test "displays hotel", %{conn: conn, hotel: hotel} do
      {:ok, _show_live, html} = live(conn, ~p"/hotels/#{hotel}")

      assert html =~ "Show Hotel"
      assert html =~ hotel.name
    end

    test "updates hotel within modal", %{conn: conn, hotel: hotel} do
      {:ok, show_live, _html} = live(conn, ~p"/hotels/#{hotel}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Hotel"

      assert_patch(show_live, ~p"/hotels/#{hotel}/show/edit")

      assert show_live
             |> form("#hotel-form", hotel: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#hotel-form", hotel: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/hotels/#{hotel}")

      html = render(show_live)
      assert html =~ "Hotel updated successfully"
      assert html =~ "some updated name"
    end
  end
end
