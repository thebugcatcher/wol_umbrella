defmodule WolWeb.IterationControllerTest do
  use WolWeb.ConnCase

  alias Wol.Organization

  @create_attrs %{end_date: ~D[2010-04-17]}
  @update_attrs %{end_date: ~D[2011-05-18]}
  @invalid_attrs %{end_date: nil}

  def fixture(:iteration) do
    {:ok, iteration} = Organization.create_iteration(@create_attrs)
    iteration
  end

  describe "index" do
    test "lists all iterations", %{conn: conn} do
      conn = get conn, iteration_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Iterations"
    end
  end

  describe "new iteration" do
    test "renders form", %{conn: conn} do
      conn = get conn, iteration_path(conn, :new)
      assert html_response(conn, 200) =~ "New Iteration"
    end
  end

  describe "create iteration" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, iteration_path(conn, :create), iteration: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == iteration_path(conn, :show, id)

      conn = get conn, iteration_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Iteration"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, iteration_path(conn, :create), iteration: @invalid_attrs
      assert html_response(conn, 200) =~ "New Iteration"
    end
  end

  describe "edit iteration" do
    setup [:create_iteration]

    test "renders form for editing chosen iteration", %{conn: conn, iteration: iteration} do
      conn = get conn, iteration_path(conn, :edit, iteration)
      assert html_response(conn, 200) =~ "Edit Iteration"
    end
  end

  describe "update iteration" do
    setup [:create_iteration]

    test "redirects when data is valid", %{conn: conn, iteration: iteration} do
      conn = put conn, iteration_path(conn, :update, iteration), iteration: @update_attrs
      assert redirected_to(conn) == iteration_path(conn, :show, iteration)

      conn = get conn, iteration_path(conn, :show, iteration)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, iteration: iteration} do
      conn = put conn, iteration_path(conn, :update, iteration), iteration: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Iteration"
    end
  end

  describe "delete iteration" do
    setup [:create_iteration]

    test "deletes chosen iteration", %{conn: conn, iteration: iteration} do
      conn = delete conn, iteration_path(conn, :delete, iteration)
      assert redirected_to(conn) == iteration_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, iteration_path(conn, :show, iteration)
      end
    end
  end

  defp create_iteration(_) do
    iteration = fixture(:iteration)
    {:ok, iteration: iteration}
  end
end
