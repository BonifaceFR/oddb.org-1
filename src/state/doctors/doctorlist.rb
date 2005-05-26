#!/usr/bin/env ruby
# State::Doctors::DoctorList -- oddb -- 26.05.2003 -- maege@ywesee.com

require 'state/doctors/global'
require 'state/doctors/doctor'
require 'view/doctors/doctorlist'
require 'model/doctor'
require 'model/user'
require 'sbsm/user'

module ODDB
	module State
		module Doctors
class DoctorList < State::Doctors::Global
	DIRECT_EVENT = :doctorlist
	VIEW = View::Doctors::Doctors
	RANGE_PATTERNS = {
		'a-d'			=>	'a-d����������',
		'e-h'			=>	'e-h��������',
		'i-l'			=>	'i-l',
		'm-p'			=>	'm-p��������',
		'q-t'			=>	'q-t',
		'u-z'			=>	'u-z��������',
		'unknown'	=>	'unknown',
	}
	#REVERSE_MAP = ResultList::REVERSE_MAP
	def init
		super
		@model = @session.app.doctors.values
=begin
		userrange = @session.user_input(:range) || default_interval
		range = RANGE_PATTERNS.fetch(userrange)
		@filter = Proc.new { |model|
			model.select { |doc| 
				if(range=='unknown')
					doc.name =~ /^[^'a-z��������������������������']/i
				else
					/^[#{range}]/i.match(comp.name)
				end
			}
		}
		@range = range
=end
	end
	def default_interval
		intervals.first
	end
	def get_intervals
		@model.collect { |doctor| 
			rng = RANGE_PATTERNS.select { |key, pattern| 
				/^[#{pattern}]/i.match(doctor.name)
			}.first
			rng.nil? ? 'unknown' : rng.first
		}.compact.uniq.sort
	end
	def interval
		@interval ||= self::class::RANGE_PATTERNS.index(@range)
	end	
	def intervals
		@intervals ||= get_intervals
	end	
end
		end
	end
end
