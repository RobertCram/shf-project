CAPTURE_STRING = '((?:t\()?"(?:[^"]*)"(?:\))?)'

Transform /^#{CAPTURE_STRING}$/ do | content |
  content[0] == 't' ? i18n_content(content[3..-3]) : content[1..-2]
end


