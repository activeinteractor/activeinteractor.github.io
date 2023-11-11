# frozen_string_literal: true

module Jekyll
  class HeaderTag < Liquid::Tag
    TEXT_SIZE = {
      '1' => 'text-4xl',
      '2' => 'text-2xl'
    }.freeze

    def initialize(tag_name, input, parse_context)
      super
      @text = input.split('|')[0].strip
      @options = input.split('|').drop(1).map(&:strip)
    end

    def render(context)
      "<h#{size} class=\"#{TEXT_SIZE[size]} font-bold #{classes}\">#{@text}</h#{size}>"
    end

    private

    def classes
      @classes ||= @options.find { |o| o.include?('class:') }&.gsub('class:', '')&.strip
    end

    def size
      @size ||= @options.find { |o| o.include?('size:') }&.gsub('size:', '')&.strip
    end
  end
end

Liquid::Template.register_tag('heading', Jekyll::HeaderTag)
