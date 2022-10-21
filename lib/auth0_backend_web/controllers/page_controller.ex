defmodule Auth0BackendWeb.PageController do
  use Auth0BackendWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
