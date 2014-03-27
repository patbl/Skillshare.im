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

  def fa_tag(icon, text: nil, tooltip: nil)
    text &&= " " + text
    tooltip &&= %(rel="tooltip" title="#{tooltip}" )
    %(<i #{tooltip}class="fa fa-#{icon}"></i>#{text}).html_safe
  end

  def wanted_icon
    "rotate-right"
  end

  def offer_icon
    "gift"
  end

  def filtered_proposal_path(category = nil)
    type = params[:type].underscore.pluralize
    path = "#{type}_path"
    public_send(path, category: category)
  end
end
