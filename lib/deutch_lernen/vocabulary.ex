defmodule DeutchLernen.Vocabulary do
  @moduledoc """
  Vocabulary domain handles German words with grammatical metadata.

  This domain manages words, their translations, and instances of words
  appearing in sentences. It captures German-specific linguistic features
  such as articles, gender, cases, and verb conjugations.
  """
  use Ash.Domain

  resources do
    # Resources will be registered here as they are created
  end
end
