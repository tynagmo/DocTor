class CoursController < ApplicationController
  def tous
  	@titre = "Tous les cours"
  end

  def html
  	Dir.chdir("public/cours/txt") do 
  		Dir.glob("*.txt") do |file|
  			complet=file.split(".")
  			name=complet[0]
  			puts `asciidoc #{file}`
  			puts `mv -f #{name}.html ../html/`
  		end
  	end		
  end	

  def pdf
  	Dir.chdir("public/cours/pdf") do
  		Dir.glob("../html/*.html") do |file|
  			
  			#on supprime l'entension .html
  			complet=file.split(".")
  			name=complet[0]

  			puts `wkhtmltopdf #{file} #{name}.pdf`
  		end
  	end
  end
end
