module SweetStaging
  module ApplicationHelper
    def icon(name)
      # https://www.iconfinder.com/iconsets/vivid
      raw File.read(File.expand_path(File.dirname(__FILE__) +  "/../../assets/images/#{name}.svg"))
    end

    def insert_css_file(file)
      raw "<style>#{raw File.read File.expand_path(File.dirname(__FILE__) + "/../../views/sweet_staging/stylesheets/#{file}")}</style>"
    end

    def insert_js_file(file)
      raw "<script>#{raw File.read File.expand_path(File.dirname(__FILE__) + "/../../views/sweet_staging/javascripts/#{file}")}</script>"
    end

    def format_datetime(e)
      e.strftime("%Y-%m-%d %H:%M:%S")
    end

    def active?(section)
      case section
      when :dashboard
        "is-active" if controller_name == "home" && action_name == "index"
      end
    end
  end
end