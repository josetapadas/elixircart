defmodule Natureba.Repo do
  use Ecto.Repo,
    otp_app: :natureba,
    adapter: Ecto.Adapters.Postgres
end
