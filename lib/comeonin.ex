defmodule Comeonin do
  @moduledoc """
  Comeonin is a password hashing library that aims to be secure,
  easy to use and well-documented.

  ## Further information

  Visit our [wiki](https://github.com/riverrun/comeonin/wiki)
  for links to further information about these and related issues.
  """

  @doc """
  Hashes a password and return the password hash in a map, with the
  password set to nil.
  """
  @callback add_hash(binary, keyword) :: map

  @doc """
  Checks the password by comparing its hash with the password hash found
  in a user struct, or map.
  """
  @callback check_pass(map, binary, keyword) :: {:ok, map} | {:error, String.t()}

  @doc """
  Runs the password hash function, but always returns false.

  This is to help prevent user enumeration.
  """
  @callback no_user_verify(keyword) :: false

  defmacro __using__(_) do
    quote do
      @behaviour Comeonin
      @behaviour Comeonin.PasswordHash

      @impl Comeonin
      def add_hash(password, opts \\ []) do
        hash_key = opts[:hash_key] || :password_hash
        %{hash_key => hash_pwd_salt(password, opts), :password => nil}
      end

      @impl Comeonin
      def check_pass(user, password, opts \\ [])

      def check_pass(nil, _password, opts) do
        unless opts[:hide_user] == false, do: no_user_verify(opts)
        {:error, "invalid user-identifier"}
      end

      def check_pass(user, password, opts) when is_binary(password) do
        case get_hash(user, opts[:hash_key]) do
          {:ok, hash} ->
            (verify_pass(password, hash) and {:ok, user}) || {:error, "invalid password"}

          _ ->
            {:error, "no password hash found in the user struct"}
        end
      end

      def check_pass(_, _, _) do
        {:error, "password is not a string"}
      end

      defp get_hash(%{password_hash: hash}, _), do: {:ok, hash}
      defp get_hash(%{encrypted_password: hash}, _), do: {:ok, hash}
      defp get_hash(_, nil), do: nil
      defp get_hash(user, hash_key), do: if(hash = Map.get(user, hash_key), do: {:ok, hash})

      @impl Comeonin
      def no_user_verify(opts \\ []) do
        hash_pwd_salt("password", opts)
        false
      end

      defoverridable Comeonin
    end
  end
end
