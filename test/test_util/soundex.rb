#!/usr/bin/env ruby
# TestSoundex -- ODDB -- 15.10.2004 -- hwyss@ywesee.com

$: << File.expand_path('../../src', File.dirname(__FILE__))

require 'test/unit'
require 'util/soundex'

module ODDB
	class TestSoundex < Test::Unit::TestCase
		def test_prepare
			assert_equal('essigsaeure', Text::Soundex.prepare('essigs�ure'))
			input = "� � � � � � � � � � � �"
			expected = "ae a a a ae a ae a a a ae a"
			assert_equal(expected, Text::Soundex.prepare(input))
			input = "� �"
			expected = "c c"
			assert_equal(expected, Text::Soundex.prepare(input))
			input = "� � � � � � � �"
			expected = "e e e e e e e e"
			assert_equal(expected, Text::Soundex.prepare(input))
			input = "� � � � � � � �"
			expected = "i i i i i i i i"
			assert_equal(expected, Text::Soundex.prepare(input))
			input = "� � � � � � � � � � � �"
			expected = "oe o o o o o oe o o o o o"
			assert_equal(expected, Text::Soundex.prepare(input))
			input = "� � � � � � � �"
			expected = "ue u u u ue u u u"
			assert_equal(expected, Text::Soundex.prepare(input))
			input = "� � �"
			expected = "p s d"
			assert_equal(expected, Text::Soundex.prepare(input))
			input = "(+)-alpha-Tocopheroli Acetas"
			expected = "alpha Tocopheroli Acetas"
			assert_equal(expected, Text::Soundex.prepare(input))
		end
		def test_soundex
			assert_not_nil(Text::Soundex.soundex('essigs�ure'))
		end
	end
end
