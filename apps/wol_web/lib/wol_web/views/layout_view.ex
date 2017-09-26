defmodule WolWeb.LayoutView do
  use WolWeb, :view

    def active_class_for_nav_tab(conn, path_base) do
    path_info = conn.path_info
    current_path_base = fn
                          [] -> false
                          [h | _t] -> path_base == h
                        end

    if current_path_base.(path_info) do
      "active"
    else
      nil
    end
  end
end
