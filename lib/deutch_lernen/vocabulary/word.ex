defmodule DeutchLernen.Vocabulary.Word do
  use Ash.Resource,
    otp_app: :deutch_lernen,
    domain: DeutchLernen.Vocabulary,
    extensions: [AshGraphql.Resource],
    data_layer: AshPostgres.DataLayer

  postgres do
    table "words"
    repo DeutchLernen.Repo
  end

  graphql do
    type :word
  end

  code_interface do
    define :create
    define :read
    define :search_by_lemma, args: [:lemma]
    define :by_type, args: [:word_type]
    define :by_level, args: [:level]
    define :update
    define :destroy
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]

    read :search_by_lemma do
      argument :lemma, :string do
        allow_nil? false
      end

      filter expr(contains(lemma, ^arg(:lemma)))
    end

    read :by_type do
      argument :word_type, :atom do
        allow_nil? false
      end

      filter expr(word_type == ^arg(:word_type))
    end

    read :by_level do
      argument :level, :atom do
        allow_nil? false
      end

      filter expr(level == ^arg(:level))
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :lemma, :string do
      allow_nil? false
      public? true
    end

    attribute :article, :atom do
      constraints one_of: [:der, :die, :das]
      public? true
    end

    attribute :word_type, :atom do
      constraints one_of: [:nomen, :verb, :adjektiv, :adverb, :präposition, :konjunktion, :pronomen, :trennbares_verb]
      default :nomen
      allow_nil? false
      public? true
    end

    attribute :gender, :atom do
      constraints one_of: [:maskulin, :feminin, :neutrum]
      public? true
    end

    attribute :plural_form, :string do
      public? true
    end

    attribute :verb_type, :atom do
      constraints one_of: [:schwach, :stark, :gemischt, :modal, :unregelmäßig]
      public? true
    end

    attribute :separable_prefix, :string do
      public? true
    end

    attribute :level, :atom do
      constraints one_of: [:a1, :a2, :b1, :b2, :c1, :c2]
      default :b1
      allow_nil? false
      public? true
    end

    timestamps()
  end

  identities do
    identity :unique_lemma, [:lemma]
  end
end
