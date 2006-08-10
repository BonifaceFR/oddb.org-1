#!/usr/bin/env ruby
# AnalysisParse::TestAnonymousListParser -- oddb -- 10.11.2005 -- hwyss@ywesee.com

$: << File.expand_path('../src', File.dirname(__FILE__))

require 'test/unit'
require 'anonymous_list_parser'

module ODDB
	module AnalysisParse
		class TestAnonymousListParser < Test::Unit::TestCase
			def setup
				@parser = AnonymousListParser.new
			end
			def test_parse_line__1
				src = <<-EOS
		 8531.00    50 Sqamous Cell Carcinoma (SCC).....?   9800.22
				EOS
				begin
					result = @parser.parse_line(src)
				end
				expected = {
					:code							=>	'8531.00',
					:group						=>	'8531',
					:position					=>	'00',
					:taxpoints				=>	50,
					:description			=>	'Sqamous Cell Carcinoma (SCC)',
					:anonymousgroup		=>	'9800',
					:anonymouspos			=>	'22',
					:list_title				=>	nil,
					:permission				=>	nil,
					:taxpoint_type		=>	nil,
				}
				assert_equal(expected,result)
			end
			def test_parse_line__2
				src = <<-EOS
8804.00  50 Chromosomenuntersuchung, Zuschlag f�r Ben�tzung von zus�tzlicher F�rbung (G-,Q-,R- oder C-B�nderung, Ag-NOR, hohe Aufl�sung, andere), pro F�rbung...?   9800.22
				EOS
				begin
					result = @parser.parse_line(src)
				end
				expected = {
					:code						=>	'8804.00',
					:group					=>	'8804',
					:position				=>	'00',
					:taxpoints			=>	50,
					:description		=>	'Chromosomenuntersuchung, Zuschlag f�r Ben�tzung von zus�tzlicher F�rbung (G-,Q-,R- oder C-B�nderung, Ag-NOR, hohe Aufl�sung, andere), pro F�rbung',
					:anonymousgroup =>	'9800',
					:anonymouspos		=>	'22',
					:list_title			=>	nil,
					:permission			=>	nil,
					:taxpoint_type	=>	nil,

				}
				assert_equal(expected, result)
			end
			def test_parse_line__3
				src =<<-EOS
8485.00  45 Prostata spezifisches Antigen (PSA) ?   9800.20
				EOS
				begin
					result = @parser.parse_line(src)
				end
				expected = {
					:code						=>	'8485.00',
					:group					=>	'8485',
					:position				=>	'00',
					:taxpoints			=>	45,
					:description		=>	'Prostata spezifisches Antigen (PSA)',
					:anonymousgroup	=>	'9800',
					:anonymouspos		=>	'20',
					:list_title			=>	nil,
					:permission			=>	nil,
					:taxpoint_type	=>	nil,
				}
				assert_equal(expected, result)
			end
			def test_parse_line__4
				src = <<-EOS
8806.00 300 In situ-Hybridisierung an Inter- phasekernen inkl. Pr�paration und Analyse von 20 oder mehr Zellen..? 9800.48
				EOS
				begin
					result = @parser.parse_line(src)
				end
				expected = {
					:code						=>	'8806.00',
					:group					=>	'8806',
					:position				=>	'00',
					:taxpoints			=>	300,
					:description		=>	'In situ-Hybridisierung an Interphasekernen inkl. Pr�paration und Analyse von 20 oder mehr Zellen',
					:anonymousgroup	=>	'9800',
					:anonymouspos		=>	'48',
					:list_title			=>	nil,
					:permission			=>	nil,
					:taxpoint_type	=>	nil,
				}
				assert_equal(expected, result)
			end
			def test_parse_line__5
				src = <<-EOS
8477.01 70 Primidon, inkl. Phenobarbital (Blut). ? 9800.26
				EOS
				begin
					result = @parser.parse_line(src)
				end
				expected = {
					:code						=>	'8477.01',
					:group					=>	'8477',
					:position				=>	'01',
					:taxpoints			=>	70,
					:description		=>	'Primidon, inkl. Phenobarbital (Blut)',
					:anonymousgroup	=>	'9800',
					:anonymouspos		=>	'26',
					:list_title			=>	nil,
					:permission			=>	nil,
					:taxpoint_type	=>	nil,
				}
				assert_equal(expected, result)
			end
			def test_parse_line__6
				src = <<-EOS
