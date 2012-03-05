module Jekyll

  #
  # Render file & gist example
  #
  # Usage:
  #
  # {% example "file_to_expand", gist_id %} =>
  #
  # Raises: Liquid::SyntaxError
  class Example < ::Liquid::Tag

    Syntax = /(#{::Liquid::Expression}+), (#{::Liquid::Expression}+)?/

    def initialize(tag_name, markup, tokens)
      if markup =~ Syntax
        @name = $1
        @gist_id = $2
        @options = {}
        markup.scan(::Liquid::TagAttributes) { |key, value| @options[key.to_sym] = value.gsub(/"|'/, '') }
      else
        raise ::Liquid::SyntaxError.new("Syntax Error in 'link' - Valid syntax: gist <id> <options>")
      end

      super
    end

    def render(context)

    end
  end

  class YardLink < ::Liquid::Tag

    Syntax = /(#{::Liquid::Expression}+)?/

    def initialize(tag_name, markup, tokens)
      if markup =~ Syntax
        @class_name = $1
        @options = {}
        markup.scan(::Liquid::TagAttributes) { |key, value| @options[key.to_sym] = value.gsub(/"|'/, '') }
      else
        raise ::Liquid::SyntaxError.new("Syntax Error in 'link' - Valid syntax: gist <id> <options>")
      end

      super
    end

    def calculate_path full_name
      path = full_name.gsub("::", "/").gsub(".", "#")
      unless is_class?(full_name)
        if is_instance_method?(full_name)
          path += "-instance_method"
        else
          path += "-class_method"
        end
      end
      path
    end

    def is_instance_method? full_name
      !(full_name =~ /\#/).nil?
    end

    def is_class? full_name
      (full_name =~ /\./ || full_name =~ /\#/).nil?
    end

    def render(context)
      %{<a class="highlight" href="http://rubydoc.info/github/ruby-amqp/amqp/master/#{calculate_path(@class_name)}">#{@class_name}</a>}
    end
  end

end


Liquid::Template.register_tag('example', Jekyll::Example)
