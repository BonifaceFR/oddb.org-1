#!/usr/bin/env ruby
# ODDB::View::Admin::TestPasswordLost -- oddb.org -- 29.06.2011 -- mhatakeyama@ywesee.com

$: << File.expand_path("../../../src", File.dirname(__FILE__))

require 'test/unit'
require 'flexmock'
require 'view/admin/password_lost'


module ODDB
  module View
    module Admin

class TestPasswordLostComposite < Test::Unit::TestCase
  include FlexMock::TestCase
  def setup
    @lnf       = flexmock('lookandfeel', 
                          :lookup     => 'lookup',
                          :attributes => {},
                          :base_url   => 'base_url'
                         )
    @session   = flexmock('session', 
                          :lookandfeel => @lnf,
                          :error    => 'error',
                          :warning? => nil,
                          :error?   => nil
                         )
    @model     = flexmock('model')
    @composite = ODDB::View::Admin::PasswordLostComposite.new(@model, @session)
  end
  def test_init
    assert_equal(nil, @composite.init)
  end
end

    end # Admin
  end # View
end # ODDB