#!/usr/bin/env ruby
# State::Companies::FiPiCsv -- de.oddb.org -- 04.12.2006 -- hwyss@ywesee.com

require 'state/global_predefine'
require 'view/companies/fipi_csv'

module ODDB
  module State
    module Companies
class FiPiCsv < Global
  VOLATILE = true
  VIEW = View::Companies::FiPiCsv
end
    end
  end
end