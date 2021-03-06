#!/usr/bin/env ruby
# encoding: utf-8
# State::PayPal::Return -- ODDB -- 21.04.2005 -- hwyss@ywesee.com

require 'state/global_predefine'
require 'view/paypal/return'
require 'delegate'

module ODDB
	module State
		module PayPal
class Return < State::Global
	class InvoiceWrapper < SimpleDelegator
		attr_accessor :items
	end
	class ItemWrapper < SimpleDelegator
		attr_accessor :email, :oid
	end
	VIEW = View::PayPal::Return
	def init
		if(@model)
			invoice = @model
			@model = InvoiceWrapper.new(invoice)
			@model.items = invoice.items.values.collect { |item|
				wrap = ItemWrapper.new(item)
				wrap.email = invoice.yus_name
				wrap.oid = invoice.oid
				wrap
			}
		end
		super
	end
	def back
		@previous.previous if(@previous.respond_to?(:previous))
	end
	def paypal_return
		if(@model && @model.types.all? { |type| type  == :poweruser } \
			&& @model.payment_received? && (des = @session.desired_state))
			des
		else
			self
		end
	end
end
		end
	end
end
