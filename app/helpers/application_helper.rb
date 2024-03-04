module ApplicationHelper

  def component_id(name)
    "#{Rails.application.class.module_parent_name.downcase}--#{name}"
  end

  def component_css(name, &block)
    return if instance_variable_get(component_instance_var(name))

    instance_variable_set(component_instance_var(name), true)
    content_for :view_component_head do
      yield
    end
  end

  def component_instance_var(name)
    "@#{Rails.application.class.module_parent_name.downcase}_#{name}_erbcv"
  end
end
