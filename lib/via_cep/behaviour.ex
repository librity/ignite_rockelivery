defmodule ViaCEP.Behaviour do
  alias Rockelivery.Error

  @typep get_cep_info_return :: {:ok, map()} | {:error, Error.t()}
  @callback get_cep_info(String.t()) :: get_cep_info_return
end
