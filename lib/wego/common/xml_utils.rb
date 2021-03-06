module Wego
  module XmlUtils

    # Public: Get one xml which have 1 tag like
    #     <?xml version="1.0" encoding="UTF-8" ?>
    #     <error>No airline operating between desired locations</error>
    #
    # params root_name       string
    # params content         string
    #
    # return                 xml string
    #
    def self.get_one_tag_xml(root_name, content)
      response_body = {
      }.to_xml(:root => root_name)
      last = '</' + root_name + '>'
      response_body[0..(response_body.length - last.length - 3)] + content + last
    end
  end
end