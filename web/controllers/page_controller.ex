defmodule ApiKompot.PageController do
  require IEx
  use ApiKompot.Web, :controller

  alias ApiKompot.TestWs
  alias ApiKompot.Metric

  def index(conn, _params) do
    test_ws = ApiKompot.Repo.all(Metric)
    render conn, "index.html", test_ws: test_ws
  end
end
