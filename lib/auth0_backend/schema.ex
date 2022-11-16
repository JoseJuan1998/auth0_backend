defmodule Auth0Backend.Schema do
  defmacro __using__ do
    quote do
      use Ecto.Schema

      import Ecto.Changeset

      alias Auth0Backend.Repo

      @timestamps_opts [type: :naive_datetime_usec]
      @type t :: %__MODULE__{}

      @primary_key {:id, Ecto.UUID, autogenerate: true}
    end
  end
end
