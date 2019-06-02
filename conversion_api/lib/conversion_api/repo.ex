defmodule ConversionApi.Repo do
  use Ecto.Repo,
    otp_app: :conversion_api,
    adapter: Ecto.Adapters.Postgres
end
