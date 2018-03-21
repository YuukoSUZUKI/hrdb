class HomeController < ApplicationController
  def index

  end
  #認証不要
  def reqire_authenticate? 
    false
  end
end