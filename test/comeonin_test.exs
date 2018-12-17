defmodule ComeoninTest do
  use ExUnit.Case

  alias Comeonin.TestHash

  test "add_hash with default arguments" do
    assert %{password_hash: hash, password: nil} = TestHash.add_hash("password")
    assert TestHash.verify_pass("password", hash)
  end

  test "add_hash with custom hash_key" do
    assert %{encrypted_password: hash, password: nil} = TestHash.add_hash("password", hash_key: :encrypted_password)
    assert TestHash.verify_pass("password", hash)
  end

  test "check_pass with default arguments" do
    user = %{password_hash: TestHash.hash_pwd_salt("password")}
    assert {:ok, user_1} = TestHash.check_pass(user, "password")
    assert user_1 == user
    assert {:error, message} = TestHash.check_pass(nil, "password")
    assert message =~ "invalid user-identifier"
    user = %{password_hash: TestHash.hash_pwd_salt("password1")}
    assert {:error, message} = TestHash.check_pass(user, "password")
    assert message =~ "invalid password"
  end

  test "check_pass with custom hash_key" do
    user = %{encrypted_password: TestHash.hash_pwd_salt("password")}
    assert {:ok, user_1} = TestHash.check_pass(user, "password")
    assert user_1 == user
    user = %{arrr: TestHash.hash_pwd_salt("password")}
    assert {:ok, user_1} = TestHash.check_pass(user, "password", hash_key: :arrr)
    assert user_1 == user
    user = %{arrrggghh: TestHash.hash_pwd_salt("password")}
    assert {:error, message} = TestHash.check_pass(user, "password")
    assert message =~ "no password hash found in the user struct"
  end
end
