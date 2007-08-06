#!/usr/bin/env ruby
# TestMiGeLPlugin -- oddb -- 30.08.2005 -- hwyss@ywesee.com

$: << File.expand_path('../../src', 
	File.dirname(__FILE__))
$: << File.expand_path('..', File.dirname(__FILE__))


require 'test/unit'
require 'plugin/migel'
require 'flexmock'

module ODDB
	class TestMiGeLPlugin < Test::Unit::TestCase
		def setup
			@app = FlexMock.new
			@plugin = MiGeLPlugin.new(@app)
		end
		def test_update_group__id
			row = [
"03.","","APPLIKATIONSHILFEN","Ger�tereparaturen beim Kaufsystem: Bei sorgf�ltigem Gebrauch ohne Selbstverschuldung, Verg�tung nach Aufwand nur nach vorg�ngiger Kostengutsprache durch den Krankenversicherer.","03.02","","Insulinpumpen","","","","","","","03.02.01.00.2","L","Insulinpumpen-System, Miete
Inkl. Zubeh�r und Verbrauchsmaterial.
Limitation: Kosten�bernahme nur auf vorg�ngige besondere Gutsprache des Krankenversicherers und mit ausdr�cklicher Bewilligung des Vertrauensarztes oder der Vertrauens�rztin.
Zur Insulintherapie bei:
- Extrem labiler Diabetes.
-  Einstellung auch mit der Methode der   Mehrfachinjektionen unbefriedigend.
-  Indikationen des Pumpeneinsatzes und   Betreuung des Patienten durch ein   qualifiziertes Zentrum oder, nach    R�cksprache mit dem Vertrauensarzt, durch  einen Arzt, der in der Anwendung der   Insulinpumpen ausgebildet ist.","","Miete/Tag","9","B","01.01.2006"
			]
			id = %w(03 02 01 00 199)
			ptr = Persistence::Pointer.new([:migel_group, '03'])
			pointers = [ptr, ptr + :limitation_text]
			expecteds = [
				{
					:code => '03',
					:de    => 'APPLIKATIONSHILFEN',
				},
				{
					:de    => "Ger�tereparaturen beim Kaufsystem: Bei sorgf�ltigem Gebrauch ohne Selbstverschuldung, Verg�tung nach Aufwand nur nach vorg�ngiger Kostengutsprache durch den Krankenversicherer.",
				},
			]
			@app.mock_handle(:update, 2) { |pointer, values|
				ptr = pointers.shift
				assert_equal(ptr.creator, pointer)
				expected = expecteds.shift
				assert_equal(expected, values)
			}
			@plugin.update_group(id, row, :de)
			@app.mock_verify
		end
		def test_update_group__de
			row = [
"03.","","APPLIKATIONSHILFEN","Ger�tereparaturen beim Kaufsystem: Bei sorgf�ltigem Gebrauch ohne Selbstverschuldung, Verg�tung nach Aufwand nur nach vorg�ngiger Kostengutsprache durch den Krankenversicherer.","03.02","","Insulinpumpen","","","","","","","03.02.01.00.2","L","Insulinpumpen-System, Miete
Inkl. Zubeh�r und Verbrauchsmaterial.
Limitation: Kosten�bernahme nur auf vorg�ngige besondere Gutsprache des Krankenversicherers und mit ausdr�cklicher Bewilligung des Vertrauensarztes oder der Vertrauens�rztin.
Zur Insulintherapie bei:
- Extrem labiler Diabetes.
-  Einstellung auch mit der Methode der   Mehrfachinjektionen unbefriedigend.
-  Indikationen des Pumpeneinsatzes und   Betreuung des Patienten durch ein   qualifiziertes Zentrum oder, nach    R�cksprache mit dem Vertrauensarzt, durch  einen Arzt, der in der Anwendung der   Insulinpumpen ausgebildet ist.","","Miete/Tag","9","B","01.01.2006"
			]
			id = %w(03 02 01 00 2)
			ptr = Persistence::Pointer.new([:migel_group, '03'])
			pointers = [ptr, ptr + :limitation_text]
			expecteds = [
				{
					:code => '03',
					:de    => 'APPLIKATIONSHILFEN',
				},
				{
					:de    => "Ger�tereparaturen beim Kaufsystem: Bei sorgf�ltigem Gebrauch ohne Selbstverschuldung, Verg�tung nach Aufwand nur nach vorg�ngiger Kostengutsprache durch den Krankenversicherer.",
				},
			]
			@app.mock_handle(:update, 2) { |pointer, values|
				ptr = pointers.shift
				assert_equal(ptr.creator, pointer)
				expected = expecteds.shift
				assert_equal(expected, values)
			}
			@plugin.update_group(id, row, :de)
			@app.mock_verify
		end
		def test_update_group__fr
			row = [
"03.","","MOYENS D'APPLICATION","R�paration des appareils selon le syst�me d'achat: en cas d'utilisation soigneuse sans erreur de la part de l'utilisateur, contribution selon les frais, seulement apr�s demande de remboursement pr�alable aupr�s de l'assureur-maladie.","03.02","","Pompes � insuline","","","","","","","03.02.01.00.2","L","Syst�me pompe � insuline, location
Y c. accessoires et mat�riel � usage unique.
Limitation: prise en charge seulement si l'assureur-maladie a donn� pr�alablement une garantie sp�ciale et avec l'autorisation expresse du m�decin-conseil. La th�rapie est li�e aux conditions suivantes:
-  diab�te extr�mement labile;  
-  impossibilit� de stabiliser l'affection de mani�re  satisfaisante par la m�thode des injections  multiples;  
-  indication d'une pose de pompe et suivi du  patient dans un centre sp�cialis� ou, avec  l'accord du  m�decinconseil, par un m�decin  exp�riment� dans l'utilisation des pompes �  insuline.","","location/jour",9,"B","01.01.2006"
			]
			id = %w(03 02 01 00 2)
			ptr = Persistence::Pointer.new([:migel_group, '03'])
			pointers = [ptr, ptr + :limitation_text]
			expecteds = [
				{
					:code => '03',
					:fr    => 'MOYENS D\'APPLICATION',
				},
				{
					:fr    => "R�paration des appareils selon le syst�me d'achat: en cas d'utilisation soigneuse sans erreur de la part de l'utilisateur, contribution selon les frais, seulement apr�s demande de remboursement pr�alable aupr�s de l'assureur-maladie.",
				},
			]
			@app.mock_handle(:update, 2) { |pointer, values|
				ptr = pointers.shift
				assert_equal(ptr.creator, pointer)
				expected = expecteds.shift
				assert_equal(expected, values)
			}
			@plugin.update_group(id, row, :fr)
			@app.mock_verify
		end
		def test_update_subgroup
			row = [
"03.","","APPLIKATIONSHILFEN","Ger�tereparaturen beim Kaufsystem: Bei sorgf�ltigem Gebrauch ohne Selbstverschuldung, Verg�tung nach Aufwand nur nach vorg�ngiger Kostengutsprache durch den Krankenversicherer.","03.02","","Insulinpumpen","","","","","","","03.02.01.00.2","L","Insulinpumpen-System, Miete
Inkl. Zubeh�r und Verbrauchsmaterial.
Limitation: Kosten�bernahme nur auf vorg�ngige besondere Gutsprache des Krankenversicherers und mit ausdr�cklicher Bewilligung des Vertrauensarztes oder der Vertrauens�rztin.
Zur Insulintherapie bei:
- Extrem labiler Diabetes.
-  Einstellung auch mit der Methode der   Mehrfachinjektionen unbefriedigend.
-  Indikationen des Pumpeneinsatzes und   Betreuung des Patienten durch ein   qualifiziertes Zentrum oder, nach    R�cksprache mit dem Vertrauensarzt, durch  einen Arzt, der in der Anwendung der   Insulinpumpen ausgebildet ist.","","Miete/Tag","9","B","01.01.2006"
			]
			id = %w(03 02 01 00 2)
			group = FlexMock.new 
			group.mock_handle(:pointer) {
				Persistence::Pointer.new([:migel, '03'])
			}
			@app.mock_handle(:update, 1) { |pointer, values|
				ptr = Persistence::Pointer.new([:migel, '03'],[:subgroup, '02'])
				assert_equal(ptr.creator, pointer)
				expected = {
					:code => '02',
					:de => 'Insulinpumpen',
				}
				assert_equal(expected, values) 
 
			}
			@plugin.update_subgroup(id, group, row, :de)
			@app.mock_verify	
		end
		def test_update_subgroup__limitation
			row = [
"03.","","APPLIKATIONSHILFEN","Ger�tereparaturen beim Kaufsystem: Bei sorgf�ltigem Gebrauch ohne Selbstverschuldung, Verg�tung nach Aufwand nur nach vorg�ngiger Kostengutsprache durch den Krankenversicherer.","03.03","L","Infusionspumpen","Limitation: Zur Zytostatika-, Antibiotika-, Schmerz-, Chelatbildner-, Parkinsontherapie sowie f�r die parenterale Ern�hrung.","","","","","","03.03.02.06.2","","Nadel","1","St�ck",0.45,"B","01.01.2006"
			]
			id = %w(03 02 01 00 2)
			group = FlexMock.new 
			group.mock_handle(:pointer) {
				Persistence::Pointer.new([:migel, '03'])
			}
			ptr = Persistence::Pointer.new([:migel, '03'],[:subgroup, '02'])
			pointers = [ptr, ptr + [:limitation_text]]
			expecteds = [
				{
					:code => '02',
					:de => 'Infusionspumpen',
				},
				{
					:de => "Limitation: Zur Zytostatika-, Antibiotika-, Schmerz-, Chelatbildner-, Parkinsontherapie sowie f�r die parenterale Ern�hrung.",
				}
			]
			@app.mock_handle(:update, 2) { |pointer, values|
				ptr = pointers.shift
				assert_equal(ptr.creator, pointer)
				expected = expecteds.shift
				assert_equal(expected, values) 
 
			}
			@plugin.update_subgroup(id, group, row, :de)
			@app.mock_verify	
		end
		def test_update_product__naked_de
			row = [
"03.","","APPLIKATIONSHILFEN","Ger�tereparaturen beim Kaufsystem: Bei sorgf�ltigem Gebrauch ohne Selbstverschuldung, Verg�tung nach Aufwand nur nach vorg�ngiger Kostengutsprache durch den Krankenversicherer.","03.02","","Insulinpumpen","","","","","","","03.02.01.00.2","L","Insulinpumpen-System, Miete
Inkl. Zubeh�r und Verbrauchsmaterial.
Limitation: Kosten�bernahme nur auf vorg�ngige besondere Gutsprache des Krankenversicherers und mit ausdr�cklicher Bewilligung des Vertrauensarztes oder der Vertrauens�rztin.
Zur Insulintherapie bei:
- Extrem labiler Diabetes.
-  Einstellung auch mit der Methode der   Mehrfachinjektionen unbefriedigend.
-  Indikationen des Pumpeneinsatzes und   Betreuung des Patienten durch ein   qualifiziertes Zentrum oder, nach    R�cksprache mit dem Vertrauensarzt, durch  einen Arzt, der in der Anwendung der   Insulinpumpen ausgebildet ist.","","Miete/Tag","Fr. 9","B","01.01.2006"
			]
			id = %w(03 02 01 00 2)
			subgroup = FlexMock.new
			sg_pointer = Persistence::Pointer.new([:migel, '03'],
				[:subgroup, '02']) 
			subgroup.mock_handle(:pointer) {
				sg_pointer
			}
			pointer = sg_pointer + [:product, '01.00.2']
			pointers = [
				pointer,
				pointer + [:product_text],
				pointer + [:limitation_text],
				pointer + [:unit],
			]
			expecteds = [
				{
					:de => "Insulinpumpen-System, Miete",
					:price =>	900,
					:type	 => :rent,
					:date  => Date.new(2006),
					:limitation => true,
				},
				{
					:de => "Inkl. Zubeh�r und Verbrauchsmaterial.",
				},
				{
					:de => "Limitation: Kosten�bernahme nur auf vorg�ngige besondere Gutsprache des Krankenversicherers und mit ausdr�cklicher Bewilligung des Vertrauensarztes oder der Vertrauens�rztin.\nZur Insulintherapie bei:\n- Extrem labiler Diabetes.\n- Einstellung auch mit der Methode der Mehrfachinjektionen unbefriedigend.\n- Indikationen des Pumpeneinsatzes und Betreuung des Patienten durch ein qualifiziertes Zentrum oder, nach R�cksprache mit dem Vertrauensarzt, durch einen Arzt, der in der Anwendung der Insulinpumpen ausgebildet ist.",
				},
				{
					:de => 'Miete/Tag',
				},
			]
			@app.mock_handle(:update, 4) { |pointer, values|
				ptr = pointers.shift
				assert_equal(ptr.creator, pointer) 	
				expected = expecteds.shift
				assert_equal(expected, values)	
		  }	
			@plugin.update_product(id, subgroup, row, :de)
			@app.mock_verify
		end
		def test_update_product__naked_fr
			row = [
"03.","","MOYENS D'APPLICATION","R�paration des appareils selon le syst�me d'achat: en cas d'utilisation soigneuse sans erreur de la part de l'utilisateur, contribution selon les frais, seulement apr�s demande de remboursement pr�alable aupr�s de l'assureur-maladie.","03.02","","Pompes � insuline","","","","","","","03.02.01.00.2","L","Syst�me pompe � insuline, location
Y c. accessoires et mat�riel � usage unique.
Limitation: prise en charge seulement si l'assureur-maladie a donn� pr�alablement une garantie sp�ciale et avec l'autorisation expresse du m�decin-conseil. La th�rapie est li�e aux conditions suivantes:
-  diab�te extr�mement labile;  
-  impossibilit� de stabiliser l'affection de mani�re  satisfaisante par la m�thode des injections  multiples;  
-  indication d'une pose de pompe et suivi du  patient dans un centre sp�cialis� ou, avec  l'accord du  m�decinconseil, par un m�decin  exp�riment� dans l'utilisation des pompes �  insuline.","","location/jour",9,"B","01.01.2006"
			]
			id = %w(03 02 01 00 2)
			subgroup = FlexMock.new
			sg_pointer = Persistence::Pointer.new([:migel, '03'],
				[:subgroup, '02']) 
			subgroup.mock_handle(:pointer) {
				sg_pointer
			}
			pointer = sg_pointer + [:product, '01.00.2']
			pointers = [
				pointer,
				pointer + [:product_text],
				pointer + [:limitation_text],
				pointer + [:unit],
			]
			expecteds = [
				{
					:fr => "Syst�me pompe � insuline, location",
					:price =>	900,
					:type	 => :rent,
					:date  => Date.new(2006),
					:limitation => true,
				},
				{
					:fr => "Y c. accessoires et mat�riel � usage unique.",
				},
				{
					:fr => "Limitation: prise en charge seulement si l'assureur-maladie a donn� pr�alablement une garantie sp�ciale et avec l'autorisation expresse du m�decin-conseil. La th�rapie est li�e aux conditions suivantes:\n- diab�te extr�mement labile; \n- impossibilit� de stabiliser l'affection de mani�re satisfaisante par la m�thode des injections multiples; \n- indication d'une pose de pompe et suivi du patient dans un centre sp�cialis� ou, avec l'accord du m�decinconseil, par un m�decin exp�riment� dans l'utilisation des pompes � insuline.",
				},
				{
					:fr => 'location/jour',
				},
			]
			@app.mock_handle(:update, 4) { |pointer, values|
				ptr = pointers.shift
				assert_equal(ptr.creator, pointer) 	
				expected = expecteds.shift
				assert_equal(expected, values)	
		  }	
			@plugin.update_product(id, subgroup, row, :fr)
			@app.mock_verify
		end
		def test_update_product__no_extras
			row = [
"03.","","APPLIKATIONSHILFEN","Ger�tereparaturen beim Kaufsystem: Bei sorgf�ltigem Gebrauch ohne Selbstverschuldung, Verg�tung nach Aufwand nur nach vorg�ngiger Kostengutsprache durch den Krankenversicherer.","03.02","","Insulinpumpen","","","","","","","03.02.01.00.2","L","Insulinpumpen-System, Miete
Inkl. Zubeh�r und Verbrauchsmaterial.","","","9","B","01.01.2006"
			]
			id = %w(03 02 01 00 2)
			subgroup = FlexMock.new
			sg_pointer = Persistence::Pointer.new([:migel, '03'],
				[:subgroup, '02']) 
			subgroup.mock_handle(:pointer) {
				sg_pointer
			}

			pointer = sg_pointer + [:product, '01.00.2']
			pointers = [
				pointer, pointer + :product_text,	
			]
			expecteds = [
				{
					:de => "Insulinpumpen-System, Miete",
					:price =>	900,
					:type	 => :rent,
					:date  => Date.new(2006),
					:limitation => true,
				},
				{	:de	=>	"Inkl. Zubeh�r und Verbrauchsmaterial."  },
			]
			@app.mock_handle(:update, 2) { |pointer, values|
				ptr = pointers.shift
				assert_equal(ptr.creator, pointer) 	
				expected = expecteds.shift
				assert_equal(expected, values)
		  }	
			@plugin.update_product(id, subgroup, row, :de)
			@app.mock_verify
		end
		def test_date_object
			assert_equal(Date.new(2005, 8,1), 
				@plugin.date_object('01.08.2005'))
			assert_nothing_raised {
				@plugin.date_object('')
			}
		end
	end
end
