module HTTPStub
  def self.new(a,b)
    Stub.new(a,b)
  end

  class Stub
    attr_accessor :body

    def self.rig(responses)
      @@responses = responses
    end

    def initialize(a,b)
      @body = a
    end

    def request(content)
      Stub.new(@@responses.pop, "")
    end

    def use_ssl=(whatever)
    end

    def body=(whatever)
    end
  end

  class Get < Stub
  end

  class Post < Stub
  end
end