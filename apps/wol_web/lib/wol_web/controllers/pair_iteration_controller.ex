defmodule WolWeb.PairIterationController do
  use WolWeb, :controller

  alias Wol.Organization
  alias Wol.Organization.PairIteration

  def index(conn, _params) do
    pair_iterations = Organization.list_pair_iterations()
    render(conn, "index.html", pair_iterations: pair_iterations)
  end

  def new(conn, _params) do
    changeset = Organization.change_pair_iteration(%PairIteration{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pair_iteration" => pair_iteration_params}) do
    case Organization.create_pair_iteration(pair_iteration_params) do
      {:ok, pair_iteration} ->
        conn
        |> put_flash(:info, "Pair iteration created successfully.")
        |> redirect(to: pair_iteration_path(conn, :show, pair_iteration))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pair_iteration = Organization.get_pair_iteration!(id)
    render(conn, "show.html", pair_iteration: pair_iteration)
  end

  def edit(conn, %{"id" => id}) do
    pair_iteration = Organization.get_pair_iteration!(id)
    changeset = Organization.change_pair_iteration(pair_iteration)
    render(conn, "edit.html", pair_iteration: pair_iteration, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pair_iteration" => pair_iteration_params}) do
    pair_iteration = Organization.get_pair_iteration!(id)

    case Organization.update_pair_iteration(pair_iteration, pair_iteration_params) do
      {:ok, pair_iteration} ->
        conn
        |> put_flash(:info, "Pair iteration updated successfully.")
        |> redirect(to: pair_iteration_path(conn, :show, pair_iteration))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pair_iteration: pair_iteration, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pair_iteration = Organization.get_pair_iteration!(id)
    {:ok, _pair_iteration} = Organization.delete_pair_iteration(pair_iteration)

    conn
    |> put_flash(:info, "Pair iteration deleted successfully.")
    |> redirect(to: pair_iteration_path(conn, :index))
  end
end
