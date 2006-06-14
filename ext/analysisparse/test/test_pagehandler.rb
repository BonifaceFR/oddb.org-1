#!/usr/bin/env ruby
# TestPageHandler -- oddb.org -- 12.04.2006 -- sfrischknecht@ywesee.com

$: << File.expand_path('../src', File.dirname(__FILE__))

require 'test/unit'
require 'pagehandler'
require 'extended_list_parser'
require 'fragmented_page_handler'

module ODDB
	module AnalysisParse
		class TestIndexFinder < Test::Unit::TestCase
			def setup
				@index = {}
				@handler = IndexFinder.new
				@index_handler = IndexHandler.new(@index)
				@parser = FragmentedPageHandler.new
			end
			
			def test_index_finder__1
				src = <<-EOS
Systematische Auflistung der Analysen inkl. Anh�nge
1. Kapitel: Chemie/H�matologie/Immunologie............................. 41
				EOS
				begin
					result = @handler.next_pagehandler(src)
					assert_kind_of(IndexFinder, result)
					expected = {
						41	=>	'Chemie/H�matologie/Immunologie'
					}
					assert_equal(expected, result.index)
				end
			end
			def test_index_finder__2
				src = <<-EOS
				Systematische Auflistung der Analysen inkl. Anh�nge
				1. Kapitel: Chemie/H\uffffmatologie/Immunologie............................. 41
				2. Kapitel: Genetik
				2.1 Bemerkungen........................................................................ 75
				EOS
				begin
					result = @handler.next_pagehandler(src)
					assert_kind_of(IndexFinder, result)
					expected = {
						75	=>	'Genetik',
						41	=>	'Chemie/Huffffmatologie/Immunologie'
					}
					assert_equal(expected, result.index)
				end
			end
			def test_index_finder__3
				src = <<-EOS
				Inhalts�bersicht
				Vorbemerkungen
				1. Rechtsgrundlagen ....................................................................... 5
				1.1 Auszug aus dem Bundesgesetz vom 18. M�rz 1994
				�ber die Krankenversicherung (KVG) .................................. 5
				1.2 Auszug aus der Verordnung �ber die
				Krankenversicherung vom 27. Juni 1995 (KVV) ................ 13
				1.3 Auszug aus der Krankenpflege-Leistungsverordnung
				(KLV) vom 29. September 1995 ........................................ 20
				2. Erl�uterungen zu einzelnen Bestimmungen des KVG sowie
				der KVV und der KLV................................................................ 24
				EOS
				begin
					result = @handler.next_pagehandler(src)
					assert_kind_of(IndexFinder, result)
					expected = {
						24	=>	'Erl�uterungen zu einzelnen Bestimmungen des KVG sowie der KVV und der KLV',
						5		=>	'Rechtsgrundlagen'
					}
					assert_equal(expected, result.index)
				end
			end
			def test_index_finder__4
				src = <<-EOS
				Analysenliste
				Anhang 3 der Krankenpflege-Leistungsverordnung (KLV) vom
				29. September 1995
				Liste der von den Krankenversicherern im Rahmen der
				obligatorischen Krankenpflegeversicherung als Pflichtleistung zu
				verg�tenden Analysen
				Fassung vom 1. Januar 2006
				Die vorliegende Analysenliste ersetzt diejenige vom 1. Januar 2005
				Herausgegeben vom Eidgen�ssischen Departement des Innern
				Vertrieb:
				Bundesamt f�r Bauten und Logistik BBL, Vertrieb Publikationen,
				3003 Bern, Fax 031 325 50 58
				(Bestell-Nr. 316.935 d)
				http://www.bbl.admin.ch/internet/produkte_und_dienstleistungen/online_shop/alle/index
				.html?lang=de (Sucheingabe: Analysenliste)
				Die Analysenliste ist auch auf der Webseite des Bundesamtes f�r Gesundheit unter
				http://www.bag.admin.ch/kv/gesetze/d/index.htm ver�ffentlicht.

				3
				Inhalts�bersicht
				Vorbemerkungen
				1. Rechtsgrundlagen ....................................................................... 5
				1.1 Auszug aus dem Bundesgesetz vom 18. M�rz 1994
				�ber die Krankenversicherung (KVG) .................................. 5
				1.2 Auszug aus der Verordnung �ber die
				Krankenversicherung vom 27. Juni 1995 (KVV) ................ 13
				1.3 Auszug aus der Krankenpflege-Leistungsverordnung
				(KLV) vom 29. September 1995 ........................................ 20
				2. Erl�uterungen zu einzelnen Bestimmungen des KVG sowie
				der KVV und der KLV................................................................ 24
				2.1 Allgemeine Zulassungsbedingungen f�r Laboratorien....... 24
				2.2 Spezielle Zulassungsbedingungen f�r die
				verschiedenen Laboratoriumstypen................................... 25
				2.2.1 Laboratorien, die nur Analysen der Grundversorgung
				durchf�hren d�rfen ................................ 25
				2.2.2 Laboratorien, die ausser den Analysen der
				Grundversorgung weitere Analysen durchf�hren
				d�rfen........................................................................ 25
				2.2.3 Laboratorien, die Analysen des Kapitels Genetik
				der Analysenliste durchf�hren d�rfen ....................... 26
				2.2.4 Laboratorien, die Analysen des Kapitels Mikrobiologie
				der Analysenliste durchf�hren d�rfen.......... 27
				2.2.5 Speziallaboratorien ................................................... 27
				2.3 Anh�nge zur Analysenliste ................................................ 28
				2.4 Qualit�tssicherung als Voraussetzung der Verg�tung....... 29
				2.5 Durchf�hrung von Laboranalysen im Ausland ................... 29
				2.6 Vermittlung von Laboranalysen ......................................... 31
				2.7 Rechnungstellung .............................................................. 31
				2.8 �berpr�fung der Verordnung von Laboranalysen.............. 31
				2.9 Auskunfterteilung ............................................................... 32
				3. Medizinprodukte f�r die In-vitro-Diagnostik (IVD) ..................... 33
				EOS
				begin
					result = @handler.next_pagehandler(src)
					assert_kind_of(IndexFinder, result)
					expected = {
						33	=>	'Medizinprodukte f�r die In-vitro-Diagnostik (IVD)',
						5		=>	'Rechtsgrundlagen',
						24	=>	'Erl�uterungen zu einzelnen Bestimmungen des KVG sowie der KVV und der KLV'
					}
					assert_equal(expected, result.index)
				end
			end
			def test_index_finder__5
				src = <<-EOS
				Inhalts�bersicht
				Vorbemerkungen
				1. Rechtsgrundlagen ....................................................................... 5
				1.1 Auszug aus dem Bundesgesetz vom 18. M�rz 1994
				�ber die Krankenversicherung (KVG) .................................. 5
				1.2 Auszug aus der Verordnung �ber die
				Krankenversicherung vom 27. Juni 1995 (KVV) ................ 13
				1.3 Auszug aus der Krankenpflege-Leistungsverordnung
				(KLV) vom 29. September 1995 ........................................ 20
				2. Erl�uterungen zu einzelnen Bestimmungen des KVG sowie
				der KVV und der KLV................................................................ 24
				EOS
				begin
					result = @handler.next_pagehandler(src)
					assert_kind_of(IndexFinder, result)
					expected = {
						5		=>	'Rechtsgrundlagen',
						24	=>	'Erl�uterungen zu einzelnen Bestimmungen des KVG sowie der KVV und der KLV'
					}
					assert_equal(expected, result.index)
				end
			end
			def test_index_finder__6
				src = <<-EOS 
				Inhalts�bersicht
				Vorbemerkungen
				1. Rechtsgrundlagen ....................................................................... 5
				1.1 Auszug aus dem Bundesgesetz vom 18. M�rz 1994
				�ber die Krankenversicherung (KVG) .................................. 5
				1.2 Auszug aus der Verordnung �ber die
				Krankenversicherung vom 27. Juni 1995 (KVV) ................ 13
				1.3 Auszug aus der Krankenpflege-Leistungsverordnung
				(KLV) vom 29. September 1995 ........................................ 20
				2. Erl�uterungen zu einzelnen Bestimmungen des KVG sowie
				der KVV und der KLV................................................................ 24
				2.1 Allgemeine Zulassungsbedingungen f�r Laboratorien....... 24
				2.2 Spezielle Zulassungsbedingungen f�r die
				verschiedenen Laboratoriumstypen................................... 25
				2.2.1 Laboratorien, die nur Analysen der Grundversorgung
				durchf�hren d�rfen ................................ 25
				2.2.2 Laboratorien, die ausser den Analysen der
				Grundversorgung weitere Analysen durchf�hren
				d�rfen........................................................................ 25
				2.2.3 Laboratorien, die Analysen des Kapitels Genetik
				der Analysenliste durchf�hren d�rfen ....................... 26
				2.2.4 Laboratorien, die Analysen des Kapitels Mikrobiologie
				der Analysenliste durchf�hren d�rfen.......... 27
				2.2.5 Speziallaboratorien ................................................... 27
				2.3 Anh�nge zur Analysenliste ................................................ 28
				2.4 Qualit�tssicherung als Voraussetzung der Verg�tung....... 29
				2.5 Durchf�hrung von Laboranalysen im Ausland ................... 29
				2.6 Vermittlung von Laboranalysen ......................................... 31
				2.7 Rechnungstellung .............................................................. 31
				2.8 �berpr�fung der Verordnung von Laboranalysen.............. 31
				2.9 Auskunfterteilung ............................................................... 32
				3. Medizinprodukte f�r die In-vitro-Diagnostik (IVD) ..................... 33
				4. Antr�ge auf �nderungen der Eidgen�ssischen Analysenliste
				(AL) ........................................................................................... 33
				5. Tarif ........................................................................................... 35
				6. Systematik der Analysenlistenpositionen.................................. 37
				7. Abk�rzungen ............................................................................. 37
				8. Bemerkungen zur vorliegenden Ausgabe ................................. 39
				4
				Systematische Auflistung der Analysen inkl. Anh�nge
				1. Kapitel: Chemie/H�matologie/Immunologie............................. 41
				2. Kapitel: Genetik
				2.1 Bemerkungen........................................................................ 75
				2.2 Liste der Analysen ................................................................ 76
				2.2.1 Chromosomenanalysen.............................................. 76
				2.2.2 Molekulargenetische Analysen ................................... 78
				3. Kapitel: Mikrobiologie
				3.1 Virologie ................................................................................ 85
				3.2 Bakteriologie/Mykologie ........................................................ 96
				3.2.1 Bemerkungen ............................................................. 96
				3.2.2 Liste der Analysen ...................................................... 96
				3.3 Parasitologie ...................................................................... 105
				4. Kapitel: �brige
				4.1 Allgemeine Positionen ....................................................... 109
				4.2 Anonyme Positionen.......................................................... 111
				4.3 Fixe Analysenbl�cke.......................................................... 120
				4.4 Liste seltener Autoantik�rper ............................................. 121
				5. Kapitel: Anh�nge zur Analysenliste ....................................... 123
				5.1 Anhang A
				Im Rahmen der Grundversorgung durchgef�hrte Analysen
				5.1.1 Allgemeines .............................................................. 123
				5.1.2 �rztliches Praxislaboratorium
				5.1.2.1 Definition "Analysen im Rahmen der
				Grundversorgung" bezogen auf das �rztliche
				Praxislaboratorium........................................... 124
				5.1.2.2 Definition "�rztliches Praxislaboratorium"........ 124
				5.1.2.3 Definition "Pr�senzdiagnostik"......................... 125
				5.1.3 Analysen der Grundversorgung im engern Sinn....... 127
				5.1.4 Erweiterte Liste f�r Fach�rzte oder Fach�rztinnen... 132
				5.2 Anhang B
				Von Chiropraktoren oder Chiropraktorinnen veranlasste
				Analysen ............................................................................ 139
				5.3 Anhang C
				Von Hebammen veranlasste Analysen.............................. 141
				Alphabetisches Verzeichnis der Analysen
				(inkl. Synonyme) ........................................................................... 143
				EOS
				begin
					result = @handler.next_pagehandler(src)
					assert_kind_of(IndexFinder, result)
					expected = {
						75	=>	'Genetik',
						41	=>	'Chemie/H�matologie/Immunologie',
						5		=>	'Rechtsgrundlagen',
						24	=>	'Erl�uterungen zu einzelnen Bestimmungen des KVG sowie der KVV und der KLV',
						33	=>	'Antr�ge auf �nderungen der Eidgen�ssischen Analysenliste (AL)',
						35	=>	'Tarif',
						37	=>	'Abk�rzungen',
						39	=>	'Bemerkungen zur vorliegenden Ausgabe',
						85	=>	'Mikrobiologie',
						109	=>	'Allgemeine Positionen',
						111	=>	'Anonyme Positionen',
						120	=>	'Fixe Analysenbl�cke',
						121	=>	'Liste seltener Autoantik�rper',
						123	=>	'Im Rahmen der Grundversorgung durchgef�hrte Analysen',
						139	=>	'Von Chiropraktoren oder Chiropraktorinnen veranlasste Analysen',
						141	=>	'Von Hebammen veranlasste Analysen'
					}
					assert_equal(expected.sort, result.index.sort)
				end
			end
			def test_index_finder__7
				src = <<-EOS
