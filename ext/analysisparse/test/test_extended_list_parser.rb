#!/usr/bin/env ruby
# AnalysisParse::TestExtendedListParser -- oddb -- 10.11.2005 -- hwyss@ywesee.com

$: << File.expand_path('../src', File.dirname(__FILE__))

require 'test/unit'
require 'extended_list_parser'

module ODDB
	module AnalysisParse
		class TestExtendedListParser < Test::Unit::TestCase
			def setup
				@parser = ExtendedListParser.new
			end
			def test_parse_line__1
				src = <<-EOS
8317.00 35 Immunglobulin IgE total, qn
				EOS
				begin
					result = @parser.parse_line(src)
				rescue AmbigousParseException	=>	e
					puts e.inspect
				end
				expected = {
				:group				=>	'8317',
				:code					=>	'8317.00',
				:position			=>	'00',
				:taxpoints		=>	35,
				:description	=>	'Immunglobulin IgE total, qn',
				:taxpoint_type	=>	nil,
				:list_title			=>	nil,
				:permission			=>	nil,	
				}
				assert_equal(expected, result)
			end
			def test_parse_line__2
				src = <<-EOS
C 8272.00 30 H�matogramm V (automatisiert): wie
H�matogramm IV, flowzytometrische
Differenzierung der Leukozyten
Limitation: nicht mit QBC-Methode
				EOS
				begin
					result = @parser.parse_line(src)
				rescue AmbigousParseException => e
					puts e.inspect
				end
				expected = {
					:code						=>	'8272.00',
					:group					=>	'8272',
					:position				=>	'00',
					:analysis_revision				=>	'C',
					:taxpoints			=>	30,
					:description		=>	'H�matogramm V (automatisiert): wie H�matogramm IV, flowzytometrische Differenzierung der Leukozyten',
					:limitation			=>	'nicht mit QBC-Methode',
					:list_title			=>	nil,
					:permission			=>	nil,
					:taxpoint_type	=>	nil,
				}
				assert_equal(expected, result)
			end
			def test_parse_line__3
				src = <<-EOS
8317.01 25(1) Immunglobulin IgE - multispezifischer oder gruppenspezifischer Atopie-Screeningtest, ql/sq, ohne Unterscheidung einzelner spez. IgE
(1) analog abgestuftem Blocktarif gem�ss Punkt 5.7 der Vorbemerkungen, je nach Anzahl Allergene im verwendeten Testsystem
				EOS
				begin
					result = @parser.parse_line(src)
				rescue AmbigousParseException	=> e
					puts e.inspect
				end
				expected = {
					:code					=>	'8317.01',
					:group				=>	'8317',
					:position			=>	'01',
					:taxpoints		=>	25,
					:description	=>	'Immunglobulin IgE - multispezifischer oder gruppenspezifischer Atopie-Screeningtest, ql/sq, ohne Unterscheidung einzelner spez. IgE',
					:taxnumber		=>	'1',
					:taxnote			=>	'analog abgestuftem Blocktarif gem�ss Punkt 5.7 der Vorbemerkungen, je nach Anzahl Allergene im verwendeten Testsystem',
					:list_title		=>	nil,
					:permission		=>	nil,
					:taxpoint_type	=>	nil,
				}
				assert_equal(expected, result)
			end
			def test_parse_line__4
				src = <<-EOS
8317.02 45(1) Immunglobulin IgE - monospezifischer Multi-
Screeningtest, mindestens sq, mit
Unterscheidung einzelner spez. IgE (nicht 
kumulierbar mit 8317.04)
(1) analog abgestuftem Blocktarif gem�ss Punkt 5.7
der Vorbemerkungen, je nach Anzahl Allergene im
verwendeten Testsystem
				EOS
				begin
					result = @parser.parse_line(src)
				rescue AmbigousParseException => e
					puts e.inspect
				end
				expected = {
					:code					=>	'8317.02',
					:group				=>	'8317',
					:position			=>	'02',
					:taxpoints		=>	45,
					:taxnumber		=>	'1',
					:description	=>	'Immunglobulin IgE - monospezifischer Multi-Screeningtest, mindestens sq, mit Unterscheidung einzelner spez. IgE (nicht kumulierbar mit 8317.04)',
					:taxnote			=>	'analog abgestuftem Blocktarif gem�ss Punkt 5.7 der Vorbemerkungen, je nach Anzahl Allergene im verwendeten Testsystem',
					:list_title			=>	nil,
					:permission			=>	nil,
					:taxpoint_type	=>	nil,
				}
				assert_equal(expected, result)
			end
			def test_parse_line__5
				src = "      8572.00          9  Triglyceride\n"
				begin
					result = @parser.parse_line(src)
				rescue AmbigousParseException => e
					puts e.inspect
				end
				expected = {
					:code					=>	'8572.00',
					:description	=>"Triglyceride", 
					:position			=>"00", 
					:taxpoints		=>9, 
					:group				=>"8572",
					:list_title		=>	nil,
					:permission		=>	nil,
					:taxpoint_type	=>	nil,
				}
				assert_equal(expected, result)
			end
			def test_parse_line__6
				src = <<-EOS
