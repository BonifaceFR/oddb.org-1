#!/usr/bin/env ruby
# MedDataTest -- oddb -- 26.11.2004 -- jlang@ywesee.com

$: << File.expand_path('..', File.dirname(__FILE__))
$: << File.expand_path("../../../src", 
	File.dirname(__FILE__))
$: << File.expand_path("../src", File.dirname(__FILE__))

require 'test/unit'
require 'meddata'
require 'flexmock'

module ODDB
	class MedDataTest < Test::Unit::TestCase
    include FlexMock::TestCase
=begin
		def test__dispatch__block
			session = flexmock('Session')
			input = [
				['ctl1', {:name => 'Meier'}],
				['ctl2', {:name => 'M�ller'}],
				['ctl3', {:name => 'Huber'}],
				['ctl4', {:name => 'Klaus'}],
			]
			result = MedData._dispatch(session, input) { |res|
				assert_instance_of(MedData::Result, res)
			}
			assert_nil(result)
		end
		def test__dispatch__no_block
			session = flexmock('Session')
			input = [
				['ctl1', {:name => 'Meier'}],
				['ctl2', {:name => 'M�ller'}],
				['ctl3', {:name => 'Huber'}],
				['ctl4', {:name => 'Klaus'}],
			]
			results = MedData._dispatch(session, input)
			results.each { |result|
				assert_instance_of(MedData::Result, result)
			}
		end
=end
		def test__dispatch
			str = MedData::Result
			instance = str.new('bar', 'baz')
			assert_equal('bar', instance.values)
			assert_equal('baz', instance.ctl)
		end
=begin
		def test_remove_whitespace
			data = {
				:fax =>	"041 111 22 33\240\240",
				:tel =>	nil,
			}
			result = ODDB::MedData.remove_whitespace(data)
			assert_equal("041 111 22 33", result[:fax])
		end
=end
	end
end
