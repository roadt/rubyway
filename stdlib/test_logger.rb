

require 'logger'

logger = Logger.new(STDOUT)

logger.level 
logger.level = Logger::WARN
puts Logger.constants

logger.debug("created logger")
logger.info("program started")
logger.warn("nothing to do!")

path = "a_non_existent_file"

begin
  File.foreach(path) do |line|
    unless line =~ /^(\w+) = (.*)$/
      logger.error("Line in wrong format: #{line.chomp)")
    end
  end
end
