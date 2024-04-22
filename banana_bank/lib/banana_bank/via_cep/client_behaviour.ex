defmodule BananaBank.ViaCep.ClientBehaviour do
  @moduledoc false

  @callback call(cep :: String.t()) :: {:ok, map()} | {:error, :atom}
end
