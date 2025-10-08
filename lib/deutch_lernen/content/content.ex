defmodule DeutchLernen.Content.Content do
  use Ash.Resource,
    otp_app: :deutch_lernen,
    domain: DeutchLernen.Content,
    extensions: [AshGraphql.Resource],
    data_layer: AshPostgres.DataLayer

  postgres do
    table "contents"
    repo DeutchLernen.Repo
  end

  graphql do
    type :content
  end

  code_interface do
    define :create
    define :read
    define :by_difficulty, args: [:difficulty_level]
    define :by_type, args: [:content_type]
    define :update
    define :destroy
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]

    read :by_difficulty do
      argument :difficulty_level, :atom do
        allow_nil? false
      end

      filter expr(difficulty_level == ^arg(:difficulty_level))
    end

    read :by_type do
      argument :content_type, :atom do
        allow_nil? false
      end

      filter expr(content_type == ^arg(:content_type))
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string do
      allow_nil? false
      public? true
    end

    attribute :author, :string do
      public? true
    end

    attribute :content_type, :atom do
      constraints one_of: [:book, :article, :blog_post, :news, :short_story, :other]
      default :article
      allow_nil? false
      public? true
    end

    attribute :difficulty_level, :atom do
      constraints one_of: [:a1, :a2, :b1, :b2, :c1, :c2]
      default :b1
      allow_nil? false
      public? true
    end

    attribute :description, :string do
      public? true
    end

    attribute :url, :string do
      public? true
    end

    timestamps()
  end

  relationships do
    has_many :sentences, DeutchLernen.Content.Sentence do
      destination_attribute :content_id
    end
  end
end
