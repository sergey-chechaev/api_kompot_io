defmodule ApiKompot.TestWsTest do
  use ApiKompot.ModelCase

  alias ApiKompot.TestWs

  @valid_attrs %{title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TestWs.changeset(%TestWs{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TestWs.changeset(%TestWs{}, @invalid_attrs)
    refute changeset.valid?
  end
end
