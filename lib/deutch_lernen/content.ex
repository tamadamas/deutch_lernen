defmodule DeutchLernen.Content do
  @moduledoc """
  Content domain manages German reading materials and their sentences.

  This domain is responsible for books, sentences, and other reading content
  that serves as input for German language learning.
  """
  use Ash.Domain, extensions: [AshGraphql.Domain]

  resources do
    resource DeutchLernen.Content.Content
    resource DeutchLernen.Content.Sentence
    # Resources will be registered here as they are created
  end
end
