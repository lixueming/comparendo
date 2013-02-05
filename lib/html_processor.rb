module HTMLProcessor
  ALLOWED_TAGS = %w(<p> </p> <b> </b> <br> <br/>)

  class << self
    # Filter all html tags except <p>, </p>, <b>, </b>, <br>, <br/>
    def filter_html(text)
      text.gsub(/<.+?>/) do |s|
        s = remove_whitespace(s)
        (ALLOWED_TAGS.include?(s)) ? s : ''
      end
    end

    def remove_whitespace(text)
      text.gsub(/\s/, '')
    end
  end
end