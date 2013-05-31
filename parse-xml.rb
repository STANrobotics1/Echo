require 'nokogiri'
require 'pp' # pretty print

class Nokogiri::XML::Node
  # TODO: There's probably a built-in function that does this
  def select_Element
    self.children.select { |x| Nokogiri::XML::Element === x }[0]
  end
end

class Nokogiri::XML::NodeSet
  # TODO: There's probably a built-in function that does this
  def plaintext_for_title title
    self.select { |x| 
      x.attr("title") == title 
    }[0].select_Element.select_Element.children[0]
  end
end

def parse_xml_file filename
  doc = Nokogiri::XML(File.open(filename, "r"))
  pods = doc.xpath("//pod")
  [pods.plaintext_for_title("Input"), 
   pods.plaintext_for_title("Result") ]

end

# TODO: Right now this only correctly parses results that follow 
# a specific format. It works for factorial.xml but not 
# malaysia.xml

puts parse_xml_file("xml_test/factorial.xml")
