defmodule DeutchLernen.VocabularyTest do
  use ExUnit.Case, async: true

  alias DeutchLernen.Vocabulary

  describe "Vocabulary domain" do
    test "is an Ash domain" do
      assert Vocabulary.domain?()
    end

    test "has resources list" do
      resources = Ash.Domain.Info.resources(Vocabulary)
      assert is_list(resources)
    end
  end
end
