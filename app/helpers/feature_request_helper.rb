module FeatureRequestHelper
  def get_list_options(array, selected)
    result = ''
    array.each do |option_data|
      html_options = { value: option_data[1], tag: option_data.last }
      html_options[:selected] = 'selected' if selected == option_data[1]
      result << content_tag(:option, option_data.first, html_options)
    end
    result.html_safe
  end
end
