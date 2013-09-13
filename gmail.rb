class Filter

  def initialize (name, emails, terms = nil)
  	@name = name.strip
  	@emails = emails.strip.split(',')
  	@emails.each {|email| email.strip!}
  	if terms
  	  @terms = terms.strip.split(',')
  	  @terms.each do |term| 
  	  	term.strip!
  	  	term.gsub!('"','&quot;')
  	  end
  	end
  end

  def build_it
  	filter = "
  	<entry>
		<category term='filter'></category>
		<title>Mail Filter</title>
		<id></id>
		<updated></updated>
		<content></content>
		<apps:property name='to' value='#{@emails.join(' OR ')}'/>
		<apps:property name='label' value='#{@name}'/>
	</entry>
	<entry>
		<category term='filter'></category>
		<title>Mail Filter</title>
		<id></id>
		<updated></updated>
		<content></content>
		<apps:property name='from' value='#{@emails.join(' OR ')}'/>
		<apps:property name='label' value='#{@name}'/>
	</entry>"
	if @terms
	  filter += "
  	<entry>
		<category term='filter'></category>
		<title>Mail Filter</title>
		<id></id>
		<updated></updated>
		<content></content>
		<apps:property name='hasTheWord' value='#{@terms.join(', ')}'/>
		<apps:property name='label' value='#{@name}'/>
	</entry>"
	end
	return filter
  end

end

class GmailFilter

  attr_reader :output_text

  def initialize
  	@output_text = "<?xml version='1.0' encoding='UTF-8'?>
  	<feed xmlns='http://www.w3.org/2005/Atom' xmlns:apps='http://schemas.google.com/apps/2006'>
	<title>Mail Filters</title>
		"
	@filename = ''
	@text_string = ''
  end

  def build_from_filename
  	print 'Input filename: '
  	@filename = gets.strip
  	@text_string = IO.read(@filename)
  end

  def build_filters(text_string = nil)
  	#call directly with a text string
  	if text_string
  	  @text_string = text_string
  	end
  	text_array = @text_string.split(/\n/)
  	text_array.each do |line|
	  if (line[0,2] == '//' || line == '' || line == nil)
	  else
	    label, searches = line.split(':')
	    if searches
	      emails, terms = searches.split('|')
	      filter = Filter.new(label, emails, terms)
	      @output_text += filter.build_it
	    end
	  end
	end
	@output_text += "

</feed>"
  end

  def export_filters_to_file 	
	File.open('mailfilters.xml','w') do |file|
	  file.puts @output_text
	end
  end

end

#___________________________

#EXAMPLE USES:

#Reading from existing file, user is prompted for filename:
#output = GmailFilter.new
#output.build_from_filename
#output.build_filters
#puts output.output_text

#Reading from directly input text:
#output = GmailFilter.new
#output.build_filters('thislabel: emily.sommer@gmail.com, another@email.com; "this search phrase"')
#puts output.output_text