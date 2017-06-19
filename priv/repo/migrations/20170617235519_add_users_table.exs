defmodule Test.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name,    :string
      add :last_name,     :string
      add :username,      :string
      add :email_address, :string
    end
  end
end
