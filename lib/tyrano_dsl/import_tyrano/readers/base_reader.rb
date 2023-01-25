require_relative 'readers'

class TyranoDsl::ImportTyrano::Readers::BaseReader

  protected

  def logger
    @logger ||= TyranoDsl::Logger.new
  end

  def log
    logger.info(self.class) {yield}
  end

  def warn
    logger.warn(self.class) {yield}
  end

end
