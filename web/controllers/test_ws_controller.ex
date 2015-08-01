defmodule ApiKompot.TestWsController do
  use ApiKompot.Web, :controller

  alias ApiKompot.TestWs

  plug :scrub_params, "test_ws" when action in [:create, :update]

  def index(conn, _params) do
    test_ws = Repo.all(TestWs)
    render(conn, "index.json", test_ws: test_ws)
  end

  def create(conn, %{"test_ws" => test_ws_params}) do
    changeset = TestWs.changeset(%TestWs{}, test_ws_params)

    case Repo.insert(changeset) do
      {:ok, test_ws} ->
        render(conn, "show.json", test_ws: test_ws)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ApiKompot.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    test_ws = Repo.get!(TestWs, id)
    render conn, "show.json", test_ws: test_ws
  end

  def update(conn, %{"id" => id, "test_ws" => test_ws_params}) do
    test_ws = Repo.get!(TestWs, id)
    changeset = TestWs.changeset(test_ws, test_ws_params)

    case Repo.update(changeset) do
      {:ok, test_ws} ->
        render(conn, "show.json", test_ws: test_ws)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ApiKompot.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    test_ws = Repo.get!(TestWs, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    test_ws = Repo.delete!(test_ws)

    send_resp(conn, :no_content, "")
  end
end
