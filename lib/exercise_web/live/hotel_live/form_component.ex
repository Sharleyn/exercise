defmodule ExerciseWeb.HotelLive.FormComponent do
  use ExerciseWeb, :live_component

  alias Exercise.Hotels

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage hotel records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="hotel-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:location]} type="text" label="Location" />
        <.input field={@form[:stars]} type="number" label="Stars" />
        <.input field={@form[:category]} type="text" label="Categories" />
        <.input field={@form[:breakfast]} type="text" label="Breakfast" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Hotel</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{hotel: hotel} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hotels.change_hotel(hotel))
     end)}
  end

  @impl true
  def handle_event("validate", %{"hotel" => hotel_params}, socket) do
    changeset = Hotels.change_hotel(socket.assigns.hotel, hotel_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"hotel" => hotel_params}, socket) do
    save_hotel(socket, socket.assigns.action, hotel_params)
  end

  defp save_hotel(socket, :edit, hotel_params) do
    case Hotels.update_hotel(socket.assigns.hotel, hotel_params) do
      {:ok, hotel} ->
        notify_parent({:saved, hotel})

        {:noreply,
         socket
         |> put_flash(:info, "Hotel updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_hotel(socket, :new, hotel_params) do
    case Hotels.create_hotel(hotel_params) do
      {:ok, hotel} ->
        notify_parent({:saved, hotel})

        {:noreply,
         socket
         |> put_flash(:info, "Hotel created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
