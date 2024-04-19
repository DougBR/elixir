defmodule BananaBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Ecto.Changeset

  @required_params [:name, :password, :email, :cep]
  @required_params_update [:name, :email, :cep]

  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :email, :string
    field :cep, :string
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> do_validations()
    |> add_password_hash()
  end

  def changeset(user, params) do
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params_update)
    |> do_validations()
  end

  defp do_validations(changeset) do
    changeset
    |> validate_length(:cep, is: 8)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_length(:name, min: 3, max: 15)
  end

  defp add_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    changeset
    |> change(Argon2.add_hash(password))
  end

  defp add_password_hash(changeset), do: changeset

  def all_users_query do
    from(u in __MODULE__, select: u)
  end
end
