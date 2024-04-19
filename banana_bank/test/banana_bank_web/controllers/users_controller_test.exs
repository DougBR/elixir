defmodule BananaBankWeb.UsersControllerTest do
  alias BananaBank.Users.User
  use BananaBankWeb.ConnCase

  import BananaBank.Factory

  describe "create/2" do
    test "successfully creates a user", %{conn: conn} do
      %User{cep: cep, email: email, name: name, password: password} = build(:user)

      response =
        conn
        |> post(~p"/api/users", %{"cep" => cep, "email" => email, "name" => name, "password" => password})
        |> json_response(:created)

      assert %{
               "data" => %{"cep" => cep, "email" => email, "id" => response["data"]["id"], "name" => name},
               "message" => "User created"
             } == response
    end

    test "when there are missing params, returns an error", %{conn: conn} do
      %User{cep: cep, email: email, name: name} = insert(:user)

      response =
        conn
        |> post(~p"/api/users/", %{"cep" => cep, "email" => email, "name" => name})
        |> json_response(:bad_request)

      assert %{
               "errors" => %{"password" => ["can't be blank"]}
             } == response
    end
  end

  describe "delete/2" do
    test "successfully deletes a user", %{conn: conn} do
      %User{id: id, email: email, cep: cep} = insert(:user)

      response =
        conn
        |> delete(~p"/api/users/#{id}")
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"cep" => cep, "email" => email, "id" => id, "name" => "Jane Smith"},
        "message" => "User deleted"
      }

      assert response == expected_response
    end
  end
end