9356.30 * 25 Spezielle Mikroskopie (Acridineorange, 
Ziehl-Neelsen, Auramin Phasenkontrast etc., KOH, Pilze)
				EOS
				begin
					result = @parser.parse_line(src)
				end
				expected = {
					:code						=>	'9356.30',
					:group					=>	'9356',
					:anonymous			=>	true,
					:position				=>	'30',
					:taxpoints			=>	25,
					:description		=>	'Spezielle Mikroskopie (Acridineorange, Ziehl-Neelsen, Auramin Phasenkontrast etc., KOH, Pilze)',
					:list_title			=>	nil,
					:permission			=>	nil,
					:taxpoint_type	=>	nil,
				}
				assert_equal(expected, result)
			end
			def test_parse_line__7
				src = <<-EOS
S 9710.00 8 Blutentnahme, Kapillarblut oder Venenpunktion, nur anwendbar durch
�rztliches Praxislaboratorium im Rahmen
der Pr�senzdiagnostik nach Artikel 54
Absatz 1 Buchstabe a KVV und Kapitel
5.1.2 der Analysenliste
Limitation: g�ltig ab 1.5.2004 bis 31.12.2005
				EOS
				begin
					result = @parser.parse_line(src)
				end
				expected = {
					:code					=>	'9710.00',
					:group				=>	'9710',
					:position			=>	'00',
					:taxpoints		=>	8,
					:analysis_revision			=>	'S',
					:description	=>	'Blutentnahme, Kapillarblut oder Venenpunktion, nur anwendbar durch �rztliches Praxislaboratorium im Rahmen der Pr�senzdiagnostik nach Artikel 54 Absatz 1 Buchstabe a KVV und Kapitel 5.1.2 der Analysenliste',
					:limitation		=>	'g�ltig ab 1.5.2004 bis 31.12.2005',
					:list_title			=>	nil,
					:permission			=>	nil,
					:taxpoint_type	=>	nil,
				}
				assert_equal(expected, result)
			end
			def test_parse_footnotes__1
				src = <<-EOS
1____________________________________________________________________________
 Nur bei Kindern bis zu 6 Jahren
* anonyme Position
				EOS
				begin
					result = @parser.parse_footnotes(src)
				end
				expected = {
				'1'			=>	'Nur bei Kindern bis zu 6 Jahren',
				'*'			=>	'anonyme Position',
				}
				assert_equal(expected, result)
			end
			def test_parse_footnotes__2
				src = <<-EOS
*Anonyme Position
1  Nur f�r Spit�ler
2 Nur f�r autorisierte Medizinalpersonen in Substitutions- oder Entzugsbehandlungen
3 Nur f�r Spit�ler und Pneumologen
4 Nur f�r Spit�ler, Pneumologen und H�matologen
				EOS
				begin
					result = @parser.parse_footnotes(src)
				end
				expected = {
				'*'				=>	'Anonyme Position',
				'1'				=>	'Nur f�r Spit�ler',
				'2'				=>	'Nur f�r autorisierte Medizinalpersonen in Substitutions- oder Entzugsbehandlungen',
				'3'				=>	'Nur f�r Spit�ler und Pneumologen',
				'4'				=>	'Nur f�r Spit�ler, Pneumologen und H�matologen',
				}
				assert_equal(expected, result)
			end
			def test_parse_footnotes__3
				src = <<-EOS
___________________________
*anonyme Position
1 Whatever!
				EOS
				begin
					result = @parser.parse_footnotes(src)
				end
				expected = {
				'*'			=>	'anonyme Position',
				'1'			=>	'Whatever!',
				}
				assert_equal(expected, result)
			end
			def test_parse_page__1
				src = <<-EOS
Physikalische Medizin und Rehabilitation Rev. Pos.-Nr. A TP Bezeichnung (Liste physik. Medizin und Rehabilitation)
8388.00 20 Kristallnachweis mit polarisiertem Licht 
8600.00 25 Zellz�hlung, sowie Differenzierung nach Anreicherung und F�rbung von K�rper- fl�ssigkeiten

