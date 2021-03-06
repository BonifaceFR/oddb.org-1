#!/usr/bin/env ruby
# encoding: utf-8
# ODDB::View::Drugs::TestFachinfo -- oddb.org -- 08.11.2011 -- mhatakeyama@ywesee.com

$: << File.expand_path('../..', File.dirname(__FILE__))
$: << File.expand_path("../../../src", File.dirname(__FILE__))

require 'test/unit'
require 'flexmock'
require 'view/drugs/fachinfo'
require 'view/drugs/ddd'

class TestFiChapterChooserLink < Test::Unit::TestCase
  include FlexMock::TestCase
  def setup
    @lookandfeel = flexmock('lookandfeel', 
                            :lookup     => 'lookup',
                            :_event_url => '_event_url'
                           )
    @session = flexmock('session', 
                        :language    => 'language',
                        :lookandfeel => @lookandfeel,
                        :user_input  => 'user_input'
                       )
    @chapter  = flexmock('chapter', :heading => 'title')
    @document = flexmock('document', 
                        :amzv => 'amzv',
                        :name => @chapter,
                        :respond_to? => true
                       )
    @pointer  = flexmock('pointer', :skeleton => 'skeleton')
    registration = flexmock('registration', :iksnr => 'iksnr')
    @model   = flexmock('model', 
                        :language => @document,
                        :pointer  => @pointer,
                        :registrations => [registration]
                       )
    @link    = ODDB::View::Drugs::FiChapterChooserLink.new('name', @model, @session)
  end
  def test_init
    assert_equal('_event_url', @link.init)
  end
  def test_init__title_empty
    flexmock(@pointer, :skeleton => [:create])
    flexmock(@lookandfeel, :event_url => 'event_url')
    section = flexmock('section', :subheading => 'subheading')
    flexmock(@chapter, 
             :heading  => '',
             :sections => [section]
            )
    assert_equal('event_url', @link.init)
  end
  def test_init__title_lookup
    @document.should_receive(:name2)
    @link = ODDB::View::Drugs::FiChapterChooserLink.new('name2', @model, @session)
    assert_equal('_event_url', @link.init)
  end
end

class TestFiChapterChooser < Test::Unit::TestCase
  include FlexMock::TestCase
  def setup
    lookandfeel = flexmock('lookandfeel', 
                           :lookup     => 'lookup',
                           :attributes => {},
                           :_event_url => '_event_url'
                          )
    @state     = flexmock('state', :allowed? => nil)
    @session   = flexmock('session', 
                          :state       => @state,
                          :language    => 'language',
                          :lookandfeel => lookandfeel,
                          :user_input  => 'user_input'
                         )
    @pointer   = flexmock('pointer', :skeleton => 'skeleton')
    language   = flexmock('language', :chapter_names => 'chapter_names')
    atc_class  = flexmock('atc_class')
    registration = flexmock('registration', :iksnr => 'iksnr')
    @model     = flexmock('model', 
                          :pointer   => @pointer,
                          :language  => language,
                          :atc_class => atc_class,
                          :registrations => [registration]
                         )
    @composite = ODDB::View::Drugs::FiChapterChooser.new(@model, @session)
  end
  def test_init
    expected = {[2, 0]=>"chapter-tab bold", [0, 0, 2]=>"chapter-tab", [0, 1]=>"chapter-tab"}
    assert_equal(expected, @composite.init)
  end
  def test_init__status_allowed
    flexmock(@state, :allowed? => true)
    expected = {[2, 0]=>"chapter-tab bold", [0, 0, 2]=>"chapter-tab", [0, 1]=>"chapter-tab"}
    assert_equal(expected, @composite.init)
  end
  def test_full_text
    flexmock(@pointer, :skeleton => [:create])
    assert_equal('lookup', @composite.full_text(@model, @session))
  end
end

class TestFachinfoInnerComposite < Test::Unit::TestCase
  include FlexMock::TestCase
  def test_init
    lookandfeel = flexmock('lookandfeel', :lookup     => 'lookup')
    @session    = flexmock('session', :lookandfeel => lookandfeel)
    @model      = flexmock('model', :chapter_names => ['name'])
    @composite  = ODDB::View::Drugs::FachinfoInnerComposite.new(@model, @session)
    expected    = [[[0, 0], "name"]]
    assert_equal(expected, @composite.init)
  end
end

class TestFachinfoPreviewComposite < Test::Unit::TestCase
  include FlexMock::TestCase
  def test_fachinfo_name
    lookandfeel = flexmock('lookandfeel', :lookup     => 'lookup')
    @session    = flexmock('session', :lookandfeel => lookandfeel)
    @model      = flexmock('model', 
                           :name          => 'name', 
                           :chapter_names => ['name']
                          )
    @composite  = ODDB::View::Drugs::FachinfoPreviewComposite.new(@model, @session)
    assert_equal('lookup', @composite.fachinfo_name(@model, @session))
  end
end

