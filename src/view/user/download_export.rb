#!/usr/bin/env ruby
# encoding: utf-8
# ODDB::View::User::DownloadExport -- oddb.org -- 22.08.2012 -- yasaka@ywesee.com
# ODDB::View::User::DownloadExport -- oddb.org -- 20.01.2012 -- mhatakeyama@ywesee.com
# ODDB::View::User::DownloadExport -- oddb.org -- 20.09.2004 -- mhuggler@ywesee.com

require 'view/publictemplate'
require 'view/form'
require 'view/datadeclaration'
require 'view/user/export'
require 'view/user/oddbdatdownload'
require 'view/user/fachinfopdf_download'
require 'view/user/yamlexport'
require 'htmlgrid/link'
require 'htmlgrid/errormessage'

module ODDB
  module View
    module User
class DownloadExportInnerComposite < HtmlGrid::Composite
  include View::User::Export
  COMPONENTS = {
    [2,0]   => 'months_1',
    [3,0]   => 'months_12',
    [9,0]   => 'howto',
    [11,0]  => 'direct_link',

    [0,1]   => 'export_datafiles',
    [0,2]   => :csv_analysis_export,
    [2,2]   => :csv_analysis_price,
    [5,2]   => :datadesc_analysis_csv,
    [7,2]   => :example_analysis_csv,
    [11,2]  => :directlink_analysis_csv,
    [0,3]   => :csv_doctors_export,
    [2,3]   => :csv_doctors_price,
    [5,3]   => :datadesc_doctors_csv,
    [7,3]   => :example_doctors_csv,
    [11,3]  => :directlink_doctors_csv,
    [0,4]   => :yaml_doctors_export,
    [2,4]   => :yaml_doctors_price,
    [5,4]   => :datadesc_doctors_yaml,
    [7,4]   => :example_doctors_yaml,
    [11,4]  => :directlink_doctors_yaml,
    [0,5]   => :yaml_fachinfo_export,
    [2,5]   => :radio_fachinfo_yaml_1,
    [3,5]   => :radio_fachinfo_yaml_12,
    [5,5]   => :datadesc_fachinfo_yaml,
    [7,5]   => :example_fachinfo_yaml,
    [11,5]  => :directlink_fachinfo_yaml,
    [0,6]   => :download_index_therapeuticus,
    [2,6]   => :radio_index_therapeuticus_1,
    [3,6]   => :radio_index_therapeuticus_12,
    [5,6]   => :datadesc_index_therapeuticus,
    [7,6]   => :example_index_therapeuticus,
    [11,6]  => :directlink_index_therapeuticus,
    [0,7]   => :yaml_interactions_export,
    [2,7]   => :radio_interactions_yaml_1,
    [3,7]   => :radio_interactions_yaml_12,
    [5,7]   => :datadesc_interactions_yaml,
    [7,7]   => :example_interactions_yaml,
    [11,7]  => :directlink_interactions_yaml,
    [0,8]   => :csv_migel_export,
    [2,8]   => :csv_migel_price,
    [5,8]   => :datadesc_migel_csv,
    [7,8]   => :example_migel_csv,
    [11,8]  => :directlink_migel_csv,
#    [0,9]  => :csv_narcotics_export,
#    [2,9]  => :radio_narcotics_csv,
#    [6,9]  => :datadesc_narcotics_csv,
#    [7,9]  => :example_narcotics_csv,
#    [0,10] => :yaml_narcotics_export,
#    [2,10] => :radio_narcotics_yaml,
#    [6,10] => :datadesc_narcotics_yaml,
#    [7,10] => :example_narcotics_yaml,
    [0,9]   => :csv_export,
    [2,9]   => :radio_oddb_csv_1,
    [3,9]   => :radio_oddb_csv_12,
    [5,9]   => :datadesc_oddb_csv,
    [7,9]   => :example_oddb_csv,
    [11,9]  => :directlink_oddb_csv,
    [0,10]  => :csv_export2,
    [2,10]  => :radio_oddb2_csv_1,
    [3,10]  => :radio_oddb2_csv_12,
    [5,10]  => :datadesc_oddb2_csv,
    [7,10]  => :example_oddb2_csv,
    [11,10] => :directlink_oddb2_csv,
    [0,11]  => :yaml_export,
    [2,11]  => :radio_oddb_yaml_1,
    [3,11]  => :radio_oddb_yaml_12,
    [5,11]  => :datadesc_oddb_yaml,
    [7,11]  => :example_oddb_yaml,
    [11,11] => :directlink_oddb_yaml,
    [0,12]  => :yaml_patinfo_export,
    [2,12]  => :yaml_patinfo_price,
    [5,12]  => :datadesc_patinfo_yaml,
    [7,12]  => :example_patinfo_yaml,
    [11,12] => :directlink_patinfo_yaml,
    [0,13]  => :yaml_price_history_export,
    [2,13]  => :yaml_price_history_price_1,
    [3,13]  => :yaml_price_history_price_12,
    [5,13]  => :datadesc_price_history_yaml,
    [7,13]  => :example_price_history_yaml,
    [11,13] => :directlink_price_history_yaml,
    [0,14]  => :csv_price_history_export,
    [2,14]  => :csv_price_history_price_1,
    [3,14]  => :csv_price_history_price_12,
    [5,14]  => :datadesc_price_history_csv,
    [7,14]  => :example_price_history_csv,
    [11,14] => :directlink_price_history_csv,
    [0,15]  => :oddb_dat_export,
    [3,15]  => :oddb_dat_price,
    [5,15]  => :datadesc_oddb_dat,
    [7,15]  => :example_oddb_dat,
    [11,15] => :directlink_oddb_dat,
    [0,16]  => :oddb_with_migel_dat_export,
    [3,16]  => :oddb_with_migel_dat_price,
    [5,16]  => :datadesc_oddb_with_migel_dat,
    [7,16]  => :example_oddb_with_migel_dat,
    [11,16] => :directlink_oddb_with_migel_dat,

    [0,18]  => 'export_added_value',
    [0,19]  => :fachinfos_de_pdf,
    [2,19]  => :radio_fachinfos_de_pdf_1,
    [3,19]  => :radio_fachinfos_de_pdf_12,
    [7,19]  => :example_fachinfos_de_pdf,
    [11,19] => :directlink_fachinfos_de_pdf,
    [0,20]  => :fachinfos_fr_pdf,
    [2,20]  => :radio_fachinfos_fr_pdf_1,
    [3,20]  => :radio_fachinfos_fr_pdf_12,
    [7,20]  => :example_fachinfos_fr_pdf,
    [11,20] => :directlink_fachinfos_fr_pdf,
    [0,21]  => :fachinfo_epub_firefox,
    [2,21]  => :price_fachinfo_firefox_epub,
    [5,21]  => :datadesc_epub,
    [7,21]  => :example_fachinfo_firefox_epub,
    [9,21]  => :howto_epub_firefox,
    [11,21] => :directlink_compendium_ch_oddb_org_firefox_epub,
    [0,22]  => :fachinfo_htc,
    [2,22]  => :price_fachinfo_htc,
    [5,22]  => :datadesc_kindle,
    [7,22]  => :example_fachinfo_htc,
    [9,22]  => :howto_htc,
    [11,22] => :directlink_compendium_ch_oddb_org_htc_prc,
    [0,23]  => :fachinfo_kindle,
    [2,23]  => :price_fachinfo_kindle,
    [5,23]  => :datadesc_kindle,
    [7,23]  => :example_fachinfo_kindle,
    [9,23]  => :howto_kindle,
    [11,23] => :directlink_compendium_ch_oddb_org_kindle_mobi,
    [0,24]  => :fachinfo_epub_stanza,
    [2,24]  => :price_fachinfo_stanza_epub,
    [5,24]  => :datadesc_epub,
    [7,24]  => :example_fachinfo_stanza_epub,
    [9,24]  => :howto_epub_stanza,
    [11,24] => :directlink_compendium_ch_oddb_org_stanza_epub,
    [0,25]  => :xls_generics,
    [2,25]  => :radio_generics_xls_1,
    [3,25]  => :radio_generics_xls_12,
    [5,25]  => :datadesc_generics_xls,
    [7,25]  => :example_generics_xls,
    [11,25] => :directlink_generics_xls,
    [0,26]  => :xls_patents,
    [2,26]  => :radio_patents_xls,
    [5,26]  => :datadesc_patents_xls,
    [7,26]  => :example_patents_xls,
    [11,26] => :directlink_patents_xls,
    [0,27]  => :xls_swissdrug_update,
    [2,27]  => :radio_swissdrug_update_xls_1,
    [3,27]  => :radio_swissdrug_update_xls_12,
    [5,27]  => :datadesc_swissdrug_update_xls,
    [7,27]  => :example_swissdrug_update_xls,
    [11,27] => :directlink_swissdrug_update_xls,

    [0,30]  => 'export_compatibility',
    [0,31]  => :oddbdat_download,
    [2,31]  => :radio_oddbdat_1,
    [3,31]  => :radio_oddbdat_12,
    [5,31]  => :datadesc_oddbdat,
    [7,31]  => :example_oddbdat,
    [11,31] => :directlink_oddbdat,
    [0,32]  => :s31x,
    [2,32]  => :radio_s31x_1,
    [3,32]  => :radio_s31x_12,
    [5,32]  => :datadesc_s31x,
    [11,32] => :directlink_s31x,

    [0,34]  => :compression_label,
    [0,35]  => :compression,
  }
  CSS_MAP = {
    [0,0,12]  => 'subheading',

    [0,1,12]  => 'list bg sum',
    [0,2,12]  => 'list',
    [0,3,12]  => 'list bg',
    [0,4,12]  => 'list',
    [0,5,12]  => 'list bg',
    [0,6,12]  => 'list',
    [0,7,12]  => 'list bg',
    [0,8,12]  => 'list',
    [0,9,12]  => 'list bg',
    [0,10,12] => 'list',
    [0,11,12] => 'list bg',
    [0,12,12] => 'list',
    [0,13,12] => 'list bg',
    [0,14,12] => 'list',
    [0,15,12] => 'list bg',
    [0,16,12] => 'list',
    [0,17,12] => 'list',

    [0,18,12] => 'list bg sum',
    [0,19,12] => 'list',
    [0,20,12] => 'list bg',
    [0,21,12] => 'list',
    [0,22,12] => 'list bg',
    [0,23,12] => 'list',
    [0,24,12] => 'list bg',
    [0,25,12] => 'list',
    [0,26,12] => 'list bg',
    [0,27,12] => 'list',
    [0,28,12] => 'list bg',
    [0,29,12] => 'list',

    [0,30,12] => 'list bg sum',
    [0,31,12] => 'list',
    [0,32,12] => 'list bg',

    [0,34]    => 'list',
    [0,35]    => 'list',
  }
  COLSPAN_MAP = {
    [5,0]     => 3,
    [6,0]     => 3,
    [11,0]    => 2,
    [0,1,17]  => 13,
    [0,18,12] => 13,
    [0,30,4]  => 13,
  }
  CSS_CLASS = 'component'
  SYMBOL_MAP = {
    :compression => HtmlGrid::Select,
  }
  %w(
    analysis.csv doctors.csv doctors.yaml fachinfo.yaml index_therapeuticus
    interactions.yaml oddb.csv migel.csv oddb2.csv oddb.yaml patinfo.yaml
    price_history.yaml price_history.csv oddb.dat oddb_with_migel.dat
    fachinfos_de.pdf fachinfos_fr.pdf
    compendium_ch.oddb.org.firefox.epub compendium_ch.oddb.org.htc.prc
    compendium_ch.oddb.org.kindle.mobi compendium_ch.oddb.org.stanza.epub
    generics.xls patents.xls swissdrug_update.xls
    oddbdat s31x
  ).each do |file|
    name = "directlink_#{file.gsub(/\./, '_')}".intern
    define_method(name) do |model, session|
		  link = HtmlGrid::Link.new(name, model, session, self)
		  args = { 'buy' => file }
		  link.href = @lookandfeel._event_url(:data, args)
		  link.label = false
      link.value = @lookandfeel.lookup(:direct_link)
		  link
    end
  end
  def compression_label(model, session)
    HtmlGrid::LabelText.new(:compression, model, session, self)
  end
  def csv_export(model, session)
    checkbox_with_filesize("oddb.csv")
  end
  def csv_export2(model, session)
    checkbox_with_filesize("oddb2.csv")
  end
  def csv_analysis_export(model, session)
    checkbox_with_filesize("analysis.csv")
  end
  def csv_analysis_price(model, session)
    once('analysis.csv')
  end
  def csv_doctors_export(model, session)
    checkbox_with_filesize("doctors.csv")
  end
  def csv_doctors_price(model, session)
    once('doctors.csv')
  end
  def csv_migel_export(model, session)
    checkbox_with_filesize('migel.csv')
  end
  def csv_migel_price(model, session)
    once('migel.csv')
  end
  def csv_narcotics_export(model, session)
    checkbox_with_filesize('narcotics.csv')
  end
  def csv_price_history_export(model, session)
    checkbox_with_filesize("price_history.csv")
  end
  def csv_price_history_price_1(model, session)
    radio_price('price_history.csv', 1)
  end
  def csv_price_history_price_12(model, session)
    radio_price('price_history.csv', 12)
  end
  def datadesc_analysis_csv(model, session)
    datadesc('analysis.csv')
  end
  def datadesc_doctors_csv(model, session)
    datadesc('doctors.csv')
  end
  def datadesc_doctors_yaml(model, session)
    datadesc('doctors.yaml')
  end
  def datadesc_epub(model, session)
    link = HtmlGrid::Link.new(:data_description, @model, @session, self)
    link.href = "http://www.openebook.org/specs.htm"
    link.css_class = 'small'
    link
  end
  alias :datadesc_compendium_ch_oddb_org_firefox_epub :datadesc_epub
  alias :datadesc_compendium_ch_oddb_org_stanza_epub :datadesc_epub
  def datadesc_kindle(model, session)
    link = HtmlGrid::Link.new(:data_description, @model, @session, self)
    link.href = "http://www.mobipocket.com/dev/article.asp?BaseFolder=prcgen&File=mobiformat.htm"
    link.css_class = 'small'
    link
  end
  alias :datadesc_compendium_ch_oddb_org_kindle_mobi :datadesc_kindle
  alias :datadesc_compendium_ch_oddb_org_htc_prc :datadesc_kindle
  def datadesc_fachinfo_yaml(model, session)
    datadesc('fachinfo.yaml')
  end
  def datadesc_generics_xls(model, session)
    datadesc('generics.xls')
  end
  def datadesc_index_therapeuticus(model, session)
    datadesc('index_therapeuticus')
  end
  def datadesc_interactions_yaml(model, session)
    datadesc('interactions.yaml')
  end
  def datadesc_swissdrug_update_xls(model, session)
    datadesc('swissdrug-update.xls')
  end
  def datadesc_migel_csv(model, session)
    datadesc('migel.csv')
  end
  def datadesc_narcotics_csv(model, session)
    datadesc('narcotics.csv')
  end
  def datadesc_narcotics_yaml(model, session)
    datadesc('narcotics.yaml')
  end
  def datadesc_oddb_csv(model, session)
    datadesc('oddb.csv')
  end
  def datadesc_oddb2_csv(model, session)
    datadesc('oddb2.csv')
  end
  def datadesc_oddb_yaml(model, session)
    datadesc('oddb.yaml')
  end
  def datadesc_oddbdat(model, session)
    datadesc('oddbdat')
  end
  def datadesc_oddb2tdat(model, session)
    link = HtmlGrid::Link.new(:data_description, model, session, self)
    link.href      = 'http://dev.ywesee.com/ODDB/Oddb2tdat'
    link.css_class = 'small'
    link.set_attribute('target', '_blank')
    link
  end
  alias :datadesc_oddb_dat :datadesc_oddb2tdat
  alias :datadesc_oddb_with_migel_dat :datadesc_oddb2tdat
  def datadesc_patents_xls(model, session)
    datadesc('patents.xls')
  end
  def datadesc_patinfo_yaml(model, session)
    datadesc('patinfo.yaml')
  end
  def datadesc_price_history_csv(model, session)
    datadesc('price_history.csv')
  end
  def datadesc_price_history_yaml(model, session)
    datadesc('price_history.yaml')
  end
  def datadesc_s31x(model, session)
    datadesc('s31x')
  end
  def example_doctors_csv(model, session)
    example('doctors.csv')
  end
  def example_analysis_csv(model, session)
    example('analysis.csv')
  end
  def example_doctors_yaml(model, session)
    example('doctors.yaml')
  end
  # TODO
  # replace method name with new alias
  def example_fachinfo_firefox_epub(model, session)
    example('compendium_ch.oddb.org.firefox.epub')
  end
  alias :example_compendium_ch_oddb_org_firefox_epub :example_fachinfo_firefox_epub
  def example_fachinfo_htc(model, session)
    example('compendium_ch.oddb.org.htc.prc')
  end
  alias :example_compendium_ch_oddb_org_htc_prc :example_fachinfo_htc
  def example_fachinfo_kindle(model, session)
    example('compendium_ch.oddb.org.kindle.mobi')
  end
  alias :example_compendium_ch_oddb_org_kindle_mobi :example_fachinfo_kindle
  def example_fachinfo_stanza_epub(model, session)
    link = example('compendium_ch.oddb.org.stanza.epub')
    url = URI.parse link.href
    url.scheme = 'stanza'
    link.href = url.to_s
    link
  end
  alias :example_compendium_ch_oddb_org_stanza_epub :example_fachinfo_stanza_epub
  def example_fachinfo_yaml(model, session)
    example('fachinfo.yaml')
  end
  def example_fachinfos_de_pdf(model, session)
    example('fachinfos_de.pdf')
  end
  def example_fachinfos_fr_pdf(model, session)
    example('fachinfos_fr.pdf')
  end
  def example_generics_xls(model, session)
    example('generics.xls')
  end
  def example_index_therapeuticus(model, session)
    example('index_therapeuticus.tar.gz')
  end
  def example_interactions_yaml(model, session)
    example('interactions.yaml')
  end
  def example_swissdrug_update_xls(model, session)
    example('swissdrug-update.xls')
  end
  def example_migel_csv(model, session)
    example('migel.csv')
  end
  def example_narcotics_csv(model, session)
    example('narcotics.csv')
  end
  def example_narcotics_yaml(model, session)
    example('narcotics.yaml')
  end
  def example_oddb_csv(model, session)
    example('oddb.csv')
  end
  def example_oddb2_csv(model, session)
    example('oddb2.csv')
  end
  def example_oddb_yaml(model, session)
    example('oddb.yaml')
  end
  def example_oddb_dat(model, session)
    example('oddb.dat.zip')
  end
  def example_oddb_with_migel_dat(model, session)
    example('oddb_with_migel.dat.zip')
  end
  def example_oddbdat(model, session)
    example('oddbdat.tar.gz')
  end
  def example_patinfo_yaml(model, session)
    example('patinfo.yaml')
  end
  def example_patents_xls(model, session)
    example('patents.xls')
  end
  def example_price_history_csv(model, session)
    example('price_history.csv')
  end
  def example_price_history_yaml(model, session)
    example('price_history.yaml')
  end
  def fachinfo_epub_firefox(model, session)
    checkbox_with_filesize('compendium_ch.oddb.org.firefox.epub')
  end
  def fachinfo_htc(model, session)
    checkbox_with_filesize('compendium_ch.oddb.org.htc.prc')
  end
  def fachinfo_kindle(model, session)
    checkbox_with_filesize('compendium_ch.oddb.org.kindle.mobi')
  end
  def fachinfo_epub_stanza(model, session)
    checkbox_with_filesize('compendium_ch.oddb.org.stanza.epub')
  end
  def fachinfos_de_pdf(model, session)
    checkbox_with_filesize('fachinfos_de.pdf')
  end
  def fachinfos_fr_pdf(model, session)
    checkbox_with_filesize('fachinfos_fr.pdf')
  end
  def howto_epub_firefox(model, session)
    link = HtmlGrid::Link.new(:howto_epub_firefox, @model, @session, self)
    link.href = "http://www.ywesee.com/pmwiki.php/Main/EPUB"
    link.css_class = 'small'
    link
  end
  def howto_epub_stanza(model, session)
    link = HtmlGrid::Link.new(:howto_epub_stanza, @model, @session, self)
    link.href = "http://www.ywesee.com/pmwiki.php/Ywesee/Stanza"
    link.css_class = 'small'
    link
  end
  def howto_htc(model, session)
    link = HtmlGrid::Link.new(:howto_htc, @model, @session, self)
    link.href = "http://www.ywesee.com/pmwiki.php/Ywesee/HTC"
    link.css_class = 'small'
    link
  end
  def howto_kindle(model, session)
    link = HtmlGrid::Link.new(:howto_kindle, @model, @session, self)
    link.href = "http://www.ywesee.com/pmwiki.php/Ywesee/Kindle"
    link.css_class = 'small'
    link
  end
  def download_index_therapeuticus(model, session)
    checkbox_with_filesize('index_therapeuticus')
  end
  def oddb_dat_export(model, session)
    checkbox_with_filesize("oddb.dat")
  end
  def oddb_dat_price(model, session)
    once('oddb.dat')
  end
  def oddb_with_migel_dat_export(model, session)
    checkbox_with_filesize("oddb_with_migel.dat")
  end
  def oddb_with_migel_dat_price(model, session)
    once('oddb_with_migel.dat')
  end
  def oddbdat_download(model, session)
    checkbox_with_filesize("oddbdat")
  end
  def price_fachinfo_firefox_epub(model, session)
    once('compendium_ch.oddb.org.firefox.epub')
  end
  def price_fachinfo_htc(model, session)
    once('compendium_ch.oddb.org.htc.prc')
  end
  def price_fachinfo_kindle(model, session)
    once('compendium_ch.oddb.org.kindle.mobi')
  end
  def price_fachinfo_stanza_epub(model, session)
    once('compendium_ch.oddb.org.stanza.epub')
  end
  def radio_fachinfos_de_pdf_1(model, session)
    radio_price('fachinfos_de.pdf', 1)
  end
  def radio_fachinfos_de_pdf_12(model, session)
    radio_price('fachinfos_de.pdf', 12)
  end
  def radio_fachinfos_fr_pdf_1(model, session)
    radio_price('fachinfos_fr.pdf', 1)
  end
  def radio_fachinfos_fr_pdf_12(model, session)
    radio_price('fachinfos_fr.pdf', 12)
  end
  def radio_oddb_csv_1(model, session)
    radio_price('oddb.csv', 1)
  end
  def radio_oddb_csv_12(model, session)
    radio_price('oddb.csv', 12)
  end
  def radio_oddb2_csv_1(model, session)
    radio_price('oddb2.csv', 1)
  end
  def radio_oddb2_csv_12(model, session)
    radio_price('oddb2.csv', 12)
  end
  def radio_fachinfo_yaml_1(model, session)
    radio_price('fachinfo.yaml', 1)
  end
  def radio_fachinfo_yaml_12(model, session)
    radio_price('fachinfo.yaml', 12)
  end
  def radio_generics_xls_1(model, session)
    radio_price('generics.xls', 1)
  end
  def radio_generics_xls_12(model, session)
    radio_price('generics.xls', 12)
  end
  def radio_index_therapeuticus_1(model, session)
    radio_price('index_therapeuticus', 1)
  end
  def radio_index_therapeuticus_12(model, session)
    radio_price('index_therapeuticus', 12)
  end
  def radio_interactions_yaml_1(model, session)
    radio_price('interactions.yaml', 1)
  end
  def radio_interactions_yaml_12(model, session)
    radio_price('interactions.yaml', 12)
  end
  def radio_swissdrug_update_xls_1(model, session)
    radio_price('swissdrug-update.xls', 1)
  end
  def radio_swissdrug_update_xls_12(model, session)
    radio_price('swissdrug-update.xls', 12)
  end
  def radio_narcotics_csv(model, session)
    once_or_year('narcotics.csv')
  end
  def radio_narcotics_yaml(model, session)
    once_or_year('narcotics.yaml')
  end
  def radio_oddbdat_1(model, session)
    radio_price('oddbdat', 1)
  end
  def radio_oddbdat_12(model, session)
    radio_price('oddbdat', 12)
  end
  def radio_oddb_yaml_1(model, session)
    radio_price('oddb.yaml', 1)
  end
  def radio_oddb_yaml_12(model, session)
    radio_price('oddb.yaml', 12)
  end
  def radio_patents_xls(model, session)
    once('patents.xls')
  end
  def radio_s31x_1(model, session)
    radio_price('s31x', 1)
  end
  def radio_s31x_12(model, session)
    radio_price('s31x', 12)
  end
  def s31x(model, session)
    checkbox_with_filesize("s31x")
  end
  def xls_generics(model, session)
    checkbox_with_filesize('generics.xls')
  end
  def xls_patents(model, session)
    checkbox_with_filesize('patents.xls')
  end
  def xls_swissdrug_update(model, session)
    checkbox_with_filesize('swissdrug-update.xls')
  end
  def yaml_doctors_export(model, session)
    checkbox_with_filesize("doctors.yaml")
  end
  def yaml_doctors_price(model, session)
    once('doctors.yaml')
  end
  def yaml_export(model, session)
    checkbox_with_filesize("oddb.yaml")
  end
  def yaml_fachinfo_export(model, session)
    checkbox_with_filesize("fachinfo.yaml")
  end
  def yaml_interactions_export(model, session)
    checkbox_with_filesize("interactions.yaml")
  end
  def yaml_narcotics_export(model, session)
    checkbox_with_filesize('narcotics.yaml')
  end
  def yaml_patinfo_export(model, session)
    checkbox_with_filesize("patinfo.yaml")
  end
  def yaml_patinfo_price(model, session)
    once('patinfo.yaml')
  end
  def yaml_price_history_export(model, session)
    checkbox_with_filesize("price_history.yaml")
  end
  def yaml_price_history_price_1(model, session)
    radio_price('price_history.yaml', 1)
  end
  def yaml_price_history_price_12(model, session)
    radio_price('price_history.yaml', 12)
  end
