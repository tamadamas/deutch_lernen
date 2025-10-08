defmodule DeutchLernen.LearningTest do
  use ExUnit.Case, async: true

  alias DeutchLernen.Learning

  describe "Learning domain" do
    test "is an Ash domain" do
      assert Learning.domain?()
    end

    test "has resources list" do
      resources = Ash.Domain.Info.resources(Learning)
      assert is_list(resources)
    end
  end
end
