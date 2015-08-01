defmodule ApiKompot.V1.MetricView do
  use ApiKompot.Web, :view

  def render("index.json", %{metrics: metrics}) do
    %{data: render_many(metrics, "metric.json")}
  end

  def render("show.json", %{metric: metric}) do
    %{data: render_one(metric, "metric.json")}
  end

  def render("metric.json", %{metric: metric}) do
    %{id: metric.id}
  end
end
