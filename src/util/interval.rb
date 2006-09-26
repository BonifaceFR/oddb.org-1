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
		def default_interval
			intervals.first || 'a-d'
		end
		def filter_interval
			if(@model.size > self::class::FILTER_THRESHOLD)
        ptrns = range_patterns
				@range = ptrns.fetch(user_range) {
					ptrns[default_interval]
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
		def get_intervals
			@model.collect { |item| 
				range_patterns.collect { |range, pattern| 
					range if /^[#{pattern}]/i.match(item.send(*symbol))
				}.compact.first || '|unknown'
			}.flatten.uniq.sort
		end
		def interval
			@interval ||= range_patterns.index(@range)
		end
		def intervals
			@intervals ||= get_intervals
		end
    def range_patterns
      self.class.const_get(:RANGE_PATTERNS)
    end
		def user_range
			range = if(self::class::PERSISTENT_RANGE)
				@session.persistent_user_input(:range)
			else
				@session.user_input(:range)
			end
			unless(intervals.include?(range))
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
				parts = @range = tmp_rng
				if(@range == '0-9')
					intervals
					parts = @numbers
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
		def index_lookup(query)
			ODBA.cache.retrieve_from_index(index_name, query)
		end
		def index_name
		end
		def intervals
			@intervals or begin
				values = ODBA.cache.index_keys(index_name, 1)
				@intervals, @numbers = values.partition { |char|
					/[a-z]/i.match(char)
				}
				unless(@numbers.empty?)
					@intervals.push('0-9')
				end
				@intervals
			end
		end
	end
end
