#!/usr/bin/env ruby
# ODDB::Invoicer -- ydpm -- 12.12.2005 -- hwyss@ywesee.com

require 'rmail'
require 'date'
require 'plugin/plugin'
require 'pdfinvoice/config'
require 'pdfinvoice/invoice'
require 'util/oddbconfig'

module ODDB
	class Invoicer < Plugin
		RECIPIENTS = [ 
			'hwyss@ywesee.com', 
			'zdavatz@ywesee.com' 
		]
		def address_lines(comp_or_hosp, email)
			lines = [ comp_or_hosp.name, "z.H. #{comp_or_hosp.contact}", email ]
			lines += comp_or_hosp.address(0).lines
		end
		def assemble_pdf_invoice(pdfinvoice, comp_or_hosp, items, email)
			pdfinvoice.debitor_address = address_lines(comp_or_hosp, email)
			pdfinvoice.items = sort_items(items).each { |item| 
			}.collect { |item|
				[ item.time, item_text(item), item.unit, 
					item.quantity.to_i, item.price.to_f ]
			}
			pdfinvoice
		end
		def create_invoice(user, items)
			pointer = Persistence::Pointer.new(:invoice)
			values = {
				:user_pointer		=>	user.pointer,
				:keep_if_unpaid =>	true,
			}
			ODBA.transaction { 
				invoice = @app.update(pointer.creator, values)
				pointer = invoice.pointer + [:item]
				items.each { |item|
					@app.update(pointer.dup.creator, item.values)
				}
			}
		end
		def create_pdf_invoice(day, comp_or_hosp, items, email)
			config = PdfInvoice.config
			config.formats['quantity'] = quantity_format
			config.texts['thanks'] = <<-EOS