class TestFachinfoComposite < Test::Unit::TestCase
  include FlexMock::TestCase
  def setup
    lookandfeel = flexmock('lookandfeel', 
                           :lookup     => 'lookup',
                           :attributes => {},
                           :_event_url => '_event_url'
                          )
    state       = flexmock('state', :allowed? => nil)
    @session    = flexmock('session', 
                           :lookandfeel => lookandfeel,
                           :language    => 'language',
                           :state       => state,
                           :user_input  => 'user_input'
                           )
    language    = flexmock('language', 
                           :name          => 'name',
                           :chapter_names => ['name']
                          )
    pointer     = flexmock('pointer', :skeleton => 'skeleton')
    @atc_clas   = flexmock('atc_class')
    registration = flexmock('registration', :iksnr => 'iksnr')
    @model      = flexmock('model',
                          :language  => language,
                          :pointer   => pointer,
                          :atc_class => @atc_class,
                          :registrations => [registration]
                          )
    @composite  = ODDB::View::Drugs::FachinfoComposite.new(@model, @session)
  end
  def test_chapter_chooser
    assert_kind_of(ODDB::View::Drugs::FiChapterChooser, @composite.chapter_chooser(@model, @session))
  end
  def test_document__chapter_ddd
    flexmock(@atc_class, :parent_code => 'parent_code') 
    flexmock(@session, :user_input => 'ddd')
    assert_kind_of(ODDB::View::Drugs::DDDTree, @composite.document(@model, @session))
  end
  def test_document__chapter_changelog
    flexmock(@model, 
             :change_log => [@model],
             :time       => Time.local(2011,2,3) ,
             :chapter    => 'chapter'
            )
    flexmock(@session, 
             :user_input => 'changelog',
             :event      => 'event'
            )
    assert_kind_of(ODDB::View::ChangeLog, @composite.document(@model, @session))
  end
  def test_document__chapter_else
    assert_kind_of(ODDB::View::Chapter, @composite.document(@model, @session))
  end
  def test_document__chapter_nil
    flexmock(@session, :user_input => nil)
    assert_kind_of(ODDB::View::Drugs::FachinfoInnerComposite, @composite.document(@model, @session))
  end
end

class TestEditFiChapterChooser < Test::Unit::TestCase
  include FlexMock::TestCase
  def test_display_names
    lookandfeel = flexmock('lookandfeel', 
                           :lookup     => 'lookup',
                           :attributes => {},
                           :_event_url => '_event_url'
                          )
    state      = flexmock('state', :allowed? => nil)
    @session   = flexmock('session', 
                          :state       => state,
                          :language    => 'language',
                          :lookandfeel => lookandfeel,
                          :user_input  => 'user_input'
                         )
    pointer    = flexmock('pointer', :skeleton => 'skeleton')
    chapter    = flexmock('chapter')
    language   = flexmock('language', :chapters => [chapter])
    atc_class  = flexmock('atc_class')
    registration = flexmock('registration', :iksnr => 'iksnr')
    @model     = flexmock('model', 
                          :pointer   => pointer,
                          :language  => language,
                          :atc_class => atc_class,
                          :registrations => [registration]
                         )
    @composite = ODDB::View::Drugs::EditFiChapterChooser.new(@model, @session)
    document   = flexmock('document', :chapters => 'chapters')
    assert_equal('chapters', @composite.display_names(document))
  end
end

class TestRootFachinfoComposite < Test::Unit::TestCase
  include FlexMock::TestCase
  def setup
    @lookandfeel = flexmock('lookandfeel', 
                           :attributes => {},
                           :lookup     => 'lookup',
                           :_event_url => '_event_url'
                          )
    state      = flexmock('state', :allowed? => nil)
    @session   = flexmock('session', 
                          :state       => state,
                          :language    => 'language',
                          :lookandfeel => @lookandfeel,
                          :user_input  => 'user_input'
                         )
    chapter    = flexmock('chapter')
    language   = flexmock('language', 
                          :chapters => [chapter],
                          :name => 'name'
                         )
    pointer    = flexmock('pointer', :skeleton => 'skeleton')
    @company   = flexmock('company', 
                          :invoiceable? => nil,
                          :pointer      => pointer
                         )
    atc_class  = flexmock('atc_class')
    registration = flexmock('registration', :iksnr => 'iksnr')
    @model     = flexmock('model',
                          :pointer   => pointer,
                          :company   => @company,
                          :language  => language,
                          :atc_class => atc_class,
                          :registrations => [registration]
                         )
    @composite = ODDB::View::Drugs::RootFachinfoComposite.new(@model, @session)
  end
  def test_init
    assert_equal({}, @composite.init)
  end
  def test_chapter_view
    flexmock(@company, :invoiceable? => true)
    chapter  = flexmock('chapter')
    document = flexmock('document', :chapter => chapter)
    flexmock(@session, :error => nil)
    flexmock(@lookandfeel, :base_url => 'base_url')
    assert_kind_of(ODDB::View::EditChapterForm, @composite.chapter_view('chapter', document))
  end
end
