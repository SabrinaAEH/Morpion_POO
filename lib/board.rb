require_relative 'boardcase.rb'

class Board
    attr_accessor :boardcases, :count_turn        # 2 variables accessibles en lecture et en écriture
  
    def initialize                                
      @boardcases = {}                            # initialisation de ma classe, boardcases représente un hash de chaque case,
      @count_turn = 0                             # et count_turn va compter les cases remplies (à chaque tour de jeu, elle ajoute 1)
  
      ('A'..'C').each do |letter|                 # boucle sur chaque case horizontale
        (1..3).each do |number|                   # boucle sur chaque case verticale
          id = "#{letter}#{number}"               # Création d'un identifiant unique pour chaque case avec sa lettre et son chiffre
          @boardcases[id] = BoardCase.new(id)     # Création d'une nouvelle instance de BoardCase avec l'identifiant et ajout à mon hash @boardcases
        end
      end
    end
  
    def display                                   # méthode d'affichage de mon plateau de jeu
      puts "  1 2 3"                              # je commence par afficher mes numéros de colonnes
      ('A'..'C').each do |letter|                 # puis les lettres de chaque ligne
        print "#{letter} "                        # je les affiche avec un espace juste après pour être bien aligné avec mes colonnes
        (1..3).each do |number|
          id = "#{letter}#{number}"               # je créé mon id unique pour chaque case (il y a surement une façon de ne pas refaire ça puisqu'on le fait dans initialize)
          print "#{@boardcases[id].value}|"       # Affiche la valeur de la case suivie d'un '|'
        end
        puts                                      # là je passe à la ligne suivante pour afficher la prochaine ligne du plateau
      end
    end
  
    def play_turn(player)                         # méthode de jeu pour chaque joueur quand c'est son tour
      id = player.get_move                        # permet d'obtenir l'identifiant de la case choisie par le joueur (cf fichier player)
  
      if valid_move?(id)                          # vérifie si le mouvement est valide
        @boardcases[id].value = player.symbol     # inscrit le symbole du joueur dans la case choisie
        @count_turn += 1                          # incrémente le compteur de tours
        return true                               # retourne true pour indiquer un mouvement valide
      else
        puts "Case invalide ou déjà prise. Veuillez choisir une autre case."
        return false                              # retourne false si le move est non valide
      end
    end
  
    def victory?                                  # définition d'une méthode pour vérifier si un joueur gagne
      winning_combinations = [                    # ici je créé un array avec toutes mes combinaisons gagnantes
        ['A1', 'A2', 'A3'], ['B1', 'B2', 'B3'], ['C1', 'C2', 'C3'],
        ['A1', 'B1', 'C1'], ['A2', 'B2', 'C2'], ['A3', 'B3', 'C3'],
        ['A1', 'B2', 'C3'], ['A3', 'B2', 'C1']
      ]
  
      winning_combinations.each do |combo|                               # pour chaque combinaison gagnante:
        if @boardcases[combo[0]].value != ' ' &&                         # je vérifie si la première case de la combinaison n'est pas vide
           @boardcases[combo[0]].value == @boardcases[combo[1]].value && # Vérifie si les trois cases de la combinaison ont bien le même symbole
           @boardcases[combo[1]].value == @boardcases[combo[2]].value
          return true                                                    # si toutes les cases ont la même valeur (et ne sont pas vides), on a une victoire
        end
      end
  
      if @count_turn == 9                              # ensuite j'ajoute une condition, c'est que si le nombre total de tours = 9 (plateau plein)
        puts "La partie est terminée. Match nul ! 👎 " # alors match nul               
        exit                                          # et fin du jeu
      end
  
      false                                        # retourne false si aucune victoire n'a été trouvée
    end
  
    private
  
    def valid_move?(id)
      @boardcases.keys.include?(id) && @boardcases[id].value == ' '              # définit le valid move : oblige le joueur à bien rentrer une case existante, et vérifie si la case spécifiée est vide
    end
    
  end
  
  