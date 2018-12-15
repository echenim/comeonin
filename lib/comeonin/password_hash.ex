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

  @doc """
  Runs the password hash function, but always returns false.

  This is to help prevent user enumeration.
  """
  @callback no_user_verify(keyword) :: false

  @doc """
  Prints out a report to help you configure the hash function.
  """
  @callback report(keyword) :: String.t()
end
