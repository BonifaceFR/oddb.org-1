#!/usr/bin/env ruby
# View::Analysis::Position -- oddb.org -- 23.06.2006 -- sfrischknecht@ywesee.com

require 'htmlgrid/urllink'
require 'view/additional_information'
require 'view/dataformat'
require 'view/pointervalue'
require 'view/privatetemplate'
require 'view/analysis/result'
require 'view/resultfoot'
require 'model/analysis/position'
require 'view/analysis/explain_result'

module ODDB
	module View
		module Analysis
class AdditionalInfoComposite < HtmlGrid::Composite
	include View::AdditionalInformation
	CSS_CLASS = 'composite'
	COMPONENTS = {
		[0,0]	=>	'dacapo_title',
	}	
	CSS_MAP = {
		[0,0,2]	=>	'subheading',
	}
	COLSPAN_MAP = {
		[0,0]	=> 2,
	}
	DEFAULT_CLASS = HtmlGrid::Value
	LEGACY_INTERFACE = false
	LABELS = true
	def init
		counter = 1
		if(@model.info_description)
			components.update([0, counter]	=>	:info_description)
			counter += 1
		end
		if(@model.info_interpretation)
			components.update([0, counter]	=>	:info_interpretation)
			counter += 1
		end
		if(@model.info_indication)
			components.update([0, counter]	=>	:info_indication)
			counter += 1
		end
		if(@model.info_significance)
			components.update([0, counter]	=>	:info_significance)
			counter += 1
		end
		if(@model.info_ext_material)
			components.update([0, counter]	=> :info_ext_material)
			counter += 1
		end
		if(@model.info_ext_condition)
			components.update([0, counter]	=>	:info_ext_condition)
			counter += 1
		end
		if(@model.info_storage_condition)
			components.update([0, counter]	=>	:info_storage_condition)
			counter += 1
		end
		if(@model.info_storage_time)
			components.update([0, counter]	=>	:info_storage_time)
			counter += 1
		end
		css_map.update([0,1,1,counter -1]	=>	'list top')
		css_map.update([1,1,1,counter -1]	=>	'list')
		super
	end
end
class PositionInnerComposite < HtmlGrid::Composite
	include View::AdditionalInformation
	include DataFormat
	SYMBOL_MAP = {
		:feedback_label	=>	HtmlGrid::LabelText,
	}
	COMPONENTS	= {
		[0,0]		=>	:code,
		[0,1]		=>	:anonymous,
		[0,2]		=>	:analysis_revision,
		[0,3]		=>	:description,
		[0,4]		=>	:taxpoints,
		[0,5]		=>	:lab_areas,
		[0,6]		=>	:limitation_text,
		[0,7]		=>	:finding,
		[0,8]		=>	:taxnote,	
#		[0,7]		=>	:feedback_label,
#		[1,7]		=>	:feedback,
		[0,9]		=>	:footnote,
	}
	CSS_CLASS = ''
	CSS_MAP = {
		[0,0,1,10]		=>	'list top',
		[1,0,1,10]		=>	'list',
	}
	CSS_STYLE_MAP = {
		[1,0,1,6]		=>	'max-width:250px',
	}
	LABELS = true
	DEFAULT_CLASS = HtmlGrid::Value
	LEGACY_INTERFACE = false
	def anonymous(model, key = :anonymous)
			value = HtmlGrid::Value.new(key, model, @session, self)
			if(model.anonymous)
				value.value = [model.anonymousgroup.dup, model.anonymouspos].join('.')
			end
			value
	end
	def description(model, key = :description)
		value = HtmlGrid::Value.new(key, model, @session, self)
		if(model && (str = model.send(@session.language)))
			value.value = str.gsub(/(\d{4})\.(\d{2})/) {
				group_code = $~[1]
				pos_code = $~[2]
				ptr = Persistence::Pointer.new([:analysis_group, group_code])
				ptr += [:position, pos_code]
				args = {:pointer => ptr}
				'<a class="list" href="' << @lookandfeel._event_url(:resolve, args) << '">' << $~[0] << '</a>'
			}
		end
		value
	end
	def limitation_text(model)
		description(model.limitation_text, :limitation)
	end
	def taxnote(model)
		description(model.taxnote, :taxnote)
	end
	def footnote(model)
		description(model.footnote, :footnote)
	end
	def taxpoints(model, key = :taxpoints)
		value = HtmlGrid::Value.new(key, model, @session, self)
		effective_tax = sprintf("%1.2f", (model.taxpoints.to_i * 0.9).to_s)
		
		value.value = model.taxpoints.to_s << ' (' << model.taxpoints.to_s << ' x 0.90 CHF = ' << effective_tax  << ' CHF)'
		value
	end
end
class Permissions < HtmlGrid::List
	DEFAULT_HEAD_CLASS = 'subheading'
	SORT_HEADER =	false
	CSS_MAP = {
		[0,0,2]	=>	'list',
	}
	COMPONENTS = {
		[0,0]	=>	:specialization,
		[1,0]	=>	:restriction,
	}
end
class PositionComposite < HtmlGrid::Composite
	include ResultFootBuilder
	CSS_CLASS = 'composite'
	EXPLAIN_RESULT = View::Analysis::ExplainResult
	COMPONENTS = {
		[0,0]		=>	'position_details',
		[0,1]		=>	PositionInnerComposite,
		[0,2]		=>	:permissions,
		[0,3]		=>	:additional_info,
		[0,4]		=>	:result_foot,
	}
	CSS_MAP	=	{
		[0,0]		=>	'th',
		[0,1]		=>	'list',
	}
	DEFAULT_CLASS = HtmlGrid::Value
	LEGACY_INTERFACE = false
	def additional_info(model)
		if(info = model.detail_info(:dacapo))
			AdditionalInfoComposite.new(info, @session, self)
		end
	end
	def permissions(model)
		Permissions.new(model.permissions.send(@session.language), @session, self)
	end
end
class Position < View::PrivateTemplate
	CONTENT = PositionComposite
	SNAPBACK_EVENT = :result
end
		end
	end
end