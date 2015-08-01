defmodule ApiKompot.TestWsControllerTest do
  use ApiKompot.ConnCase

  alias ApiKompot.TestWs
  @valid_attrs %{title: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, test_ws_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    test_ws = Repo.insert! %TestWs{}
    conn = get conn, test_ws_path(conn, :show, test_ws)
    assert json_response(conn, 200)["data"] == %{
      "id" => test_ws.id
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, test_ws_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, test_ws_path(conn, :create), test_ws: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(TestWs, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, test_ws_path(conn, :create), test_ws: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    test_ws = Repo.insert! %TestWs{}
    conn = put conn, test_ws_path(conn, :update, test_ws), test_ws: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(TestWs, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    test_ws = Repo.insert! %TestWs{}
    conn = put conn, test_ws_path(conn, :update, test_ws), test_ws: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    test_ws = Repo.insert! %TestWs{}
    conn = delete conn, test_ws_path(conn, :delete, test_ws)
    assert response(conn, 204)
    refute Repo.get(TestWs, test_ws.id)
  end
end
