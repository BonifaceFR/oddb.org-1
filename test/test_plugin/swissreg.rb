#!/usr/bin/env ruby
# encoding: utf-8
# ODDB::TestSwissregPlugin -- oddb.org -- 31.05.2011 -- mhatakeyama@ywesee.com

$: << File.expand_path("../../src", File.dirname(__FILE__))

require 'test/unit'
require 'flexmock'
require 'drb'
require 'plugin/swissreg'
require 'uri'

module ODDB
  class TestSwissregPlugin < Test::Unit::TestCase
    include FlexMock::TestCase
    def stderr_null
      require 'tempfile'
      $stderr = Tempfile.open('stderr')
      yield
      $stderr.close
      $stderr = STDERR
    end
    def replace_constant(constant, temp)
      stderr_null do
        keep = eval constant
        eval "#{constant} = temp"
        yield
        eval "#{constant} = keep"
      end
    end
    def setup
      @app    = flexmock('app')
      @plugin = ODDB::SwissregPlugin.new(@app)
    end
    def test_get_detail
      server  = flexmock('server', :detail => 'detail')
      replace_constant('ODDB::SwissregPlugin::SWISSREG_SERVER', server) do
        assert_equal('detail', @plugin.get_detail('http://aaa.bbb.ccc'))
      end
    end
    def test_format_data
      data = {:iksnr => 'iksnr'}
      expected = " -> http://www.swissreg.ch/srclient/faces/jsp/spc/sr300.jsp?language=de&section=spc&id=\n"
      assert_equal(expected, @plugin.format_data(data))
    end
    def test_report
      expected = "Checked      0 Substances for connected Patents\nFound        0 Patents\nof which     0 had a Swissmedic-Number.\n             0 Registrations were successfully updated;\nfor these    0 Swissmedic-Numbers no Registration was found:\n\n"
      assert_equal(expected, @plugin.report)
    end
    def test_update_registration
      pointer = flexmock('pointer', :creator => 'creator')
      flexmock(pointer, :+ => pointer)
      registration = flexmock('registration', :pointer => pointer)
      flexmock(@app, 
               :registration => registration,
               :update       => 'update'
              )
      assert_equal('update', @plugin.update_registration('iksnr', {}))
    end
    def test_update_registrations
      server  = flexmock('server', :search => [{}])
      flexmock(@plugin, :sleep => nil)
      replace_constant('ODDB::SwissregPlugin::SWISSREG_SERVER', server) do
        assert_equal([{}], @plugin.update_registrations('substance_name'))
      end
    end
    def test_update_news
      active_agent = flexmock('active_agent', :substance => 'substance')
      sequence = flexmock('sequence', :active_agents => [active_agent])
      registration = flexmock('registration') do |r|
        r.should_receive(:each_sequence).and_yield(sequence)
      end
      pointer = flexmock('pointer', :resolve => registration)
      log = flexmock('log', :change_flags => {pointer => 'value'})
      log_group = flexmock('log_group', :latest => log)
      flexmock(@app, :log_group => log_group)
      server  = flexmock('server', :search => [{}])
      flexmock(@plugin, :sleep => nil)
      replace_constant('ODDB::SwissregPlugin::SWISSREG_SERVER', server) do
        assert_equal(["substanc"], @plugin.update_news)
      end
    end
  end
end # ODDB
