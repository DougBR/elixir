defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  import Mox
  import BananaBank.Factory

  alias BananaBank.Users.User

  describe "create/2" do
    test "successfully creates a user", %{conn: conn} do
      %User{cep: cep, email: email, name: name, password: password} = build(:user)

      body = build(:cep)

      expect(BananaBank.ViaCep.ClientMock, :call, fn _cep -> {:ok, body} end)

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

      body = build(:cep)

      expect(BananaBank.ViaCep.ClientMock, :call, fn _cep -> {:ok, body} end)

      response =
        conn
        |> post(~p"/api/users/", %{"cep" => cep, "email" => email, "name" => name})
        |> json_response(:bad_request)

      assert %{
               "errors" => %{"password" => ["can't be blank"]}
             } == response
    end

    test "when CEP is not found, returns an error", %{conn: conn} do
      %User{email: email, name: name} = insert(:user)
      cep = 39_816_000

      expect(BananaBank.ViaCep.ClientMock, :call, fn _cep -> {:error, :bad_request} end)

      response =
        conn
        |> post(~p"/api/users/", %{"cep" => cep, "email" => email, "password" => "pass", "name" => name})
        |> json_response(:bad_request)

      assert %{"message" => "Something went wrong", "status" => "bad_request"} == response
    end

    test "when CEP is invalid, returns an error", %{conn: conn} do
      cep = "12"
      params = %{"cep" => cep, "email" => "aderf@gjao.com", "name" => "Jabraulino", "password" => "pass"}

      expect(BananaBank.ViaCep.ClientMock, :call, fn _cep -> {:ok, ""} end)

      response =
        conn
        |> post(~p"/api/users/", params)
        |> json_response(:bad_request)

      assert %{"errors" => %{"cep" => ["should be 8 character(s)"]}} == response
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
