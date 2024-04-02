defmodule BananaBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string
    field :cep, :string
    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password_hash, :cep])
    |> validate_required([:name, :email, :password_hash, :cep])
  end
end
