#!/usr/bin/env ruby
# FachinfoInvoicer -- oddb -- 28.04.2006 -- hwyss@ywesee.com

require 'plugin/plugin'

module ODDB
	class FachinfoInvoicer < Plugin
		def initialize(*args)
			super
			@companies = {}
		end
		def run(day1)
			day2 = day1 + 1
			time1 = Time.local(day1.year, day1.month, day1.day)
			time2 = Time.local(day2.year, day2.month, day2.day)
			range = (time1...time2)
			modified = @app.fachinfos.values.select { |fi| 
				fi.change_log.reverse.any? { |item|
					range.include?(item.time)
				}
			}
			modified.each { |fi|
				(@companies[fi.company_name] ||= []).push(fi)
			}
		end
		def report
			report = super
			@companies.sort.each { |company_name, fachinfos|
				report << company_name << "\n"
				fachinfos.sort_by { |fi| fi.name_base }.each { |fi|
					report << sprintf("%s:\n  http://www.oddb.org/de/gcc/resolve/pointer/%s\n",
												fi.name_base, fi.pointer) 
				}
				report << "\n"
			}
			(report.empty?) ? "Es wurden keine FI editiert" : report
		end
	end
end