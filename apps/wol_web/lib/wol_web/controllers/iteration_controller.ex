defmodule WolWeb.IterationController do
  use WolWeb, :controller

  alias Wol.Organization
  alias Wol.Organization.Iteration

  def index(conn, _params) do
    iterations = Organization.list_iterations()
    render(conn, "index.html", iterations: iterations)
  end

  def new(conn, _params) do
    changeset = Organization.change_iteration(%Iteration{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"iteration" => iteration_params}) do
    case Organization.create_iteration(iteration_params) do
      {:ok, iteration} ->
        conn
        |> put_flash(:info, "Iteration created successfully.")
        |> redirect(to: iteration_path(conn, :show, iteration))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    iteration = Organization.get_iteration!(id)
    render(conn, "show.html", iteration: iteration)
  end

  def edit(conn, %{"id" => id}) do
    iteration = Organization.get_iteration!(id)
    changeset = Organization.change_iteration(iteration)
    render(conn, "edit.html", iteration: iteration, changeset: changeset)
  end

  def update(conn, %{"id" => id, "iteration" => iteration_params}) do
    iteration = Organization.get_iteration!(id)

    case Organization.update_iteration(iteration, iteration_params) do
      {:ok, iteration} ->
        conn
        |> put_flash(:info, "Iteration updated successfully.")
        |> redirect(to: iteration_path(conn, :show, iteration))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", iteration: iteration, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    iteration = Organization.get_iteration!(id)
    {:ok, _iteration} = Organization.delete_iteration(iteration)

    conn
    |> put_flash(:info, "Iteration deleted successfully.")
    |> redirect(to: iteration_path(conn, :index))
  end
end
