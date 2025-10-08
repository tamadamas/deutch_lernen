defmodule DeutchLernen.ContentTest do
  use ExUnit.Case, async: true

  alias DeutchLernen.Content

  describe "Content domain" do
    test "is an Ash domain" do
      assert Content.domain?()
    end

    test "has resources list" do
      resources = Ash.Domain.Info.resources(Content)
      assert is_list(resources)
    end
  end
end
