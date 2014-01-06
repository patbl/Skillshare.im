module ApplicationHelper
  CATEGORIES = %w[services lodging goods]

  def markdown(text)
    text ||= ""
    markdown_renderer.render(text).html_safe
  end

  def markdown_renderer
    markdown_options = {
      no_intra_emphasis: true,
      autolink: true,
      lax_spacing: true,
      quote: true
    }
    html_options = { filter_html: true }
    Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(html_options), markdown_options)
  end

  def alert_type(level)
    case level
    when :notice  then "alert alert-info"
    when :success then "alert alert-success"
    when :alert   then "alert alert-warning"
    when :error   then "alert alert-danger"
    end
  end

  def active?(path = nil, **options)
    return "active" if current_page? path
  end

  def title(page_title)
    default_page_title = "Sharing Between Effective Alruists"
    content_for(:title)  { page_title }
  end

  def avatar_url(user, size = "large")
    if user.avatar_url
      "#{user.avatar_url}?type=#{size}"
    else
      # default Gravatar doesn't display locally
      default_url = "#{request.protocol}#{request.host_with_port}#{asset_path('avatar_placeholder.gif')}"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      dimensions = case size
                   when "square"
                   when "small" then "s=50"
                   when "normal" then "s=100"
                   when "large" then "s=200"
                   end
      "http://gravatar.com/avatar/#{gravatar_id}.png?#{dimensions}&d=#{CGI.escape(default_url)}"
    end
  end
end
