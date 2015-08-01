defmodule ApiKompot.V1.MetricController do
  require IEx
  use ApiKompot.Web, :controller

  alias ApiKompot.Metric

  plug :scrub_params, "metric" when action in [:create, :update]

  def index(conn, _params) do
    metrics = Repo.all(Metric)
    render(conn, "index.json", metrics: metrics)
  end

  def create(conn, %{"metric" => metric_params}) do
    changeset = Metric.changeset(%Metric{}, metric_params)

    # Phoenix.Channel.broadcast "messages", "rooms:lobby", %{ body: metric_params }
    # ApiKompot.Endpoint.broadcast! "rooms:lobby", "new_msg", %{body: 11}
    case Repo.insert(changeset) do
      {:ok, metric} ->
        render(conn, "show.json", metric: metric)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ApiKompot.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    metric = Repo.get!(Metric, id)
    render conn, "show.json", metric: metric
  end

  def update(conn, %{"id" => id, "metric" => metric_params}) do
    metric = Repo.get!(Metric, id)
    changeset = Metric.changeset(metric, metric_params)

    case Repo.update(changeset) do
      {:ok, metric} ->
        render(conn, "show.json", metric: metric)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ApiKompot.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    metric = Repo.get!(Metric, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    metric = Repo.delete!(metric)

    send_resp(conn, :no_content, "")
  end
end