8810.19 50 1. Krebserkrankungen, famili�re
Pr�disposition; direkte oder
indirekte Mutationsanalyse bei
- heredit�rem Brust- oder
Ovarialkrebs-Syndrom, Gene
BRCA1 und BRCA2
- Polyposis coli oder attenuierter
Form der Polyposis coli, Gen
APC
- heredit�rem Colon-Carcinom-
Syndrom ohne Polyposis
(hereditary non polypotic colon
cancer HNPCC), Gene MLH1,
MSH2, MSH6 und PMS2
- Multiplen endokrinen Neoplasien ? 9800.22
				EOS
				begin
					result = @parser.parse_line(src)
				end
				expected = {
					:code							=>	'8810.19',
					:group						=>	'8810',
					:position					=>	'19',
					:taxpoints				=>	50,
					:description			=>	'1. Krebserkrankungen, famili�re Pr�disposition; direkte oder indirekte Mutationsanalyse bei
- heredit�rem Brust- oder Ovarialkrebs-Syndrom, Gene BRCA1 und BRCA2
- Polyposis coli oder attenuierter Form der Polyposis coli, Gen APC
- heredit�rem Colon-Carcinom-Syndrom ohne Polyposis (hereditary non polypotic colon cancer HNPCC), Gene MLH1, MSH2, MSH6 und PMS2
- Multiplen endokrinen Neoplasien',
					:anonymousgroup		=>	'9800',
					:anonymouspos			=>	'22',
					:list_title				=>	nil,
					:taxpoint_type		=>	nil,
					:permission				=>	nil,
				}
				assert_equal(expected, result)
			end
			def test_parse_page__1
				src = <<-EOS
Rev. Pos.-Nr. TP Bezeichnung Anonyme Nr.
8800.04 100 Chromosomenuntersuchung, maligne H�mopathien, Zuschlag f�r Zelltrennung und Einfrieren......? 9800.30
8801.00 400 Chromosomenuntersuchung,konstitutioneller Karyotyp..............? 9800.56
8801.01 50 Chromosomenuntersuchung, konstitutioneller Karyotyp, Zuschlag f�r �ber 25 analysierte Zellen.............................................? 9800.22
8801.02 100 Chromosomenuntersuchung, konstitutioneller Karyotyp, Zuschlag f�r �ber 50 analysierte Zellen.............................................? 9800.30
8802.00 600 Chromosomenuntersuchung, maligne H�mopathien, 10 karyo- typisierte Metaphasen oder 5 karyotypisierte Metaphasen und 15 analysierte Metaphasen...........? 9800.68
8802.01 300 Chromosomenuntersuchung,maligne H�mopathien, Zuschlag f�r zus�tzliche analysierte Zellen, 5 karyotypisierte Metaphasen oder 10 analysierte Metaphasen...........? 9800.48
8802.02 150 Chromosomenuntersuchung, maligne H�mopathien, Zuschlag f�r komplexe Anomalien (� 3 Anomalien)....................................? 9800.36 
8802.03 150 Chromosomenuntersuchung, maligne H�mopathien, Zuschlag f�r schwierige Analyse...................? 9800.36
8804.00 50 Chromosomenuntersuchung, Zuschlag f�r Ben�tzung von zus�tzlicher F�rbung (G-,Q-,R- oder C-B�nderung, Ag-NOR, hohe Aufl�sung, andere), pro F�rbung...? 9800.22
8805.00 250 Chromosomenuntersuchung, Zuschlag f�r in-situ Hybridisierung, pro Sonde......................................? 9800.44
8806.00 300 In situ-Hybridisierung an Inter- phasekernen inkl. Pr�paration und Analyse von 20 oder mehr Zellen..? 9800.48 112
				EOS
				begin
					result = @parser.parse_page(src,112)
				rescue AmbigousParseException => e
				end
				expected_first = {
					:code							=>	'8800.04',
					:group						=>	'8800',
					:position					=>	'04',
					:taxpoints				=>	100,
					:description			=>	'Chromosomenuntersuchung, maligne H�mopathien, Zuschlag f�r Zelltrennung und Einfrieren',
					:anonymousgroup		=>	'9800',
					:anonymouspos			=>	'30',
					:list_title				=>	nil,
					:permission				=>	nil,
					:taxpoint_type		=>	nil,
				}
				expected_last = {
					:code							=>	'8806.00',
					:group						=>	'8806',
					:position					=>	'00',
					:taxpoints				=>	300,
					:description			=>	'In situ-Hybridisierung an Interphasekernen inkl. Pr�paration und Analyse von 20 oder mehr Zellen',
					:anonymousgroup		=>	'9800',
					:anonymouspos			=>	'48',
					:list_title				=>	nil,
					:permission				=>	nil,
					:taxpoint_type		=>	nil,
				}
				expected_size = 11
				assert_equal(expected_first, result.first)
				assert_equal(expected_last, result.last)
				assert_equal(expected_size, result.size)
			end
			def test_fr_parse_line__1
				src = <<-EOS
