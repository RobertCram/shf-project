
CAPTURE_STRING = '((?:t\(".*\)|"[^"]*")'+'(?:, locale: :\w\w)?)'

Transform /^#{CAPTURE_STRING}$/ do | content |
  if content[0] != 't'
    content[1..-2]
  else
    matcher = content.tr("\"'", '').match('t\((.*)\)(?:, locale: :(\w\w))?')
    key = matcher[1]
    if key.include? ','
      parameters = string_to_hash(key[key.index(',')+1..-1])
      i18n_content(key[0..key.index(',')-1], parameters)
    else
      locale = matcher[2]
      i18n_content(key, locale: locale)
    end
  end
end

def string_to_hash(str, arr_sep=',', key_sep=':')
  array = str.split(arr_sep)
  hash = {}

  array.each do |e|
    key_value = e.split(key_sep)
    hash[key_value[0].strip.to_sym] = key_value[1].strip
  end

  return hash
end

module StepHelpers

  # remove any leading locale path info
  def current_path_without_locale(path)
    locale_pattern =  /^(\/)(en|sv)?(\/)?(.*)$/
    path.gsub(locale_pattern, '\1\4')
  end
end

World(StepHelpers)

# Transform /^#{CAPTURE_STRING_WITH_LOCALE}$/ do | content |
#   key = content.match(CAPTURE_STRING)[1][3..-3]
#   locale = content.match('.*, locale: :(.*)')[1]
#   i18n_content(key, locale: locale)
# end

