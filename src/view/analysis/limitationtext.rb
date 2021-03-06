#!/usr/bin/env ruby
# encoding: utf-8
# ODDB::View::Analysis::LimitationText -- oddb.org -- 01.03.2012 -- mhatakeyama@ywesee.com

require 'view/privatetemplate'
require 'view/chapter'
require 'util/pointerarray'

module ODDB
	module View
		module Analysis 
class LimitationTextInnerComposite < HtmlGrid::Composite
	COMPONENTS = {
    [0,0] => :limitation_text
  }
	DEFAULT_CLASS = View::Chapter
  def limitation_text(model, session)
    lang = @session.language.intern
    if model and model.respond_to?(lang.to_sym) and lim = model.send(lang) and lim.respond_to?(:gsub)
      lim.gsub(/^Limitation: /,'')
    end
  end
end
class LimitationTextComposite < HtmlGrid::Composite
	COMPONENTS = {
		[0,0]	=>	:limitation_text_title,
		[0,1]	=>	View::Analysis::LimitationTextInnerComposite,
	}
	CSS_CLASS = 'composite'
	CSS_MAP = {
		[0,0] => 'th',
		[0,1] => 'list',
	}	
	def limitation_text_title(model, session)
    if model and model.respond_to?(:pointer) and lim_ptr = model.pointer\
      and pos_ptr = lim_ptr.parent and position = pos_ptr.resolve(@session.app)\
      and position.respond_to?(:description)
      @lookandfeel.lookup(:limitation_text_title, position.description)
    end
	end
end
class LimitationText < PrivateTemplate
	CONTENT = View::Analysis::LimitationTextComposite
	SNAPBACK_EVENT = :result
end
		end
	end
end
