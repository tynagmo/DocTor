class CoursController < ApplicationController
  def tous
  	@titre = "Tous les cours"
  end

  def html
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
