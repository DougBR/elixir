defmodule BananaBank.ViaCep.ClientBehaviour do
  @callback call(cep :: String.t()) :: {:ok, map()} | {:error, :atom}
end
