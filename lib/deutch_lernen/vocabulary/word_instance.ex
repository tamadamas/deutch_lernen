defmodule DeutchLernen.Vocabulary.WordInstance do
  use Ash.Resource,
    otp_app: :deutch_lernen,
    domain: DeutchLernen.Vocabulary,
    extensions: [AshGraphql.Resource],
    data_layer: AshPostgres.DataLayer

  postgres do
    table "word_instances"
    repo DeutchLernen.Repo
  end

  graphql do
    type :word_instance
  end

  code_interface do
    define :create
    define :read
    define :by_sentence, args: [:sentence_id]
    define :by_word, args: [:word_id]
    define :destroy
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      accept [:position_in_sentence, :inflected_form, :case_usage]
      argument :word_id, :uuid, allow_nil?: false
      argument :sentence_id, :uuid, allow_nil?: false
      change manage_relationship(:word_id, :word, type: :append_and_remove)
      change manage_relationship(:sentence_id, :sentence, type: :append_and_remove)
    end

    read :by_sentence do
      argument :sentence_id, :uuid, allow_nil?: false
      filter expr(sentence_id == ^arg(:sentence_id))
      prepare build(sort: [position_in_sentence: :asc])
    end

    read :by_word do
      argument :word_id, :uuid, allow_nil?: false
      filter expr(word_id == ^arg(:word_id))
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :position_in_sentence, :integer do
      allow_nil? false
      public? true
    end

    attribute :inflected_form, :string do
      public? true
    end

    attribute :case_usage, :atom do
      constraints one_of: [:nominativ, :akkusativ, :dativ, :genitiv]
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

    belongs_to :sentence, DeutchLernen.Content.Sentence do
      allow_nil? false
      attribute_type :uuid
      attribute_writable? true
    end
  end
end
