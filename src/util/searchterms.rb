#!/usr/bin/env ruby
# ODDB -- oddb -- 05.04.2006 -- hwyss@ywesee.com

module ODDB
	def ODDB.search_term(term)
		term = term.to_s.gsub(/[\/\s\-]+/, ' ')
		term.gsub!(/[,'()]/, '')
		term.tr!('�����������������������������������', 
             'AAAaaacEEEEeeeeIIIIiiiiOOOoooUUUuuu')
		term.gsub!(/�/, 'Ae')
		term.gsub!(/�/, 'ae')
		term.gsub!(/�/, 'Oe')
		term.gsub!(/�/, 'oe')
		term.gsub!(/�/, 'Ue')
		term.gsub!(/�/, 'ue')
		term
	end
	def ODDB.search_terms(words, opts={})
		terms = []
		words.flatten.compact.uniq.inject(terms) { |terms, term| 
      if(opts[:downcase])
        term = term.downcase
      end
			parts = term.split(/[\/-]/)
			if(parts.size > 1)
        terms.push(ODDB.search_term(parts.first))
				terms.push(ODDB.search_term(parts.join))
				terms.push(ODDB.search_term(parts.join(' ')))
			else
				terms.push(ODDB.search_term(term))
			end
			terms
		}.select { |term| 
			                # don't exclude analysis-codes
			term.length > 2 # && !/^[0-9]+$/.match(term)
		}
	end
end
