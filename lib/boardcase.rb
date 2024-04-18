class BoardCase
    attr_accessor :value, :id # value sera X, O ou rien ; et id sert à identifier la case (A1, B2, C3,...).
  
    def initialize(id)
      @value = ' '
      @id = id
    end
end