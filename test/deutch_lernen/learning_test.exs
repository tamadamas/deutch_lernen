defmodule DeutchLernen.LearningTest do
  use ExUnit.Case, async: true

  alias DeutchLernen.Learning

  describe "Learning domain" do
    test "is an Ash domain" do
      assert Learning.__ash_domain__?()
    end

    test "can retrieve domain info" do
      info = Ash.Domain.Info.domain(Learning)
      assert info
    end
  end
end
