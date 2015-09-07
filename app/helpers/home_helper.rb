module HomeHelper
  def self.index_view_template
    templates = {
        :general => 'home/index',
        :angular_js => 'home/index_angular_js'
    }
    key = Wego::Settings.value('front_end.ui_framework')
    templates[key.to_sym]
  end
end
