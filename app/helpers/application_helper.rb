module ApplicationHelper
  def us_states_options
    [
      ['Alabama', 'AL'], ['Alaska', 'AK'], ['Arizona', 'AZ'], ['Arkansas', 'AR'], 
      ['California', 'CA'], ['Colorado', 'CO'], ['Connecticut', 'CT'], 
      ['Delaware', 'DE'], ['Florida', 'FL'], ['Georgia', 'GA'], ['Hawaii', 'HI'], 
      ['Idaho', 'ID'], ['Illinois', 'IL'], ['Indiana', 'IN'], ['Iowa', 'IA'], 
      ['Kansas', 'KS'], ['Kentucky', 'KY'], ['Louisiana', 'LA'], ['Maine', 'ME'], 
      ['Maryland', 'MD'], ['Massachusetts', 'MA'], ['Michigan', 'MI'], 
      ['Minnesota', 'MN'], ['Mississippi', 'MS'], ['Missouri', 'MO'], 
      ['Montana', 'MT'], ['Nebraska', 'NE'], ['Nevada', 'NV'], 
      ['New Hampshire', 'NH'], ['New Jersey', 'NJ'], ['New Mexico', 'NM'], 
      ['New York', 'NY'], ['North Carolina', 'NC'], ['North Dakota', 'ND'], 
      ['Ohio', 'OH'], ['Oklahoma', 'OK'], ['Oregon', 'OR'], 
      ['Pennsylvania', 'PA'], ['Rhode Island', 'RI'], ['South Carolina', 'SC'], 
      ['South Dakota', 'SD'], ['Tennessee', 'TN'], ['Texas', 'TX'], 
      ['Utah', 'UT'], ['Vermont', 'VT'], ['Virginia', 'VA'], 
      ['Washington', 'WA'], ['West Virginia', 'WV'], ['Wisconsin', 'WI'], 
      ['Wyoming', 'WY']
    ]
  end

  def set_meta_tags(title: nil, description: nil, image: nil)
    content_for :meta_tags do
      tags = []
      # Make sure image URL is absolute
      image = Rails.application.routes.url_helpers.url_for(image) if image.present?
      
      # Open Graph tags
      tags << tag(:meta, property: 'og:title', content: title) if title
      tags << tag(:meta, property: 'og:description', content: description) if description
      tags << tag(:meta, property: 'og:image', content: image) if image
      tags << tag(:meta, property: 'og:type', content: 'website')
      
      # Twitter Card tags
      tags << tag(:meta, name: 'twitter:card', content: 'summary_large_image')
      tags << tag(:meta, name: 'twitter:title', content: title) if title
      tags << tag(:meta, name: 'twitter:description', content: description) if description
      tags << tag(:meta, name: 'twitter:image', content: image) if image
      
      tags.join("\n").html_safe
    end
  end
end 