require_relative 'parsing_words_test_helper'

class ParsingWordsShowMessageWindowTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_ok
    parser = create_parser
    parser.show_message_window
    assert_equal(parser.context.words.length, 1)
    assert_equal(parser.context.words[0].word, TyranoDsl::Vocabulary::SHOW_MESSAGE_WINDOW)
    assert_kind_of(Array, parser.context.words[0].word_location)
    assert_equal(parser.context.words[0].parameters, {})
  end

end
