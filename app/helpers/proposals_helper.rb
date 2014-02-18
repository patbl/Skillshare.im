module ProposalsHelper
  def category_icon(category)
    case category
    when 'lodging'  then 'home'
    when 'services' then 'suitcase'
    when 'goods'    then 'gift'
    end
  end

  def category_tag(category)
    fa_tag(category_icon(category))
  end

  def fa_tag(icon, text = nil)
    text &&= " " + text
    %(<i class="fa fa-#{icon}"></i>#{text}).html_safe
  end
end
