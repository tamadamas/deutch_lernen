defmodule DeutchLernen.Content.Sentence do
  use Ash.Resource,
    otp_app: :deutch_lernen,
    domain: DeutchLernen.Content,
    extensions: [AshGraphql.Resource],
    data_layer: AshPostgres.DataLayer

  postgres do
    table "sentences"
    repo DeutchLernen.Repo
  end

  graphql do
    type :sentence
  end

  code_interface do
    define :create
    define :read
    define :by_content_ordered, args: [:content_id]
    define :update
    define :destroy
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      accept [:text, :position, :translation, :grammar_notes]
      argument :content_id, :uuid, allow_nil?: false
      change manage_relationship(:content_id, :content, type: :append_and_remove)
    end

    update :update do
      accept [:text, :position, :translation, :grammar_notes]
    end

    read :by_content_ordered do
      argument :content_id, :uuid do
        allow_nil? false
      end

      filter expr(content_id == ^arg(:content_id))
      prepare build(sort: [position: :asc])
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :text, :string do
      allow_nil? false
      public? true
    end

    attribute :position, :integer do
      allow_nil? false
      public? true
      constraints min: 1
    end

    attribute :translation, :string do
      public? true
    end

    attribute :grammar_notes, :string do
      public? true
    end

    timestamps()
  end

  relationships do
    belongs_to :content, DeutchLernen.Content.Content do
      allow_nil? false
      attribute_type :uuid
      attribute_writable? true
    end
  end
end
