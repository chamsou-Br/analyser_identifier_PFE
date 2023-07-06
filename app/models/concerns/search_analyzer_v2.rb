# frozen_string_literal: true

##
# Contains all custom ElasticSearch analyzers used to tokenized text (when indexing and searching).
#
# @see https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis.html
#
module SearchAnalyzerV2
  ##
  # Generic text analyzer
  #
  TEXT_ANALYZER = {
    filter: {
      stop_words: {
        type: :stop,
        stopwords: %w[_french_ _english_ _dutch_ _spanish_ _german_]
      }
    },
    analyzer: {
      text_analyzer: {
        type: :custom,
        tokenizer: :standard,
        filter: %i[lowercase asciifolding stop_words elision]
      }
    }
  }.freeze

  ##
  # Analyzers used for auto-completion search query
  #
  # Use the `autocomplete_index_analyzer` for the index's `analyzer` (used for indexing)
  # Use the `autocomplete_search_analyzer` for the index's `search_analyzer` (used for searching)
  # @see https://www.elastic.co/guide/en/elasticsearch/reference/current/search-analyzer.html
  #
  AUTOCOMPLETE_ANALYZER = {
    filter: {
      autocomplete_edge_ngram: {
        type: :edge_ngram,
        min_gram: 2,
        max_gram: 25
      },
      autocomplete_truncate: {
        type: :truncate,
        length: 25
      }
    },
    analyzer: {
      # Use for indexing
      autocomplete_index_analyzer: {
        type: :custom,
        tokenizer: :standard,
        filter: %i[lowercase asciifolding stop_words elision autocomplete_edge_ngram]
      },
      # Use for searching
      autocomplete_search_analyzer: {
        type: :custom,
        tokenizer: :standard,
        filter: %i[lowercase asciifolding elision autocomplete_truncate]
      }
    }
  }.freeze

  ##
  # Analyzer for internal reference field like `ACT000042`
  #
  INTERNAL_REFERENCE_ANALYZER = {
    filter: {
      # example: ACT000042 => ACT42
      remove_centered_zeros_from_internal_reference: {
        type: :pattern_replace,
        pattern: "^(\\D+)0+(\\d+)$",
        replacement: "$1$2"
      }
    },
    analyzer: {
      internal_reference_analyzer: {
        tokenizer: :whitespace,
        filter: %i[lowercase remove_centered_zeros_from_internal_reference]
      }
    }
  }.freeze

  ##
  # Analyzer for an exact value. It's good for `reference` field.
  #
  KEYWORD_ANALYZER = {
    analyzer: {
      keyword_analyzer: {
        tokenizer: :keyword,
        filter: %i[lowercase trim]
      }
    }
  }.freeze

  ##
  # Hash containing all custom ElasticSearch analyzers.
  # Set this value to the `analysis` fields in index's `settings`
  #
  ANALYZERS = [
    TEXT_ANALYZER,
    AUTOCOMPLETE_ANALYZER,
    INTERNAL_REFERENCE_ANALYZER,
    KEYWORD_ANALYZER
  ].reduce(&:deep_merge).freeze
end
