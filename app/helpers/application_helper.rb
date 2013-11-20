module ApplicationHelper
  CATEGORIES = %w[services lodging goods]

  def markdown(text)
    text ||= ""
    markdown_options = {
      no_intra_emphasis: true,
      autolink: true,
      lax_spacing: true,
      quote: true
    }
    html_options = { safe_links_only: true }
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(html_options), markdown_options)
    renderer.render(text).html_safe
  end

  def alert_type(level)
    case level
    when :notice  then "alert alert-info"
    when :success then "alert alert-success"
    when :alert   then "alert alert-warning"
    when :error   then "alert alert-danger"
    end
  end

  def active?(path)
    "active" if current_page?(path)
  end
end
