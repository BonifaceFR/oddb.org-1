#!/usr/bin/env ruby
# TestPatinfoHtmlParser -- oddb -- 24.10.2003 -- rwaltert@ywesee.com

$: << File.dirname(__FILE__)
$: << File.expand_path("../src", File.dirname(__FILE__))
$: << File.expand_path("../../../src", File.dirname(__FILE__))

require 'test/unit'
require 'patinfo_html'

module ODDB
	module FiParse
		class PatinfoHtmlWriter
			attr_reader :company, :galenic_form, :effects
			attr_reader :amendments, :contra_indications, :precautions
			attr_reader :pregnancy, :usage, :unwanted_effects
			attr_reader :general_advice, :composition, :packages
			attr_reader :distribution, :date, :amzv, :date_dummy
		end
	end
end

class TestPatinfoHtmlParser00907 < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/de/00907.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	end
	def test_name1
		assert_equal('Arteoptic� 0,5%, 1%, 2%', @writer.name)
	end
	def test_company1
		chapter = @writer.company
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('CHAUVIN NOVOPHARMA', chapter.heading)
	end
	def test_galenic_form1
		chapter = @writer.galenic_form
		assert_instance_of(ODDB::Text::Chapter, chapter)
		assert_equal('Augentropfen', chapter.heading)
		assert_equal(0, chapter.sections.size)
	end
	def test_effects1
		chapter = @writer.effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Eigenschaften/Verwendungszweck', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Was ist Arteoptic und wann wird es angewendet?\n", section.subheading)
		assert_equal(1, section.paragraphs.size)
		paragraph = section.paragraphs.first
		expected = "Arteoptic enth�lt einen sogenannten Betablocker, der den Augeninnendruck senkt. Arteoptic wird bei erh�htem Augeninnendruck angewendet, um Ihre Augen vor einer nicht r�ckg�ngig zu machenden Verschlechterung des Sehverm�gens durch den gr�nen Star zu sch�tzen. Arteoptic Augentropfen d�rfen nur auf Verschreibung des Arztes angewendet werden."
		assert_equal(expected, paragraph.text)
	end
	def test_amendments1
		chapter = @writer.amendments
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Erg�nzungen', chapter.heading)
		assert_equal(2, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Was sollte dazu beachtet werden?\n", section.subheading)
		assert_equal(1, section.paragraphs.size)
		section = chapter.sections.last
		assert_equal("Hinweis f�r Kontaktlinsentr�ger:", section.subheading)
	end
	def test_contra_indications1
		chapter = @writer.contra_indications
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Kontraindikationen', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Wann darf Arteoptic nicht angewendet werden?\n", section.subheading)
		assert_equal(1, section.paragraphs.size)
	end
	def test_precautions1
		chapter = @writer.precautions
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Vorsichtsmassnahmen', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Wann ist bei der Anwendung von Arteoptic Vorsicht geboten?\n", section.subheading)
		assert_equal(3, section.paragraphs.size)
	end
	def test_pregnancy1
		chapter = @writer.pregnancy
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Schwangerschaft/Stillzeit', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Darf Arteoptic w�hrend einer Schwangerschaft oder in der Stillzeit angewendet werden?\n", section.subheading)
		assert_equal(1, section.paragraphs.size)
	end
	def test_usage1
		chapter = @writer.usage
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Dosierung/Anwendung', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Wie verwenden Sie Arteoptic?\n", section.subheading)
		assert_equal(5, section.paragraphs.size)
	end
	def test_unwanted_effects1
		chapter = @writer.unwanted_effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Unerw�nschte Wirkungen', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Welche Nebenwirkungen kann Arteoptic haben?\n", section.subheading)
		assert_equal(4, section.paragraphs.size)
	end
	def test_general_advice1
		chapter = @writer.general_advice
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Allgemeine Hinweise', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Was ist ferner zu beachten?\n", section.subheading)
		assert_equal(4, section.paragraphs.size)
	end
	def test_composition1
		chapter = @writer.composition
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Zusammensetzung', chapter.heading)
		assert_equal(2, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Wirkstoff:", section.subheading)
		assert_equal(1, section.paragraphs.size)
	end
	def test_packages1
		chapter = @writer.packages
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal("Verkaufsart/Packungen", chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("", section.subheading)
		assert_equal(2, section.paragraphs.size)
	end
	def test_distribution1
		chapter = @writer.distribution
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Vertriebsfirma', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("", section.subheading)
		assert_equal(1, section.paragraphs.size)
	end
	def test_date1
		chapter = @writer.date
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Stand der Information', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("", section.subheading)
		assert_equal(1, section.paragraphs.size)
		assert_equal("Mai 2001.", section.paragraphs.first.text)
	end
end
class TestPatinfoHtmlParser00495 < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/de/00495.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	end
	def test_name2
		assert_equal('Mycostatin� Suspension', @writer.name)
	end
	def test_company2
		chapter = @writer.company
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('SANOFI-SYNTH�LABO', chapter.heading)
	end
	def test_effects2
		chapter = @writer.effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Eigenschaften/Verwendungszweck', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Was ist Mycostatin und wann wird es angewendet?\n", section.subheading)
		assert_equal(2, section.paragraphs.size)
		paragraph = section.paragraphs.first
		expected = "Mycostatin enth�lt Nystatin, ein gegen Pilzinfektionen (Candidosen) wirksames Antibiotikum. Beim Menschen k�nnen Haut und Schleimh�ute (Mund, Geschlechtsorgane, Verdauungsorgane) davon betroffen sein."	
		assert_equal(expected, paragraph.text)
	end
end
class TestPatinfoHtmlParser00338 < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/de/00338.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	end
	def test_name3
		assert_equal('Cafergot�', @writer.name)
	end
	def test_company3
		chapter = @writer.company
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('NOVARTIS PHARMA', chapter.heading)
	end
	def test_effects3
		chapter = @writer.effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Eigenschaften/Verwendungszweck', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Was ist Cafergot und wann wird es angewendet?\n", section.subheading)
		assert_equal(1, section.paragraphs.size)
		paragraph = section.paragraphs.first
		expected = "Cafergot ist ein Kombinationspr�parat, das auf den Migr�neanfall selbst wirkt. Es wirkt gef�ssverengend auf die erweiterten Arterien. Sein Wirkungseintritt wird durch den Zusatz von Coffein beschleunigt. Cafergot wird auf Verschreibung des Arztes zur Behandlung akuter Migr�neanf�lle (mit oder ohne Aura) verwendet."	
		assert_equal(expected, paragraph.text)
	end
	def test_contra_indications3
		chapter = @writer.contra_indications
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Kontraindikationen', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Wann darf Cafergot nicht eingenommen werden?\n", section.subheading)
		assert_equal(9, section.paragraphs.size)
	end
end
class TestPatinfoHtmlParser00943 < Test::Unit::TestCase
	def setup	
		path = File.expand_path('data/html/de/00943.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	end
	def test_name4
		assert_equal('Rapura�', @writer.name)
	end
	def test_company4
		chapter = @writer.company
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('GLOBOPHARM', chapter.heading)
	end
	def test_galenic_form4
		chapter = @writer.galenic_form
		assert_instance_of(ODDB::Text::Chapter, chapter)
		assert_equal('', chapter.heading)
		assert_equal(1, chapter.sections.size)
		assert_equal("Heilsalbe auf pflanzlicher Basis", chapter.sections.first.subheading) 
	end
end
class TestPatinfoHtmlParser05050 < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/de/05050.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	end
	def test_amzv5
		chapter = @writer.amzv
		assert_instance_of(ODDB::Text::Chapter, chapter)
		assert_equal('AMZV 9.11.2001', chapter.heading)
		assert_equal(0, chapter.sections.size)
	end
	def test_effects5
		chapter = @writer.effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Was ist Osa Zahngel und wann wird es angewendet?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(2, section.paragraphs.size)
		paragraph = section.paragraphs.first
		expected = "Osa Zahngel ist ein schmerzstillendes Gel. Es wird angewendet w�hrend der Zahnungsperiode von Kleinkindern. Es ist zuckerfrei und zahnschonend. Es brennt nicht, stillt akute Schmerzen im Zahnfleischbereich, vor allem dann, wenn Z�hne die Pilgern durchstossen."
		assert_equal(expected, paragraph.text)
	end
	def test_composition5
		chapter = @writer.composition
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Was ist in Osa Zahngel enthalten?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(1, section.paragraphs.size)
		assert_equal("1 g enth�lt: Salicylamid 80 mg, Lidocainhydrochlorid 1 mg, Dexpanthenol 13 mg, Saccharin, Konservierungsmittel: Benzoes�ure (E 210), sowie weitere Hilfsstoffe.", section.paragraphs.first.text)
	end
	def test_iksnrs5
		chapter = @writer.iksnrs
		assert_instance_of(ODDB::Text::Chapter, chapter)
		assert_equal('42989 (Swissmedic).', chapter.heading)
		assert_equal(0, chapter.sections.size)
	end
	def test_packages5
		chapter = @writer.packages
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal("Wo erhalten Sie Osa Zahngel? Welche Packungen sind erh�ltlich?", chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("", section.subheading)
		assert_equal(2, section.paragraphs.size)
		paragraph = section.paragraphs.last
		assert_equal('In Tuben zu 10g und 25g.', paragraph.text)
		assert_equal(2, paragraph.formats.size)
	end
end
class TestPatinfoHtmlParser05993 < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/de/05993.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	end
	def test_amzv6
		chapter = @writer.amzv
		assert_instance_of(ODDB::Text::Chapter, chapter)
		assert_equal('AMZV 9.11.2001', chapter.heading)
		assert_equal(0, chapter.sections.size)
	end
	def test_effects6
		chapter = @writer.effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Was ist Co-Epril und wann wird es angewendet?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(2, section.paragraphs.size)
		paragraph = section.paragraphs.first
		expected = "Co-Epril ist ein Arzneimittel mit zwei Wirksubstanzen zur Behandlung des hohen Blutdruckes. Die Wirkung des einen Bestandteiles (Enalapril, ein Wirkstoff aus der Gruppe der sog. ACE-Hemmer [Angiotensin-Converting-Enzym-Hemmer]) beruht auf der Hemmung von k�rpereigenen Stoffen, die f�r den erh�hten Blutdruck verantwortlich sind. Der andere Bestandteil (Hydrochlorothiazid) erh�ht die Salz- und Wasserausscheidung durch die Nieren. Die Wirkmechanismen der beiden Substanzen unterst�tzen sich gegenseitig. Dadurch kann der Blutdruck wirkungsvoll gesenkt werden."
		assert_equal(expected, paragraph.text)
	end
	def test_contra_indications6
		chapter = @writer.contra_indications
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Wann darf Co-Epril nicht angewendet werden?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(6, section.paragraphs.size)
		assert_equal("Nehmen Sie Co-Epril nicht ein, wenn Sie", section.paragraphs.first.text)
	end
	def test_precautions6
		chapter = @writer.precautions
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Wann ist bei der Einnahme/Anwendung von Co-Epril Vorsicht geboten?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(10, section.paragraphs.size)
		assert_equal("Dieses Arzneimittel kann die Reaktionsf�higkeit, die Fahrt�chtigkeit und F�higkeit, Werkzeuge oder Maschinen zu bedienen, beeintr�chtigen!", section.paragraphs.first.text)
	end
	def test_pregnancy6
		chapter = @writer.pregnancy
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Darf Co-Epril w�hrend einer Schwangerschaft oder in der Stillzeit eingenommen/angewendet werden?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(1, section.paragraphs.size)
		assert_equal("Informieren Sie Ihren Arzt oder Ihre �rztin, falls Sie schwanger sind, eine Schwangerschaft planen oder stillen. Co-Epril darf w�hrend der Schwangerschaft und Stillzeit nur auf ausdr�ckliche Verordnung des Arztes oder Ihrer �rztin eingenommen werden.", section.paragraphs.first.text)
	end
	def test_usage6
		chapter = @writer.usage
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Wie verwenden Sie Co-Epril?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(9, section.paragraphs.size)
		assert_equal("Co-Epril kann vor, w�hrend oder nach den Mahlzeiten eingenommen werden. Die Dosierung wird vom Arzt oder der �rztin festgelegt.", section.paragraphs.first.text)
	end
	def test_unwanted_effects6
		chapter = @writer.unwanted_effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Welche Nebenwirkungen kann Co-Epril haben?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(11, section.paragraphs.size)
		assert_equal("Folgende Nebenwirkungen k�nnen bei der Einnahme von Co-Epril auftreten:", section.paragraphs.first.text)
	end
	def test_general_advice6
		chapter = @writer.general_advice
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Was ist ferner zu beachten?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(3, section.paragraphs.size)
		assert_equal("Das Arzneimittel darf nur bis zu dem auf dem Beh�lter mit �EXP� bezeichneten Datum verwendet werden.", section.paragraphs.first.text)
	end
	def test_composition6
		chapter = @writer.composition
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Was ist in Co-Epril enthalten?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(1, section.paragraphs.size)
		assert_equal("Co-Epril enth�lt als Wirkstoffe 20 mg Enalapril Maleat und 12,5 mg Hydrochlorothiazid sowie Hilfsstoffe und ist erh�ltlich als teilbare Tablette.", section.paragraphs.first.text)
	end
	def test_iksnrs6
		chapter = @writer.iksnrs
		assert_instance_of(ODDB::Text::Chapter, chapter)
		assert_equal('55942 (Swissmedic).', chapter.heading)
		assert_equal(0, chapter.sections.size)
	end
	def test_packages6
		chapter = @writer.packages
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal("Wo erhalten Sie Co-Epril? Welche Packungen sind erh�ltlich?", chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("", section.subheading)
		assert_equal(2, section.paragraphs.size)
		paragraph = section.paragraphs.last
		assert_equal('Packungen zu 30 und 100 Tabletten.', paragraph.text)
		assert_equal(2, paragraph.formats.size)
	end
	def test_distribution6
		chapter = @writer.distribution
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Zulassungsinhaberin', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(1, section.paragraphs.size)
		assert_equal("Ecosol AG, Z�rich.", section.paragraphs.first.text)
	end
	def test_date_dummy6
		chapter = @writer.date_dummy
		assert_instance_of(ODDB::Text::Chapter, chapter)
		assert_equal('Diese Packungsbeilage wurde im M�rz 2002 letztmals durch die Arzneimittelbeh�rde (Swissmedic) gepr�ft.', chapter.heading)
		assert_equal(0, chapter.sections.size)
	end
	def test_date6
		chapter = @writer.date
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Stand der Information', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(2, section.paragraphs.size)
		assert_equal("Diese Packungsbeilage wurde im M�rz 2002 letztmals durch die Arzneimittelbeh�rde (Swissmedic) gepr�ft.", section.paragraphs.first.text)
	end
end
class TestPatinfoHtmlParser00914 < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/de/00914.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)
	end
	def test_distribution7
		chapter = @writer.distribution
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Zulassungsinhaberin', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(1, section.paragraphs.size)
		assert_equal("Padma AG, Wiesenstrasse 5, 8603 Schwerzenbach.", section.paragraphs.first.text)
	end
	def test_date7
		chapter = @writer.date
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Stand der Information', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(2, section.paragraphs.size)
		assert_equal("Diese Packungsbeilage wurde im November 2002 letztmals durch die Arzneimittelbeh�rde (Swissmedic) gepr�ft.", section.paragraphs.first.text)
	end
end
class TestPatinfoHtmlParser06028 < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/de/06028.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	end
	def test_name8
		assert_equal('Aspirin�/Aspirin� 500', @writer.name)
	end
	def test_company8
		chapter = @writer.company
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('BAYER', chapter.heading)
	end
	def test_galenic_form8
		chapter = @writer.galenic_form
		assert_instance_of(ODDB::Text::Chapter, chapter)
		assert_equal("Tabletten und Kautabletten zu 500 mg\nInstant-Tabletten zu 500 mg", chapter.heading)
		assert_equal(0, chapter.sections.size)
	end
	def test_effects8
		chapter = @writer.effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Eigenschaften/Verwendungszweck', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Was ist Aspirin und wann wird es angewendet?\n", section.subheading)
		assert_equal(2, section.paragraphs.size)
		paragraph = section.paragraphs.first
		expected = "Aspirin enth�lt den Wirkstoff Acetylsalicyls�ure. Dieser wirkt schmerzlindernd und fiebersenkend."
		assert_equal(expected, paragraph.text)
	end
end
class TestPatinfoHtmlParser00907_fr < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/fr/00907.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	end
	def test_name9
		assert_equal('Arteoptic� 0,5%, 1%, 2%', @writer.name)
	end
	def test_company9
		chapter = @writer.company
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('CHAUVIN NOVOPHARMA', chapter.heading)
	end
	def test_galenic_form9
		chapter = @writer.galenic_form
		assert_instance_of(ODDB::Text::Chapter, chapter)
		assert_equal('Collyre', chapter.heading)
		assert_equal(0, chapter.sections.size)
	end
	def test_effects9
		chapter = @writer.effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Propri�t�s/Emploi th�rapeutique', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Qu'est-ce que Arteoptic et quand est-il utilis�?\n", section.subheading)
		assert_equal(1, section.paragraphs.size)
		paragraph = section.paragraphs.first
		expected = "Arteoptic contient un b�ta-bloquant qui fait baisser la pression intra-oculaire. Arteoptic est utilis� en cas d'augmentation de la pression intra-oculaire, pour prot�ger vos yeux d'une aggravation irr�versible de la vision sous l'effet d'un glaucome. Arteoptic collyre ne peut �tre utilis� que sur ordonnance m�dicale."
		assert_equal(expected, paragraph.text)
	end
	def test_amendments9
		chapter = @writer.amendments
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Compl�ment d\'information', chapter.heading)
		assert_equal(2, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("De quoi faut-il tenir compte en dehors du traitement?\n", section.subheading)
		assert_equal(1, section.paragraphs.size)
		section = chapter.sections.last
		assert_equal("Conseils pour porteurs de lentilles de contact:", section.subheading)
	end
	def test_contra_indications9
		chapter = @writer.contra_indications
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Contre-indications',chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Quand Arteoptic ne doit-il pas �tre utilis�?\n", section.subheading)
		assert_equal(1, section.paragraphs.size)
	end
	def test_precautions9
		chapter = @writer.precautions
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Pr�cautions', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Quelles sont les mesures de pr�caution � observer lors de l'utilisation de Arteoptic?\n", section.subheading)
		assert_equal(2, section.paragraphs.size)
	end
	def test_pregnancy9
		chapter = @writer.pregnancy
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Grossesse/Allaitement', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Arteoptic peut-il �tre utilis� pendant la grossesse ou l'allaitement?\n", section.subheading)
		assert_equal(1, section.paragraphs.size)
	end
	def test_usage9
		chapter = @writer.usage
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Posologie/Mode d\'emploi', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Comment utiliser Arteoptic?\n", section.subheading)
		assert_equal(5, section.paragraphs.size)
	end
	def test_unwanted_effects9
		chapter = @writer.unwanted_effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Effets ind�sirables', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Quels effets ind�sirables Arteoptic peut-il avoir?\n", section.subheading)
		assert_equal(3, section.paragraphs.size)
	end
	def test_general_advice9
		chapter = @writer.general_advice
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Remarques particuli�res', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("De quoi faut-il en outre tenir compte?\n", section.subheading)
		assert_equal(4, section.paragraphs.size)
	end
	def test_composition9
		chapter = @writer.composition
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Composition', chapter.heading)
		assert_equal(2, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Principe actif", section.subheading)
		assert_equal(1, section.paragraphs.size)
	end
	def test_packages9
		chapter = @writer.packages
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal("Mode de vente/Pr�sentation", chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("", section.subheading)
		assert_equal(2, section.paragraphs.size)
	end
	def test_distribution9
		chapter = @writer.distribution
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Distributeur', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("", section.subheading)
		assert_equal(1, section.paragraphs.size)
	end
	def test_date9
		chapter = @writer.date
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Mise � jour de l\'information', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("", section.subheading)
		assert_equal(1, section.paragraphs.size)
		assert_equal("Mai 2001.", section.paragraphs.first.text)
	end
end
class TestPatinfoHtmlParser05993_fr < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/fr/05993.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	end
	def test_amzv10
		chapter = @writer.amzv
		assert_instance_of(ODDB::Text::Chapter, chapter)
		assert_equal('OEM�d 9.11.2001', chapter.heading)
		assert_equal(0, chapter.sections.size)
	end
	def test_effects10
		chapter = @writer.effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Qu\'est-ce que Co-Epril et quand est-il utilis�?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(2, section.paragraphs.size)
		paragraph = section.paragraphs.first
		expected = "Co-Epril est un m�dicament contenant deux principes actifs destin� au traitement de l'hypertension art�rielle. L'effet de l'un des composants (l'�nalapril, un principe actif de la classe dite des inhibiteurs de l'ECA [inhibiteurs de l'enzyme de conversion de l'angiotensine]) repose sur l'inhibition de substances endog�nes responsables de la pression art�rielle trop �lev�e. L'autre composant (hydrochlorothiazide) augmente l'�limination r�nale de sel et d'eau. Les principes d'action des deux substances se renforcent mutuellement. La pression art�rielle peut ainsi �tre diminu�e efficacement."
		assert_equal(expected, paragraph.text)
	end
	def test_contra_indications10
		chapter = @writer.contra_indications
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Quand Co-Epril ne doit-il pas �tre utilis�?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(6, section.paragraphs.size)
		assert_equal("Ne prenez pas Co-Epril si", section.paragraphs.first.text)
	end
	def test_precautions10
		chapter = @writer.precautions
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Quelles sont les pr�cautions � observer lors de la prise/utilisation de Co-Epril?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(10, section.paragraphs.size)
		assert_equal("Ce m�dicament peut affecter les r�actions, l'aptitude � la conduite et l'aptitude � utiliser des outils ou des machines!", section.paragraphs.first.text)
	end
	def test_pregnancy10
		chapter = @writer.pregnancy
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Co-Epril peut-il �tre pris/utilis� pendant la grossesse ou l\'allaitement?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(1, section.paragraphs.size)
		assert_equal("Veuillez informer votre m�decin si vous �tes enceinte, si vous envisagez une grossesse ou si vous allaitez. Pendant la grossesse ou en p�riode d'allaitement, Co-Epril ne peut �tre pris que sur prescription expresse de votre m�decin.", section.paragraphs.first.text)
	end
	def test_usage10
		chapter = @writer.usage
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Comment utiliser Co-Epril?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(9, section.paragraphs.size)
		assert_equal("Co-Epril peut �tre pris avant, pendant ou apr�s les repas. La posologie est fix�e par le m�decin.", section.paragraphs.first.text)
	end
	def test_unwanted_effects10
		chapter = @writer.unwanted_effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Quels effets secondaires Co-Epril peut-il provoquer?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(9, section.paragraphs.size)
		assert_equal("La prise ou l'utilisation de Co-Epril peut provoquer les effets secondaires suivants:", section.paragraphs.first.text)
	end
	def test_general_advice10
		chapter = @writer.general_advice
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('A quoi faut-il encore faire attention?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(3, section.paragraphs.size)
		assert_equal("Le m�dicament ne doit pas �tre utilis� au-del� de la date figurant apr�s la mention �EXP� sur le r�cipient.", section.paragraphs.first.text)
	end
	def test_composition10
		chapter = @writer.composition
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Que contient Co-Epril?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(1, section.paragraphs.size)
		assert_equal("Co-Epril contient comme principes actifs 20 mg de mal�ate d'�nalapril et 12,5 mg d'hydrochlorothiazide ainsi que des excipients et est disponible sous forme de comprim�s s�cables.", section.paragraphs.first.text)
	end
	def test_date_dummy10
		chapter = @writer.date_dummy
		assert_instance_of(ODDB::Text::Chapter, chapter)
		assert_equal("Cette notice d'emballage a �t� contr�l�e par l'autorit� de contr�le des m�dicaments (Swissmedic) en mars 2002.", chapter.heading)
		assert_equal(0, chapter.sections.size)
	end
	def test_date10
		chapter = @writer.date
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal("Mise � jour de l'information", chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(2, section.paragraphs.size)
		assert_equal("Cette notice d'emballage a �t� contr�l�e par l'autorit� de contr�le des m�dicaments (Swissmedic) en mars 2002.", section.paragraphs.first.text)
	end
end
class TestPatinfoHtmlParser06209 < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/de/06209.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	end
	def test_amzv11
		chapter = @writer.amzv
		assert_instance_of(ODDB::Text::Chapter, chapter)
		assert_equal('AMZV 9.11.2001', chapter.heading)
		assert_equal(0, chapter.sections.size)
	end
	def test_effects11
		chapter = @writer.effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Was ist Omed und wann wird es angewendet?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(8, section.paragraphs.size)
		paragraph = section.paragraphs.first
		expected = "Omed enthaelt den Wirkstoff Omeprazol. Dieser f�hrt zu einer Verminderung der Magensaeureproduktion. Omed dient zur Behandlung von:"
		assert_equal(expected, paragraph.text)
	end
	def test_amendments11
		chapter = @writer.amendments
		assert_instance_of(ODDB::Text::Chapter, chapter)
		assert_equal('Was sollte dazu beachtet werden?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(1, section.paragraphs.size)
		paragraph = section.paragraphs.first
		expected = "Eine durch Magensaeure hervorgerufene Entz�ndung oder ein Geschw�r kann nur richtig behandelt werden, wenn Sie sich genau an die mit Ihrem Arzt oder Ihrer �rztin besprochenen Anweisungen halten."
		assert_equal(expected, paragraph.text)
	end
	def test_contra_indications11
		chapter = @writer.contra_indications
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Wann darf Omed nicht angewendet werden?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(2, section.paragraphs.size)
		expected = "Omed darf nicht eingenommen werden bei bekannter �berempfindlichkeit auf den Wirkstoff oder einen der Hilfsstoffe."
		assert_equal(expected, section.paragraphs.first.text)
	end
end
class TestPatinfoHtmlParser01300 < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/de/01300.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	end
	def test_name10
		assert_equal('Liberol� Baby N', @writer.name)
	end
	def test_company10
		chapter = @writer.company
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('SEMOMED', chapter.heading)
	end
	def test_effects10
		chapter = @writer.effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Eigenschaften/Verwendungszweck', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Was ist Liberol Baby N Salbe und wann wird sie angewendet?\n", section.subheading)
		assert_equal(1, section.paragraphs.size)
		paragraph = section.paragraphs.first
		expected = "Liberol Baby N ist eine Kombination �therischer �le. Diese durchdringen die Haut, loesen z�hen Schleim, steigern die Durchblutung der Haut. Liberol Baby N eignet sich speziell fuer S�uglinge und Kleinkinder bei Erk�ltung mit Husten, Schnupfen und Brustkatarrh."
		assert_equal(expected, paragraph.text)
	end
	def test_contra_indications10
		chapter = @writer.contra_indications
		assert_instance_of(ODDB::Text::Chapter, chapter) 
		assert_equal('Kontraindikationen',chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Wann darf Liberol Baby N Salbe nicht angewendet werden?\n", section.subheading)
		assert_equal(2, section.paragraphs.size)
	end
	def test_precautions10
		chapter = @writer.precautions
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Vorsichtsmassnahmen', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Wann ist bei der Anwendung von Liberol Baby N Salbe Vorsicht geboten?\n", section.subheading)
		assert_equal(2, section.paragraphs.size)
	end
	def test_usage10
		chapter = @writer.usage
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Dosierung/Anwendung', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Wie verwenden Sie Liberol Baby N Salbe?\n", section.subheading)
		assert_equal(3, section.paragraphs.size)
	end
	def test_unwanted_effects10
		chapter = @writer.unwanted_effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Unerwuenschte Wirkungen', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Welche Nebenwirkungen kann Liberol Baby N Salbe haben?\n", section.subheading)
		assert_equal(1, section.paragraphs.size)
	end
end
class TestPatinfoHtmlParser00415 < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/de/00415.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	end
	def test_name11
		assert_equal('Geriavit Pharmaton�', @writer.name)
	end
	def test_company11
		chapter = @writer.company
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('PHARMATON', chapter.heading)
	end
	def test_effects11
		chapter = @writer.effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Eigenschaften/Verwendungszweck', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Was ist Geriavit Pharmaton und wann wird es angewendet?\n", section.subheading)
		assert_equal(4, section.paragraphs.size)
		paragraph = section.paragraphs.first
		expected = "Geriavit Pharmaton ist ein Kombinationspraeparat aus Ginseng-Extrakt G115, Vitaminen, Mineralstoffen und Spurenelementen."
		assert_equal(expected, paragraph.text)
	end
	def test_amendments11
		chapter = @writer.amendments
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Ergaenzungen', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Was sollte dazu beachtet werden?\n", section.subheading)
		assert_equal(1, section.paragraphs.size)
	end
	def test_pregnancy11
		chapter = @writer.pregnancy
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Schwangerschaft/Stillzeit', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Darf Geriavit Pharmaton waehrend einer Schwangerschaft oder in der Stillzeit eingenommen werden?\n", section.subheading)
		assert_equal(5, section.paragraphs.size)
	end
	def test_usage11
		chapter = @writer.usage
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Dosierung/Anwendung', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Wie verwenden Sie Geriavit Pharmaton?\n", section.subheading)
		assert_equal(4, section.paragraphs.size)
	end
	def test_unwanted_effects11
		chapter = @writer.unwanted_effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Unerwuenschte Wirkungen', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Welche Nebenwirkungen kann Geriavit Pharmaton haben?\n", section.subheading)
		assert_equal(1, section.paragraphs.size)
	end
	def test_general_advice11
		chapter = @writer.general_advice
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Allgemeine Hinweise', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Was ist ferner zu beachten?\n", section.subheading)
		assert_equal(3, section.paragraphs.size)
	end
	def test_date11
		chapter = @writer.date
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Stand der Information', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("", section.subheading)
		assert_equal(1, section.paragraphs.size)
		assert_equal("Januar 1997.", section.paragraphs.first.text)
	end
class TestPatinfoHtmlParser00555 < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/de/00555.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	end
	def test_amzv12
		chapter = @writer.amzv
		assert_instance_of(ODDB::Text::Chapter, chapter)
		assert_equal('AMZV 9.11.2001', chapter.heading)
		assert_equal(0, chapter.sections.size)
	end
	def test_effects12
		chapter = @writer.effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Was ist Prostatonin und wann wird es angewendet?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(3, section.paragraphs.size)
		paragraph = section.paragraphs.first
		expected = "Prostatonin ist ein Kombinationspraeparat, das bei Beschwerden infolge Prostatavergroesserung (Prostatahyperplasie), und damit verbundenen Stoerungen beim Wasserlassen verwendet wird."
		assert_equal(expected, paragraph.text)
	end
	def test_contra_indications12
		chapter = @writer.contra_indications
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Wann darf Prostatonin nicht oder nur mit Vorsicht angewendet werden?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(2, section.paragraphs.size)
		assert_equal("Bis heute sind keine Anwendungseinschraenkungen bekannt. Bei bestimmungsgemaessem Gebrauch sind keine besonderen Vorsichtsmassnahmen notwendig.", section.paragraphs.first.text)
	end
	def test_usage12
		chapter = @writer.usage
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Wie verwenden Sie Prostatonin?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(3, section.paragraphs.size)
		assert_equal("Sofern nicht anders verschrieben, 2mal taeglich 1 Kapsel unzerkaut mit etwas Fluessigkeit nach den Mahlzeiten einnehmen.", section.paragraphs.first.text)
	end
end
end
class TestPatinfoHtmlParser00013 < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/fr/00013.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	end
	def test_general_advice12
		chapter = @writer.general_advice
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Remarques particuli�res', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("De quoi faut-il en outre tenir compte?\n", section.subheading)
		assert_equal(3, section.paragraphs.size)
	end
	def test_composition12
		chapter = @writer.composition
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Composition', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("", section.subheading)
		assert_equal(1, section.paragraphs.size)
		assert_equal("L'Akineton/Akineton retard contient 2 mg contient resp. 4 mg de chlorhydrate de bip�rid�ne (principe actif) ainsi que des excipients pour la fabrication de comprim�s.", section.paragraphs.first.text)
	end
	def test_sale13
		chapter = @writer.packages
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Mode d\'emploi/Pr�sentation', chapter.heading)
		assert_equal(3, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("", section.subheading)
		assert_equal(1, section.paragraphs.size)
		assert_equal("En pharmacie, sur ordonnance m�dicale.", section.paragraphs.first.text)
	end
	def test_date12
		chapter = @writer.date
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Mise � jour de l\'information', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("", section.subheading)
		assert_equal(1, section.paragraphs.size)
		assert_equal("Mai 1999.", section.paragraphs.first.text)
	end
end
class TestPatinfoHtmlParser00116 < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/fr/00116.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	end
	def test_name18
		assert_equal('Klyx Magnum�', @writer.name)
	end
	def test_usage18
		chapter = @writer.usage
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Posologie/Mode d\'emploi', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("Comment utiliser Klyx Magnum?\n", section.subheading)
		assert_equal(2, section.paragraphs.size)
	end
	def test_composition18
		chapter = @writer.composition
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Composition', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(3, section.paragraphs.size)
	end
	def test_distribution18
		chapter = @writer.distribution
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Distributeur', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("", section.subheading)
		assert_equal(1, section.paragraphs.size)
		assert_equal("Ferring S.A., 8304 Wallisellen.", section.paragraphs.first.text)
	end
	def test_date18
		chapter = @writer.date
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Mise � jour de l\'information', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal("", section.subheading)
		assert_equal(1, section.paragraphs.size)
		assert_equal("Avril 1990.", section.paragraphs.first.text)
	end
end
class TestPatinfoHtmlParser00117 < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/de/00744.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	end	
	def test_composition19
		chapter = @writer.composition
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Zusammensetzung', chapter.heading)
		assert_equal(2, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(3, section.paragraphs.size)
	end
	def test_distribution19
		chapter = @writer.distribution
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Vertriebsfirma', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section= chapter.sections.first
		assert_equal("", section.subheading)
		assert_equal(1, section.paragraphs.size)
	end
end
class TestPatinfoHtmlParser00018 < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/de/00455.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	end
	def test_packages18
		chapter = @writer.packages
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Packungen', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(1, section.paragraphs.size)
	end
end
class TestPatinfoHtmlParser03831 < Test::Unit::TestCase
	def setup
		path = File.expand_path('data/html/de/03831.html', 
			File.dirname(__FILE__))
		@html = File.read(path)
		@writer = ODDB::FiParse::PatinfoHtmlWriter.new
		@formatter = ODDB::HtmlFormatter.new(@writer)
		@parser = ODDB::HtmlParser.new(@formatter)
		@parser.feed(@html)	
	end
	def test_amzv20
		chapter = @writer.amzv
		assert_instance_of(ODDB::Text::Chapter, chapter)
		assert_equal('AMZV 9.11.2001', chapter.heading)
		assert_equal(0, chapter.sections.size)
	end
	def test_effects20
		chapter = @writer.effects
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal("Was ist Co-Diovan/- Forte 160/12,5/- Forte 160/25\nund wann wird es angewendet?", chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(4, section.paragraphs.size)
		paragraph = section.paragraphs.first
		expected = "Co-Diovan/- Forte 160/12,5/- Forte 160/25 enth�lt zwei sich erg�nzende Wirksubstanzen, die das blutdruckregulierende System des K�rpers beeinflussen: Valsartan, das in erster Linie zu einer Erweiterung der Blutgef�sse f�hrt und damit den Blutdruck senkt, und Hydrochlorothiazid, welches den Natriumchlorid- und Wassergehalt im K�rper vermindert, indem es die Urinausscheidung erh�ht."
		assert_equal(expected, paragraph.text)
	end
	def test_amendment20
		chapter = @writer.amendments
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Was sollte dazu beachtet werden?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(1, section.paragraphs.size)
		assert_equal("Wenn ein hoher Blutdruck nicht behandelt wird, k�nnen lebenswichtige Organe wie das Herz, die Nieren und das Hirn gesch�digt werden. Sie k�nnen sich wohl f�hlen und keine Symptome haben, aber die unbehandelte Hypertonie kann zu Sp�tfolgen wie z.B. Hirnschlag, Herzinfarkt, Herzschw�che, Nierenfunktionsst�rungen oder Erblinden f�hren.", section.paragraphs.first.text)
		end
	def test_contra_indications20
		chapter = @writer.contra_indications
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal('Wann darf Co-Diovan/- Forte 160/12,5/- Forte 160/25 nicht angewendet werden?', chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(1, section.paragraphs.size)
		assert_equal("Sie sollten Co-Diovan/- Forte 160/12,5/- Forte 160/25 nicht einnehmen, wenn Sie jemals �berempfindlich oder allergisch auf Valsartan, Hydrochlorothiazid oder einen anderen Bestandteil dieses Arzneimittels reagiert haben. Bei Schwangerschaft, w�hrend der Stillzeit oder wenn Sie an einer schweren Leber- oder Nierenerkrankung, Gicht, Nierensteinen (Uratsteinen) oder starken St�rungen des Elektrolythaushaltes leiden, sollte Co-Diovan/- Forte 160/12,5/- Forte 160/25 nicht angewendet werden. Falls fr�her anl�sslich der Einnahme eines blutdrucksenkenden Medikamentes Schwellungen im Gesicht, auf Lippen, Zunge oder im Rachen (Schluck- oder Atembeschwerden) auftraten, d�rfen Sie Co-Diovan/- Forte 160/12,5/- Forte 160/25 nicht einnehmen.", section.paragraphs.first.text)
		end
	def test_precautions20
		chapter = @writer.precautions
		assert_instance_of(ODDB::Text::Chapter, chapter )
		assert_equal("Wann ist bei der Einnahme/Anwendung von Co-Diovan/\n- Forte 160/12,5/- Forte160/25 Vorsicht geboten?", chapter.heading)
		assert_equal(1, chapter.sections.size)
		section = chapter.sections.first
		assert_equal(10, section.paragraphs.size)
		assert_equal("Wie jedes andere blutdrucksenkende Mittel kann auch Co-Diovan/- Forte 160/12,5/- Forte 160/25 Ihre Aufmerksamkeit und Konzentration herabsetzen. Daher ist Vorsicht im Strassenverkehr und beim Bedienen von Maschinen geboten.", section.paragraphs.first.text)
	end
end