Ohne Ihre Gegenmeldung erfolgt der Rechnungsversand nur per Email.
Thank you for your patronage
			EOS
			pdfinvoice = PdfInvoice::Invoice.new(config)
			pdfinvoice.invoice_number = invoice_number(day)
			assemble_pdf_invoice(pdfinvoice, comp_or_hosp, items, email)
		end
		def invoice_number(day)
			day.strftime('Rechnung-%d.%m.%Y')
		end
		def invoice_subject(items, date)
			sprintf("Rechnung (%i x) %s", 
				items.size, date.strftime("%m/%Y"))
		end
		def item_text(item)
			item.text
		end
		def quantity_format
			'%i'
		end
		def resend_invoice(invoice, day = Date.today)
			if((user = invoice.user_pointer.resolve(@app)) \
				&& (comp_or_hosp = user.model))
				items = invoice.items.values
				send_invoice(day, comp_or_hosp, items)
			end
		end
		def rp2fr(price)
			price.to_f / 100.0
		end
		def send_invoice(date, comp_or_hosp, items)
			to = comp_or_hosp.invoice_email || comp_or_hosp.user.unique_email
			invoice = create_pdf_invoice(date, comp_or_hosp, items, to)
			invoice_name = "#{invoice.invoice_number}.pdf"
			fpart = RMail::Message.new
			header = fpart.header
			header.to = to
			header.from = MAIL_FROM
			header.subject = invoice_subject(items, date)
			header.add('Content-Type', 'application/pdf')
			header.add('Content-Disposition', 'attachment', nil,
				{'filename' => invoice_name })
			header.add('Content-Transfer-Encoding', 'base64')
			fpart.body = [invoice.to_pdf].pack('m')
			smtp = Net::SMTP.new(SMTP_SERVER)
			recipients = RECIPIENTS.dup.push(to).uniq
			smtp.start {
				recipients.each { |recipient|
					smtp.sendmail(fpart.to_s, SMTP_FROM, recipient)
				}
			}
		end
		def sort_items(items)
			items
		end
	end
	class LookandfeelInvoicer < Invoicer
		def run
			@app.companies.each_value { |comp| 
				invoice_lookandfeel(comp)
			}
		end
		def invoice_lookandfeel(comp, date = Date.today)
			idate = comp.lookandfeel_invoice_date
			price = rp2fr(comp.lookandfeel_price)
			## lookandfeel_member_price is stored in Rappen
			member_price = rp2fr(comp.lookandfeel_member_price)
			member_count = comp.lookandfeel_member_count.to_i
			member_sum = member_price * member_count
			if(date == idate && price > 0)
				time = Time.now
				expiry_time = Time.local(date.year, date.month, date.day)
				base_item = AbstractInvoiceItem.new
				base_item.text = case comp.business_area
				when 'ba_info'
					'Grundgeb�hr Look & Feel Medi-Information'
				when 'ba_insurance'
					'Grundgeb�hr Krankenkasse'
				else
					'Grundgeb�hr'
				end
				base_item.type = :lookandfeel
				base_item.unit = 'Jahr'
				base_item.price = price.to_f
				base_item.vat_rate = VAT_RATE
				base_item.time = time
				base_item.expiry_time = expiry_time
				items = [base_item]
				if(member_sum > 0)
					member_item = AbstractInvoiceItem.new
					member_item.type = :lookandfeel_per_member
					member_item.text = 'Anzahl Versicherte'
					member_item.unit = 'Person'
					member_item.quantity = member_count
					member_item.price = member_price
					member_item.vat_rate = VAT_RATE
					member_item.time = time
					member_item.expiry_time = expiry_time
					items.push(member_item)
				end
				## first send the invoice 
				send_invoice(date, comp, items) 
				## then store it in the database
				user = comp.user
				if(user.nil?)
					values = {:model, comp.pointer}	
					ptr = Persistence::Pointer.new(:user)
					user = @app.update(ptr.creator, values)
				end
				create_invoice(user, items)
				@app.update(comp.pointer, {:lookandfeel_invoice_date => (date >> 12)})
			end
		end
		def invoice_subject(items, date)
			year = date.year
			sprintf("Rechnung Lookandfeel-Integration %i/%i", year, year.next)
		end
	end
	class CompanyIndexInvoicer < Invoicer
		def run
			@app.companies.each_value { |comp| 
				invoice_company_index(comp)
			}
		end
		def invoice_company_index(comp, date = Date.today)
			idate = comp.index_invoice_date
			price = rp2fr(comp.index_price)
			## package_price is stored in Rappen
			package_price = rp2fr(comp.index_package_price)
			package_count = comp.active_package_count
			package_sum = package_price * package_count
			if(date == idate && price > 0)
				time = Time.now
				expiry_time = Time.local(date.year, date.month, date.day)
				base_item = AbstractInvoiceItem.new
				year = date.year
				base_item.text = sprintf('Eintrag Firmenverzeichnis %i/%i', 
																 year, year.next)
				base_item.type = :index
				base_item.unit = 'Jahr'
				base_item.price = price.to_f
				base_item.vat_rate = VAT_RATE
				base_item.time = time
				base_item.expiry_time = expiry_time
				items = [base_item]
				if(package_sum > 0)
					package_item = AbstractInvoiceItem.new
					package_item.type = :index_per_package
					package_item.text = sprintf('Anzahl Produktelinks (%i)', package_count)
					package_item.unit = 'Produkt'
					package_item.quantity = package_count
					package_item.price = package_price
					package_item.vat_rate = VAT_RATE
					package_item.time = time
					package_item.expiry_time = expiry_time
					items.push(package_item)
				end
				## first send the invoice 
				send_invoice(date, comp, items) 
				## then store it in the database
				user = comp.user
				if(user.nil?)
					values = {:model, comp.pointer}	
					ptr = Persistence::Pointer.new(:user)
					user = @app.update(ptr.creator, values)
				end
				create_invoice(user, items)
				@app.update(comp.pointer, {:index_invoice_date => (date >> 12)})
			end
		end
		def invoice_subject(items, date)
			year = date.year
			sprintf("Rechnung Firmenverzeichnis %i/%i", year, year.next)
		end
	end
end