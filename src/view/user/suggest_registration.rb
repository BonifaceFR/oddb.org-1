#!/usr/bin/env ruby
# View::User::SuggestRegistration -- oddb -- 29.11.2005 -- hwyss@ywesee.com

require 'view/admin/registration'
require 'util/persistence'

module ODDB
	module View
		module User
class StepList < HtmlGrid::List
	CSS_MAP = {
		[0,0]	=> 'subheading'
	}
	COMPONENTS = {
		[0,0]	=>	:step,
	}
	LEGACY_INTERFACE = false
end
class SuggestRegistrationForm < View::Admin::RegistrationForm
	include HtmlGrid::ErrorMessage
	DEFAULT_CLASS = HtmlGrid::InputText
	EVENT = :update
	COMPONENTS = {
		[0,0]		=>	:iksnr,
		[2,0]		=>	:registration_date,
		[0,1]		=>	:company_name,
		[2,1]		=>	:revision_date,
		[0,2]		=>	:generic_type,
		[2,2]		=>	:expiration_date,
		[0,3]		=>	:indication,
		[2,3]		=>	:market_date,
		[2,4]		=>	:inactive_date,
		[1,5]		=>	:submit,
		[1,5,0]	=>	:new_registration,
	}
	CSS_MAP = { 
		[0,0,4,6] => 'list' 
	}
	LOOKANDFEEL_MAP = {
		:email_suggestion	=>	:suggest_addr_sender,
	}
	def new_registration(model, session=@session)
		button = HtmlGrid::Button.new(:search_again, model, @session, self)
		url = @lookandfeel.event_url(:new_registration)
		button.set_attribute('onclick', "location.href='#{url}'")
		button
	end
	def reorganize_components
		unless(@model.is_a?(Persistence::CreateItem))
			components.update({
				[0,6]	=>	:email_suggestion,
				[1,7]	=>	:suggest,
			})
			component_css_map.store([0,6], 'standard')
			symbol_map.store(:email_suggestion, HtmlGrid::InputText)
			css_map.store([0,6,4,2], 'list')
		end
	end
	def suggest(model, session)
		button = HtmlGrid::Button.new(:suggest, model, session, self)
		button.attributes["onClick"] = "this.form.event.value='accept';this.form.submit()"
		button
	end
end
class SuggestRegistrationInnerComposite < HtmlGrid::Composite
	COMPONENTS = {
		[0,0]	=>	:th_active_registration,
		[0,1]	=>	:active_registration,
	}
	DEFAULT_CLASS = HtmlGrid::Value
	CSS_CLASS = 'composite'
	CSS_MAP = {
		[0,0]	=>	"subheading",
	}
	SYMBOL_MAP = {
		:th_active_registration	=>	HtmlGrid::Text,
	}
	def active_registration(model, session)
		if(registration = session.app.registration(@model.iksnr))
			View::Admin::RegistrationComposite.new(registration, session, self)
		end
	end
end
class SuggestRegistrationComposite < View::Admin::RootRegistrationComposite
	COMPONENTS = {
		#[0,1]	=>	:steps,
		[0,1]	=>	View::User::SuggestRegistrationForm,
		[1,1]	=>	:help,
		[0,2]	=>	:registration_sequences,
		[0,3]	=>	View::User::SuggestRegistrationInnerComposite,
	}
	COLSPAN_MAP = {
		[0,0]	=> 2,
		[0,2]	=> 2,
		[0,3]	=> 2,
	}
	CSS_MAP = {
		[0,0]	=>	'th',
		#[0,4]	=>	'composite',
		[1,1]	=>	'top list-r',
	}
	def help(model, session=@session)
		link = HtmlGrid::Link.new(:help, model, @session, self)
		txt = @lookandfeel.lookup(:help_suggest_registration)
		link.value = txt
		link.href = "mailto:#{MAIL_FROM}?subject=#{txt}"
		link
	end
end
class SuggestRegistration < View::PrivateTemplate
	CONTENT = View::User::SuggestRegistrationComposite
	SNAPBACK_EVENT = :user_home
end
		end
	end
end