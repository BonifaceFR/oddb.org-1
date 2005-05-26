#!/usr/bin/env ruby
# SubstancesState -- oddb -- 25.05.2004 -- maege@ywesee.com

require 'state/global_predefine'
require 'util/interval'
require 'view/substances'

module ODDB
	class SubstancesState < GlobalState
		include Interval
		VIEW = SubstanceListView
		DIRECT_EVENT = :substances
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
			'unknown'	=>	'unknown',
		}
	end
end
