defmodule DeutchLernen.Vocabulary.WordTest do
  use DeutchLernenWeb.ConnCase, async: true

  alias DeutchLernen.Vocabulary.Word

  describe "Word resource CRUD" do
    test "creates word with full noun data" do
      assert {:ok, word} =
               Word.create(%{
                 lemma: "Haus",
                 article: :das,
                 word_type: :nomen,
                 gender: :neutrum,
                 plural_form: "Häuser",
                 level: :a1
               })

      assert word.lemma == "Haus"
      assert word.article == :das
      assert word.word_type == :nomen
      assert word.gender == :neutrum
      assert word.plural_form == "Häuser"
      assert word.level == :a1
    end

    test "creates strong verb" do
      assert {:ok, word} =
               Word.create(%{
                 lemma: "gehen",
                 word_type: :verb,
                 verb_type: :stark,
                 level: :a1
               })

      assert word.lemma == "gehen"
      assert word.word_type == :verb
      assert word.verb_type == :stark
    end

    test "creates separable verb" do
      assert {:ok, word} =
               Word.create(%{
                 lemma: "aufstehen",
                 word_type: :trennbares_verb,
                 separable_prefix: "auf",
                 verb_type: :stark,
                 level: :a2
               })

      assert word.lemma == "aufstehen"
      assert word.word_type == :trennbares_verb
      assert word.separable_prefix == "auf"
    end

    test "creates adjective" do
      assert {:ok, word} =
               Word.create(%{
                 lemma: "schön",
                 word_type: :adjektiv,
                 level: :a1
               })

      assert word.lemma == "schön"
      assert word.word_type == :adjektiv
    end

    test "creates word with minimal data" do
      assert {:ok, word} = Word.create(%{lemma: "Test"})
      assert word.lemma == "Test"
      assert word.word_type == :nomen
      assert word.level == :b1
    end

    test "fails without lemma" do
      assert {:error, %Ash.Error.Invalid{}} = Word.create(%{word_type: :nomen})
    end

    test "enforces unique lemma" do
      {:ok, _} = Word.create(%{lemma: "einzigartig"})
      assert {:error, %Ash.Error.Invalid{}} = Word.create(%{lemma: "einzigartig"})
    end

    test "validates article" do
      assert {:error, %Ash.Error.Invalid{}} =
               Word.create(%{lemma: "Test", article: :invalid})
    end

    test "validates word_type" do
      assert {:error, %Ash.Error.Invalid{}} =
               Word.create(%{lemma: "Test", word_type: :invalid})
    end

    test "validates gender" do
      assert {:error, %Ash.Error.Invalid{}} =
               Word.create(%{lemma: "Test", gender: :invalid})
    end

    test "validates verb_type" do
      assert {:error, %Ash.Error.Invalid{}} =
               Word.create(%{lemma: "Test", verb_type: :invalid})
    end

    test "validates level" do
      assert {:error, %Ash.Error.Invalid{}} =
               Word.create(%{lemma: "Test", level: :invalid})
    end

    test "updates word" do
      {:ok, word} = Word.create(%{lemma: "alt"})
      {:ok, updated} = Word.update(word, %{level: :a2, plural_form: "alte"})
      assert updated.level == :a2
      assert updated.plural_form == "alte"
    end

    test "destroys word" do
      {:ok, word} = Word.create(%{lemma: "löschen"})
      assert :ok = Word.destroy(word)
    end
  end

  describe "German articles" do
    test "accepts der (masculine)" do
      {:ok, word} = Word.create(%{lemma: "Mann", article: :der, gender: :maskulin})
      assert word.article == :der
    end

    test "accepts die (feminine)" do
      {:ok, word} = Word.create(%{lemma: "Frau", article: :die, gender: :feminin})
      assert word.article == :die
    end

    test "accepts das (neuter)" do
      {:ok, word} = Word.create(%{lemma: "Kind", article: :das, gender: :neutrum})
      assert word.article == :das
    end
  end

  describe "German word types" do
    test "supports all word types" do
      types = [
        :nomen,
        :verb,
        :adjektiv,
        :adverb,
        :präposition,
        :konjunktion,
        :pronomen,
        :trennbares_verb
      ]

      for type <- types do
        {:ok, word} = Word.create(%{lemma: "test_#{type}", word_type: type})
        assert word.word_type == type
      end
    end
  end

  describe "German genders" do
    test "supports all genders" do
      {:ok, m} = Word.create(%{lemma: "Test1", gender: :maskulin})
      {:ok, f} = Word.create(%{lemma: "Test2", gender: :feminin})
      {:ok, n} = Word.create(%{lemma: "Test3", gender: :neutrum})

      assert m.gender == :maskulin
      assert f.gender == :feminin
      assert n.gender == :neutrum
    end
  end

  describe "German verb types" do
    test "supports all verb types" do
      types = [:schwach, :stark, :gemischt, :modal, :unregelmäßig]

      for type <- types do
        {:ok, word} = Word.create(%{lemma: "verb_#{type}", word_type: :verb, verb_type: type})
        assert word.verb_type == type
      end
    end
  end

  describe "CEFR levels" do
    test "supports all CEFR levels" do
      levels = [:a1, :a2, :b1, :b2, :c1, :c2]

      for level <- levels do
        {:ok, word} = Word.create(%{lemma: "level_#{level}", level: level})
        assert word.level == level
      end
    end
  end

  describe "Search and filtering" do
    setup do
      Word.create(%{lemma: "Haus", word_type: :nomen, level: :a1})
      Word.create(%{lemma: "Hausaufgabe", word_type: :nomen, level: :a2})
      Word.create(%{lemma: "gehen", word_type: :verb, level: :a1})
      Word.create(%{lemma: "schön", word_type: :adjektiv, level: :b1})
      :ok
    end

    test "searches by lemma (partial match)" do
      results = Word.search_by_lemma!("Haus")
      assert length(results) >= 2
      assert Enum.all?(results, &String.contains?(&1.lemma, "Haus"))
    end

    test "filters by word type" do
      nouns = Word.by_type!(:nomen)
      assert length(nouns) >= 2
      assert Enum.all?(nouns, &(&1.word_type == :nomen))

      verbs = Word.by_type!(:verb)
      assert length(verbs) >= 1
      assert Enum.all?(verbs, &(&1.word_type == :verb))
    end

    test "filters by level" do
      a1_words = Word.by_level!(:a1)
      assert length(a1_words) >= 2
      assert Enum.all?(a1_words, &(&1.level == :a1))

      b1_words = Word.by_level!(:b1)
      assert length(b1_words) >= 1
      assert Enum.all?(b1_words, &(&1.level == :b1))
    end
  end
end
