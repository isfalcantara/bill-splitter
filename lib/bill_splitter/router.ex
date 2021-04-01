defmodule BillSplitter.Router do
  @moduledoc """
  This module defines the router and web interface for the BillSplitter
  Application.
  """

  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "The result will be here")
  end

  match _ do
    send_resp(conn, 404, "Oops! This is not the right place to be!")
  end
end
