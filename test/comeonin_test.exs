defmodule ComeoninTest do
  use ExUnit.Case

  alias Comeonin.TestHash

  test "add_hash with default arguments" do
    assert %{password_hash: "password", password: nil} = TestHash.add_hash("password")
  end

  test "add_hash with custom hash_key" do
    assert %{encrypted_password: "password", password: nil} =
             TestHash.add_hash("password", hash_key: :encrypted_password)
  end

  test "check_pass with default arguments" do
    user = %{password_hash: "password"}
    assert {:ok, user_1} = TestHash.check_pass(user, "password")
    assert user_1 == user
    assert {:error, message} = TestHash.check_pass(nil, "password")
    assert message =~ "invalid user-identifier"
    user = %{password_hash: "password1"}
    assert {:error, message} = TestHash.check_pass(user, "password")
    assert message =~ "invalid password"
  end

  test "check_pass with custom hash_key" do
    user = %{encrypted_password: "password"}
    assert {:ok, user_1} = TestHash.check_pass(user, "password")
    assert user_1 == user
    user = %{arrr: "password"}
    assert {:ok, user_1} = TestHash.check_pass(user, "password", hash_key: :arrr)
    assert user_1 == user
    user = %{arrrggghh: "password"}
    assert {:error, message} = TestHash.check_pass(user, "password")
    assert message =~ "no password hash found in the user struct"
  end
end
