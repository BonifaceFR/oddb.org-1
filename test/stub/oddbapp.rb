#!/usr/bin/env ruby
# encoding: utf-8
# OddbApp -- oddb -- 09.04.2012 -- yasaka@ywesee.com
# OddbApp -- oddb -- 18.11.2002 -- hwyss@ywesee.com 

require 'syck'
require 'yaml'
YAML::ENGINE.yamler = "syck"
require 'util/oddbapp'

class OddbPrevalence
	attr_accessor :registrations, :galenic_groups, :galenic_forms, :substances
	attr_accessor :indications, :atc_classes, :companies, :generic_groups, :doctors
	attr_accessor :incomplete_registrations, :log_groups
	attr_accessor :last_update, :doctors
	attr_accessor :last_medication_update
	attr_reader :sequence_index, :indication_index, :substance_index
	attr_reader :patinfos
	attr_writer :fachinfos, :orphaned_patinfos, :indices_therapeutici, :invoices, :minifis, :migel_groups, :orphaned_fachinfos, :patinfos, :registrations, :substances, :commercial_forms, :address_suggestions, :atc_classes, :users, :feedbacks, :narcotics, :analysis_groups, :slates, :hospitals, :sponsors
	attr_writer :substance_index, :soundex_substances
	#public :rebuild_indices
	def all_soundex_substances
		@soundex_substances
	end
end
module ODDB
	ODDB_VERSION = 'version'
	class App < SBSM::DRbServer
		remove_const :RUN_CLEANER
		remove_const :RUN_UPDATER
		RUN_CLEANER = false
		RUN_EXPORTER = false
		RUN_UPDATER = false
	end
end