8485.00   45  Prostate, antig�ne sp�cifique (PSA)  ?  9800.20
				EOS
				begin
					result = @parser.parse_line(src)
				end
				expected =	{
					:code						=>	'8485.00',
					:group					=>	'8485',
					:position				=>	'00',
					:taxpoints			=>	45,
					:description		=>	'Prostate, antig�ne sp�cifique (PSA)',
					:anonymousgroup	=>	'9800',
					:anonymouspos		=>	'20',
					:list_title			=>	nil,
					:permission			=>	nil,
					:taxpoint_type	=>	nil,
				} 
				assert_equal(expected, result)
			end
			def test_fr_parse_line__2
				src = <<-EOS
8810.09     20  D�termination du sexe, utilisation
lors de maladies h�r�ditaires li�es
au chromosome X..........................?  9800.10
				EOS
				begin
					result = @parser.parse_line(src)
				end
				expected = {
					:code							=>	'8810.09',
					:group						=>	'8810',
					:position					=>	'09',
					:taxpoints				=>	20,
					:description			=>	'D�termination du sexe, utilisation lors de maladies h�r�ditaires li�es au chromosome X',
					:anonymousgroup		=>	'9800',
					:anonymouspos			=>	'10',
					:list_title				=>	nil,
					:permission				=>	nil,
					:taxpoint_type		=>	nil,
				}
				assert_equal(expected, result)
			end
			def test_fr_parse_line__3
				src = <<-EOS
8810.13     50  Maladies d'h�mostase; recherche
				d'une mutation ou d'un polymor-
				phisme li� lors d'h�mophilies A et
				B, troubles du facteur II et du
				facteur V.........................................?  9800.22
				EOS
				begin
					result = @parser.parse_line(src)
				end
				expected = {
					:code						=>	'8810.13',
					:group					=>	'8810',
					:position				=>	'13',
					:taxpoints			=>	50,
					:description		=>	'Maladies d\'h�mostase; recherche d\'une mutation ou d\'un polymorphisme li� lors d\'h�mophilies A et B, troubles du facteur II et du facteur V',
					:anonymousgroup	=>	'9800',
					:anonymouspos		=>	'22',
					:list_title			=>	nil,
					:taxpoint_type	=>	nil,
					:permission			=>	nil,
				}
				assert_equal(expected, result)
			end
			def test_fr_parse_line__4
				src = <<-EOS
				     8810.23     50  Dystrophies musculaires; recherche
				d'une mutation ou d'un polymor-
				phisme li� lors de dystrophies de
				Duchenne et de Becker, troubles
				des prot�ines associ�s � la dystro-
				phine dans d'autres types de dys-
				trophies musculaires, dystrophie
				musculaire facio-scapulo-hum�ral  ?  9800.22

				EOS
				begin
					result = @parser.parse_line(src)
				end
				expected = {
					:code							=>	'8810.23',
					:group						=>	'8810',
					:position					=>	'23',
					:taxpoints				=>	50,
					:description			=>	'Dystrophies musculaires; recherche d\'une mutation ou d\'un polymorphisme li� lors de dystrophies de Duchenne et de Becker, troubles des prot�ines associ�s � la dystrophine dans d\'autres types de dystrophies musculaires, dystrophie musculaire facio-scapulo-hum�ral',	
					:anonymousgroup		=>	'9800',
					:anonymouspos			=>	'22',
					:list_title				=>	nil,
					:taxpoint_type		=>	nil,
					:permission				=>	nil,
				}
				assert_equal(expected, result)
			end
			def test_fr_parse_line__5
				src = <<-EOS
				     9116.07    60  HIV 1, test de confirmation des anti-
				corps p24 + gp41 (par EIA), ql        ?  9800.24
				EOS
				begin
					result = @parser.parse_line(src)
				end
				expected = {
					:code						=>	'9116.07',
					:group					=>	'9116',
					:position				=>	'07',
					:taxpoints			=>	60,
					:description		=>	'HIV 1, test de confirmation des anticorps p24 + gp41 (par EIA), ql',
					:anonymousgroup	=>	'9800',
					:anonymouspos		=>	'24',
					:list_title			=>	nil,
					:permission			=>	nil,
					:taxpoint_type	=>	nil,
				}
				assert_equal(expected, result)
			end
			def test_fr_parse_page__1
				src = <<-EOS
