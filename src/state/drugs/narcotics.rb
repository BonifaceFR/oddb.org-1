#!/usr/bin/env ruby
#State::Drugs::Narcotics  -- oddb -- 16.11.2005 -- spfenninger@ywesee.com


require 'state/global_predefine'
require 'util/interval'
require 'view/drugs/narcotics'

module ODDB
	module State
		module Drugs
class Narcotics < State::Drugs::Global
	include Interval
	VIEW = View::Drugs::Narcotics
	DIRECT_EVENT = :narcotics
	PERSISTENT_RANGE  = true
	RANGE_PATTERNS = {
		'a'			=>	'a��������',
		'b'			=>	'b',
		'c'			=>	'c��',
		'd'			=>	'd',
		'e'			=>	'e��������',
		'f'			=>	'f',
		'g'			=>	'g',
		'h'			=>	'h',
		'i'			=>	'i',
		'j'			=>	'j',
		'k'			=>	'k',
		'l'			=>	'l',
		'm'			=>	'm',
		'n'			=>	'n',
		'o'			=>	'o��������',
		'p'			=>	'p',
		'q'			=>	'q',
		'r'			=>	'r',
		's'			=>	's',
		't'			=>	't',
		'u'			=>	'u��������',
		'v'			=>	'v',
		'w'			=>	'w',
		'x'			=>	'x',
		'y'			=>	'y',
		'z'			=>	'z',
		'|unknown'=>	'|unknown',
	}
	Limited = true
	def init
		@model = @session.narcotics.values
		filter_interval
	end
end
		end
	end
end
