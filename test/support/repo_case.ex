defmodule Test.RepoCase do
  use ExUnit.CaseTemplate

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Test.Repo)
  end
end
