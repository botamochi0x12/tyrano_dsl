require 'logger'
require_relative 'tyrano_dsl'

class TyranoDsl::Logger

  UNKNOWN = ::Logger::UNKNOWN
  FATAL = ::Logger::FATAL
  ERROR = ::Logger::ERROR
  WARN = ::Logger::WARN
  INFO = ::Logger::INFO
  DEBUG = ::Logger::DEBUG

  # @param on_high_severity [IO | nil] a pipeline or file descriptor, default to `STDERR`
  # @param on_low_severity [IO | nil] a pipeline or file descriptor, default to `STDOUT`
  # @return [Logger]
  def initialize(on_high_severity: nil, on_low_severity: nil)
    @high_severity_logger = ::Logger.new(on_high_severity || STDERR)
    @low_severity_logger = ::Logger.new(on_low_severity || STDOUT)
  end

  # See standard library's `Logger.fatal`
  def fatal(...)
    @high_severity_logger.fatal(...)
  end

  # See standard library's `Logger.error`
  def error(...)
    @high_severity_logger.error(...)
  end

  # See standard library's `Logger.warn`
  def warn(...)
    @high_severity_logger.warn(...)
  end

  # See standard library's `Logger.info`
  def info(...)
    @low_severity_logger.info(...)
  end

  # See standard library's `Logger.debug`
  def debug(...)
    @low_severity_logger.debug(...)
  end
end
