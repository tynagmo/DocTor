class MainController < ApplicationController
  def home
  	@titre = "Accueil"
  end

  def about
  	@titre = "A propos de l'application"
  end
end
