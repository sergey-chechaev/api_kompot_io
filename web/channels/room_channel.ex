defmodule ApiKompot.RoomChannel do
  use Phoenix.Channel

  alias ApiKompot.TestWs
  alias ApiKompot.Metric

  def join("rooms:lobby", auth_msg, socket) do
    {:ok, socket}
  end

  def join("rooms:" <> _private_room_id, _auth_msg, socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_msg", %{body: body}
    params = %{name: body}
    # changes = TestWs.changeset(%TestWs{}, params)
    changes = Metric.changeset(%Metric{}, params)
    ApiKompot.Repo.insert(changes)
    {:noreply, socket}
  end

  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    {:noreply, socket}
  end
end