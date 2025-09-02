defmodule NvivoOrgsWeb.Router do
  use NvivoOrgsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    forward "/", Absinthe.Plug, schema: NvivoOrgsWeb.Schema
  end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:nvivo_orgs, :dev_routes) do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