end
class DownloadExportComposite < Form
  include HtmlGrid::ErrorMessage
  include View::DataDeclaration
  COMPONENTS = {
    [0,0,0] => 'download_export',
    [0,0,1] => 'dash_separator',
    [0,0,2] => :data_declaration,
    [0,1]   => :download_export_descr,
    [0,2]   => DownloadExportInnerComposite,
    [0,3]   => :submit,
  }
  CSS_CLASS = 'composite'
  CSS_MAP = {
    [0,0] => 'th',
    [0,1] => 'list',
    [0,3] => 'list',
  }
  EVENT = :proceed_download
  SYMBOL_MAP = {
    :yaml_link => HtmlGrid::Link,
  }
  def download_export_descr(model, session)
    pages = {
      'de' => 'Stammdaten',
      'en' => 'MasterData',
      'fr' => 'DonneesDeBase',
    }
    page = pages[@lookandfeel.language]
    link = HtmlGrid::Link.new(:download_export_descr, model,
      @session, self)
    link.href = "http://wiki.oddb.org/wiki.php?pagename=ODDB.#{page}"
    link
  end
  def init
    super
    error_message(1)
  end
end
class DownloadExport < View::ResultTemplate
  CONTENT = View::User::DownloadExportComposite
end
    end
  end
end
