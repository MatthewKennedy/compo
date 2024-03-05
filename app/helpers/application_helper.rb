module ApplicationHelper
  def erbv_id
    "#{Rails.application.class.module_parent_name.downcase}--#{erbv_name}"
  end

  def erbv_css(&block)
    return if instance_variable_get(erbv_var("css"))

    instance_variable_set(erbv_var("css"), true)
    content_for(:erbv_css, &block)
  end

  def erbv_js(&block)
    return if instance_variable_get(erbv_var("js"))

    instance_variable_set(erbv_var("js"), true)
    content_for(:erbv_js, &block)
  end

  def erbv_var(postfix)
    "@#{Rails.application.class.module_parent_name.downcase}_#{erbv_name}_erbv_#{postfix}"
  end

  def erbv_html(theme: nil, css_vars: nil, &block)
    content_tag(:div, class: "#{erbv_id} #{theme}", style: "css_vars", &block)
  end

  def erbv_name
    caller_locations.each do |location|
      return location.path.split(".").first.split("/").last.sub(/^_/, "") if location&.path&.ends_with?(".erb")
    end
  end

  def erbv_class
    "div.#{erbv_id}"
  end
end
