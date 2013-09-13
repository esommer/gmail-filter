#testapp.rb
require 'rubygems'
require 'sinatra'
require 'gmail.rb'

helpers do
  def escape_html(text)
    Rack::Utils.escape_html(text)
  end
end

get '/' do
	@name = "Emily"
	@friends = ["Victoria", "Jen", "Steve", "Vikram", "JJ"]
	erb :index
end

get '/friends' do
	@photoname = "IMG_0883.JPG"
	erb :friends
end

get '/gmailapp' do
	erb :gmailapp
end

post '/gmail_app_backend' do
	safety = Rack::Utils.escape_html(params['formtext'])
	replaced = safety.gsub!('&#x2F;','/') || safety
	output = GmailFilter.new
	output.build_filters(replaced)
	@output = output.output_text
	erb :results
end

post '/download' do
	attachment 'mailfilters.xml'
	params['write_data']
end
