#!/usr/bin/env ruby
# View::TestChapter -- oddb -- 02.10.2003 -- rwaltert@ywesee.com

$: << File.expand_path('..', File.dirname(__FILE__))
$: << File.expand_path("../../src", File.dirname(__FILE__))

require 'test/unit'
require 'view/chapter'
require 'stub/cgi'
require 'model/text'

module ODDB
	module View
		class TestChapter < Test::Unit::TestCase
			def setup 
				@view = View::Chapter.new(:name, nil, nil)
			end	
			def test_escaped_paragraphs
				txt = "Guten Tag! & wie gehts uns Heute? < oder >?"
				par1 = Text::Paragraph.new
				par2 = Text::Paragraph.new
				par1 << txt
				par2 << txt
				par1.preformatted!
				result = @view.paragraphs(CGI.new, [par1, par2])
				expected = <<-EOS
		<PRE>Guten Tag! &amp; wie gehts uns Heute? &lt; oder &gt;?</PRE><BR><SPAN>Guten Tag! &amp; wie gehts uns Heute? &lt; oder &gt;?</SPAN>
				EOS
				assert_equal(expected.strip, result)
			end
			def test_escaped_heading
				chapter = Text::Chapter.new
				chapter.heading = "F�r Zwerge > 1.5 m"
				@view.value = chapter
				expected = '<H3>F�r Zwerge &gt; 1.5 m</H3>'
				result = @view.to_html(CGI.new)
				assert_equal(expected, result)
			end
			def test_escaped_subheading
				chapter = Text::Chapter.new
				section = chapter.next_section
				section.subheading = "F�r Zwerge > 1.5 m"
				@view.value = chapter
				expected = '<DIV>F�r Zwerge &gt; 1.5 m&nbsp;</DIV>'
				result = @view.to_html(CGI.new)
				assert_equal(expected, result)
			end
			def test_formatted_paragraph
				par = Text::Paragraph.new
				par << "Guten "
				par.set_format(:italic)
				par << "Tag"
				par.set_format
				par << "! Guten "
				par.set_format(:bold)
				par << "Abend"
				par.set_format
				par << "! Guten "
				par.set_format(:bold, :italic)
				par << "Morgen!!!"
				par.set_format
				par << " Danke."
				result = @view.paragraphs(CGI.new, [par])
				expected = '<SPAN>Guten<SPAN style="font-style:italic;"> Tag</SPAN>! Guten<SPAN style="font-weight:bold;"> Abend</SPAN>! Guten<SPAN style="font-style:italic; font-weight:bold;"> Morgen!!!</SPAN> Danke.</SPAN>'
				assert_equal(expected, result)
			end
		end
	end
end
