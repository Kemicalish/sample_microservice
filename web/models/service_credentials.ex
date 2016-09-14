defmodule SampleMicroservice.ServiceCredentials do
  use Ecto.Schema
  use Dayron.Model

  def __from_json_list__(%{data: data}, opts) do
    Enum.map(data, &__from_json__(&1, opts))
  end

  def __from_json__(data = %{id: id}, _opts) do
    struct(__MODULE__, data)
  end

  def __from_json__(data = %{"id" => _id}, opts) do
    new_data = for {key, val} <- data, into: %{}, do: {String.to_atom(key), val}
    __from_json__(new_data, opts)
  end

  schema "consumers/admin/oauth2" do
    field :client_id, :string
    field :client_secret, :string
    field :name, :string
    field :created_at, :integer
    field :consumer_id, :string
  end
end

