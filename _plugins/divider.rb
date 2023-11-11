# frozen_string_literal: true

module Jekyll
  class DividerTag < Liquid::Tag
    def render(context)
      "<div class=\"border-b border-gray-200 w-11/12 mx-auto my-[16px]\"></div>"
    end
  end
end

Liquid::Template.register_tag('divider', Jekyll::DividerTag)
