module Wego
  module XmlUtils
    def self.get_one_tag_xml(root_name, content)
      response_body = {
      }.to_xml(:root => root_name)
      last = '</' + root_name + '>'
      response_body[0..(response_body.length - last.length - 3)] + content + last
    end
  end
end