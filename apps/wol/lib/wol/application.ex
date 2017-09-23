defmodule Wol.Application do
  @moduledoc """
  The Wol Application Service.

  The wol system business domain lives in this application.

  Exposes API to clients such as the `WolWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Wol.Repo, []),
    ], strategy: :one_for_one, name: Wol.Supervisor)
  end
end
