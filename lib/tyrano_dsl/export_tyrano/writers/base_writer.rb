require_relative 'writers'

class TyranoDsl::ExportTyrano::Writers::BaseWriter

  protected

  # @param [Array<String>] pathes
  def preload_text(pathes)
    pathes.collect {|a| "[preload storage=\"./#{a}\"]\n"}.join + '[return]'
  end

  def logger
    @logger ||= TyranoDsl::Logger.new
  end

  def log
    logger.info(self.class) {yield}
  end

end
