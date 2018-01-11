require "rails/generators/resource_helpers"
class VueGenerator < Rails::Generators::NamedBase
  include Rails::Generators::ResourceHelpers
  source_root File.expand_path('../../generator_templates', __FILE__)
  
  argument :name, :type => :string, :default => "index" 
 
  def vue 
    output = "app/javascript/#{name}/#{name}"    
    pack_output = "app/javascript/packs/#{name}"
    template_path = Vuejs::Engine.root.join("lib", "generators", "generator_templates")
     
    template "#{template_path}/pack.js.erb", "#{pack_output}.js"
    create_vue_component("#{template_path}/index", output)
  end


  private
  def create_vue_component(template_dir, output)
    template "#{template_dir}.vue.erb", "#{output}.vue"
    template "#{template_dir}.js.erb", "#{output}.js"
    copy_file "#{template_dir}.css.erb", "#{output}.css"
  end

  def pluralized_state_name
    name.tableize.camelize(:lower)
  end

  def vue_attributes
    name.camelize.constantize.columns.select { |c| !["id", "created_at", "updated_at"].include?(c.name) }
  end
end
