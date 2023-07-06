# frozen_string_literal: true

# This seems like a sort of config or something.  There is no code or method
# embedded in this config so it could be externalized to a file, potentially.
# If not, perhaps refactored into smaller methods
# TODO: Refactor into smaller methods or external YAML file
# rubocop:disable Metrics/MethodLength
module SearchAnalyzer
  def analyzers
    {
      ### begin custom char filter part ###
      char_filter: {
        filenamePrefix: {
          type: :pattern_replace,
          preserve_original: 0,
          pattern: "(^.*)\\..*$",
          replacement: "$1"
        }
      },
      ### end custom char filter part ###

      ### begin custom filter part ###
      filter: {
        emailPrefix: {
          type: :pattern_capture,
          preserve_original: 0,
          patterns: [
            "(.*)@"
          ]
        },
        urlPrefix: {
          type: :pattern_capture,
          preserve_original: 0,
          patterns: ["^(.*).pyx4.com$"]
        },
        autocompleteGram: {
          type: :ngram,
          min_gram: 2,
          max_gram: 15
        },
        autoCompleteEdgeGram: {
          type: :edge_ngram,
          min_gram: 2,
          max_gram: 25
        },
        truncateGram: {
          type: :truncate,
          length: 15
        },
        stopFilter: {
          type: :stop,
          stopwords: %w[_french_ _english_ _dutch_ _spanish_ _german_]
        }
      },
      ### end custom filter part ###

      ### begin custom analyzer part ###
      analyzer: {
        email: {
          tokenizer: :uax_url_email,
          filter: [:unique]
        },
        email_prefix_autocomplete_index: {
          tokenizer: :uax_url_email,
          filter: %i[emailPrefix lowercase autocompleteGram]
        },
        email_prefix_autocomplete_search: {
          tokenizer: :standard,
          filter: [:truncateGram]
        },
        autocomplete_index: {
          type: :custom,
          tokenizer: :standard,
          filter: %i[lowercase asciifolding stopFilter elision autocompleteGram]
        },
        autocomplete_search: {
          type: :custom,
          tokenizer: :standard,
          filter: %i[lowercase elision asciifolding truncateGram]
        },
        edge_autocomplete_index: {
          type: :custom,
          tokenizer: :standard,
          filter: %i[lowercase asciifolding stopFilter elision autoCompleteEdgeGram]
        },
        filename_edge_autocomplete_index: {
          type: :custom,
          char_filter: [:filenamePrefix],
          tokenizer: :standard,
          filter: %i[word_delimiter lowercase asciifolding autoCompleteEdgeGram]
        },
        filename_autocomplete_search: {
          type: :custom,
          tokenizer: :standard,
          filter: %i[word_delimiter lowercase asciifolding truncateGram]
        },
        filename_analyzer: {
          type: :custom,
          char_filter: [:filenamePrefix],
          tokenizer: :standard,
          filter: %i[word_delimiter lowercase asciifolding]
        },
        paragraph_analyzer: {
          type: :custom,
          tokenizer: :standard,
          filter: %i[lowercase asciifolding stopFilter elision]
        },
        custom_standard: {
          type: :custom,
          tokenizer: :standard,
          filter: %i[lowercase asciifolding stopFilter elision]
        },
        url_analyzer: {
          tokenizer: :uax_url_email,
          filter: [:lowercase]
        },
        pyx4_url_autocomplete_analyzer: {
          tokenizer: :whitespace,
          filter: %i[lowercase urlPrefix autoCompleteEdgeGram]
        },
        pyx4_url_analyzer: {
          tokenizer: :whitespace,
          filter: %i[lowercase urlPrefix]
        }
      }
      ### end custom analyzer part ###
    }
  end
end
# rubocop:enable Metrics/MethodLength
