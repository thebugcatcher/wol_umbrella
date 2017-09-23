defmodule WolWeb.PageController do
  use WolWeb, :controller

  alias Wol.Organization

  def index(conn, _params) do
    people = Organization.list_people()

    render conn,
      "index.html",
      spin1_people: people,
      spin2_people: []
  end

  def about(conn, _params) do
    render conn, "about.html"
  end

  def spin1(conn, _params) do
    people = Organization.list_people()

    render conn,
      "index.html",
      spin1_people: :done,
      spin2_people: people
  end

  def spin2(conn, _params) do

  end
end
