defmodule WolWeb.PageController do
  use WolWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
