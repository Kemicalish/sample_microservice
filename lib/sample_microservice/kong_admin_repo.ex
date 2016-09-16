defmodule SampleMicroservice.KongAdminRepo do
  use Dayron.Repo, otp_app: :sample_microservice

  defp fetch_in_row(row, key, value) do
    case Map.fetch(row, key) do
      {:ok, ^value} -> true 
      {:ok, _} -> false 
    end
  end

  def get_by(model, key, value) do
    with results = all(model), 
    res <- Enum.find(results, fn(x) -> fetch_in_row(x, key, value) end) do res
    else 
      _ -> 
        nil
    end
  end
end

