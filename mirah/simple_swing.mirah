
import javax.swing.JFrame
import javax.swing.JButton

def self.run
  frame = JFrame.new "Welcome to Mirah!"
  frame.setSize 300, 300
  frame.setVisible true
  
  button = JButton.new "Press me"
  frame.add button
  frame.show
  
  button.addActionListener do |event|
    JButton(event.getSource).setText "Mirah rocks!"
  end
end

run
