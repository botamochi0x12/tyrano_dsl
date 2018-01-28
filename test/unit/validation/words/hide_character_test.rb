require_relative '../../../../lib/tyrano_dsl/validation/words/hide_character'
require_relative 'words_base_test'

class ValidationWords::HideCharacterTest < ValidationWords::WordsBaseTest

  def setup
    super
    @hide_character = TyranoDsl::Validation::Words::HideCharacter.new
  end

  def test_missing_character
    @hide_character = TyranoDsl::Validation::Words::HideCharacter.new
    assert_tyrano_exception('Unknown character [missing_character]') do
      @hide_character.validation_phase(@context, @world, caller, character_name: 'missing_character')
    end
  end

  def test_ok
    @hide_character = TyranoDsl::Validation::Words::HideCharacter.new
    declare_character(@world, 'Shinji', default: '../../assets/characters/shinji/default_stance.jpg')
    @hide_character.validation_phase(@context, @world, caller, character_name: 'Shinji')
  end

end