4.2  Positions anonymes
R�v. No pos. TP D�nomination No anonyme

8003.01  100 Cholin�sterase, iso-enzymes de l'ac�tyl~..........................................?  9800.30
8017.00 45 Alpha-1-foetoprotein (AFP)..............?  9800.20
8120.00 45 Beta-2- microglobuline.....................?  9800.20
8140.00 50 CA 125.............................................?  9800.22
8141.00 50 CA 15-3............................................?  9800.22
8142.00 50 CA 19-9............................................?  9800.22
8145.00 50 CA 72-4............................................?  9800.22
8145.01 50 CYFRA 21-1.....................................?  9800.22
8147.00 60 Calcitonine.......................................?  9800.24
8152.00 45 Antig�ne carcino-embryonnaire CEA ?  9800.20
8194.00 25 Fibres �lastiques apr�s enrichisse-
ment (mat�riel: lavage)..................?  9800.12
8212.00 125 Estradiol, r�cepteurs........................?  9800.34
8238.00 20 Fluorures..........................................?  9800.10
8345.00 12 Agglutinines froides, test de recherche.......................................?  9800.04
8430.01 45 MCA (antig�ne associ� au carcino-
me de type mucine.........................?  9800.20
8435.00 80 M�thotrexate (sang).........................?  9800.28
8461.01 70 Ph�nytoine, libre, y compris dosage
de la ph�nytoine totale (sang)........?  9800.26
8477.01 70 Primidone, y compris ph�nobarbital
(sang).............................................?  9800.26
8480.00 125 Progest�rone, r�cepteurs.................?  9800.34
8485.00 45 Prostate, antig�ne sp�cifique (PSA)  ?  9800.20
8485.01 25 Prostate, antig�ne sp�cifique (PSA),
libre, uniquement en combinaison
avec un PSA total entre 3 et 10
?g/l.................................................?  9800.12
8531.00 50 Sqamous Cell Carcinoma (SCC)......?  9800.22
8567.01 45 TPA (antig�ne polypeptidique
tissulaire)........................................?  9800.20
8800.01  250 Culture cellulaire et pr�paration
chromosomique, caryotype
constitutionnel................................?  9800.44
				111
				EOS
				begin
					result = @parser.parse_page(src, 111)
				end
				expected_first = {
				:code							=>	'8003.01',
				:group						=>	'8003',
				:position					=>	'01',
				:description			=>	'Cholin�sterase, iso-enzymes de l\'ac�tyl~',
				:anonymouspos			=>	'30',
				:anonymousgroup		=>	'9800',
				:taxpoints				=>	100,
				:taxpoint_type		=>	nil,
				:list_title				=>	nil,
				:permission				=>	nil,
				}
				expected_last = {
				:code							=>	'8800.01',
				:group						=>	'8800',
				:position					=>	'01',
				:description			=>	'Culture cellulaire et pr�paration chromosomique, caryotype constitutionnel',
				:anonymouspos			=>	'44',
				:anonymousgroup		=>	'9800',
				:taxpoints				=>	250,
				:taxpoint_type		=>	nil,
				:list_title				=>	nil,
				:permission				=>	nil,
				}
				assert_equal(expected_first, result.first)
				assert_equal(expected_last, result.last)
			end
		end
	end
end
