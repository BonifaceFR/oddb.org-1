#!/usr/bin/env ruby
# View::Admin::CommercialForm -- de.oddb.org -- 24.11.2006 -- hwyss@ywesee.com

require 'view/privatetemplate'

module ODDB
  module View
    module Admin
class CommercialFormForm < View::DescriptionForm
  COMPONENTS = {
    [2,0]  =>  :package_count,
  }
  CSS_MAP = {
    [3,0]  =>  'list right'
  }
  SYMBOL_MAP = {
    :package_count =>  HtmlGrid::Value,
  }
  def languages
    super + ['synonym_list']
  end
end
class CommercialFormComposite < HtmlGrid::Composite
  COMPONENTS = {
    [0,0] => 'commercial_form',
    [0,1] => CommercialFormForm,
  }
  CSS_MAP = {
    [0,0] => 'th'
  }
  CSS_CLASS = 'composite'
end
class CommercialForm < PrivateTemplate
  CONTENT = CommercialFormComposite
  SNAPBACK_EVENT = :commercial_forms
end
    end
  end
end