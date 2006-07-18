#!/usr/bin/env ruby
# AnalysisParse::TestAntibodyListParser -- oddb -- 10.11.2005 -- hwyss@ywesee.com

$: << File.expand_path('../src', File.dirname(__FILE__))

require 'test/unit'
require 'antibody_list_parser'

module ODDB
	module AnalysisParse
		class TestAntibodyListParser < Test::Unit::TestCase
			def setup
				@parser = AntibodyListParser.new
			end
			def test_parse_line__1
				src =<<-EOS
Autoantik�rper gegen b2-Glykoprotein I (IgA)
				EOS
				begin
					result = @parser.parse_line(src)
				rescue AmbigousParseException => e
				end
				expected = {
					:description	=>	'Autoantik�rper gegen b2-Glykoprotein I (IgA)'
				}
				assert_equal(expected, result)
			end
			def test_parse_line__2
				src =<<-EOS
S Autoantik�rper gegen CCP (Cyclisches Citrulliniertes Peptid)? Kapitel 1, Pos. 8113.20
				EOS
				begin
					result = @parser.parse_line(src)
				rescue AmbigousParseException	=> e
					puts e.inspect
				end
				expected = {
					:description	=>	'Autoantik�rper gegen CCP (Cyclisches Citrulliniertes Peptid)? Kapitel 1, Pos. 8113.20',
					:revision			=>	'S',
				}
				assert_equal(expected, result)
			end
			def test_parse_page__1
				src = <<-EOS
4.4 Liste seltener Autoantik�rper
Tarifierung: siehe Pos. 8110.00 ~V 8111.01
Rev. Bezeichnung der Antik�rper
Autoantik�rper gegen b2-Glykoprotein I (IgA)
Autoantik�rper gegen b2-Glykoprotein I (IgG)
Autoantik�rper gegen b2-Glykoprotein I (IgM)
Autoantik�rper gegen 21-Hydroxylase
Autoantik�rper gegen 68 KD (hsp-70)
Autoantik�rper gegen Becherzellen
Autoantik�rper gegen BPI (IgA)
Autoantik�rper gegen BPI (IgG)
S Autoantik�rper gegen CCP (Cyclisches Citrulliniertes Peptid)? Kapitel 1, Pos. 8113.20
Autoantik�rper gegen Chondrozyten
Autoantik�rper gegen Chromatin
Autoantik�rper gegen Cytokeratin 8/18
Autoantik�rper gegen Desmoglein 1
Autoantik�rper gegen Desmoglein 3
Autoantik�rper gegen Elastase
Autoantik�rper gegen Filaggrin (Keratin)
Autoantik�rper gegen Fodrin
Autoantik�rper gegen Gangliosid GQ1B
Autoantik�rper gegen G-S-T
Autoantik�rper gegen Herzmuskel
Autoantik�rper gegen Hu, Yo, Ri
Autoantik�rper gegen IA2
Autoantik�rper gegen Kathepsin
Autoantik�rper gegen Ku
Autoantik�rper gegen Laktoferrin
Autoantik�rper gegen MAG IgM
Autoantik�rper gegen Mi 2
Autoantik�rper gegen Myelin
Autoantik�rper gegen Nukleosomen
Autoantik�rper gegen p53
Autoantik�rper gegen Parathyreoidea
Autoantik�rper gegen PM-Scl
Autoantik�rper gegen Recoverin
Autoantik�rper gegen Retina
Autoantik�rper gegen ribosomale P-Proteine
Autoantik�rper gegen Sulfatidil
121
				EOS
				begin
					result = @parser.parse_page(src, 121)
				rescue AmbigousParseException => e
					puts e.inspect
				end
				expected_first = {
					:description	=>	'Autoantik�rper gegen b2-Glykoprotein I (IgA)'
				}
				expected_last = {
					:description	=>	'Autoantik�rper gegen Sulfatidil'
				}
				expected_size = 36
				assert_equal(expected_first, result.first)
				assert_equal(expected_last, result.last)
				assert_equal(expected_size, result.size)
			end
		end
	end
end
