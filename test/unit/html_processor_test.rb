require 'test_helper'

class HTMLProcessorTest < ActiveSupport::TestCase
  test "remove_whitespace" do
    self.assert_equal '<br/>', HTMLProcessor::remove_whitespace('<br />')
    self.assert_equal '<p>', HTMLProcessor::remove_whitespace('   <   p >  ')
  end

  test "filter_html" do
    self.assert_equal 'Title <p>Text1</p> <br/> <p>Text2</p> <br> <b>Subsection</b>',
                      HTMLProcessor::filter_html('<h1 >Title</h1 > <p >Text1</p > <br /> <p>Text2</p> <br  > <b>Subsection</ b>')
  end
end