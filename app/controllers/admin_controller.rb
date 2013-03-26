=begin rdoc
= admin_controller.rb : contrôleur pour l'administration des cours

6 méthodes :
- tous : permet de définir lea variable @titre
- detail : récupère le nom du répertoire du cours pour obtenir les informations sur le cours contenues dans le fichier config
- supprimerCours : supprime tout le dossier dont le nom est passé en paramètre et redirige vers la page d'accueil de l'adminitration (tous)
- genererUnHtml : se place dans le dossier dont le nom est passé en paramètre pour générer le html du .txt qu'il contient
- genererUnPdf : se place dans le dossier dont le nom est passé en paramètre pour générer le pdf du .txt qu'il contient
- genererTousLesHtml : parcours tous les dossiers de cours pour générer les html des .txt qu'ils contiennent
- genererTousLesPdf : parcours tous les dossiers de cours pour générer les pdf des .txt qu'ils contiennent
=end

class AdminController < ApplicationController
  
require "admin_helper"

  # la page d'accueil de la partie administration avec la liste de tous les cours
  def tous
  	@titre = "Tous les cours"
  end

  # la page avec les détails sur le cours récupérés dans le fichier config
  def detail
	  @titre = "Detail du cours"
	  @ficConf = params[:cours]
		
		# on récupère les différentes informations du fichier config
	  Dir.chdir("public/cours") do
		  fic = File.open(@ficConf, 'r')
		  @nomCours = fic.readline  # la première ligne doit être le nom du cours complet
		  @auteur = fic.readline	# la deuxième ligne doit être le nom de l'auteur
		  @date = fic.readline		# la troisiéme ligne doit être la date de dernière modification
	  end
  end
	
  # la page qui supprime un cours (aucun rendu html)
  def supprimerCours
  	@titre = "Supprimer un cours"
  	Dir.chdir("public/cours") do
	  	@dossier = params[:dossier]
	  	# utilise la commande système pour supprimer le dossier et son contenu
	  	puts `rm -Rf #{@dossier}`
	  	# et redirige vers l'affichage de tous les cours (version admin)
	  	#render :action => "tous"
	  	#redirect_to("tous") 
     end
  end

  # la page qui génère la page html du cours (aucun rendu html)
  def genererUnHtml
  	@titre = "Generer document HTML"
	@dossier = params[:dossier]
	# on se déplace dans le dossier récupéré en paramètre
  	Dir.chdir("public/cours/#{@dossier}") do 
		# utilise la commande système asciidoc pour générer l'html dans le même dossier
  		puts `asciidoc main.txt`
  	end
	# redirige vers la page précédente
  	redirect_to :back
  end
	
  # la page qui génère le fichier pdf du cours (aucun rendu html)
  def genererUnPdf
  	@titre = "Generer document PDF"
	@dossier = params[:dossier]
  	Dir.chdir("public/cours/#{@dossier}") do 
		# utilise la commande système wkhtmltopdf pour générer le pdf dans le même dossier
  		puts `wkhtmltopdf main.html main.pdf`
  	end
	# redirige vers la page précédente
  	redirect_to :back
  end
  
  # la page qui génère tous les html des cours txt dans les différents dossiers (aucun rendu html)
  def genererTousLesHtml
  	@titre = "Generer documents HTML"
  	Dir.chdir("public/cours") do 
  		Dir.glob("./*/main.txt").each do |main|  # pour tous les dossiers de cours contenant un maint.txt		
			# utilise la commande système asciidoc pour générer le html dans le même dossier
  			puts `asciidoc #{main}`
  		end
  	end	
  	# redirige vers la page précédente
  	redirect_to :back
  end

  # la page qui génère tous les pdf des cours txt dans les différents dossiers (aucun rendu html)
  def genererTousLesPdf
  	@titre = "Generer documents PDF"
  	Dir.chdir("public/cours") do 
  		Dir.glob("./*/main.html").each do |main| # pour tous les dossiers de cours contenant un maint.txt
			
			path=main.split("/") # on isole le nom du fichier txt
			dir=path[1]			 # et le nom du dossier le contenant
			# utilise la commande système wkhtmltopdf pour générer le pdf dans le même dossier
  			puts `wkhtmltopdf #{main} #{dir}/main.pdf`
  		end
  	end	
  	# redirige vers la page précédente
  	redirect_to :back
  end 

end
