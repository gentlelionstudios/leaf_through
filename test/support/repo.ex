defmodule Test.Repo do
  use Ecto.Repo, otp_app: :leaf_through
end

defmodule Test.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :first_name
    field :last_name
    field :username
    field :email_address
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:first_name, :last_name, :username, :email_address])
  end
end
