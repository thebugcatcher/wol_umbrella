defmodule WolWeb.PairIterationControllerTest do
  use WolWeb.ConnCase

  alias Wol.Organization

  @create_attrs %{iteration_id: 42, person1_id: 42, person2_id: 42}
  @update_attrs %{iteration_id: 43, person1_id: 43, person2_id: 43}
  @invalid_attrs %{iteration_id: nil, person1_id: nil, person2_id: nil}

  def fixture(:pair_iteration) do
    {:ok, pair_iteration} = Organization.create_pair_iteration(@create_attrs)
    pair_iteration
  end

  describe "index" do
    test "lists all pair_iterations", %{conn: conn} do
      conn = get conn, pair_iteration_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Pair iterations"
    end
  end

  describe "new pair_iteration" do
    test "renders form", %{conn: conn} do
      conn = get conn, pair_iteration_path(conn, :new)
      assert html_response(conn, 200) =~ "New Pair iteration"
    end
  end

  describe "create pair_iteration" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, pair_iteration_path(conn, :create), pair_iteration: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == pair_iteration_path(conn, :show, id)

      conn = get conn, pair_iteration_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Pair iteration"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, pair_iteration_path(conn, :create), pair_iteration: @invalid_attrs
      assert html_response(conn, 200) =~ "New Pair iteration"
    end
  end

  describe "edit pair_iteration" do
    setup [:create_pair_iteration]

    test "renders form for editing chosen pair_iteration", %{conn: conn, pair_iteration: pair_iteration} do
      conn = get conn, pair_iteration_path(conn, :edit, pair_iteration)
      assert html_response(conn, 200) =~ "Edit Pair iteration"
    end
  end

  describe "update pair_iteration" do
    setup [:create_pair_iteration]

    test "redirects when data is valid", %{conn: conn, pair_iteration: pair_iteration} do
      conn = put conn, pair_iteration_path(conn, :update, pair_iteration), pair_iteration: @update_attrs
      assert redirected_to(conn) == pair_iteration_path(conn, :show, pair_iteration)

      conn = get conn, pair_iteration_path(conn, :show, pair_iteration)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, pair_iteration: pair_iteration} do
      conn = put conn, pair_iteration_path(conn, :update, pair_iteration), pair_iteration: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Pair iteration"
    end
  end

  describe "delete pair_iteration" do
    setup [:create_pair_iteration]

    test "deletes chosen pair_iteration", %{conn: conn, pair_iteration: pair_iteration} do
      conn = delete conn, pair_iteration_path(conn, :delete, pair_iteration)
      assert redirected_to(conn) == pair_iteration_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, pair_iteration_path(conn, :show, pair_iteration)
      end
    end
  end

  defp create_pair_iteration(_) do
    pair_iteration = fixture(:pair_iteration)
    {:ok, pair_iteration: pair_iteration}
  end
end
