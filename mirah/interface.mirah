

import java.util.List

interface Printer do
  def printAll(a:List)
    return void
  end
end

class MyPrinter
implements Printer
  def printAll(a)
    a.each{|e| puts e }
  end
end

list = ['foo', 'bar', 'baz']

puts list
