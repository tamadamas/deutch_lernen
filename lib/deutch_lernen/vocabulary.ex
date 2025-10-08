defmodule DeutchLernen.Vocabulary do
  @moduledoc """
  Vocabulary domain handles German words with grammatical metadata.

  This domain manages words, their translations, and instances of words
  appearing in sentences. It captures German-specific linguistic features
  such as articles, gender, cases, and verb conjugations.
  """
  use Ash.Domain, extensions: [AshGraphql.Domain]

  resources do
    resource DeutchLernen.Vocabulary.Word
    resource DeutchLernen.Vocabulary.Translation
    resource DeutchLernen.Vocabulary.WordInstance
    # Resources will be registered here as they are created
  end
end
