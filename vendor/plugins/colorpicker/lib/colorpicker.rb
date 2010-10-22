module ApplicationHelper
  def colorpicker_include_tag
    content = stylesheet_link_tag("colorPicker", :media => :all) + "\n"
    content += javascript_include_tag("yahoo.color.js") + "\n"
    content += javascript_include_tag("colorPicker") + "\n"
    content
  end

  def colorpicker_input_tag(object_name, method, options = {})
    content = "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td>"
    content += text_field(object_name, method, :size => 7)
    content += "</td><td>"
    swatch_id = "#{object_name}_#{method}_swatch"
    content += "<button style=\"width: 1.5em; height: 1.5em; border: 1px outset #666;\" id=\"#{swatch_id}\" class=\"colorbox\"></button>"
    content += "</td></tr></table>"
    content
  end

  def colorpicker_initialize(fields, options = {})
    fields_js = "[\"" + fields.to_a.join("\",\"") + "\"]"
    content = <<-INITIALIZE_JS
<script type="text/javascript" defer="true">
// <![CDATA[
#{fields_js}.each(function(idx) {
	new Control.ColorPicker(idx, { "swatch" : idx + "_swatch", IMAGE_BASE : "/images/colorpicker/" });
});
// ]]>
</script>
INITIALIZE_JS
  end

end