class HomeController < ApplicationController
  set_tab :home
  before_filter :newest_infos, :only => :index

  def index
    append_meta_tag_description "Regionales Firmenverzeichnis und Offertenportal"
    append_meta_tag_keywords "Webverzeichnis, Firmenverzeichnis, Gelbe Seiten, Offertenportal, Offerten, Architekten, Architekten Schweiz"
    append_page_title "Die besten Anbieter der Schweiz"
  end

end