EOS
				begin
					result = @parser.parse_page(src, 95)
				end
				expected = [
					{
					:code					=>	'8388.00',
					:group				=>	'8388',
					:position			=>	'00',
					:taxpoints		=>	20,
					:description	=>	'Kristallnachweis mit polarisiertem Licht',
					:list_title		=>	nil,
					:permission		=>	nil,
					:taxpoint_type	=>	nil,
				},
				{
					:code					=>	'8600.00',
					:group				=>	'8600',
					:position			=>	'00',
					:taxpoints		=>	25,
					:description	=>	'Zellz�hlung, sowie Differenzierung nach Anreicherung und F�rbung von K�rperfl�ssigkeiten',
					:list_title		=>	nil,
					:permission		=>	nil,
					:taxpoint_type	=>	nil,
				}
				]
				assert_equal(expected, result)
			end
			def test_parse_page__2
				src = <<-EOS
8543.00 1 40 Theophyllin (Blut)
1_________________________________________________________________________
 Nur bei Kindern bis zu 6 Jahren
* anonyme Position
				EOS
				begin
					result = @parser.parse_page(src, 11) 
				end
				expected = [
					{
					:code					=>	'8543.00',
					:group				=>	'8543',
					:position			=>	'00',
					:taxpoints		=>	40,
					:description	=>	'Theophyllin (Blut)',
					:restriction	=>	'1',
					:list_title		=>	nil,
					:taxpoint_type	=>	nil,
					:permission		=>	nil,
				}
				]
				assert_equal(expected, result)
			end
			def test_parse_page__3
				src = <<-EOS
Kinder- und Jugendmedizin
Rev. Pos.-Nr. A TP Bezeichnung (Liste Kinder- und Jugendmedizin)
1
8317.01 * 25(1) Immunglobulin IgE - multispezifischer oder gruppenspezifischer Atopie-Screeningtest, ql/sq, ohne Unterscheidung einzelner spez. IgE
(1) analog abgestuftem Blocktarif gem�ss Punkt 5.7 der Vorbemerkungen, je nach Anzahl Allergene im Verwendeten Testsystem
8543.00 1 40 Theophyllin (Blut)
1____________________________________________________________________________
 Nur bei Kindern bis zu 6 Jahren
* anonyme Position
	1
				EOS
				begin
					result = @parser.parse_page(src, 1)
				end
				expected = [
					{
					:code						=>	'8317.01',
					:group					=>	'8317',
					:position				=>	'01',
					:taxpoints			=>	25,
					:anonymous			=>	true,
					:description		=>	'Immunglobulin IgE - multispezifischer oder gruppenspezifischer Atopie-Screeningtest, ql/sq, ohne Unterscheidung einzelner spez. IgE',
					:taxnumber			=>	'1',
					:taxnote				=>	'analog abgestuftem Blocktarif gem�ss Punkt 5.7 der Vorbemerkungen, je nach Anzahl Allergene im Verwendeten Testsystem',
					:list_title			=>	nil,
					:permission			=>	nil,
					:taxpoint_type	=>	nil,
				},
				{
					:code						=>	'8543.00',
					:group					=>	'8543',
					:position				=>	'00',
					:taxpoints			=>	40,
					:description		=>	'Theophyllin (Blut)',
					:restriction		=>	'1',
					:list_title			=>	nil,
					:permission			=>	nil,
					:taxpoint_type	=>	nil,
				}
				]
				assert_equal(expected, result)
			end
			def test_parse_page__4
				src = <<-EOS
8249.00 9 Gamma-Glutamyltranspeptidase (GGT)
8265.00 1 30 Glykiertes H�moglobin (HbA1c)
C 8268.00 12 H�matogramm I (automatisiert)
___________________
*anonyme Position
1 Nur f�r mich

12

				EOS
				begin
					result = @parser.parse_page(src, 12)
				end
				expected = [
					{
					:code					=>	'8249.00',
					:group				=>	'8249',
					:position			=>	'00',
					:taxpoints		=>	9,
					:description	=>	'Gamma-Glutamyltranspeptidase (GGT)',
					:list_title		=>	nil,
					:permission		=>	nil,
					:taxpoint_type	=>	nil,
				},
				{
					:code					=>	'8265.00',
					:group				=>	'8265',
					:position			=>	'00',
					:taxpoints		=>	30,
					:description	=>	'Glykiertes H�moglobin (HbA1c)',
					:restriction	=>	'1',
					:list_title		=>	nil,
					:permission		=>	nil,
					:taxpoint_type	=>	nil,
				},
				{
					:code					=>	'8268.00',
					:group				=>	'8268',
					:position			=>	'00',
					:analysis_revision			=>	'C',
					:taxpoints		=>	12,
					:description	=>	'H�matogramm I (automatisiert)',
					:list_title			=>	nil,
					:permission			=>	nil,
					:taxpoint_type	=>	nil,
				}
				]
				assert_equal(expected, result)
			end
			def test_update_footnotes__1
				data = [
					{
					:group					=>	'8317',
					:position				=>	'00',
					:description		=>	'Immunglobulin IgE',
					:footnote				=>	'1',
				}
				]
				footnotes = {
				'1'							=>	'analog wie etwas anderes',
				}
				begin
					result = @parser.update_footnotes(data, footnotes)
				end
				expected = [
					{
					:group					=>	'8317',
					:position				=>	'00',
					:description		=>	'Immunglobulin IgE',
					:footnote				=>	'analog wie etwas anderes',
				}
				]
				assert_equal(expected, result)
			end
			def test_fr_parse_line__1
				src = <<-EOS
