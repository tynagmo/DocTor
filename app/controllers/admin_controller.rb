class AdminController < ApplicationController
  
require "admin_helper"

  def tous
  	@titre = "Tous les cours"
  end

  def detail
  	@titre = "Detail du cours"
  	@ficConf = params[:cours]

  	Dir.chdir("public/cours") do
  	#inutile car déjà fait déjà fait dans la vue
  	fic = File.open(@ficConf, 'r')
  	@nomCours = fic.readline
  	@auteur = fic.readline
  	@date = fic.readline
  end
  end

  def supprimerCours
  	@titre = "Supprimer un cours"
  	Dir.chdir("public/cours") do
  	@dossier = params[:dossier]
  	puts `rm -Rf #{@dossier}`
  	#render :action => "tous"
  	#redirect_to("tous") 
  end
  end

  def genererUnHtml
  	@titre = "Generer document HTML"
	@dossier = params[:dossier]
  	Dir.chdir("public/cours/#{@dossier}") do 

  			puts `asciidoc main.txt`
  		end

  	redirect_to :back
  end

  def genererUnPdf
  	@titre = "Generer document PDF"
	@dossier = params[:dossier]
  	Dir.chdir("public/cours/#{@dossier}") do 

  			puts `wkhtmltopdf main.html main.pdf`
  		end

  	redirect_to :back
  end

  def genererTousLesHtml
  	@titre = "Generer documents HTML"
  	Dir.chdir("public/cours") do 
  		Dir.glob("./*/main.txt").each do |main|  			

  			puts `asciidoc #{main}`
  		end
  	end	
  	redirect_to :back
  end

  def genererTousLesPdf
  	@titre = "Generer documents PDF"
  	Dir.chdir("public/cours") do 
  		Dir.glob("./*/main.html").each do |main|
			
			path=main.split("/")
			dir=path[1]
  			puts `wkhtmltopdf #{main} #{dir}/main.pdf`
  			#puts `a2x -a final -a numbered -a icons --verbose main.txt`
  		end
  	end	
  	redirect_to :back
  end 

end
