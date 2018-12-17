ExUnit.start()

defmodule Comeonin.TestHash do
  use Comeonin

  @impl true
  def hash_pwd_salt(password, _opts \\ []) do
    password
  end

  @impl true
  def verify_pass(password, hash) do
    password == hash
  end
end
