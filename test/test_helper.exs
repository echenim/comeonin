ExUnit.start()

defmodule Comeonin.TestHash do
  use Comeonin

  @impl true
  def hash_pwd_salt(password, _opts) do
    password
  end

  @impl true
  def verify_pass(password, hash) do
    password == hash
  end

  @impl true
  def no_user_verify(opts) do
    opts
  end

  @impl true
  def report(opts) do
    opts
  end
end
