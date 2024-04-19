defmodule BananaBankWeb.UsersControllerTest do
  alias BananaBank.Users.User
  alias BananaBank.Users
  use BananaBankWeb.ConnCase

  describe "create/2" do
    test "successfully creates a user", %{conn: conn} do
      params = %{"name" => "teste", "password" => "123456", "email" => "w7h2A@example.com", "cep" => "12345678"}

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert %{
               "data" => %{"cep" => "12345678", "email" => "w7h2A@example.com", "id" => _id, "name" => "teste"},
               "message" => "User created"
             } = response
    end

    test "when there are missing params, returns an error", %{conn: conn} do
      params = %{"name" => "teste", "email" => "w7h2A@example.com", "cep" => "12345678"}

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

      assert %{
               "errors" => %{"password" => ["can't be blank"]}
             } = response
    end
  end

  describe "delete/2" do
    test "successfully deletes a user", %{conn: conn} do
      user_data = %{"name" => "teste", "password" => "123456", "email" => "w7h2A@example.com", "cep" => "12345678"}

      {:ok, %User{id: id}} =
        Users.create(user_data)

      expected_response = %{
        "data" =>
          user_data
          |> Map.delete("password")
          |> Map.put("id", id),
        "message" => "User deleted"
      }

      response =
        conn
        |> delete(~p"/api/users/#{id}")
        |> json_response(:ok)

      assert response == expected_response
    end
  end
end
