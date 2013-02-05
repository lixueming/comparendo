module CompanyHelper
  def company_city_name_or_default(company)
      company.city.present?  ? company.city.name : "(undefined city)"
  end

  def google_points_as_json
   points = Company.sponsors.map { |sponsor| {:latitude => sponsor.latitude, :longitude => sponsor.longitude, :name => sponsor.name, :city_name=> sponsor.city_name, :url=>url_to_company(sponsor) } }
    @companies.each do |company|
     if company.latitude and company.longitude
          points << {:latitude => company.latitude, :longitude => company.longitude, :name => company.name, :city_name=> company.city_name, :url=>url_to_company(company)}
     end
    end
   points = points.to_json if points
   points
  end
end
