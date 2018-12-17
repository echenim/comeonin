defmodule Comeonin.PasswordHash do
  @moduledoc """
  Password hashing behaviour.
  """

  @doc """
  Generates a random salt and hashes a password.
  """
  @callback hash_pwd_salt(binary, keyword) :: binary

  @doc """
  Checks the password by comparing it with a stored hash.
  """
  @callback verify_pass(binary, binary) :: boolean
end
