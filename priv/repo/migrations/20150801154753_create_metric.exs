defmodule ApiKompot.Repo.Migrations.CreateMetric do
  use Ecto.Migration

  def change do
    create table(:metrics) do
      add :request, :string
      add :name, :string
      add :duration, :float
      add :start, :integer
      add :metric_id, :integer

      timestamps
    end

  end
end
