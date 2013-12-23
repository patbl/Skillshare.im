module OffersHelper
  def category_icon(category)
    case category
    when 'lodging'  then 'home'
    when 'services' then 'suitcase'
    when 'goods'    then 'gift'
    end
  end

  def category_tag(category)
    icon = category_icon(category)
    %{<i class="fa fa-#{icon}"></i>}
  end
end
