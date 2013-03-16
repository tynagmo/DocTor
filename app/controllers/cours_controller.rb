class CoursController < ApplicationController
  def tous
  	@titre = "Tous les cours"
  end

  def detail
    @titre = "Detail du cours"
    @dossier = params[:cours]
    @dossierFinal = @dossier.split("/")
    @path = @dossierFinal[1]

    Dir.chdir("public/cours/") do
    #inutile car déjà fait déjà fait dans la vue
      fic = File.open(@dossier, 'r')
      @nomCours = fic.readline
      @auteur = fic.readline
      @date = fic.readline
    end
  end

  def html
@titre = "Generer pages HTML"
  	Dir.chdir("public/cours/txt") do 
  		Dir.glob("*.txt") do |file|
  			
  			# on récupère le nom du fichier sans l'extension
  			complet=file.split(".")
  			name=complet[0]

  			puts `asciidoc #{file}`
  			puts `mv -f #{name}.html ../html/`
  		end
  	end		
  end	

  def pdf
@titre = "Generer pages PDF"
  	Dir.chdir("public/cours/html") do
  		Dir.glob("*.html") do |file|
  			
  			#on supprime l'entension .html
  			complet=file.split(".")
  			name=complet[0]

  			puts `wkhtmltopdf #{file} #{name}.pdf`
  			puts `mv -f #{name}.pdf ../pdf/`
  		end
  	end
  end
end
