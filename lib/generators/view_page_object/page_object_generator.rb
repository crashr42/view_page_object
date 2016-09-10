module ViewPageObject
  class PageObjectGenerator < Rails::Generators::Base
    argument :controller, type: :string

    def create_page_object
      args.each do |action|
        create_file "app/page_objects/#{controller}/#{action}_page_object.rb" do
          out    = []
          spaces = ''

          controller_namespaces = controller.split('/')
          controller_namespaces.each_with_index do |namespace, index|
            out << sprintf('%smodule %s', spaces = ' ' * index * 2, namespace.capitalize)
          end

          out << "#{spaces}  class #{action.capitalize}PageObject"
          out << "#{spaces}    include ViewPageObject::Base"
          out << "#{spaces}    "
          out << "#{spaces}    def action"
          out << "#{spaces}      content_tag :h1, \"I'am action `#{action}` from controller `#{controller}!`\""
          out << "#{spaces}    end"
          out << "#{spaces}  end"

          controller_namespaces.each_with_index do |namespace, index|
            out << sprintf('%send', ' ' * (controller_namespaces.size - index - 1) * 2, namespace.capitalize)
          end

          (out << '').join("\n")
        end
      end
    end
  end
end
