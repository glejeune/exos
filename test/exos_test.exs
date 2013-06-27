Code.require_file "test_helper.exs", __DIR__

defmodule ExOSTest do
  use ExUnit.Case

  test "os family is not empty" do
    assert(ExOS.family() != "")
  end

  test "os name is not empty" do
    assert(ExOS.name() != "")
  end

  test "os version is not empty" do
    assert(ExOS.version() != "")
  end

  test "username is not empty" do
    assert(ExOS.username() != "")
  end

  test "UID is not empty" do
    assert(ExOS.uid > -1)
  end

  test "group is not empty" do
    assert(ExOS.group() != "")
  end

  test "GID is not empty" do
    assert(ExOS.gid > -1)
  end

  test "groups must be identicals" do
    assert(ExOS.group == ExOS.group(ExOS.gid))
  end

  test "usernames must be identicals" do
    assert(ExOS.username == ExOS.username(ExOS.uid))
  end

  test "home is not empty" do
    assert(ExOS.home != "")
  end
end