4.1 Allgemeine Positionen.......................................................109
				EOS
				begin
					result = @handler.next_pagehandler(src)
				end
					assert_kind_of(IndexFinder, result)
					expected = {
				    109	=>	'Allgemeine Positionen',
					} 
					assert_equal(expected, result.index)
			end
			def test_parse_pages__1
				page_1 = <<-EOS
Teilliste 2

F�r diese Analysen gilt auch f�r das �rztliche Praxislaboratorium der
Analysenlistentarif (Taxpunktwert und Taxpunktzahl).

Rev. Pos. Nr.  A TP  Bezeichnung (Liste Grundversorgung, Teilliste 2)

1
C     8000.00        8    ABO/D-Antigen, Kontrolle nach Empfehlun-
gen BSD SRK "Erythrozytenserologische
Untersuchungen an Patientenproben"
        8006.00          9  Alanin-Aminotransferase (ALAT)
      8007.00          9  Albumin, chemisch
      8008.50         12   Albumin im Urin, sq
      8012.00          9  Alkalische Phosphatase
      8036.00 2      16   Amphetamine, ql (Urin) (im Screening mit
anderen Suchtstoffen: siehe 8535.04/05)
      8037.00          9    Amylase, im Blut/Plasma/Urin
      8058.00          9  Aspartat-Aminotransferase (ASAT)
      8116.00 2      16  Barbiturate, ql (Blut, Urin) (im Screening mit
anderen Suchtstoffen: siehe 8535.04/05)
      8119.00 2      16   Benzodiazepine, ql (Blut, Urin) (im
Screening mit anderen Suchtstoffen: siehe
8535.04/05)
      8126.00          9  Bilirubin, gesamt
      8129.00 3      30   Blutgase (pH, pCO , pO
abgeleitete Werte) 2          2, Bikarbonat, inkl.
      8129.10 4      50  Oxymetrieblock (Oxyh�moglobin,
Carboxyh�moglobin, Meth�moglobin)
      8137.00         23   C-reaktives Protein (CRP), qn
         8137.10         12  C-reaktives Protein (CRP), Schnelltest, sq
      8158.00          9  Cholesterin, total
      8169.00 2      14  Cocain, ql (Urin)(im Screening mit anderen
Suchtstoffen: siehe 8535.04/05)
      8184.00 2      16   Cannabis, ql (Urin) (im Screening mit
anderen Suchtstoffen: siehe 8535.04/05)
N     8191.00         10   Spezielle Mikroskopie, Nativpr�parat
(Dunkelfeld, Polarisation, Phasenkontrast)
                                                                                                                    129
				EOS
				page_2 = <<-EOS
