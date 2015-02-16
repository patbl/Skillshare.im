module WordBreakHelper
  # Break up any words longer than `width` characters with `<wbr>` tags, which
  # tell the browser that it's OK to break at that point in the word.
  #
  # For text that won't have any URLs in it, we used to use the `&shy;` entity
  # instead, but we stopped because Nokogiri was eating them.
  # TODO: produce just <wbr> instead of <wbr></wbr>
  #
  # @param [String, ActiveSupport::SafeBuffer] text The text to wrap.
  # @param [Fixnum] width The number of characters to wrap to.
  # @option options [String] :separator_text ("<wbr>") The text to add at break points.
  #
  def break_words(content, width = 40, options = {})
    separator_text = options.fetch(:separator_text) { '<wbr>' }
    # Escape the HTML, without affecting already escaped entities.
    # Note that this calls #to_s on its argument.
    if options.fetch(:escape_first) { true }
      content = ERB::Util.html_escape_once(content).to_str
    end

    if content.blank?
      ''
    else
      doc = Nokogiri::HTML.fragment(content)

      if doc.content.mb_chars.length <= width
        doc.to_html.html_safe
      else
        separator = Nokogiri::HTML.fragment(separator_text)
        new_doc = Nokogiri::HTML.fragment('')

        doc.children.each do |ch|
          WordBreakHelper.clone_with_wordwrap(new_doc, ch, width, separator)
        end

        new_doc.to_html.html_safe
      end
    end
  end

  def self.clone_with_wordwrap(new_parent, node, width, separator)
    if node.text? && (node.parent.name.downcase != 'pre') && ( (chars = node.content.mb_chars) =~ /\S{#{width}}/ )
      snippet_chars = []

      chars.each_char do |ch|
        snippet_chars << ch

        if ch.to_s.blank?
          new_parent << Nokogiri::XML::Text.new(snippet_chars.join, new_parent.document)
          snippet_chars = []
        elsif snippet_chars.size >= width
          new_parent << Nokogiri::XML::Text.new(snippet_chars.join, new_parent.document)
          new_parent << separator.dup
          snippet_chars = []
        end
      end

      if snippet_chars.size > 0
        new_parent << Nokogiri::XML::Text.new(snippet_chars.join, new_parent.document)
      end
    else
      new_node = node.dup(0) #shallow
      new_parent << new_node

      node.attributes.each do |name, value|
        new_node[name] = value
      end

      node.children.each do |ch|
        clone_with_wordwrap(new_node, ch, width, separator)
      end
    end
  end
end
