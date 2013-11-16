module ProposalsHelper

  def category_icon(category)
    case category
    when 'lodging'
      'home'
    when 'services'
      'suitcase'
    when 'goods'
      'gift'
    end
  end

  def category_tag(category)
    icon = category_icon(category)
    "<i class='fa fa-#{icon}'></i>"
  end
end
