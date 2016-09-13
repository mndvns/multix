import Multix

defmulti Foo do
  def test(value)
end

defdispatch Foo, value when value == 1 do
  def test(_value) do
    :ITS_ONE!
  end
end

defdispatch Foo, %{type: :foo} do
  def test(%{value: value}) do
    value
  end
end

defmodule Test.Multix do
  use ExUnit.Case

  test "multi dispatch" do
    assert Foo.test(%{type: :foo, value: 123}) == 123
    assert Foo.test(1) == :ITS_ONE!
    assert Foo.test(:test) == :ITS_A_TEST
  end
end
