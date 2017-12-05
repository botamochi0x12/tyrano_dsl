require_relative 'parser'
require_relative 'parsing_context'
require_relative 'tyrano_exception'
require_relative 'writer'

module TyranoDsl

  class Main

    DEFAULT_FILENAME = 'content.rb'.freeze

    def initialize
      @logger = Logger.new(STDOUT)
    end

    def log()
      @logger.info(self.class){yield}
    end

    # @return [!TyranoDsl::WritingContext]
    def run(file_path)
      log{"Reading content file at [#{file_path}]"}
      unless File.exist? file_path
        raise "File not found [#{file_path}]"
      end

      parsing_context = ParsingContext.new(File.dirname(file_path), file_path)
      parser = Parser.new(parsing_context)
      log{'Parsing begin'}
      parser.instance_eval(IO.read(file_path), file_path, 1)
      log{"Parsing end #{parsing_context.inspect}"}


      Writer.new.write(parsing_context)
    end

  end
end