Rev. Pos. Nr.  A TP  Bezeichnung (Liste Grundversorgung, Teilliste 2)

N     8560.10
    6    H�matologische Untersuchungen mit QBC-
Methode
Limitation: nur f�r H�moglobin und H�matokrit.
G�ltig ab 1.1.2006 bis 31.12.2006.
      8572.00          9  Triglyceride
      8574.11         16  Troponin (T oder I), Schnelltest, nicht
kumulierbar mit 8384.00 Kreatin-Kinase
(CK), total
      8578.00          9  Urat
C     8587.00 1      25   Vertr�glichkeitsprobe: Kreuzprobe nach
Empfehlungen BSD SRK "Erythrozyten-
serologische Untersuchungen an Patien-
tenproben", pro Erythrozytenkonzentrat
      9116.40    *  12   HIV-1+2 -Antik�rper (Screening) Schnelltest,
ql
S     9710.00          8  Blutentnahme, Kapillarblut oder
Venenpunktion, nur anwendbar durch
�rztliches Praxislaboratorium im Rahmen
der Pr�senzdiagnostik nach Artikel 54
Absatz 1 Buchstabe a KVV und Kapitel
5.1.2 der Analysenliste
  Limitation: g�ltig ab 1.5.2004 bis 31.12.2005
___________________________________________________________
*Anonyme Position
1  Nur f�r Spit�ler
2 Nur f�r autorisierte Medizinalpersonen in Substitutions- oder Entzugsbehandlungen
ihrer eigenen Patienten
3 Nur f�r Spit�ler und Pneumologen
4 Nur f�r Spit�ler, Pneumologen und H�matologen
                                                                                                                    131
				EOS
				begin
					res1 = @index_handler.parse_pages(page_1, 1, @parser)
					res2 = @index_handler.parse_pages(page_2, 2, @parser)
				end
				item1 = res1.last
				item2 = res2.first
				assert_equal('Teilliste 2', item2[:list_title])
				expected = {
				:group				=>	'8191',
				:position			=>	'00',
				:taxpoints		=>	10,
				:description	=>	'Spezielle Mikroskopie, Nativpr�parat (Dunkelfeld, Polarisation, Phasenkontrast)',
				:revision			=>	'N',
				:list_title		=>	'Teilliste 2'
				}
				assert_equal(expected, item1)
				expected = [
					{
				:revision			=>	'N',
				:group				=>	'8560',
				:position			=>	'10',
				:taxpoints		=>	6,
				:description	=>	'H�matologische Untersuchungen mit QBC-Methode',
				:limitation		=>	'nur f�r H�moglobin und H�matokrit. G�ltig ab 1.1.2006 bis 31.12.2006.',
				:list_title		=>	'Teilliste 2',
				},
					{
				:group				=>	'8572',
				:position			=>	'00',
				:taxpoints		=>	9,
				:description	=>	'Triglyceride',
				:list_title		=>	'Teilliste 2',
				},
					{
				:group				=>	'8574',
				:position			=>	'11',
				:taxpoints		=>	16,
				:description	=>	'Troponin (T oder I), Schnelltest, nicht kumulierbar mit 8384.00 Kreatin-Kinase (CK), total',
				:list_title		=>	'Teilliste 2',
				},
					{
				:group				=>	'8578',
				:position			=>	'00',
				:taxpoints		=>	9,
				:description	=>	'Urat',
				:list_title		=>	'Teilliste 2',	
				},
					{
				:group				=>	'8587',
				:position			=>	'00',
				:taxpoints		=>	25,
				:description	=>	'Vertr�glichkeitsprobe: Kreuzprobe nach Empfehlungen BSD SRK "Erythrozytenserologische Untersuchungen an Patientenproben", pro Erythrozytenkonzentrat',
				:list_title		=>	'Teilliste 2',
				:footnote			=>	'Nur f�r Spit�ler',
				:revision			=>	'C',
				},
					{
				:group				=>	'9116',
				:position			=>	'40',
				:taxpoints		=>	12,
				:description	=>	'HIV-1+2-Antik�rper (Screening) Schnelltest, ql',
				:list_title		=>	'Teilliste 2',
				:anonymous		=>	true,
				},
					{
				:revision			=>	'S',
				:group				=>	'9710',
				:position			=>	'00',
				:taxpoints		=>	8,
				:description	=>	'Blutentnahme, Kapillarblut oder Venenpunktion, nur anwendbar durch �rztliches Praxislaboratorium im Rahmen der Pr�senzdiagnostik nach Artikel 54 Absatz 1 Buchstabe a KVV und Kapitel 5.1.2 der Analysenliste',
				:limitation		=>	'g�ltig ab 1.5.2004 bis 31.12.2005',
				:list_title		=>	'Teilliste 2',
				},
				] 
				assert_equal(expected, res2)
			end
		end
	end
end
