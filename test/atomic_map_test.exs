defmodule AtomicMapTest do
  use ExUnit.Case
  doctest AtomicMap

  test "works with maps" do
    input    = %{"a" => 2, "b" => %{"c" => 4}}
    expected = %{a: 2, b: %{c: 4}}
    assert AtomicMap.convert(input, safe: true) == expected
  end

  test "works with maps with lists" do
    input    = %{ "a" => [ %{"c" => 1}, %{"c" => 2}] }
    expected = %{a: [%{c: 1}, %{c: 2}] }
    assert AtomicMap.convert(input, safe: true) == expected
  end

  test "works with lists with maps" do
    input    = [ %{"c" => 1}, %{"c" => 2}, %{"c" => %{"b" => 4}}]
    expected = [%{c: 1}, %{c: 2}, %{c: %{b: 4}}]
    assert AtomicMap.convert(input, safe: true) == expected
  end

  test "works with mixed keys (string / atoms)" do
    input    = [ %{"c" => 1}, %{:c => 2}, %{"c" => %{:b => 4}}]
    expected = [%{c: 1}, %{c: 2}, %{c: %{b: 4}}]
    assert AtomicMap.convert(input, safe: true) == expected
  end

  test "works with simple values" do
    input    = "2"
    expected = "2"
    assert AtomicMap.convert(input, safe: true) == expected
  end

  test "works with default opts" do
    input    = "2"
    expected = "2"
    assert AtomicMap.convert(input) == expected
  end

  test "raises for not existing atoms" do
    assert_raise ArgumentError, fn ->
      input = %{"a" => 2, "b" => %{"c" => 4}, "__not___existing__" => 5}
      AtomicMap.convert(input, safe: true)
    end
  end
end
