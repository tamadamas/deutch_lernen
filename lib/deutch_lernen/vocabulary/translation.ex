defmodule DeutchLernen.Vocabulary.Translation do
  use Ash.Resource,
    otp_app: :deutch_lernen,
    domain: DeutchLernen.Vocabulary,
    extensions: [AshGraphql.Resource],
    data_layer: AshPostgres.DataLayer

  postgres do
    table "translations"
    repo DeutchLernen.Repo
  end

  graphql do
    type :translation
  end

  code_interface do
    define :create
    define :read
    define :by_word, args: [:word_id]
    define :by_language, args: [:language]
    define :update
    define :destroy
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      accept [:text, :language, :context]
      argument :word_id, :uuid, allow_nil?: false
      change manage_relationship(:word_id, :word, type: :append_and_remove)
    end

    update :update do
      accept [:text, :language, :context]
    end

    read :by_word do
      argument :word_id, :uuid do
        allow_nil? false
      end

      filter expr(word_id == ^arg(:word_id))
    end

    read :by_language do
      argument :language, :atom do
        allow_nil? false
      end

      filter expr(language == ^arg(:language))
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :text, :string do
      allow_nil? false
      public? true
    end

    attribute :language, :atom do
      constraints one_of: [:en, :uk]
      default :en
      allow_nil? false
      public? true
    end

    attribute :context, :string do
      public? true
    end

    timestamps()
  end

  relationships do
    belongs_to :word, DeutchLernen.Vocabulary.Word do
      allow_nil? false
      attribute_type :uuid
      attribute_writable? true
    end
  end
end
