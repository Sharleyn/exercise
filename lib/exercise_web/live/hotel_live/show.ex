defmodule ExerciseWeb.HotelLive.Show do
  use ExerciseWeb, :live_view

  alias Exercise.Hotels

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:hotel, Hotels.get_hotel!(id))}
  end

  defp page_title(:show), do: "Show Hotel"
  defp page_title(:edit), do: "Edit Hotel"



end
