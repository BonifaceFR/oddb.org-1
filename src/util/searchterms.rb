#!/usr/bin/env ruby
# ODDB -- oddb -- 05.04.2006 -- hwyss@ywesee.com

module ODDB
	def ODDB.search_term(term)
		term = term.to_s.gsub(/\s+/, ' ')
		term.gsub!(/[,'\-]/, '')
		term.gsub!(/[���]/, 'A')
		term.gsub!(/[���]/, 'a')
		term.gsub!(/�/, 'Ae')
		term.gsub!(/�/, 'ae')
		term.gsub!(/�/, 'c')
		term.gsub!(/[����]/, 'E')
		term.gsub!(/[����]/, 'e')
		term.gsub!(/[����]/, 'I')
		term.gsub!(/[����]/, 'i')
		term.gsub!(/���/, 'O')
		term.gsub!(/���/, 'o')
		term.gsub!(/�/, 'Oe')
		term.gsub!(/�/, 'oe')
		term.gsub!(/���/, 'U')
		term.gsub!(/���/, 'u')
		term.gsub!(/�/, 'Ue')
		term.gsub!(/�/, 'ue')
		term
	end
	def ODDB.search_terms(words)
		terms = []
		words.flatten.compact.uniq.inject(terms) { |terms, term| 
			parts = term.split('-')
			if(parts.size > 1)
				terms.push(ODDB.search_term(parts.join))
				terms.push(ODDB.search_term(parts.join(' ')))
			else
				terms.push(ODDB.search_term(term))
			end
			terms
		}.select { |term| 
			term.length > 2 && !/^[0-9]+$/.match(term)
		}
	end
end
