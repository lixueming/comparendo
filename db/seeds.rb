# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

country = Country.create(:name => 'Switzerland')

ar = Region.create(:name => 'Aargau', :country => country)
aa = Region.create(:name => 'Appenzell-Ausserrhoden', :country => country)
ai = Region.create(:name => 'Appenzell-Innerrhoden', :country => country)
bl = Region.create(:name => 'Basel-Landschaft', :country => country)
bs = Region.create(:name => 'Basel-Stadt', :country => country)
be = Region.create(:name => 'Bern', :country => country)
fr = Region.create(:name => 'Fribourg', :country => country)
ge = Region.create(:name => 'Genève', :country => country)
gl = Region.create(:name => 'Glarus', :country => country)
gr = Region.create(:name => 'Graubünden', :country => country)
ju = Region.create(:name => 'Jura', :country => country)
lu = Region.create(:name => 'Luzern', :country => country)
ne = Region.create(:name => 'Neuchâtel', :country => country)
ni = Region.create(:name => 'Nidwalden', :country => country)
ob = Region.create(:name => 'Obwalden', :country => country)
sc = Region.create(:name => 'Schaffhausen', :country => country)
sh = Region.create(:name => 'Schwyz', :country => country)
so = Region.create(:name => 'Solothurn', :country => country)
st = Region.create(:name => 'St. Gallen', :country => country)
th = Region.create(:name => 'Thurgau', :country => country)
ti = Region.create(:name => 'Ticino', :country => country)
ur = Region.create(:name => 'Uri', :country => country)
va = Region.create(:name => 'Valais', :country => country)
vu = Region.create(:name => 'Vaud', :country => country)
zu = Region.create(:name => 'Zug', :country => country)
zh = Region.create(:name => 'Zürich', :country => country)

city = City.create(:name => 'Zürich', :region => zh)
regensdorf = City.create(:name => 'Regensdorf', :region => zh)
effretikon = City.create(:name => 'Effretikon', :region => zh)
bern = City.create(:name => 'Bern', :region => be)

user = User.find_or_create_by_email(
  :name => 'Armin Primadi',
  :email => 'aprimadi@gmail.com',
  :password => 'password'
)

user.confirm!

olegp = User.find_or_create_by_email(
  :name => 'Oleg Panchenko',
  :email => 'olegapanchenko@gmail.com',
  :password => 'password',
  :author => true
)
olegp.confirm!

regios = User.find_or_create_by_email(
  :name => 'Regios GmbH',
  :email => 'regios@gmail.com',
  :password => 'password',
  :author => true
)
regios.confirm!


user_alex = User.find_or_create_by_email(
    :name => 'Alex Maslakov',
    :email => 'universal178@mail.ru',
    :password => 'password',
    :author => true
 )
user_alex.confirm!

#-------------------------------------------------#
#                    Articles                     #
#-------------------------------------------------#
tags = Faker::Lorem.words(5)
(1..9).each do |i|
  article = Article.create(
    :author => [olegp,user_alex].shuffle.first,
    :title => Faker::Lorem.sentence,
    :body => "<p>" + Faker::Lorem.paragraph(8) + "</p><p>" +
          Faker::Lorem.paragraph(8)  + "</p><p>" +
          Faker::Lorem.paragraph(8)  + "</p><p>" +
          Faker::Lorem.paragraph(8)  + "</p><p>"
    #:tags => tags.shuffle[0..2].join(",")
  )

  article.images = [Image.new(:image => File.new("#{Rails.root}/tmp_images/articles/#{i}.jpg"))]
  article.save
end

#ProjectType.create(:title => "One Family Home", :image_file_name => "house.jpg")
#ProjectType.create(:title => "Double Family Home", :image_file_name => "house-double.jpg")
#ProjectType.create(:title => "Wooden House", :image_file_name => "house-wooden.jpg")
#ProjectType.create(:title => "Office Building", :image_file_name => "office.jpg")
#ProjectType.create(:title => "Villa", :image_file_name => "villa.jpg")
#ProjectType.create(:title => "Chalet", :image_file_name => "chalet.jpg")
#ProjectType.create(:title => "Modification", :image_file_name => "modification.jpg")
#ProjectType.create(:title => "Agricultural Building", :image_file_name => "agricultural.jpg")
#ProjectType.create(:title => "Catalog Building", :image_file_name => "catalog.jpg")
#ProjectType.create(:title => "Other Project", :image_file_name => "other.jpg")

ProjectType.create(:title => "Einfamilienhaus", :image_file_name => "house.jpg")
ProjectType.create(:title => "Doppelhaus", :image_file_name => "house-double.jpg")
ProjectType.create(:title => "Holzhaus", :image_file_name => "house-wooden.jpg")
ProjectType.create(:title => "Bürohaus", :image_file_name => "office.jpg")
ProjectType.create(:title => "Villa", :image_file_name => "villa.jpg")
ProjectType.create(:title => "Chalet", :image_file_name => "chalet.jpg")
ProjectType.create(:title => "Änderung", :image_file_name => "modification.jpg")
ProjectType.create(:title => "Landwirtsch", :image_file_name => "agricultural.jpg")
ProjectType.create(:title => "Fertighaus", :image_file_name => "catalog.jpg")
ProjectType.create(:title => "Anderes Projekt", :image_file_name => "other.jpg")


