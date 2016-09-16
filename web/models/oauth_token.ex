defmodule SampleMicroservice.OauthToken do
  def __from_json_list__(%{data: data}, opts) do
    Enum.map(data, &__from_json__(&1, opts))
  end

  use Ecto.Schema
  use Dayron.Model
  
  schema "oauth2/token" do
    field :secret,          :string 
    field :refresh_token,   :string
    field :access_token,    :string
    field :token_type,      :string
    field :credential_id,   :string
  end
end

