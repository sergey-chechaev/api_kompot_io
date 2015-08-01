defmodule ApiKompot.TestWsView do
  use ApiKompot.Web, :view

  def render("index.json", %{test_ws: test_ws}) do
    %{data: render_many(test_ws, "test_ws.json")}
  end

  def render("show.json", %{test_ws: test_ws}) do
    %{data: render_one(test_ws, "test_ws.json")}
  end

  def render("test_ws.json", %{test_ws: test_ws}) do
    %{id: test_ws.id}
  end
end
