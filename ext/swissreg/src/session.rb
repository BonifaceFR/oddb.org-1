#!/usr/bin/env ruby
# encoding: utf-8
# ODDB::Swissreg::Session -- oddb.org -- 09.10.2012 -- yasaka@ywesee.com
# ODDB::Swissreg::Session -- oddb.org -- 09.01.2012 -- mhatakeyama@ywesee.com
# ODDB::Swissreg::Session -- oddb.org -- 04.05.2006 -- hwyss@ywesee.com

require 'writer'
require 'hpricot'
require 'util/http'
require 'iconv'

module ODDB
	module Swissreg
class Session < HttpSession
	def initialize
		super('www.swissreg.ch')
		@http.read_timeout = 120 
	end
	def extract_result_links(html)
    doc = Hpricot.make(html, {})
    path = "//a[@target='detail']/span[@title='zur Detailansicht']" 
    link = "/srclient/faces/jsp/spc/sr300.jsp?language=de&section=spc&id=%s"
    (doc/path).collect { |span|
      link % span.inner_html
    }
	end
  def get(url, *args)
    res = super
    @referer = url
    res
  end
	def get_detail(url)
		response = get(url)
		writer = DetailWriter.new
		formatter = ODDB::HtmlFormatter.new(writer)
		parser = ODDB::HtmlParser.new(formatter)
		parser.feed(response.body)
		writer.extract_data
	rescue Timeout::Error
		{}
	end
  def get_headers
    hdrs = super
    if(@cookie_id)
      hdrs.push(['Cookie', @cookie_id])
    end
    hdrs
	end
	def get_result_list(substance)
    response = get("/srclient/")
    update_cookie(response)
    response = get(response['location'])
    data = [
      [ 'id_swissreg_SUBMIT', '1' ],
      [ 'id_swissreg:_idcl', 
       'id_swissreg_sub_nav_ipiNavigation_item10'],
      ["javax.faces.ViewState", view_state(response)],
    ]
    url = "/srclient/faces/jsp/start.jsp"
		response = post(url, data)
    update_cookie(response)
		criteria = [
      ["id_swissreg:mainContent:id_txf_title", "%s*" % substance],
      ["id_swissreg:mainContent:id_txf_basic_pat_no", ""],
      ["id_swissreg:mainContent:id_txf_spc_no", ""],
      ["id_swissreg:mainContent:sub_fieldset:id_submit", "suchen"],
      ["id_swissreg:_link_hidden_", ""],
      ["id_swissreg_SUBMIT", "1"],
      ["id_swissreg:_idcl", ""],
      ["autoScroll", "0"],
      ["javax.faces.ViewState", view_state(response)],
		]
    url = "/srclient/faces/jsp/spc/sr1.jsp"
		response = post(url, criteria)
    update_cookie(response)
		extract_result_links(response.body)
	rescue Timeout::Error
		[]
	end
  def post(url, *args)
    res = super
    @referer = url
    res
  end
  def update_cookie(response)
    if(hdr = response['set-cookie'])
      @cookie_id = hdr[/^[^;]+/u]
    end
  end
  def view_state(response)
    if match = /javax.faces.ViewState.*?value="([^"]+)"/u.match(response.body.force_encoding('utf-8'))
      match[1]
    else
      ""
    end
  end
end
	end
end
