defmodule NvivoOrgs.Repo do
  use Ecto.Repo,
    otp_app: :nvivo_orgs,
    adapter: Ecto.Adapters.Postgres
end
