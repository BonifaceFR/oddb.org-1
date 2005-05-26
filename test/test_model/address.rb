#!/usr/bin/env ruby
# TestAddress -- oddb -- 24.02.2003 -- jlang@ywesee.com, usenguel@ywesee.com 

$: << File.expand_path('..', File.dirname(__FILE__))
$: << File.expand_path("../../src", File.dirname(__FILE__))

require 'test/unit'
require 'model/address'

module ODDB
	class TestAddress < Test::Unit::TestCase
		def setup
			@address = ODDB::Address.new
		end
		def test_search_terms__prof
			@address.lines = [
				'Egregio Prof.',
				'Monsieur le Professeur',
				'Claudio Marone',
				'Studio medico',
				'Christoph Profos',
				'Ospedale San Giovanni',
				'6500 Bellinzona' 
			]
			expected = [
				'Claudio Marone',
				'Studio medico',
				'Christoph Profos',
				'Ospedale San Giovanni',
				'6500 Bellinzona' 
			]
			assert_equal(expected, @address.lines_without_title)
		end
		def test_search_terms__dr
			@address.lines = [
				'Herr Dr. med.',
				'Herrn Dr. med.',
				'Frau Dr. med',
				'6500 Bellinzona' 
			]
			expected = [
				'6500 Bellinzona' 
			]
			assert_equal(expected, @address.lines_without_title)
		end
		def test_street__1
			@address.lines = [
				'Herrn Dr. med.',
				'Rolf Hugentobler',
				'Arztpraxis',
				'Stichweg 8',
				'5024 Kuettigen',
			]
			assert_equal('Stichweg', @address.street)
			assert_equal('8', @address.number)
		end
		def test_street__2
			@address.lines = [
				'Ospedale San Giovanni',
				'6500 Bellinzona' 
			]
			assert_equal('Ospedale San Giovanni', @address.street)
			assert_nil(@address.number)
		end
		def test_street__3
			@address.lines = [
				'Herrn Dr. med.',
				'Johannes Andreas Blum',
				'Arztpraxis',
				'Schweiz. Tropeninstitut Basel',
				'Socinstr. 57, Postfach',
				'4002 Basel',
			]
			assert_equal('Socinstr.', @address.street)
			assert_equal('57', @address.number)
		end
		def test_street__4
			@address.lines = [
				'Madame le Docteur',
				'Verena Schweizer-Rohrer',
				'Cabinet medical',
				'4, rte d\'Arnier',
				'1092 Belmont-Lausanne',
			]
			assert_equal('rte d\'Arnier', @address.street)
			assert_equal('4', @address.number)
		end
		def test_street__5
			@address.lines = [
				'Herrn Dr. med.',
				'Bernhard Hugentobler',
				'Arztpraxis',
				'Muhlernstr. 244A',
				'3098 Schliern b. Koenitz',
			]
			assert_equal('Muhlernstr.', @address.street)
			assert_equal('244A', @address.number)
		end
		def test_street__5_lines_hack
			@address.lines = [
				'Herrn Dr. med.',
				'Bernhard Hugentobler',
				'Arztpraxis',
				'Muhlernstr. 244A',
				'3098 Schliern b. Koenitz',
				'',
			]
			assert_equal('Muhlernstr.', @address.street)
			assert_equal('244A', @address.number)
		end
		def test_plz_city
			@address.lines = [
				'Herrn Dr. med.',
				'Bernhard Hugentobler',
				'Arztpraxis',
				'Muhlernstr. 244A',
				'3098 Schliern b. Koenitz',
			]
			assert_equal('Schliern b. Koenitz', @address.city)
			assert_equal('3098', @address.plz)
		end
		def test_plz_city_lines_hack
			@address.lines = [
				'Herrn Dr. med.',
				'Bernhard Hugentobler',
				'Arztpraxis',
				'Muhlernstr. 244A',
				'3098 Schliern b. Koenitz',
				'',
			]
			assert_equal('Schliern b. Koenitz', @address.city)
			assert_equal('3098', @address.plz)
		end
	end
end
