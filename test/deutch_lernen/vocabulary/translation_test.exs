defmodule DeutchLernen.Vocabulary.TranslationTest do
  use DeutchLernenWeb.ConnCase, async: true

  alias DeutchLernen.Vocabulary.Word
  alias DeutchLernen.Vocabulary.Translation

  setup do
    {:ok, word} = Word.create(%{lemma: "Haus", word_type: :nomen})
    %{word: word}
  end

  test "creates English translation", %{word: word} do
    {:ok, translation} = Translation.create(%{text: "house", language: :en, word_id: word.id})
    assert translation.text == "house"
    assert translation.language == :en
  end

  test "creates Ukrainian translation", %{word: word} do
    {:ok, translation} = Translation.create(%{text: "дім", language: :uk, word_id: word.id})
    assert translation.text == "дім"
    assert translation.language == :uk
  end

  test "filters by word", %{word: word} do
    Translation.create(%{text: "house", language: :en, word_id: word.id})
    Translation.create(%{text: "дім", language: :uk, word_id: word.id})

    translations = Translation.by_word!(word.id)
    assert length(translations) == 2
  end

  test "validates language constraint", %{word: word} do
    assert {:error, %Ash.Error.Invalid{}} =
      Translation.create(%{text: "test", language: :de, word_id: word.id})
  end
end
