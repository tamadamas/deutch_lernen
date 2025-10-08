defmodule DeutchLernen.VocabularyTest do
  use ExUnit.Case, async: true

  alias DeutchLernen.Vocabulary

  describe "Vocabulary domain" do
    test "is an Ash domain" do
      assert Vocabulary.__ash_domain__?()
    end

    test "can retrieve domain info" do
      info = Ash.Domain.Info.domain(Vocabulary)
      assert info
    end
  end
end
