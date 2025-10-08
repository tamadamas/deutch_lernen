defmodule DeutchLernen.Content.ContentTest do
  use DeutchLernenWeb.ConnCase, async: true

  alias DeutchLernen.Content.Content, as: ContentResource

  describe "Content resource CRUD" do
    test "creates content with valid data" do
      assert {:ok, content} =
               ContentResource.create(%{
                 title: "Café in Berlin",
                 author: "André Klein",
                 content_type: :book,
                 difficulty_level: :b1,
                 description: "A German learning book for B1 level",
                 url: "https://example.com/cafe-in-berlin"
               })

      assert content.title == "Café in Berlin"
      assert content.author == "André Klein"
      assert content.content_type == :book
      assert content.difficulty_level == :b1
      assert content.description == "A German learning book for B1 level"
      assert content.url == "https://example.com/cafe-in-berlin"
      assert content.inserted_at
      assert content.updated_at
    end

    test "creates content with minimal data" do
      assert {:ok, content} =
               ContentResource.create(%{
                 title: "German Article"
               })

      assert content.title == "German Article"
      assert content.content_type == :article
      assert content.difficulty_level == :b1
      assert is_nil(content.author)
      assert is_nil(content.description)
      assert is_nil(content.url)
    end

    test "fails to create content without title" do
      assert {:error, %Ash.Error.Invalid{}} =
               ContentResource.create(%{
                 author: "Test Author"
               })
    end

    test "fails to create content with invalid content_type" do
      assert {:error, %Ash.Error.Invalid{}} =
               ContentResource.create(%{
                 title: "Test",
                 content_type: :invalid_type
               })
    end

    test "fails to create content with invalid difficulty_level" do
      assert {:error, %Ash.Error.Invalid{}} =
               ContentResource.create(%{
                 title: "Test",
                 difficulty_level: :invalid_level
               })
    end

    test "reads all content" do
      ContentResource.create(%{title: "Content 1"})
      ContentResource.create(%{title: "Content 2"})

      contents = ContentResource.read!()
      assert length(contents) >= 2
    end

    test "updates content" do
      {:ok, content} = ContentResource.create(%{title: "Original Title"})

      {:ok, updated} =
        ContentResource.update(content, %{
          title: "Updated Title",
          difficulty_level: :b2
        })

      assert updated.title == "Updated Title"
      assert updated.difficulty_level == :b2
    end

    test "destroys content" do
      {:ok, content} = ContentResource.create(%{title: "To Delete"})
      assert :ok = ContentResource.destroy(content)
    end
  end

  describe "Content filtering" do
    setup do
      ContentResource.create(%{
        title: "B1 Book",
        content_type: :book,
        difficulty_level: :b1
      })

      ContentResource.create(%{
        title: "B2 Article",
        content_type: :article,
        difficulty_level: :b2
      })

      ContentResource.create(%{
        title: "A2 Blog",
        content_type: :blog_post,
        difficulty_level: :a2
      })

      :ok
    end

    test "filters by difficulty level" do
      b1_contents = ContentResource.by_difficulty!(:b1)
      assert length(b1_contents) >= 1
      assert Enum.all?(b1_contents, &(&1.difficulty_level == :b1))

      b2_contents = ContentResource.by_difficulty!(:b2)
      assert length(b2_contents) >= 1
      assert Enum.all?(b2_contents, &(&1.difficulty_level == :b2))
    end

    test "filters by content type" do
      books = ContentResource.by_type!(:book)
      assert length(books) >= 1
      assert Enum.all?(books, &(&1.content_type == :book))

      articles = ContentResource.by_type!(:article)
      assert length(articles) >= 1
      assert Enum.all?(articles, &(&1.content_type == :article))

      blogs = ContentResource.by_type!(:blog_post)
      assert length(blogs) >= 1
      assert Enum.all?(blogs, &(&1.content_type == :blog_post))
    end
  end

  describe "Content types" do
    test "supports all content types" do
      types = [:book, :article, :blog_post, :news, :short_story, :other]

      for type <- types do
        assert {:ok, content} =
                 ContentResource.create(%{
                   title: "Test #{type}",
                   content_type: type
                 })

        assert content.content_type == type
      end
    end
  end

  describe "Difficulty levels" do
    test "supports all difficulty levels" do
      levels = [:a1, :a2, :b1, :b2, :c1, :c2]

      for level <- levels do
        assert {:ok, content} =
                 ContentResource.create(%{
                   title: "Test #{level}",
                   difficulty_level: level
                 })

        assert content.difficulty_level == level
      end
    end
  end
end
