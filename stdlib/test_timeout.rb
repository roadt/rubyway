
# timeout long-running blocks

require 'timeout'


# if > 5s raise Timeout::Error
status = Timeout::timeout(5) {
  while true do end
}
