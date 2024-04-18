class HumanPlayer
    attr_reader :name, :symbol     # je donne accès à ma variable seulement en lecture, 2 variables: le nom du joueur et son symbole X ou O
  
    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end
  
    def get_move                  # définition de ma méthode de mouvement: demande au joueur dans quel case il veut aller
      puts "#{@name}, c'est votre tour ! Veuillez choisir une case (A1-C3) :"
      gets.chomp.upcase
    end
end
  

  
  