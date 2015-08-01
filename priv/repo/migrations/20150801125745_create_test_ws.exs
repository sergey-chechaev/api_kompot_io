defmodule ApiKompot.Repo.Migrations.CreateTestWs do
  use Ecto.Migration

  def change do
    create table(:test_ws) do
      add :title, :string

      timestamps
    end

  end
end
