module Sinatra
  module FormHelper

    def resource_index_path(resource)
      "/#{pluralize(resource)}"
    end

    def form_open(record, options={})
      if options[:method]
        method = options[:method]
      else
        method = record.persisted? ? 'get' : 'post'
      end
      action = resource_index_path(record.class.to_s.downcase)
      open_form_tag(action, method, record)
    end

    def open_form_tag(action, method, record)
      full_action = [action, record.id].compact.join("/")
      str = ""
      if ['delete', 'patch', 'put'].include?(method)
        str << "<form action='#{full_action}' method='post'>"
        str << "<input type='hidden' name='_method' value='#{method}'>"
      else
        str << "<form action='#{full_action}' method='#{method}'>"
      end
    end

    def input_tag(options={})
      type = options[:type]
      resource = options[:resource]
      name = options[:name]
      value = options[:value]
      placeholder = options[:placeholder]
      "<input type='#{type}' name='#{resource}[#{name}]' value='#{value}' placeholder='#{placeholder}'>"

    end

    def textarea_tag(options={})
      cols = options[:cols]
      rows = options[:rows]
      resource = options[:resource]
      name = options[:name]
      placeholder = options[:placeholder]
      "<textarea name='#{resource}[#{name}]' placeholder='#{placeholder}' cols='#{cols}' rows='#{rows}'></textarea> "
    end

    def form_close
      "</form>"
    end

  end
  helpers FormHelper
end