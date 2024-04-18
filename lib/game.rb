require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'board.rb'
require_relative 'boardcase.rb'

class Game
    attr_accessor :current_player, :status, :board, :players     # 4 variables accessibles en lecture et en écriture
  
    def initialize
      @players = []
      
      # Demander le nom des joueurs:
      puts "Joueur 1, quel est votre nom (X) ?:"
      name1 = gets.chomp
      puts "Joueur 2, quel est votre nom (O) ?:"
      name2 = gets.chomp
      
      # Création des joueurs et de leurs attributs:
      @players << HumanPlayer.new(name1, "X")
      @players << HumanPlayer.new(name2, "O")
      
      # affichage du plateau de jeu:
      @board = Board.new
      @status = "en cours"  # statut défini tant que le jeu est en cours contrairement à status = nul qd il y a match nul et status = non du gagnant quand l'un des 2 joueurs gagne
    
      # initialisation du current player, qui est le joueur le 1er joueur qui joue:
      @current_player = @players.first
    end
  
    def start                              #méthode de démarrage du jeu:
      puts " ❌ Bienvenue dans le jeu du morpion ⭕️ !"
      puts "#{@players[0].name} affrontera #{@players[1].name}. Que le meilleur gagne! 🏆 "
  
      loop do                              # création de la loop pour jouer plusieurs parties si les joueurs le souhaite
        play_round
        puts "Voulez-vous jouer une nouvelle partie ? (oui/non)"
        answer = gets.chomp.downcase
        break unless answer == "oui"       # on la break sauf si le joueur dit oui et là on remet un plateau de jeu avec son statut encours 
        @board = Board.new
        @status = "en cours"
      end
    end
  
    private
  
    def play_round                          # méthode de chaque round de jeu
      loop do                               # je fais une loop do où j'affiche le plateau
        @board.display  
        valid_move = false                  # Avant d'entrer dans la boucle until, valid_move est initialisé à false. Cela signifie que la condition until valid_move sera true tant que valid_move est false.
        
        until valid_move                    # début de ma boucle until qui tournera jusqu'à ce qu'il y ait un move valide
          valid_move = @board.play_turn(@current_player) # pour vérifier le move valide, j'appelle la méthode playturn du fichier board
        end
  
        if @board.victory?                  # A chaque tour de jeu, la loop vérifiera si le joueur a gagné en faisant appel aux conditions de victoire du fichier board.rb
          @status = @current_player.name    # le statut du jeu changera avec le nom du vainqueur
          game_end                          # et appelera la méthode game_end définie plus bas
          break                             # et donc j'arrête le jeu
        else
          switch_player                     # si ma vérification de victoire me dit que personne n'a encore gagné, je fais appel à ma méthode switch_player
        end                                 # qui passe au joueur suivant (cf plus bas)
      end
    end
  
    def switch_player                       # méthode de changement de joueur: on vérifie si le current player le le joueur 1, si oui on passe à players.last, si non à players.first
      @current_player = @current_player == @players.first ? @players.last : @players.first 
    end
  
    def game_end                            # méthode de fin de jeu:
      if @status == "nul"                   # vérifie le statut de jeu, s'il est nul => match nul
        puts "La partie est terminée. Match nul !"
      else                                  # si non, affiche le nom du gagnant
        puts "La partie est terminée.  #{@status} YOU WIN 🥇 !"
      end
    end
end
  

  