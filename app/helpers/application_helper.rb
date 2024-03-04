module ApplicationHelper
  def erbvc_id
    "#{Rails.application.class.module_parent_name.downcase}--#{erbvc_name}"
  end

  def erbvc_css(&block)
    return if instance_variable_get(erbvc_var)

    instance_variable_set(erbvc_var, true)
    content_for :erb_view_component_head_css do
      yield
    end
  end

  def erbvc_var
    "@#{Rails.application.class.module_parent_name.downcase}_#{erbvc_name}_erbcv"
  end

  def erbvc_html(theme: nil, css_vars: nil, &block)
    content_tag(:div, class: "#{erbvc_id} #{theme}", style: "css_vars", &block)
  end

  def erbvc_name
    caller_path.split(".").first.split("/").last.sub(/^_/, "")
  end

  def caller_path
    caller_locations(2, 1).first.path
  end

  def erbvc_container_class
    "div.#{erbvc_id}"
  end
end
