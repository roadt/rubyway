
#Like a class, a module is a named group of methods, constants, and class variables.


def base64_encode
end

def base64_decode
end

module Base64
  DIGITS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  def self.encode(x)
    return x
  end
  
  def self.decode x
    return x
  end
end

data ='abc'
text = Base64.encode(data)
data = Base64.decode(text)



module BBase64
    DIGITS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  class Encoder
    def encode
    end
  end

  class Decoder
    def decode
    end
  end

  def Base64.helper
  end
end
