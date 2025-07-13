defmodule ExerciseWeb.HotelLive.Index do
  use ExerciseWeb, :live_view

  alias Exercise.Hotels
  alias Exercise.Hotels.Hotel

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :hotels, Hotels.list_hotels())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Hotel")
    |> assign(:hotel, Hotels.get_hotel!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Hotel")
    |> assign(:hotel, %Hotel{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Hotels")
    |> assign(:hotel, nil)
  end

  @impl true
  def handle_info({ExerciseWeb.HotelLive.FormComponent, {:saved, hotel}}, socket) do
    {:noreply, stream_insert(socket, :hotels, hotel)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    hotel = Hotels.get_hotel!(id)
    {:ok, _} = Hotels.delete_hotel(hotel)

    {:noreply, stream_delete(socket, :hotels, hotel)}
  end

end
