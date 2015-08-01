defmodule ApiKompot.MetricControllerTest do
  use ApiKompot.ConnCase

  alias ApiKompot.Metric
  @valid_attrs %{duration: "120.5", metric_id: 42, name: "some content", request: "some content", start: 42}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, metric_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    metric = Repo.insert! %Metric{}
    conn = get conn, metric_path(conn, :show, metric)
    assert json_response(conn, 200)["data"] == %{
      "id" => metric.id
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, metric_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, metric_path(conn, :create), metric: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Metric, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, metric_path(conn, :create), metric: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    metric = Repo.insert! %Metric{}
    conn = put conn, metric_path(conn, :update, metric), metric: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Metric, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    metric = Repo.insert! %Metric{}
    conn = put conn, metric_path(conn, :update, metric), metric: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    metric = Repo.insert! %Metric{}
    conn = delete conn, metric_path(conn, :delete, metric)
    assert response(conn, 204)
    refute Repo.get(Metric, metric.id)
  end
end
