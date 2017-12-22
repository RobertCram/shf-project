require 'spec_helper'
require_relative(File.join( SERVICES_PATH, 'url_sanitizer'))


RSpec.describe URLSanitizer  do

  it 'handles nil' do
    expect(URLSanitizer.sanitize(nil)).to eq ''
  end


  it 'removes javascript' do
    expect(URLSanitizer.sanitize('blorfo///"javascript//"')).to eq 'blorfo///"//"'
  end

  it 'uses Sanitizer to remove CSS tags' do
    expect(URLSanitizer.sanitize('<STYLE>@import"alert(\'XSS\')";</STYLE>')).to eq '@import"alert(\'XSS\')";'
  end

  it 'uses Santizer to remove anything inside a tag' do
    expect(URLSanitizer.sanitize('<IMG SRC="javascript:alert(\'XSS\');">')).to eq ''
  end


  it 'uses remove tags and javascript' do
    expect(URLSanitizer.sanitize('<STYLE>@import"javascript:alert(\'XSS\')";</STYLE>')).to eq '@import":alert(\'XSS\')";'
  end


end
