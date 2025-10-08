defmodule DeutchLernen.Content.SentenceTest do
  use DeutchLernenWeb.ConnCase, async: true

  alias DeutchLernen.Content.Content
  alias DeutchLernen.Content.Sentence

  describe "Sentence resource CRUD" do
    setup do
      {:ok, content} =
        Content.create(%{
          title: "Test Book",
          content_type: :book,
          difficulty_level: :b1
        })

      %{content: content}
    end

    test "creates sentence with valid data", %{content: content} do
      assert {:ok, sentence} =
               Sentence.create(%{
                 text: "Das ist ein deutscher Satz.",
                 position: 1,
                 content_id: content.id,
                 translation: "This is a German sentence.",
                 grammar_notes: "Simple present tense"
               })

      assert sentence.text == "Das ist ein deutscher Satz."
      assert sentence.position == 1
      assert sentence.content_id == content.id
      assert sentence.translation == "This is a German sentence."
      assert sentence.grammar_notes == "Simple present tense"
      assert sentence.inserted_at
      assert sentence.updated_at
    end

    test "creates sentence with minimal data", %{content: content} do
      assert {:ok, sentence} =
               Sentence.create(%{
                 text: "Guten Tag!",
                 position: 1,
                 content_id: content.id
               })

      assert sentence.text == "Guten Tag!"
      assert sentence.position == 1
      assert is_nil(sentence.translation)
      assert is_nil(sentence.grammar_notes)
    end

    test "fails to create sentence without text", %{content: content} do
      assert {:error, %Ash.Error.Invalid{}} =
               Sentence.create(%{
                 position: 1,
                 content_id: content.id
               })
    end

    test "fails to create sentence without position", %{content: content} do
      assert {:error, %Ash.Error.Invalid{}} =
               Sentence.create(%{
                 text: "Test",
                 content_id: content.id
               })
    end

    test "fails to create sentence without content_id" do
      assert {:error, %Ash.Error.Invalid{}} =
               Sentence.create(%{
                 text: "Test",
                 position: 1
               })
    end

    test "fails to create sentence with invalid position (zero)", %{content: content} do
      assert {:error, %Ash.Error.Invalid{}} =
               Sentence.create(%{
                 text: "Test",
                 position: 0,
                 content_id: content.id
               })
    end

    test "fails to create sentence with invalid position (negative)", %{content: content} do
      assert {:error, %Ash.Error.Invalid{}} =
               Sentence.create(%{
                 text: "Test",
                 position: -1,
                 content_id: content.id
               })
    end

    test "reads all sentences" do
      {:ok, content} = Content.create(%{title: "Test"})
      Sentence.create(%{text: "Sentence 1", position: 1, content_id: content.id})
      Sentence.create(%{text: "Sentence 2", position: 2, content_id: content.id})

      sentences = Sentence.read!()
      assert length(sentences) >= 2
    end

    test "updates sentence", %{content: content} do
      {:ok, sentence} =
        Sentence.create(%{
          text: "Original text",
          position: 1,
          content_id: content.id
        })

      {:ok, updated} =
        Sentence.update(sentence, %{
          text: "Updated text",
          translation: "Updated translation"
        })

      assert updated.text == "Updated text"
      assert updated.translation == "Updated translation"
    end

    test "destroys sentence", %{content: content} do
      {:ok, sentence} =
        Sentence.create(%{
          text: "To delete",
          position: 1,
          content_id: content.id
        })

      assert :ok = Sentence.destroy(sentence)
    end
  end

  describe "Sentence ordering" do
    setup do
      {:ok, content} = Content.create(%{title: "Ordered Book"})

      Sentence.create(%{text: "Third sentence", position: 3, content_id: content.id})
      Sentence.create(%{text: "First sentence", position: 1, content_id: content.id})
      Sentence.create(%{text: "Second sentence", position: 2, content_id: content.id})

      %{content: content}
    end

    test "orders sentences by position", %{content: content} do
      sentences = Sentence.by_content_ordered!(content.id)

      assert length(sentences) == 3
      assert Enum.at(sentences, 0).text == "First sentence"
      assert Enum.at(sentences, 1).text == "Second sentence"
      assert Enum.at(sentences, 2).text == "Third sentence"
    end
  end

  describe "Content relationship" do
    test "loads content relationship" do
      {:ok, content} = Content.create(%{title: "Relationship Test"})

      {:ok, sentence} =
        Sentence.create(%{
          text: "Test sentence",
          position: 1,
          content_id: content.id
        })

      loaded = Ash.load!(sentence, :content)
      assert loaded.content.id == content.id
      assert loaded.content.title == "Relationship Test"
    end

    test "content has sentences relationship" do
      {:ok, content} = Content.create(%{title: "With Sentences"})

      Sentence.create(%{text: "Sentence 1", position: 1, content_id: content.id})
      Sentence.create(%{text: "Sentence 2", position: 2, content_id: content.id})

      loaded = Ash.load!(content, :sentences)
      assert length(loaded.sentences) == 2
    end

    test "handles duplicate positions in same content", %{} do
      {:ok, content} = Content.create(%{title: "Duplicate Position Test"})

      {:ok, _s1} = Sentence.create(%{text: "First", position: 1, content_id: content.id})
      # This should succeed - Ash doesn't enforce unique positions by default
      {:ok, _s2} = Sentence.create(%{text: "Second", position: 1, content_id: content.id})

      sentences = Sentence.by_content_ordered!(content.id)
      assert length(sentences) == 2
    end

    test "sentences from different contents are isolated" do
      {:ok, content1} = Content.create(%{title: "Content 1"})
      {:ok, content2} = Content.create(%{title: "Content 2"})

      Sentence.create(%{text: "Content 1 Sentence", position: 1, content_id: content1.id})
      Sentence.create(%{text: "Content 2 Sentence", position: 1, content_id: content2.id})

      content1_sentences = Sentence.by_content_ordered!(content1.id)
      content2_sentences = Sentence.by_content_ordered!(content2.id)

      assert length(content1_sentences) == 1
      assert length(content2_sentences) == 1
      assert hd(content1_sentences).text == "Content 1 Sentence"
      assert hd(content2_sentences).text == "Content 2 Sentence"
    end
  end
end
