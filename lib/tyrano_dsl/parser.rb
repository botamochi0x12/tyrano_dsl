require_relative 'parsed_word'
require_relative 'tyrano_exception'
require_relative 'tyrano_dsl'
require_relative 'vocabulary'

# Parse the DSL
class TyranoDsl::Parser

  # @return [TyranoDsl::ParsingContext]
  attr_reader :context
  # @return [Array<Thread::Backtrace::Location>]
  attr_accessor :word_location

  TyranoDsl::Vocabulary.get_words_class('parsing_words') do |word, word_module|
    include word_module

    # Patch the method to store the location when a word is called
    symbol_word = word.to_sym
    old_method = instance_method(symbol_word)
    define_method(symbol_word) do |*args|
      self.word_location = caller_locations
      old_method.bind(self).call(*args)
    end
  end

  # @param [TyranoDsl::ParsingContext] parsing_context
  def initialize(parsing_context)
    @context = parsing_context
  end

  protected

  # Add a parsed word
  # @param [String] word
  # @param [Hash{String => Object}] parameters
  # @return [void]
  def add_parsed_word(word, parameters = {})
    context.words << TyranoDsl::ParsedWord.new(
        word,
        word_location,
        parameters
    )
  end

end