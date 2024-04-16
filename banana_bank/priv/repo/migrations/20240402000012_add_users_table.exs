defmodule BananaBank.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :password_hash, :string
      add :email, :string
      add :cep, :string

      timestamps()
    end
  end
end
