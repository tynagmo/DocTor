=begin rdoc
= cours_controller.rb : contrôleur pour la consultation des cours 

2 méthodes : 
- tous : permet de définir lea variable @titre
- detail : permet de récupérer le nom du répertoire du cours ainsi que des informations sur le cours contenues dans un fichier config
=end

class CoursController < ApplicationController
  def tous
  	@titre = "Tous les cours"
  end

  def detail
    @titre = "Detail du cours"
    @dossier = params[:cours]
    
    # permet de récupérer le nom du répertoire du cours (passé en paramètre dans la vue tous.html.erb)
    if (@dossier != nil)
      @dossierFinal = @dossier.split("/")
    
    # la méthode split permet de garder uniquement le nom du réperoire (on enlève /config)
      @path = @dossierFinal[1]
      # cette variable contient finalement le nom du répertoire du cours (utilisé dans la vue detail.html.erb)

      Dir.chdir("public/cours/") do
        fic = File.open(@dossier, 'r')
        @nomCours = fic.readline
        @author = fic.readline
        @date = fic.readline
        # on ouvre le fichier config du cours et on récupère des informations sur le cours (le fichier config doit pour cela respecter un certain format)
      end
    end
  end


end
