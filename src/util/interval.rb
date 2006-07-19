#!/usr/bin/env ruby
# Interval -- oddb -- 03.07.2003 -- hwyss@ywesee.com 

module ODDB
	module Interval
		PERSISTENT_RANGE = false
		RANGE_PATTERNS = {
			'a-d'			=>	'a-d����������',
			'e-h'			=>	'e-h��������',
			'i-l'			=>	'i-l��������',
			'm-p'			=>	'm-p��������',
			'q-t'			=>	'q-t',
			'u-z'			=>	'u-z��������',
			#'|unknown'=>	'^a-z������������������������������������������',
			'|unknown'=>	'|unknown',
		}
		FILTER_THRESHOLD = 30
		attr_reader :range
		def filter_interval
			if(@model.size > self::class::FILTER_THRESHOLD)
				@range = self::class::RANGE_PATTERNS.fetch(user_range) {
					self::class::RANGE_PATTERNS[default_interval]
				}
				pattern = if(@range=='|unknown')
					/^($|[^a-z������������������������������������������])/i
				elsif(@range)
					/^[#{@range}]/i
				else
					/^$/
				end
				@filter = Proc.new { |model|
					model.select { |item| 
						pattern.match(item.send(*symbol))
					}
				}
			end
		end
		def default_interval
			intervals.first || 'a-d'
		end
		def get_intervals
			@model.collect { |item| 
				self::class::RANGE_PATTERNS.collect { |range, pattern| 
					range if /^[#{pattern}]/i.match(item.send(*symbol))
				}.compact.first || '|unknown'
			}.flatten.uniq.sort
		end
		def interval
			@interval ||= self::class::RANGE_PATTERNS.index(@range)
		end
		def intervals
			@intervals ||= get_intervals
		end
		def user_range
			range = if(self::class::PERSISTENT_RANGE)
				@session.persistent_user_input(:range)
			else
				@session.user_input(:range)
			end
			unless(self.class.const_get(:RANGE_PATTERNS).include?(range))
				range = default_interval
			end
			range
		end
		def symbol
			:to_s
		end
	end
	module IndexedInterval
		include Interval
		RANGE_PATTERNS = ('a'..'z').to_a.push('0-9')
		def init
			super
			@model = []
			@filter = method(:filter)
		end
		def comparison_value(item)
			item.send(*symbol).to_s.downcase
		end
		def default_interval
		end
		def load_model
			if((tmp_rng = user_range) && tmp_rng != @range)
				@model.clear
				@range = tmp_rng
				parts = @range.split('-')
				if(parts.size == 2)
					parts = ((parts.first)..(parts.last)).to_a
				end
				parts.each { |part|
					@model.concat(index_lookup(part).sort_by { |item| 
						comparison_value(item)
					})
				}
			end
			@model
		end
		def filter(model)
			load_model
		end
		def interval
			@range
		end
		def intervals
			('a'..'z').to_a.push('0-9')
		end
	end
end
