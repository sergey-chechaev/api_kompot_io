defmodule ApiKompot.MetricTest do
  use ApiKompot.ModelCase

  alias ApiKompot.Metric

  @valid_attrs %{duration: "120.5", metric_id: 42, name: "some content", request: "some content", start: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Metric.changeset(%Metric{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Metric.changeset(%Metric{}, @invalid_attrs)
    refute changeset.valid?
  end
end
