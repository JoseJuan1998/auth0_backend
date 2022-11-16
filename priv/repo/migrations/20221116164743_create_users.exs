defmodule Auth0Backend.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :email, :string, null: false
      add :phone, :string, null: false
      add :auth0_id, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