C 8210.00 6  �rythrocytes, num�ration, d�termination manuelle, cumulable avec 8273.00
h�matocrite, 8275.00 h�moglobine,
8406.00 leucocytes (num�ration) et
8560.00 thrombocytes (num�ration),
jusqu'� un total de max. 15 points
(h�mogramme II)
Limitation: pas avec la m�thode QBC
				EOS
				begin 
					result = @parser.parse_line(src)
				end
				expected = {
					:code						=>	'8210.00',
					:group					=>	'8210',	
					:position				=>	'00',
					:description		=>	'�rythrocytes, num�ration, d�termination manuelle, cumulable avec 8273.00 h�matocrite, 8275.00 h�moglobine, 8406.00 leucocytes (num�ration) et 8560.00 thrombocytes (num�ration), jusqu\'� un total de max. 15 points (h�mogramme II)',
					:analysis_revision	=>	'C',
					:taxpoints			=>	6,
					:list_title			=>	nil,
					:permission			=>	nil,
					:taxpoint_type	=>	nil,
					:limitation			=>	'pas avec la m�thode QBC',
				}
				assert_equal(expected, result)
			end
			def test_fr_parse_footnotes__1
				src = <<-EOS
				* position anonyme
				1 seulement pour h�pitaux
				2 seulement pour les personnes m�dicales autoris�es, dans le cadre de traitements de
				substitution ou de sevrage de leurs propres patients
				3 seulement pour h�pitaux et pneumologues
				4 seulement pour h�pitaux, pneumologues et h�matologues
				
				EOS
				begin
					result = @parser.parse_footnotes(src)
				end
				expected = {
				'*'	=>	'position anonyme',
				'1'	=>	'seulement pour h�pitaux',
				'2'	=>	'seulement pour les personnes m�dicales autoris�es, dans le cadre de traitements de substitution ou de sevrage de leurs propres patients',
				'3'	=>	'seulement pour h�pitaux et pneumologues',
				'4'	=>	'seulement pour h�pitaux, pneumologues et h�matologues',
				}
				assert_equal(expected, result)
			end
			def test_fr_parse_footnotes__2
				src = <<-EOS
_______________________________________________________________
* position anonyme
1	ta m�re
				EOS
				begin
					result = @parser.parse_footnotes(src)
				end
				expected = {
				'*'	=>	'position anonyme',
				'1'	=>	'ta m�re',
				}
				assert_equal(expected, result)
			end
			def test_fr_parse_footnotes__3
				src = <<-EOS
				1_____________________________________________________________________________________
				 seulement pour enfants jusqu~R� 6 ans
				* position anonyme

				EOS
				begin
					result = @parser.parse_footnotes(src)
				end
				expected =	{
					'*'		=>	'position anonyme',	
					'1'		=>	'seulement pour enfants jusqu\'� 6 ans',
				}
				assert_equal(expected, result)
			end
			def test_fr_parse_page__1
				src = <<-EOS
Oncologie m�dicale
Pour le moment comme h�matologie
P�diatrie
R�v. No pos. A TP D�nomination (liste p�diatrie)
8543.00 1 40 Th�ophylline (sang)
1____________________________________________________________________
 seulement pour enfants jusqu'� 6 ans
* position anonyme
				EOS
				begin
					result = @parser.parse_page(src, 121)
				end
				expected = [
					{
					:code					=>	'8543.00',
					:group				=>	'8543',
					:position			=>	'00',
					:taxpoints		=>	40,
					:description	=>	'Th�ophylline (sang)',
					:restriction	=>	'1',
					:list_title		=>	nil,
					:taxpoint_type	=>	nil,
					:permission		=>	nil,
				}
				]
				assert_equal(expected, result)
			end
			def test_fr_update_footnotes__1
				data = [
					{
					:group					=>	'8317',
					:position				=>	'00',
					:description		=>	'Immunoglobuline IgE totale, qn',
					:footnote				=>	'1',
				}
				] 
				footnotes = {
					'1'	=>	'seulement pour enfants jusqu\'� 6 ans',
				}
				begin
					result = @parser.update_footnotes(data, footnotes)
				end
				expected = [
					{
					:group					=>	'8317',
					:position				=>	'00',
					:description		=>	'Immunoglobuline IgE totale, qn',
					:footnote				=>	'seulement pour enfants jusqu\'� 6 ans',
				}
				]
				assert_equal(expected, result)
			end
		end
	end
end
