module ApplicationHelper
  CATEGORIES = %w[goods lodging services] 

  def markdown(text)
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

  def facebook_auth_path
    "/auth/facebook"
  end
end
