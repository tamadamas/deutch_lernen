defmodule DeutchLernen.ContentTest do
  use ExUnit.Case, async: true

  alias DeutchLernen.Content

  describe "Content domain" do
    test "is an Ash domain" do
      assert Content.__ash_domain__?()
    end

    test "can retrieve domain info" do
      info = Ash.Domain.Info.domain(Content)
      assert info
    end
  end
end