#-----------------------------------------------------------#
#                         companies                         #
#-----------------------------------------------------------#
c = Company.find_or_create_by_name(
  :user => user,
  :name => 'CAS Chappuis Aregger Solèr Architekten AG',
  :contact_person => 'Architekten AG',
  :email => 'info@cas-architekten.ch',
  :description => '<p>Architektur als Einklang zwischen den Besonderheiten des Ortes und des Projekts. Wir denken zukunftsorientiert, lassen zusammenwirken und schaffen eine nachhaltige Identität. Dafür arbeiten wir eng mit verschiedensten Spezialisten zusammen, lassen Wünsche und Vorstellungen bereits in der frühen Planungsphase einfliessen und entwickeln intelligente Lösungen. Wir schaffen Räume für das Leben, projektieren und realisieren Hochbauten, Renovationen, Umnutzungen und städtebauliche Konzepte.</p>',
  :address => 'Zürichstrasse 44',
  :postal_code => 6000,
  :phone_numbers => ["41-41-480-00-80", "41-41-418-00-81"],
  :websites => ["www.cas-architekten.ch"],
  :city => City.find_or_create_by_name(:name => 'Luzern', :region => lu),
  :region => lu,
  :latitude => 47.503982472345974,
  :longitude => 8.546655178070068,
  :cover_image => File.new("#{Rails.root}/tmp_images/cas/logo.gif"),
  :reviews => [Review.new({:user => user, :rating => 3, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/cas/1.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/cas/2.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/cas/3.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/cas/4.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/cas/5.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/cas/6.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/cas/7.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/cas/8.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/cas/9.jpg"))
]
c.save

c = Company.find_or_create_by_name(
  :user => user,
  :name => 'Weberbrunner architekten ag',
  :contact_person => 'Nicole Hangartner',
  :email => 'mail@weberbrunner.ch',
  :description => '<p>Gründung 1999. Rechtsform Aktiengesellschaft seit 2008. Inhaber Boris Brunner, dipl. Arch. FH / SIA / BSA und Roger Weber, dipl. Arch. FH / SIA / BSA. MWSt 453 001. Bank Migrosbank, 8023 Zürich. IBAN CH28 0840 1016 7256 3570 5. Impressum © weberbrunner architekten ag. Alle Rechte vorbehalten. Nichts von dieser Web-Seite darf reproduziert oder in irgendeiner Form publiziert werden ohne schriftliche Genehmigung durch weberbrunner architekten ag. Diese Seite wurde erstellt mit WordPress. Foto Mitarbeiter: Beat Bühler, Zürich. Zürich 2012.</p>',
  :address => 'Binzstrasse 23',
  :postal_code => 8045,
  :phone_numbers => ["41-44-405-20-80"],
  :websites => ["www.weberbrunner.ch"],
  :city => City.find_or_create_by_name(:name => 'Zürich', :region => zh),
  :region => zh,
  :latitude => 47.3624997,
  :longitude => 8.5148697,
  :reviews => [Review.new({:user => user, :rating => 2, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/weberbrunner/1.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/weberbrunner/3.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/weberbrunner/4.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/weberbrunner/5.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/weberbrunner/6.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/weberbrunner/7.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/weberbrunner/8.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/weberbrunner/9.jpg"))
]
c.save

c = Company.find_or_create_by_name(
  :user => user,
  :name => 'HHF architects eth sia bsa',
  :contact_person => 'HHF architects',
  :email => 'info@hhf.ch',
  :description => '<p>HHF architects was founded in 2003 by Tilo Herlach, Simon Hartmann and Simon Frommenwiler. Since then HHF have realized projects in Switzerland, Germany, China, Mexico, France and the USA. The scope of work ranges broadly and includes: large scale construction, e.g., fashion center Labels Berlin 2; interior design, e.g., the Confiserie Bachmann in Basel; master planning, e.g., the public space and mobility strategy for the Praille Acacias Vernets, Geneva; public structures, e.g., Ruta del Peregrino Lookout Point of a pilgrimage route in Mexico; or the Baby Dragon pavilion in the Jinhua Architecture Park, China. &nbsp; <br>
    <br>
    From the beginning HHF has aimed for collaborations with other architects, artists and specialists in order to widen the view on a project and enrich the quality of a specific proposal. <br>
    </p>',
  :address => 'Allschwilerstrasse 71a',
  :postal_code => 4000,
  :phone_numbers => ["41-61-756-70-10"],
  :websites => ["www.hhf.ch"],
  :city => City.find_or_create_by_name(:name => 'Basel', :region => bs),
  :region => bs,
  :latitude => 47.5251773,
  :longitude => 7.5437715,
  :reviews => [Review.new({:user => user, :rating => 4, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/hhf/1.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/hhf/2.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/hhf/3.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/hhf/4.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/hhf/5.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/hhf/6.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/hhf/7.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/hhf/8.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/hhf/9.jpg"))
]
c.save

c = Company.find_or_create_by_name(
  :user => user,
  :name => 'Baureag Architekten AG',
  :contact_person => 'Baureag Architekten',
  :email => 'info@baureag.ch',
  :description => '<p><p>Die BAUREAG Architekten mit Sitz in Willisau bestehen seit 1995.<br>Im November 2003 wurden die BAUREAG Architekten&nbsp;mit einem<br>Büro in Sursee erweitert.
      </p>
      <p>Unter der Leitung des Geschäftsführers Franz Glanzmann beschäftigen die<br>BAUREAG Architekten 20 gut ausgebildete und motivierte MitarbeiterInnen,<br>darunter&nbsp;auch drei Hochbauzeichnerlehrlinge.
      </p>
      <p>Das Architekturbüro bietet nicht nur individuell auf die Bauherrschaft<br>abgestimmte Lösungen, sondern ist auch als Generalunternehmen<br>erfolgreich tätig.
      </p>
      <p>Zertifizierung des Betriebes nach ISO 9001 seit 2001.</p></p>',
  :address => 'Bruggmatt 1',
  :postal_code => 6130,
  :phone_numbers => ["41-41-972-80-80"],
  :websites => ["www.baureag.ch"],
  :city => City.find_or_create_by_name(:name => 'Willisau', :region => lu),
  :region => lu,
  :latitude => 47.1222577,
  :longitude => 7.9926824,
  :reviews => [Review.new({:user => user, :rating => 1, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/baureag/1.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/baureag/2.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/baureag/3.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/baureag/4.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/baureag/5.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/baureag/6.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/baureag/7.png")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/baureag/8.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/baureag/9.jpg"))
]
c.save

c = Company.find_or_create_by_name(
  :user => user,
  :name => 'MEYER ARCHITECTE',
  :contact_person => 'Philippe Meyer',
  :email => 'info@meyer-architecte.ch',
  :description => '<p>L’architecture est l’art de construire des lieux de telle façon qu’ils permettent l’émergence de liens: sans lieux, L’architecture est l’art de construire des lieux de telle façon qu’ils permettent l’émergence de liens: sans lieux, pas de liens possibles.<br> Faire en sorte que le lieu investi soit simplement “mieux après qu’avant”, résume notre rôle, notre devoir d’architecte.</p>',
  :address => 'Veyrier 19',
  :postal_code => 1227,
  :phone_numbers => ["41-22-301-59-05"],
  :websites => ["www.meyer-architecte.ch"],
  :city => City.find_or_create_by_name(:name => 'Carouge', :region => ge),
  :region => ge,
  :latitude => 46.1850455,
  :longitude => 6.1446191,
  :cover_image => File.new("#{Rails.root}/tmp_images/meyer/logo.jpeg"),
  :reviews => [Review.new({:user => user, :rating => 3, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/meyer/1.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/meyer/2.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/meyer/3.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/meyer/4.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/meyer/5.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/meyer/6.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/meyer/7.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/meyer/8.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/meyer/9.jpg"))
]
c.save

c = Company.find_or_create_by_name(
  :user => user,
  :name => 'Schläpfer Clavadetscher Architekten',
  :contact_person => '',
  :email => 'info@sc-arc.ch',
  :description => 'Schläpfer Clavadetscher Architekten wurde 1988 unter dem Namen Nüesch Architekten AG gegründet. Seit 24 Jahren wird das Büro als klassisches Architekturbüro geführt, welches sämtliche Teilleistungen nach SIA anbietet. Anfang 2009 wurde die Aktiengesellschaft von Michael Schläpfer und Stefan Clavadetscher übernommen und als Schläpfer Clavadetscher AG eingetragen. Gegenwärtig beschäftigen wir fünf ständige Mitarbeiter und einen Lernenden: 3 Architekten, 1 Bauleiter, 1 Hochbautechniker, 2 Hochbauzeichner und 1 Lernender. Das Büro verfügt über viel Erfahrung in Neubauten, Umbauten und Renovationen von denkmalgeschützten Objekten und beteiligt sich regelmässig an ausgewählten Studien und Wettbewerben. Bei den Neubauten liegt der Schwerpunkt bei Wohnbauten und Geschäftshäusern. Wir verstehen Bauen als einen Prozess, der über die Bedürfniserfüllung hinaus, die Ansprüche der Kunden und der Gesellschaft in architektonischer, technischer, ökonomischer und ökologischer Hinsicht erfüllen soll.',
  :address => 'Teufenerstrasse 11',
  :postal_code => 9000,
  :phone_numbers => ["41-71-274-15-15"],
  :websites => ["www.sc-arc.ch"],
  :city => City.find_or_create_by_name(:name => 'St. Gallen', :region => st),
  :region => st,
  :latitude => 47.4204239,
  :longitude => 9.3711928,
  :sponsor => true,
  :reviews => [Review.new({:user => user, :rating => 4, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schlepfer/1.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schlepfer/2.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schlepfer/3.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schlepfer/4.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schlepfer/5.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schlepfer/6.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schlepfer/7.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schlepfer/8.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schlepfer/9.jpg"))
]
c.save

c = Company.find_or_create_by_name(
  :user => user,
  :name => 'schoch-tavli Architekten',
  :contact_person => '',
  :email => 'architekten@schoch-tavli.ch',
  :description => 'Architekturbüro seit 2010 mit Schwerpunkten in Planung und Ausführung von öffentlichen und privaten Bauten. 
      Unsere Dienstleistungen: 
      Projekt- und Ausführungsplanung Architektur 
      Bauleitung und Kostenkontrolle 
      Bauberatung 
      Bauherrenvertretung ',
  :address => 'Balierestrasse 27',
  :postal_code => 8500,
  :phone_numbers => ["41-52-720-95-06"],
  :websites => ["www.schoch-tavli.ch"],
  :city => City.find_or_create_by_name(:name => 'Frauenfeld', :region => th),
  :region => th,
  :latitude => 47.555015,
  :longitude => 8.8941665,
  :cover_image => File.new("#{Rails.root}/tmp_images/schoch-tavli/logo.jpg"),
  :reviews => [Review.new({:user => user, :rating => 2, :content => "Lorem ip sum"})]
)

c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schoch-tavli/1.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schoch-tavli/2.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schoch-tavli/3.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schoch-tavli/4.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schoch-tavli/5.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schoch-tavli/6.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schoch-tavli/7.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schoch-tavli/8.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/schoch-tavli/9.jpg"))
]
c.save

Company.find_or_create_by_name(
  :user => user,
  :name => 'DORENBACH AG',
  :contact_person => 'DORENBACH',
  :email => 'mail@dorenbach.com',
  :description => '<p>
    <em>Dorenbach AG - ein junges Architekturbüro mit grosser Berufserfahrung.</em><br>
    Unser 2010 neu konzipiertes Team aus mehrheitlich jüngeren Fachleuten stellt sich den Fragen unserer Zeit und setzt die Antworten mit aktuellen Mitteln in angemessene Räume um. Als Nachfolgebüro von Dorenbach AG Architekten können wir zugleich auf 40 Jahre berufliche Praxis und profundes Wissen zurückgreifen. Dies schafft die Basis, heutige Bilder im grösseren kulturellen und wirtschaftlichen Kontext zu verankern.<br>
    &nbsp;<br>
    <em>Wir suchen klare Lösungen für komplexe Fragestellungen.</em><br>
    Architektur entsteht in Teamarbeit. Hier sind wir als Spezialisten für Raum die Generalisten, die aus den Ansprüchen von Bauherrschaft, Nutzern und Fachplanern schlüssige räumliche Konzepte entwickeln und umsetzen. Dies gelingt, wenn sich die Partner mit gegenseitiger Achtung, fachlicher Kompetenz und sachlicher Ernsthaftigkeit begegnen.&nbsp;&nbsp;&nbsp;<br>
    &nbsp;<br>
    <em>Unsere Arbeit verstehen wir als Dienstleistung mit Weitblick.</em><br>
    Architektur hat als Baukunst in doppelter Hinsicht eine dienende Funktion. Einerseits erfüllt sie konkrete, zeit- und nutzungsspezifische Bedürfnisse. Zugleich ist jeder Bau ein Eingriff, der unseren Lebensraum verändert. Gesellschaftlich verantwortungsbewusstes Handeln und wirtschaftliches Denken sind dabei kein Widerspruch: Sorgfältige Planung und solide Bauweise senken die Unterhaltskosten. In die Zukunft gerichtete Konzepte erleichtern spätere Anpassungen der Bauten und erhöhen deren Nutzungsflexibilität. &nbsp;Wer auf dieser Basis investiert, denkt nicht an kurzfristigen Profit, sondern handelt langfristig gewinnorientiert.&nbsp; </p>',
  :address => 'Rittergasse 29',
  :postal_code => 4051,
  :phone_numbers => ["41-61-206-86-00"],
  :websites => ["www.dorenbach.com"],
  :city => City.find_or_create_by_name(:name => 'Basel', :region => bs),
  :region => bs,
  :latitude => 47.5551154,
  :longitude => 7.5940234,
  :cover_image => File.new("#{Rails.root}/tmp_images/dorenbach/logo.jpg")
)

c = Company.find_or_create_by_name(
  :user => user,
  :name => 'balzani diplomarchitekten eth sia swb',
  :contact_person => '',
  :email => 'info@balzani-architekten.ch',
  :description => 'Anspruchsvolle Architektur und wirtschaftliches Bauen - das ist unsere Kompetenz',
  :address => 'Belalpstrasse 10',
  :postal_code => 3900,
  :phone_numbers => ["41-27-922-44-00"],
  :websites => ["balzani-architekten.ch "],
  :city => City.find_or_create_by_name(:name => 'Brig', :region => va),
  :region => va,
  :latitude => 46.3179749,
  :longitude => 7.9895955,
  :cover_image => File.new("#{Rails.root}/tmp_images/balzani/logo.jpg"),
  :reviews => [Review.new({:user => user, :rating => 3, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/balzani/1.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/balzani/2.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/balzani/3.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/balzani/4.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/balzani/5.jpg"))
]
c.save

c = Company.find_or_create_by_name(
  :user => user,
  :name => 'baderpartner ag planen bauen nutzen',
  :contact_person => '',
  :email => 'solothurn@baderpartner.ch',
  :description => '<p>Das Ziel unserer Architekturlösungen ist der Einklang von Funktion und Form. Grundlage dafür ist die Analyse der Problemstellung, des Umfeldes sowie der Bedürfnisse und Anforderungen der Benützer.<br>
    Als kompetenter Partner und Begleiter stehen wir unseren Aufraggebern von der Grundkonzeption bis zur Realisation und dem Unterhalt zur Seite. Die integrale Verknüpfung unserer Dienstleistungen - Raumplanung, Konzepte, Projektentwicklung, Neubau, Bauerneuerung, Facility- Management, Energie und Umwelt, Generalplaner und Totalunternehmer - ermöglicht eine ganzheitliche auf die Bedürfnisse des Auftraggebers angepasste Umsetzung.</p>',
  :address => 'Bielstrasse 145',
  :postal_code => 8002,
  :phone_numbers => ["032-624-51-51"],
  :websites => ["www.baderpartner.ch"],
  :city => City.find_or_create_by_name(:name => 'Solothurn', :region => so),
  :region => so,
  :latitude => 47.2121438,
  :longitude => 7.5169452,
  :reviews => [Review.new({:user => user, :rating => 5, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/baderpartner/1.jpg"))
]
c.save

c = Company.find_or_create_by_name(
  :user => user,
  :name => 'Baumann Waser Partner AG',
  :contact_person => '',
  :email => 'info@baumann-waser.ch',
  :description => '<p>
                          <h4>
      Wir garantieren
      </h4>
                    
      <p>Kontinuität, Kompetenz, Vertrauen, Toleranz</p>
                                <h4>
      Wir agieren
      </h4>
                    
      <p>flexibel, kundenbezogen, zielorientiert</p>
                                <h4>
      Wir realisieren
      </h4>
                    
      <p>wirtschaftliche, vielseitig nutzbare Bauten</p>
                                <h4>
      Wir negieren
      </h4>
                    
      <p>flüchtige Trends und formelle Experimente</p>
                              </p>',
  :address => 'Augustin Keller-Strasse 22',
  :postal_code => 5600,
  :phone_numbers => ["41-62-885-79-00"],
  :websites => ["www.baumann-waser.ch"],
  :city => City.find_or_create_by_name(:name => 'Lenzburg', :region => ar),
  :region => ar,
  :latitude => 47.3891228,
  :longitude => 8.1708002,
  :reviews => [Review.new({:user => user, :rating => 1, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/baumann/1.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/baumann/2.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/baumann/3.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/baumann/4.jpg"))
]
c.save


c = Company.find_or_create_by_name(
  :user => user,
  :name => 'on3 architekten',
  :contact_person => '',
  :email => 'mail@on3.ch',
  :description => '<p>
        Unsere Konzepte stehen für moderne, nachhaltige Lösungen. Das optimale Verhältnis und die gute Balance zwischen Ökonomie, Ökologie, Funktionalität und Ästhetik bestimmen unser Vorgehen. Individuelle Aspekte auch. Grundlegend und umfeldgerecht: Wir stellen bauherrschaftliche Bedürfnisse in den örtlichen Kontext. Die differenzierte und transparente Arbeitsweise schafft Raum für emotionale Werte der Bauherren. Und sie setzt sich mit natürlichen oder baulichen Umgebungsmerkmalen auseinander. Architektur entsteht im Dialog.
      </p>
      <p>
        Aufgaben packen wir gerne gemeinsam an, Teamarbeit ist bei on3 Standard. Wir ziehen möglichst frühzeitig Spezialisten bei und arbeiten interdisziplinär. Kooperation und Austausch mit den Bereichen Landschaftsarchitektur, Fachplanung, Kunst und Grafik prägen das Geschehen. So entstehen innovative Konzepte, werden neue Wege beschritten, hin zu anspruchsvollen Architekturlösungen.
      </p>
      <p>
        Eine der Stärken von on3 liegt im Wohnungsbau. Mit der 2009 gegründeten Firma on3 neues wohnen ag antworten wir auf ein Kundenbedürfnis.
        Wir kreieren attraktive, dem Gemeinsinn förderliche Wohnformen in Stadt und Land. on3 neues wohnen ag entlastet die Bauherrschaft in vielfältiger Weise.
      </p>',
  :address => 'St. Johanns-Vorstadt 15',
  :postal_code => 4056,
  :phone_numbers => ["41-61-511-76-00"],
  :websites => ["www.on3.ch"],
  :city => City.find_or_create_by_name(:name => 'Basel', :region => bs),
  :region => bs,
  :latitude => 47.5628356,
  :longitude => 7.58487,
  :reviews => [Review.new({:user => user, :rating => 2, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/on3architekten/diashow1.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/on3architekten/diashow2.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/on3architekten/diashow3.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/on3architekten/diashow4.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/on3architekten/diashow5.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/on3architekten/diashow6.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/on3architekten/diashow7.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/on3architekten/diashow8.jpg"))
]

c = Company.find_or_create_by_name(
  :user => user,
  :name => 'Flubacher - Nyfeler + Partner Architekten AG',
  :contact_person => '',
  :email => 'fnp@fnp-architekten.ch ',
  :description => '
      <p><strong><font color="#000000">Architektur, von Menschen für Menschen gestalteter Raum,</font></strong> bringt eine intensive Auseinandersetzung mit dem gegebenen Umfeld mit sich. Ein komplexes Gebiet. Zu ihm gehören städtebauliche, wirtschaftliche, kulturelle, soziale, konstruktive und bauökologische Rahmenbedingungen, Vorgaben und Vorstellungen. Ein Ganzes daraus zu machen, ist die Herausforderung, der wir uns immer wieder stellen.</p>
      <p>Dabei geht es im Wesentlichen um Gewichtung. Sie ist zusammen mit der Bauherrschaft projektspezifisch zu definieren, zu analysieren und auf das Essentielle zu reduzieren. Erst dann lassen sich klare Konzepte erarbeiten. Hier sind Kreativität, Flexibilität und Erfahrung auch im Umgang mit sich verändernden Umständen und Technologien gefragt.</p>
      <p>Intelligente und innovative Lösungen zu erarbeiten und sie in nachhaltige, dauerhafte Projekte umzusetzen, ist ein Prozess. Er dreht sich letztlich um den Mittelpunkt Mensch. Damit ist das Ziel unserer Arbeit angesprochen. Es zeigt sich in einer zeitlosen, spannungsvollen und lebbaren Architektur.</p>
      <p>Sie zeichnet sich durch gut proportionierte Räume, spezifisch ausgewählte Materialien und durch Farbgebungen aus, die ihre Kraft und Schönheit im Zusammenspiel mit Licht entfalten.&nbsp; -Zeitgemässe Baulösungen, straff strukturierte Bauabläufe sowie eine transparente, professionelle Kosten- und Terminkontrolle sind für uns eine Selbstverständlichkeit.</p>
      <p>Die Firma wurde 1979 von Hanspeter Flubacher gegründet. 1997 wurde sie in Flubacher – Nyfeler + Partner architekten AG umgewandelt. 2003 fand der Generationenwechsel statt. Seither sind Andreas Nyfeler, Regine Nyfeler-Flubacher, Martin Plattner und Peter Flubacher für die Projekte des Büros mit seinen zurzeit 18 Mitarbeiterinnen und Mitarbeitern verantwortlich. Für alle zählt Kontinuität in der Qualität ihrer Arbeit. Sie führt zum Statement: <strong><font color="#000000">Projekte sind für uns dann erfolgreich, wenn Bauherrschaft, Nutzer und Architekten vom Resultat überzeugt sind. </font></strong></p>
      ',
  :address => 'Birsigstrasse 122',
  :postal_code => 4011,
  :phone_numbers => ["41-61-225-26-26"],
  :websites => ["www.fnp-architekten.ch"],
  :city => City.find_or_create_by_name(:name => 'Basel', :region => bs),
  :region => bs,
  :latitude => 47.5506184,
  :longitude => 7.5778126,
  :reviews => [Review.new({:user => user, :rating => 3, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/Flubacher/FNP-01.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/Flubacher/FNP-02.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/Flubacher/FNP-03.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/Flubacher/FNP-04.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/Flubacher/FNP-05.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/Flubacher/FNP-06.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/Flubacher/FNP-07.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/Flubacher/FNP-08.jpg"))
]
c.save


c = Company.find_or_create_by_name(
  :user => user,
  :name => 'August + Margrith Künzel Landschaftsarchitekten AG',
  :contact_person => '',
  :email => 'landschaftsarchitekt@august-kuenzel.ch',
  :description => '
      <p>Pflanzen und ihre gezielte, adäquate Verwendung verbunden mit einer differenzierten räumlichen Landschaftsgestaltung sind die treibenden Komponenten unserer Arbeit. Das Ziel ist nicht die Gestaltung einer Momentaufnahme sondern der zu erwartenden Veränderungen über den Lauf der Jahre.</p>
      <p>Die vielfältigen Aufgaben der Vergangenheit haben uns das Verständnis für die architektonischen, städtebaulichen, ökologischen und ästetischen Aspekte der Freiraumplanung gelehrt.</p>
      <p>Unser Schwerpunkt liegt in der Objektplanung von vorwiegend öffentlichen Anlagen, aber auch die Teilnahme an Wettbewerben sowie das Erarbeiten von Studien- und Konzeptplanungen gehört zu unserem Aufgabenfeld.</p>',
  :address => 'Schweissbergweg 34',
  :postal_code => 4102,
  :phone_numbers => ["41-61-335-90-20"],
  :websites => ["www.august-kuenzel.ch"],
  :city => City.find_or_create_by_name(:name => 'Binningen', :region => bs),
  :region => bs,
  :latitude => 47.5343985,
  :longitude => 7.5759549,
  :reviews => [Review.new({:user => user, :rating => 1, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/August/1.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/August/2.jpg"))
]
c.save

c = Company.find_or_create_by_name(
  :user => user,
  :name => 'Burckhardt+Partner AG Architekten Generalplaner',
  :contact_person => '',
  :email => 'basel@burckhardtpartner.ch',
  :description => '
    <h3>Portrait</h3>
    <p>Die Burckhardt+Partner AG ist ein führendes Architektur- und Generalplanungsunternehmen in der Schweiz. Wir berücksichtigen Zukunftstrends und beziehen globale, wirtschaftliche, politische, gesellschaftliche und technische Veränderungen in unser Denken und Arbeiten ein. Wir stellen damit sicher, dass wir den sich verändernden Marktbedürfnissen und den raschen Innovationszyklen gerecht werden. Unsere Unternehmenskultur ist geprägt von der Verantwortung gegenüber unseren Auftraggebern, der Gesellschaft und unserer Umwelt sowie der hohen Selbstverantwortung unserer fachlich und sozial kompetenten Mitarbeitenden.</p>
    <p>Wir ermitteln die Bedürfnisse, formulieren die Projektziele, leiten daraus kompetente Lösungen ab und setzen diese, unter Berücksichtigung aller relevanten Einflussfaktoren, um. Unsere Leistungsfähigkeit führt zu einem hohen Kundennutzen. Unser Leistungsspektrum umfasst in den beiden Hauptbereichen Planung und Realisierung alle Leistungen von der strategischen Planung bis zur Leitung der Garantiearbeiten.</p>
    <h3>Wir sind unabhängig</h3>
    <p>Die Burckhardt+Partner AG ist als Aktiengesellschaft konstituiert, deren Aktien im Besitz von rund 40 leitenden Mitarbeitenden sind. Der Aktionärskreis setzt sich aus je einer Gruppe von Partnern, assoziierten Partnern und assoziierten Mitarbeitenden zusammen. Höchstbeteiligungssatz, Kompetenzen und Verantwortlichkeiten der Inhaber sind in Statuten festgelegt. Ungeachtet des föderalen Aufbaus sind die einzelnen Geschäftseinheiten nicht als unabhängige Profit-Center tätig. Die Verantwortung für das Unternehmen – wie auch die Partizipation am wirtschaftlichen Erfolg – liegen bei der Gesamtheit der Partner und der ins Partner-Modell eingebundenen Mitarbeitenden.</p>
  ',
  :address => 'Dornacherstrasse 210',
  :postal_code => 4053,
  :phone_numbers => ["41-61-338-34-34"],
  :websites => ["www.burckhardtpartner.ch"],
  :city => City.find_or_create_by_name(:name => 'Basel', :region => bs),
  :region => bs,
  :latitude => 47.5411025,
  :longitude => 7.5945006,
  :reviews => [Review.new({:user => user, :rating => 1, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/Burckhardt/1.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/Burckhardt/2.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/Burckhardt/3.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/Burckhardt/4.jpg"))
]
c.save

c = Company.find_or_create_by_name(
  :user => user,
  :name => 'playze switzerland llc',
  :contact_person => '',
  :email => 'info@playze.com',
  :description => '
    <p>playze started as a project to explore the possibilities of mobility, intercultural exchanges and global market niches. by building up a network that ranges from very locally connected individuals to so-called neo-nomads the set-up investigates on the shifts of importance in our built and unbuilt environments. playze is a team of individuals with different educational and cultural backgrounds (economist, advertiser, architect, art director, swiss, luxemburgish, chinese,...). our activities in spatial design range from teaching and research to the classic execution of the profession of an architect.</p>',
  :address => 'seltisbergerstrasse 6',
  :postal_code => 4059,
  :phone_numbers => ["49-76-2479-1408"],
  :websites => ["www.playze.com"],
  :city => City.find_or_create_by_name(:name => 'Basel', :region => bs),
  :region => bs,
  :latitude => 47.5298882,
  :longitude => 7.600714,
  :cover_image => File.new("#{Rails.root}/tmp_images/playze/logo.jpg"),
  :reviews => [Review.new({:user => user, :rating => 4, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/playze/1.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/playze/2.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/playze/3.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/playze/4.jpg"))
]
c.save

c = Company.find_or_create_by_name(
  :user => user,
  :name => 'phalt Architekten AG',
  :contact_person => '',
  :email => 'info@phalt.ch',
  :description => '
    <p>phalt wurde 2006 von Cornelia Mattiello-Schwaller, Frank Schneider und Mike Mattiello auf Basis langjähriger Freundschaft und Zusammenarbeit während der Studienzeit in Zürich gegründet. Seither verfolgt das Büro konsequent das Ziel, anspruchsvolle Raumkultur zu schaffen.</p>
    <p>Das vielschichtige Wirkungsfeld in den Bereichen Architektur, Städtebau und Design umfasst das Entwerfen, Projektieren und Realisieren von Neu- und Umbauten für Wohnen, Bildung, Verwaltung, Gewerbe sowie Kultur- und Freizeit.</p>',
  :address => 'seltisbergerstrasse 6',
  :postal_code => 8045,
  :phone_numbers => ["41-44-455-77-99"],
  :websites => ["www.phalt.ch"],
  :city => City.find_or_create_by_name(:name => 'Zürich', :region => zh),
  :region => zh,
  :latitude => 47.3630408,
  :longitude => 8.5125782,
  :cover_image => File.new("#{Rails.root}/tmp_images/phalt/logo.jpg"),
  :reviews => [Review.new({:user => user, :rating => 5, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/1.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/2.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/3.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/4.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/5.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/6.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/7.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/8.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/9.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/10.jpg"))
]
c.save

c = Company.find_or_create_by_name(
  :user => user,
  :name => 'atelier zürich gmbh',
  :contact_person => '',
  :email => 'contact@atelierzuerich.ch',
  :description => '
    <p>Das vielschichtige Wirkungsfeld in den Bereichen Architektur, Städtebau und Design umfasst das Entwerfen, Projektieren und Realisieren von Neu- und Umbauten für Wohnen, Bildung, Verwaltung, Gewerbe sowie Kultur- und Freizeit.</p>',
  :address => 'Gotthardstrasse 51',
  :postal_code => 8002,
  :phone_numbers => ["41-44-205-93-93"],
  :websites => ["www.atelierzuerich.ch"],
  :city => City.find_or_create_by_name(:name => 'Zürich', :region => zh),
  :region => zh,
  :latitude => 47.3648553,
  :longitude => 8.5335615,
  :reviews => [Review.new({:user => user, :rating => 2, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/1.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/2.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/3.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/4.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/5.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/6.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/7.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/8.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/9.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/phalt/10.jpg"))
]
c.save

c = Company.find_or_create_by_name(
  :user => user,
  :name => 'atelier zürich gmbh',
  :contact_person => '',
  :email => 'contact@atelierzuerich.ch',
  :description => '
    <p>Das vielschichtige Wirkungsfeld in den Bereichen Architektur, Städtebau und Design umfasst das Entwerfen, Projektieren und Realisieren von Neu- und Umbauten für Wohnen, Bildung, Verwaltung, Gewerbe sowie Kultur- und Freizeit.</p>',
  :address => 'Gotthardstrasse 51',
  :postal_code => 8002,
  :phone_numbers => ["41-44-205-93-93"],
  :websites => ["www.atelierzuerich.ch"],
  :city => City.find_or_create_by_name(:name => 'Zürich', :region => zh),
  :region => zh,
  :latitude => 47.3648553,
  :longitude => 8.5335615,
  :reviews => [Review.new({:user => user, :rating => 2, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/atelier/1.jpg"))
]
c.save

c = Company.find_or_create_by_name(
  :user => user,
  :name => 'ArchitekturBureau Garzotto',
  :contact_person => '',
  :email => 'garzotto@architekturbureau.ch',
  :description => '
    <p>Our lifestyles are altering at an increasing speed, in which media, art, society and innovation are continuously redefined. My greatest endeavor is to monitor these changes, generating new forms, new spaces, and new realities.</p>',
  :address => 'Neugasse 97-10',
  :postal_code => 8005,
  :phone_numbers => ["41-44-205-93-93"],
  :websites => ["garzotto@architekturbureau.ch"],
  :city => City.find_or_create_by_name(:name => 'Zürich', :region => zh),
  :region => zh,
  :latitude => 47.3834442,
  :longitude => 8.5254142,
  :cover_image => File.new("#{Rails.root}/tmp_images/ArchitekturBureau/logo.gif"),
  :reviews => [Review.new({:user => user, :rating => 4, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/ArchitekturBureau/1.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/ArchitekturBureau/2.gif")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/ArchitekturBureau/3.gif")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/ArchitekturBureau/4.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/ArchitekturBureau/5.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/ArchitekturBureau/6.jpg"))
]
c.save

c = Company.find_or_create_by_name(
  :user => user,
  :name => 'AFC Air Flow Consulting AG',
  :contact_person => '',
  :email => 'info@afc.ch',
  :description => '
    <p>AFC bietet in den vier Geschäftsbereich Beratung und Expertisen, Computersimulationen und Strömungsanalysen, Messungen und Projektbegleitungen. Während Sicherheit, Energie, Komfort und Luftqualität die Hauptthemen in der Gebäudetechnik sind, steht die schnelle Produktentwicklung im Engineering im Vordergrund. Erfahren Sie mehr, hier auf der Webseite oder besuchen Sie uns an einem unserer Standorte in der Schweiz.</p>',
  :address => 'Weinbergstrasse 72',
  :postal_code => 8006,
  :phone_numbers => ["41-58-450-00-00"],
  :websites => ["www.afc.ch"],
  :city => City.find_or_create_by_name(:name => 'Zürich', :region => zh),
  :region => zh,
  :latitude => 47.3836828,
  :longitude => 8.5435906,
  :cover_image => File.new("#{Rails.root}/tmp_images/afc/logo.png"),
  :reviews => [Review.new({:user => user, :rating => 3, :content => "Lorem ip sum"})]
)
c.images = [
  Image.new(:image => File.new("#{Rails.root}/tmp_images/afc/1.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/afc/2.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/afc/3.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/afc/4.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/afc/5.jpg")),
  Image.new(:image => File.new("#{Rails.root}/tmp_images/afc/6.jpg"))
]
c.save
#-----------------------------------------------------------#





#------------------Tags and taggers-----------------------------------------#
Tag.create(:name=>"Kirche")
Tag.create(:name=>"Office")
Tag.create(:name=>"Schulhaus")
Tag.create(:name=>"Sportzentrum")
Tag.create(:name=>"Spital")
Tag.create(:name=>"Stadion")
Tag.create(:name=>"Stadtplatz Schlieren")
Tag.create(:name=>"Parking")

Tag.create(:name=>"Renovation")
Tag.create(:name=>"Restaurant")
Tag.create(:name=>"Clubhouse")
Tag.create(:name=>"Museum")
Tag.create(:name=>"Tower")
Tag.create(:name=>"Office")


Tag.create(:name=>"Mehrfamilienhaus")
Tag.create(:name=>"Öffentlich")
Tag.create(:name=>"Dienstleistung")
Tag.create(:name=>"An-/Umbau/Sanierungen")
Tag.create(:name=>"Wettbewerbe")
Tag.create(:name=>"Immobilien")
Tag.create(:name=>"Werkverzeichnis")

Tag.create(:name=>"Architecture")
Tag.create(:name=>"Corporate Architecture")
Tag.create(:name=>"Renovation")
Tag.create(:name=>"Architecture Theory")
Tag.create(:name=>"Interior Design")
Tag.create(:name=>"Furniture + Consumer Products")
Tag.create(:name=>"Installations + Art")

Tag.create(:name=>"Renovierung")
Tag.create(:name=>"Innenarchitektur")
Tag.create(:name=>"Möbeldesign")
Tag.create(:name=>"Konzepte für Wohnen + Arbeiten")
Tag.create(:name=>"Wettbewerb")
Tag.create(:name=>"Einfamilienhaus")
Tag.create(:name=>"Haus")


Tag.create(:name=>"Theaterhauses")
Tag.create(:name=>"Wohnüberbauung")
Tag.create(:name=>"Wettbewerb")
Tag.create(:name=>"Bauerneuerung")
Tag.create(:name=>"Raumplanung")
Tag.create(:name=>"Facility-Management")
Tag.create(:name=>"Energie und Umwelt")
Tag.create(:name=>"Konzepte")
Tag.create(:name=>"Projektentwicklung")
Tag.create(:name=>"Totalunternehmer")
Tag.create(:name=>"Sicherheitstechnik")
Tag.create(:name=>"Bauphysik")
Tag.create(:name=>"Bauingenieurwesen")
Tag.create(:name=>"Beratung")


# Tags should be added like below
#c = Company.first
#c.tags << t1 << t2 << t3


#to be removed
################## For Articles #####################################
# Tagging.create(:tag_id=>1, :taggable_type =>"Article", :taggable_id=>1)
# Tagging.create(:tag_id=>2, :taggable_type =>"Article", :taggable_id=>1)
# Tagging.create(:tag_id=>3, :taggable_type =>"Article", :taggable_id=>1)
# Tagging.create(:tag_id=>4, :taggable_type =>"Article", :taggable_id=>1)

# Tagging.create(:tag_id=>3, :taggable_type =>"Article", :taggable_id=>2)
# Tagging.create(:tag_id=>4, :taggable_type =>"Article", :taggable_id=>2)
# Tagging.create(:tag_id=>6, :taggable_type =>"Article", :taggable_id=>2)
# Tagging.create(:tag_id=>8, :taggable_type =>"Article", :taggable_id=>2)
################## For Articles end #####################################



################## For Companies #####################################
Tagging.create(:tag_id=>5, :taggable_type =>"Company", :taggable_id=>1)
Tagging.create(:tag_id=>6, :taggable_type =>"Company", :taggable_id=>1)
Tagging.create(:tag_id=>11, :taggable_type =>"Company", :taggable_id=>1)
Tagging.create(:tag_id=>9, :taggable_type =>"Company", :taggable_id=>1)

Tagging.create(:tag_id=>3, :taggable_type =>"Company", :taggable_id=>2)
Tagging.create(:tag_id=>4, :taggable_type =>"Company", :taggable_id=>2)
Tagging.create(:tag_id=>5, :taggable_type =>"Company", :taggable_id=>2)
Tagging.create(:tag_id=>7, :taggable_type =>"Company", :taggable_id=>2)
Tagging.create(:tag_id=>6, :taggable_type =>"Company", :taggable_id=>2)
Tagging.create(:tag_id=>8, :taggable_type =>"Company", :taggable_id=>2)
Tagging.create(:tag_id=>9, :taggable_type =>"Company", :taggable_id=>2)
Tagging.create(:tag_id=>10, :taggable_type =>"Company", :taggable_id=>2)
Tagging.create(:tag_id=>11, :taggable_type =>"Company", :taggable_id=>2)
Tagging.create(:tag_id=>12, :taggable_type =>"Company", :taggable_id=>2)


Tagging.create(:tag_id=>6, :taggable_type =>"Company", :taggable_id=>3)
Tagging.create(:tag_id=>8, :taggable_type =>"Company", :taggable_id=>5)

Tagging.create(:tag_id=>8, :taggable_type =>"Company", :taggable_id=>2)
Tagging.create(:tag_id=>10, :taggable_type =>"Company", :taggable_id=>2)
Tagging.create(:tag_id=>14, :taggable_type =>"Company", :taggable_id=>3)
Tagging.create(:tag_id=>12, :taggable_type =>"Company", :taggable_id=>5)

Tagging.create(:tag_id=>3, :taggable_type =>"Company", :taggable_id=>6)
Tagging.create(:tag_id=>8, :taggable_type =>"Company", :taggable_id=>6)
Tagging.create(:tag_id=>12, :taggable_type =>"Company", :taggable_id=>6)
Tagging.create(:tag_id=>14, :taggable_type =>"Company", :taggable_id=>6)


Tagging.create(:tag_id=>4, :taggable_type =>"Company", :taggable_id=>7)
Tagging.create(:tag_id=>6, :taggable_type =>"Company", :taggable_id=>8)
Tagging.create(:tag_id=>8, :taggable_type =>"Company", :taggable_id=>9)

Tagging.create(:tag_id=>3, :taggable_type =>"Company", :taggable_id=>10)
Tagging.create(:tag_id=>4, :taggable_type =>"Company", :taggable_id=>11)
Tagging.create(:tag_id=>6, :taggable_type =>"Company", :taggable_id=>11)
Tagging.create(:tag_id=>8, :taggable_type =>"Company", :taggable_id=>11)


Tagging.create(:tag_id=>3, :taggable_type =>"Company", :taggable_id=>17)
Tagging.create(:tag_id=>4, :taggable_type =>"Company", :taggable_id=>17)
Tagging.create(:tag_id=>6, :taggable_type =>"Company", :taggable_id=>17)
Tagging.create(:tag_id=>8, :taggable_type =>"Company", :taggable_id=>17)
Tagging.create(:tag_id=>9, :taggable_type =>"Company", :taggable_id=>17)
Tagging.create(:tag_id=>10, :taggable_type =>"Company", :taggable_id=>17)
Tagging.create(:tag_id=>11, :taggable_type =>"Company", :taggable_id=>17)
Tagging.create(:tag_id=>12, :taggable_type =>"Company", :taggable_id=>17)

Tagging.create(:tag_id=>3, :taggable_type =>"Company", :taggable_id=>17)
Tagging.create(:tag_id=>4, :taggable_type =>"Company", :taggable_id=>17)


Tagging.create(:tag_id=>15, :taggable_type =>"Company", :taggable_id=>18)
Tagging.create(:tag_id=>13, :taggable_type =>"Company", :taggable_id=>18)
Tagging.create(:tag_id=>19, :taggable_type =>"Company", :taggable_id=>18)
Tagging.create(:tag_id=>2, :taggable_type =>"Company", :taggable_id=>18)
Tagging.create(:tag_id=>8, :taggable_type =>"Company", :taggable_id=>18)
Tagging.create(:tag_id=>10, :taggable_type =>"Company", :taggable_id=>18)
Tagging.create(:tag_id=>11, :taggable_type =>"Company", :taggable_id=>18)
Tagging.create(:tag_id=>12, :taggable_type =>"Company", :taggable_id=>18)


Tagging.create(:tag_id=>21, :taggable_type =>"Company", :taggable_id=>19)
Tagging.create(:tag_id=>20, :taggable_type =>"Company", :taggable_id=>19)
Tagging.create(:tag_id=>9, :taggable_type =>"Company", :taggable_id=>19)
Tagging.create(:tag_id=>10, :taggable_type =>"Company", :taggable_id=>19)
Tagging.create(:tag_id=>11, :taggable_type =>"Company", :taggable_id=>19)
Tagging.create(:tag_id=>12, :taggable_type =>"Company", :taggable_id=>19)


################## For Companies end #####################################

################## For Category, Subcategory #####################################

data = {"Büro" =>
           [{:name => "Telefonanlage", 
            :q => [
              {:n => "Anzahl Endgeräte brauchen Sie für Ihre Telefonzentrale", :d => "Wieviele Endgeräte brauchen Sie für Ihre Telefonzentrale?", :t => "one", :answers => ["1 bis 10", "11 bis 20", "21 bis 50", "mehr als 50"]},
              {:n => "Technologie für Ihre Telefonanlage", :d => "Welche Technologie bevorzugen Sie für Ihre Telefonanlage?", :t => "many", :answers => ["VOIP-Telefonanlage", "ISDN-Telefonanlage", "ISDN- & VOIP-fähige Telefonanlage", "Noch offen, bitte beraten Sie mich"]},
              {:n => "Art der Beschaffung trifft zu", :d => "Welche Art der Beschaffung trifft zu?", :t => "many", :answers => ["Neue Anlage", "Ersatz einer Anlage", "Erweiterung einer bestehenden Anlage", "Bitte beraten Sie mich"]},
              {:n => "Wieviele Gespräche sollen in etwa gleichzeitig über Ihre Telefonanlage möglich sein?", :d => "Wieviele Gespräche sollen in etwa gleichzeitig über Ihre Telefonanlage möglich sein?", :t => "one", :answers => ["Bitte auswählen", "6 bis 10", "11 bis 15", "16 bis 20", "21 bis 30", "31 bis 50", "51 bis 100", "mehr als 100"]},
              {:n => "Möchten Sie Ihre Telefonanlage kaufen oder leasen?", :d => "Möchten Sie Ihre Telefonanlage kaufen oder leasen?", :t => "many", :answers => ["Kaufen", "Leasen", "Weiss nicht, bitte beraten Sie mich"]},
              {:n => "Wünschen Sie Service und Wartung?", :d => "Wünschen Sie Service und Wartung?", :t => "many", :answers => ["Erwünscht", "Nicht erwünscht", "Bitte beraten Sie mich"]},
              {:n => "Wann soll die Telefonzentrale in Betrieb gehen?", :d => "Wann soll die Telefonzentrale in Betrieb gehen?", :t => "one", :answers => ["Bitte auswählen", "Innerhalb von 2 Monaten", "Innerhalb von 2-4 Monaten"]}]
            },
            {:name => "ISDN"},
            {:name => "Projektor",
            :q => [
              {:n => "Wie viele Geräte benötigen Sie?", :d => "Wie viele Geräte benötigen Sie?", :t => "one", :answers => ["Bitte Auswahl treffen", "1", "2", "3-4", "5-7", "8-10", " mehr als 10"]},
              {:n => "Welches ist der primäre Verwendungs- zweck des gesuchten Beamers?", :d  => "Welches ist der primäre Verwendungs- zweck des gesuchten Beamers?", :t => "many", :answers => ["Einfache Prästentation (ohne Hochauflösung)", "Spreadsheets und kleine Schrift", "Präsentation detailierter Grafiken(z.B. CAD)", "Gemischte Verwendung inkl. Videoprojektion", "Nur Videoprojektion", "Homecinema/Heimkino", "Andere, bitte beraten Sie mich"]},
              {:n => "Soll der Projektor portabel sein?", :d => "Soll der Projektor portabel sein?", :t => "many", :answers => ["Ja - Gerät soll sehr klein sein (max. 1 kg)", "Ja - Gerät soll eher leicht sein (1-3 kg)", "Ja - Gerät muss portabel sein (3-5 kg)", "Nein - Gerät soll fest installiert werden"]},
              {:n => "Für welche Raumgrösse benötigen Sie das Gerät?", :d => "Für welche Raumgrösse benötigen Sie das Gerät?", :t => "many", :answers => ["Klein - Besprechungszimmer", "Mittel - Konferenz- oder Schulungsraum", "Gross - Auditorium, Halle"]},
              {:n => "Sind die Lichtverhältnisse im Raum anpassbar?", :d => "Sind die Lichtverhältnisse im Raum anpassbar?", :t => "many", :answers => ["Ja - Raum kann immer abgedunkelt werden", "Ja - Raum kann meistens abgedunkelt werden", "Nein - Raum kann nicht abgedunkelt werden"]},
              {:n => "Welche Technologie bevorzugen Sie? (siehe Produktinfomationen)", :d => "Welche Technologie bevorzugen Sie? (siehe Produktinfomationen)", :t => "many", :answers => ["DLP", "LCD", "LED", "LCOS", "Weiss nicht, bitte beraten Sie mich"]},
              {:n => "Welcher Branche gehört Ihr Unternehmen an?", :d => "Welcher Branche gehört Ihr Unternehmen an?", :t => "custom"},
              {:n => "Wie viele Mitarbeiter hat Ihr Unternehmen?", :d => "Wie viele Mitarbeiter hat Ihr Unternehmen?", :t => "custom"},
              {:n => "Wann benötigen Sie das neue Gerät?", :d => "Wann benötigen Sie das neue Gerät?", :t => "one", :answers => ["Bitte Auswahl treffen", "So schnell wie möglich", "In einem Monat", "In drei Monaten", "In einem halben Jahr", "Später als 6 Monate"]}]
            },
            {:name => "Büromöbel"},
            {:name => "Kaffeeautomat"},
            {:name => "Kopierer"},
            {:name => "Plotter"},
            {:name => "Wasserspender"},
            {:name => "Displays"},
            {:name => "Prospektständer"},
            {:name => "Büroreinigung"},
            {:name => "Reinigungsunternehmen"},
            {:name => "Multifunktionsdrucker"},
            {:name => "PCs und Notebooks"}],
        "Telekommunikation" =>
           [{:name => "Telefonanlage"},
            {:name => "ISDN Telefonanlage"},
            {:name => "VoIP Telefonanlage"},
            {:name => "Fernseher"},
            {:name => "Monitor"},
            {:name => "Videokonferenz"},
            {:name => "Webkonferenz"}],
        "Handel" =>
           [{:name => "Kassensysteme"},
            {:name => "Gastrokassen"},
            {:name => "Registrierkassen"},
            {:name => "Zahlterminals"},
            {:name => "Kreditkartenterminals"}],
        "Gastronomie" =>
           [{:name => "Verpflegung"},
            {:name => "Catering"},
            {:name => "Lieferdienst"},
            {:name => "Partyorganisation"},
            {:name => "Feierorganisation"}],
        "IT" =>
           [{:name => "Web Hosting"},
            {:name => "IT Support"},
            {:name => "IT Services"},
            {:name => "IT Security"},
            {:name => "IT Outsourcing"},
            {:name => "Cloud Computing"},
            {:name => "Netzwerke"}],
        "Software" =>
           [{:name => "Programmierung"},
            {:name => "Software-Entwicklung"},
            {:name => "App Entwicklung"},
            {:name => "CRM Software"},
            {:name => "ERP Systeme"}],
        "Hardware" =>
           [{:name => "PCs und Notebooks"},
            {:name => "Multifunktionsdrucker"},
            {:name => "Kopierer"},
            {:name => "Scanner"},
            {:name => "Plotter"}],
        "Internet" =>
           [{:name => "Web Design"},
            {:name => "Suchmaschinenoptimierung"},
            {:name => "Suchmaschinenmarketing"},
            {:name => "Social Media Marketing"},
            {:name => "Corporate Design"},
            {:name => "Logo Design"},
            {:name => "Mobile Apps"},
            {:name => "E-Commerce"}],
        "Marketing" =>
           [{:name => "Fahrzeugwerbung"},
            {:name => "Online Marketing"},
            {:name => "Printmarketing"},
            {:name => "Eventmanagement"},
            {:name => "Eventagentur"},
            {:name => "Fotograf"},
            {:name => "Texter"},
            {:name => "Übersetzer"},
            {:name => "Videoproduktion"},
            {:name => "Werbeagentur"},
            {:name => "Marketing Agentur"}],
        "Design" =>
           [{:name => "Grafikdesign"},
            {:name => "Web Design"},
            {:name => "Corporate Design"},
            {:name => "Logo Design"},
            {:name => "Print Design"}],
        "Immobilien" =>
           [{:name => "Büroräume"},
            {:name => "Office Räume"},
            {:name => "Büroimmobilien"},
            {:name => "Wohnung mieten"},
            {:name => "Haus mieten"}],
        "Reisen" =>
           [{:name => "Flüge"},
            {:name => "Logistik"},
            {:name => "Spedition"},
            {:name => "Fuhrpark"}],
        "Finanzen" =>
           [{:name => "Buchhaltung"},
            {:name => "Treuhand"},
            {:name => "Büroservice"},
            {:name => "Sekretariatsservice"},
            {:name => "Fuhrparkversicherung"},
            {:name => "Payroll Services"},
            {:name => "Personaladministration"},
            {:name => "Sozialversicherung"},
            {:name => "Wirtschaftsanwalt"},
            {:name => "Rechtsanwalt"}],
        "Technik" =>
           [{:name => "Alarmanlagen"},
            {:name => "Brandmeldeanlagen"},
            {:name => "Rauchmelder"},
            {:name => "Sprechsysteme"},
            {:name => "Videotelefonie"},
            {:name => "Photovoltaik"},
            {:name => "Solaranlage"},
            {:name => "Treppenlift"},
            {:name => "Videoüberwachung"}],
        "Industrie" =>
           [{:name => "Sanierung"},
            {:name => "Innenausbau"},
            {:name => "Raumdesign"}],
        "Umzug" =>
           [{:name => "Privater Umzug"},
            {:name => "Geschäftlicher Umzug"},
            {:name => "Auslandsumzug"}]
}

data.keys.each do |category|
  category_db = Category.find_or_create_by_name(:name => category)
  data[category].each do |subcategory|
    sub = Subcategory.find_or_create_by_name(:name =>subcategory[:name], :category_id => category_db.id)
    unless subcategory[:q].blank?
      subcategory[:q].each do |q|
        question = Question.find_or_create_by_name(:name => q[:n], 
          :description => q[:d], :question_type => q[:t], :subcategory => sub)
        unless q[:answers].blank?
          q[:answers].each do |a|
            unless question.custom?
              answer = Answer.find_or_create_by_description(:description => a, :question => question)
            end
          end
        end
      end
    end
  end
end

################## For Category, Subcategory end #####################################
