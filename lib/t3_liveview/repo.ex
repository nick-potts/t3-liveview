defmodule T3Liveview.Repo do
  use Ecto.Repo,
    otp_app: :t3_liveview,
    adapter: Ecto.Adapters.Postgres
end
