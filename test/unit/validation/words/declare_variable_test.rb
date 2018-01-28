require_relative '../../../../lib/tyrano_dsl/validation/words/declare_variable'
require_relative 'words_base_test'

class ValidationWords::DeclareVariableTest < ValidationWords::WordsBaseTest

  def setup
    super
    @declare_variable = TyranoDsl::Validation::Words::DeclareVariable.new
  end

  def test_duplicated_variable
    declare_variable(@world, 'variable', 1)
    assert_tyrano_exception('Duplicated variable [variable]') do
      @declare_variable.world_construction_phase(
          @context,
          @world,
          caller,
          variable_name: 'variable',
          initial_value: 5
      )
    end
  end

  def test_ok
    @declare_variable.world_construction_phase(
        @context,
        @world,
        caller,
        variable_name: 'variable',
        initial_value: 12
    )
    assert_equal(1, @world.variables.length)
    assert_equal('variable', @world.variables.keys.first)
    variable = @world.variables.values.first
    assert_equal('variable', variable.name)
    assert_equal(12, variable.initial_value)
  end

end
