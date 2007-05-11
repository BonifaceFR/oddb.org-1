#!/usr/bin/env ruby
# FiParse::TestMiniFi -- oddb.org -- 23.04.2007 -- hwyss@ywesee.com

$: << File.expand_path('../src', File.dirname(__FILE__))
$: << File.expand_path("../../../src", File.dirname(__FILE__))

require 'test/unit'
require 'minifi'

module ODDB
  module FiParse
    class TestMiniFiHandler < Test::Unit::TestCase
      def setup
        @writer = MiniFi::Handler.new
      end
      def test_smj_02_2003
        eval(File.read(File.expand_path('data/smj_02_2003.rb',
                                        File.dirname(__FILE__))))
        assert_equal(2, @writer.minifis.size)
        expected = [
          "Ceprotin", "Spiriva",
        ] 
        assert_equal(expected, 
                     @writer.minifis.collect { |mini| mini[:name] })
        mini1, mini2 = @writer.minifis

        assert_equal "Erstzulassung eines neuen Wirkstoffs: Ceprotin\256", mini1[:de].heading
        assert_equal "Autorisation d\351livr\351e pour un nouveau principe actif: Ceprotin\256", mini1[:fr].heading
      end
      def test_smj_05_2003
        eval(File.read(File.expand_path('data/smj_05_2003.rb',
                                        File.dirname(__FILE__))))
        assert_equal(2, @writer.minifis.size)
        expected = [
          "Cetrotide", "Ospolot",
        ] 
        assert_equal(expected, 
                     @writer.minifis.collect { |mini| mini[:name] })
        mini1, mini2 = @writer.minifis

        assert_equal "Zulassung eines neuen Wirkstoffes: Cetrorelix (Cetrotide�)", mini1[:de].heading
        assert_equal <<-EOS.strip, mini1[:de].sections.first.to_s
Am 30. April 2003 wurde das Pr�parat Cetrotide�, Pulver und L�sungsmittel zur Herstellung einer Injektionsl�sung mit dem Wirkstoff Cetrorelix f�r folgende Indikation zugelassen:
        EOS
        assert_equal <<-EOS.strip, mini1[:de].sections.last.to_s
Cetrotide, soll nur von Spezialisten mit Erfahrung auf diesem Gebiet verordnet werden.
Cetrotide, wird als subkutane Injektion verabreicht, entweder als t\344gliche Injektion von 0.25 mg oder als Einmaldosis zu 3 mg (bei Bedarf evtl. gefolgt von t\344glichen Injektionen zu 0.25 mg). Eine Wiederholung der Behandlung mit Cetrotide\256 \374ber mehrere Zyklen wurde nicht untersucht.
Cetrotide ist kontraindiziert im Falle einer \334berempfindlichkeit gegen\374ber Cetrorelix, anderen strukturellen Gonadorelin-Analoga, exogenen Peptidhormonen oder einem der Hilfsstoffe gem\344ss Zusammensetzung (Mannitol) sowie bei Patientinnen mit eingeschr\344nkter Leber- oder Nierenfunktion. Bei Frauen mit Neigung zu schweren Allergien wird von einer Behandlung mit Cetrotide abgeraten.
Wie bei anderen Behandlungen zur ovariellen Stimulation mit Gonadotropinen kann ein ovarielles Hyperstimulationssyndrom auftreten. Lokale Reaktionen an der Injektionsstelle, anaphylaktische/pseudoallergische Reaktionen geh\366ren zu den weiteren unerw\374nschten Wirkungen.
        EOS
        assert_equal "Autorisation d�livr�e pour un nouveau principe actif: C�tror�lix (Cetrotide�)", mini1[:fr].heading
        assert_equal <<-EOS.strip, mini1[:fr].sections.first.to_s
La pr�paration Cetrotide�, poudre et solvant pour solution injectable, comportant comme principe actif le c�tror�lix, a obtenu une autorisation de mise sur le march� le 30e avril 2003 pour l'indication suivante:
        EOS
        assert_equal <<-EOS.strip, mini1[:fr].sections.last.to_s
C\351tror\351lix est un antagoniste du facteur de lib\351ration de l'hormone lut\351inisante (LHRH). Le c\351tror\351lix entre en comp\351tition avec la LHRH endog\350ne au niveau des r\351cepteurs membranaires des cellules hypophysaires. La s\351cr\351tion des gonadotrophines (LH et FSH) peut ainsi \352tre contr\364l\351e.
La suppression de FSH et LH et la dur\351e d'action sont d\351pendantes de la dose. Chez la femme, le pic de LH est par cons\351quent retard\351, ce qui emp\352che une ovulation pr\351matur\351e survenant avant une maturation folliculaire suffisante. La suppression se produit presque imm\351diatement et sans effet stimulant initial, contrairement aux agonistes de la LHRH.
Cetrotide ne sera prescrit que par un sp\351cialiste de l'indication concern\351e.
Cetrotide est administr\351e en injection sous-cutan\351e, et est disponible soit pour une dose journali\350re de 0,25 mg soit pour une administration unique de 3 mg (\351ventuellement compl\351t\351es par la suite par des doses journali\350res de 0,25 mg).
Des administrations r\351p\351t\351es sur plusieurs cycles n'ont pas \351t\351 \351tudi\351es.
Cetrotide est contre-indiqu\351 en cas d'hypersensibilit\351 au c\351tror\351lix ou \340 tout autre analogue structural de la gonador\351line, aux hormones peptidiques exog\350nes ou aux excipients (mannitol), ainsi que chez les patientes pr\351sentant une insuffisance r\351nale ou h\351patique. Le traitement par Cetrotide n'est pas recommand\351 chez les femmes souffrant d'\351pisodes allergiques graves. Comme lors de tout processus de stimulation ovarienne par des gonadotrophines, un syndrome d'hyperstimulation ovarienne peut survenir. Des r\351actions au site d'injection et des r\351actions pseudo-allergiques / anaphylactiques ont \351galement \351t\351 observ\351es.
        EOS

        assert_equal "Zulassung eines neuen Wirkstoffes: Sultiam (Ospolot� Filmtabletten 50mg/200mg)", mini2[:de].heading
        assert_equal <<-EOS.strip, mini2[:de].sections.first.to_s
Am 15. Mai 2003 wurde das Pr�parat Ospolot� mit dem Wirkstoff Sultiam f�r folgende Indikation zugelassen: �Rolando-Epilepsie (benigne Epilepsie des Kindesalters mit zentrotemporalen spikes). Hinweis: Bei der Indikationsstellung f�r den Einsatz von Sultiam sollte ber�cksichtigt werden, dass die Rolando-Epilepsie eine hohe Rate an Spontanremissionen aufweist und - auch ohne medikament�se Behandlung - zumeist einen guten Verlauf und eine gute Prognose besitzt.�
        EOS
        assert_equal <<-EOS.strip, mini2[:de].sections.last.to_s
Bei der Verwendung von Ospolot ist zu beachten, dass die Dosierung individuell durch eine/n in der Epilepsiebehandlung erfahrene/n Neurop�diater/in festzulegen und zu kontrollieren ist.
Unter den in der Fachinformation umfassender dargestellten Kontraindikationen, Warnhinweisen und Vorsichtsmassnahmen ist die kontraindizierte Verwendung nicht nur in der Schwangerschaft, sondern auch bei allen M�dchen und Frauen im geb�rf�higen Alter besonders hervorzuheben. W�hrend der Behandlung sind insbesondere regelm�ssig Blutbild und Nierenfunktionsparameter zu kontrollieren. H�ufige unerw�nschte Wirkungen sind insbesondere zu Therapiebeginn u.a. (weitere und Deatils siehe FI) Tachypnoe (auf respiratorische Alkalose achten!) oder Dyspnoe, Nausea, Vomitus, M�digkeit, Schwindel und Kopfschmerzen. Schwerwiegendere, aber wesentlich seltenere sind Neutropenie, Stevens-Johnson- oder Lyell-Syndrom.
Sultiam kann mit einigen anderen Arzneistoffen, insbesondere auch anderen Antikonvulsiva interagieren, wodurch es auch zu toxischen Erscheinungen kommen kann. Bei einigen Kombinationen, insbesondere mit Phenytoin m�ssen daher die Plasmaspiegel von Sultiam und /oder den damit zusammen verabreichten Arzneistoffen kontrolliert werden.
        EOS
        assert_equal "Autorisation d�livr�e pour un nouveau principe actif: Sultiame (Ospolot�) comprim�s petticul�s 50mg/200mg)", mini2[:fr].heading
        assert_equal <<-EOS.strip, mini2[:fr].sections.first.to_s
Le 15 mai 2003, Ospolot� (principe actif: sultiame) a �t� autoris� pour l'indication suivante: �Epilepsie � paroxysmes rolandiques (�pilepsie b�nigne de l'enfance avec pointes centro-temporales). Remarque: Si on envisage d'employer le sultiame, il faut tenir compte du fait que l'�pilepsie � paroxysmes rolandiques pr�sente un taux �lev� de r�missions spontan�es et a - m�me sans traitement m�dicamenteux - une �volution le plus souvent favorable et un bon pronostic.�
        EOS
        assert_equal <<-EOS.strip, mini2[:fr].sections.last.to_s
Mis � part un certain nombre d'investigations qui n'�taient pas tellement syst�matiques, l'efficacit� clinique du sultiame dans l'�pilepsie � paroxysmes rolandiques n'a �t� d�montr�e que dans une seule �tude contr�l�e de faible envergure - (31 patients �g�s de 3 � 11 ans sous verum, 35 patients sous placebo) (Publication de cette �tude: Rating D, Wolf C, Thomas B: Sulthiame as Monotherapy in Children with benign Childhood Epilepsy with Centrotemporal Spikes: A 6-Month Randomized, Double-Blind, Placebo-Controlled Study. In: Epilepsia 41 (10): 1284-1288, 2000). Durant le traitement de 6 mois, quatre crises ont �t� observ�es dans le groupe des enfants trait�s au sultiame contre 21 crises dans le groupe placebo, une diff�rence statistiquement significative. Pour juger des r�sultats de cette �tude, il faut tenir compte du fait que seuls ont �t� inclus dans l'�tude des enfants s�lectionn�s pour des formes d'�pilepsie � paroxysmes rolandiques � �volution relativement grave, ceci parce que, comme indiqu� plus haut, l'�pilepsie � paroxysmes rolandiques ne requiert souvent pas de traitement.
Pour utiliser Ospolot, il faut veiller � ce que la posologie soit fix�e et contr�l�e individuellement pour chaque patient par un neurop�diatre exp�riment� dans le traitement de l'�pilepsie.
Dans les contre-indications, mises en garde et mesures de pr�caution pr�sent�es de mani�re exhaustive dans l'information professionnelle, on rel�vera tout particuli�rement que son utilisation est contre-indiqu�e non seulement durant la grossesse, mais �galement pour toutes les jeunes filles et les femmes en �ge de procr�er. Au cours du traitement, il faut surtout contr�ler r�guli�rement l'h�mogramme et les param�tres de la fonction r�nale.
Les effets ind�sirables fr�quents, surtout en d�but de traitement, sont entre autres (l'information professionnelle les mentionne tous en d�tail): la tachypn�e (attention � l'alcalose respiratoire!) ou la dyspn�e, les naus�es, les vomissements, la fatigue, les vertiges et les c�phal�es. Plus graves, mais nettement plus rares sont la neutrop�nie, le syndrome de Stevens-Johnson ou le syndrome de Lyell.
Le sultiame peut interagir avec quelques autres m�dicaments, en particuli�rement d'autres anticonvulsifs, pouvant provoquer des ph�nom�nes toxiques. Pour quelques associations, en particulier celles avec la ph�nyto�ne, les taux plasmatiques du sultiame et/ou des m�dicaments co-prescrits doivent par cons�quent �tre contr�l�s.
        EOS
      end
      def test_smj_08_2003
        eval(File.read(File.expand_path('data/smj_08_2003.rb',
                                        File.dirname(__FILE__))))
        assert_equal(2, @writer.minifis.size)
        expected = [
          "Fabrazyme", "Forsteo",
        ] 
        assert_equal(expected, 
                     @writer.minifis.collect { |mini| mini[:name] })
        mini1, mini2 = @writer.minifis

        assert_equal "Zulassung eines Arzneimittels mit neuem Wirkstoff: Fabrazyme� (Agalsidase Beta)", mini1[:de].heading
        assert_equal <<-EOS.strip, mini1[:de].sections.first.to_s
Am 25. Juli 2003 wurde das Pr�parat Fabrazyme� mit dem Wirkstoff Agalsidase Beta f�r folgende Indikation zugelassen:
        EOS
        assert_equal <<-EOS.strip, mini1[:de].sections.last.to_s
Die klinischen Effekte wurden in einer placebo-kontrollierten Studie gezeigt. Histologische Untersuchungen ergaben, dass nach 20 Behandlungswochen mit Fabrazyme GL-3 aus dem vaskul�ren Endothel entfernt wurde. Diese GL-3-Clearance wurde bei 69% der mit Fabrazyme behandelten Patienten erreicht im Vergleich zu keinem der Patienten unter Placebo. Die Behandlung mit Fabrazyme muss durch einen Arzt mit Erfahrung in der Behandlung von Morbus Fabry oder anderen erblichen Stoffwechselkrankheiten �berwacht werden. Die empfohlene Dosis betr�gt 1 mg/kg K�rpergewicht bei Anwendung einmal alle zwei Wochen als intraven�se Infusion. Weitere Details zur Dosierung k�nnen der Fachinformation entnommen werden.
Fabrazyme ist kontraindiziert bei lebensbedrohlicher �berempfindlichkeit gegen�ber Agalsidase Beta. 83% der Patienten entwickelten in der klinischen Studie IgG-Antik�rper gegen Agalsidase Beta. Patienten mit Antik�rpern gegen Agalsidase Beta haben ein erh�htes Risiko f�r �berempfindlichkeitsreaktionen. Patienten, bei denen w�hrend der Behandlung mit Fabrazyme im Rahmen von klinischen Studien �berempfindlichkeitsreaktionen auftraten, konnten nach Reduktion der Infusionsrate und einer Vorbehandlung mit Antihistaminika, Paracetamol, Ibuprofen und /oder Kortikosteroiden die Therapie weiterf�hren. Bei ungef�hr der H�lfte der Patienten traten am Infusionstag �berempfindlichkeitsreaktionen auf. Dazu geh�rten u.a. Fieber, Sch�ttelfrost, Engegef�hl in der Hals- und Brustgegend, R�tung, Juckreiz und Bronchokonstriktion.
        EOS
        assert_equal "Autorisation d�livr�e pour un m�dicament avec un nouveau principe actif: Fabrazyme� (Agalsidase b�ta)", mini1[:fr].heading
        assert_equal <<-EOS.strip, mini1[:fr].sections.first.to_s
Le 25 juilllet 2003, la pr�paration Fabrazyme�, avec pour principe actif la Agalsidase b�ta, a �t� autoris�e dans l'indication suivante:
        EOS
        assert_equal <<-EOS.strip, mini1[:fr].sections.last.to_s
Agalsidase b�ta est produite par g�nie g�n�tique � l'aide de cultures de cellules de mammif�res (Chinese Hamster Ovary-, CHO-Zellen); la s�quence des aminoacides de la forme recombinante, ainsi que la s�quence nucl�otidique qui l'a encod�e sont identique � la forme naturelle de l'a-galactosidase. L'a-galactosidase est une hydrolase lysosomale, qui agit en tant que catalysateur de l'hydrolyse des glycosphingolipides, notamment le globotriaosylc�ramide (GL-3) en galactose terminal et c�ramid dihexoside. L'activit� r�duite ou nulle de l'a-galactosidase entra�ne une accumulation de GL-3 dans de nombreux types de cellules, dont les cellules endoth�liales et parenchymateuses. L'objectif du traitement enzymatique substitutif par Fabrazyme� est de r�tablir un niveau d'activit� enzymatique suffisant pour hydroliser le substrat accumul�.
Lors d'un essai contr�l� contre placebo les effets cliniques de Fabrazyme� � �liminer GL-3 de l'endoth�lium vasculaire a �t� constat� par des analyses histologique apr�s 20 semaines de traitement. Cette elimination de GL-3 a �t� observ�e chez 69% de patients trait�s par Fabrazyme�, mais chez aucun des patients recevant le placebo.
Le traitement par Fabrazyme� doit �tre supervis� par un m�decin ayant l'experience de la prise en charge des patients atteints par la maladie de Fabry ou une autre maladie m�tabolique h�r�ditaire. La dose recommand� est de 1 mg/kg de poids corporel, administr�e une fois toutes les deux semaines par perfusion intraveneuse. Pour des plus amples informations concernant le dosage l'information professionnelle publi�e doit �tre consult�e.
Fabrazyme� est contre-indiqu� chez les patients pr�sentant une hypersensibilit� � l'agalsidase b�ta. Lors de l'essai clinique, 83% des patients ont d�velopp� des anticorps IgG contre l'agalsidase b�ta. Les patients poss�dant des anticorps pr�sentent un risque superieure de r�actions d'hypersensibilit�. Les patients ayant connu des r�actions d'hypersensibilit� lors du traitement par Fabrazyme� durant les essais cliniques ont poursuivi le traitement apr�s r�duction de la vitesse de perfusion et pr�traitement par antihistaminiques, parac�tamol, ibuprof�ne et/ou corticost�ro�des. Environ la moiti� des patients ont ressenti des r�actions d'hypersensibilit� le jour de la perfusion. Les r�actions les plus couremment rapport�es ont �t� entre autres fi�vre, frissons, sensation de constriction du pharynx, oppression thoracique, prurit, urticaire et constriction bronchique.
        EOS

        assert_equal "Zulassung eines Arzneimittels mit neuem Wirkstoff: Forsteo� (Teriparatid)", mini2[:de].heading
        assert_equal <<-EOS.strip, mini2[:de].sections.first.to_s
Am 8. August 2003 wurde das Pr�parat Forsteo� mit dem Wirkstoff Teriparatid f�r folgende Indikationen zugelassen:
        EOS
        assert_equal <<-EOS.strip, mini2[:de].sections.last.to_s
Forsteo erh�ht die Calciumausscheidung im Urin. Es kam nicht zu relevanten Ver�nderungen der Nierenfunktion. Es liegen keine Erfahrungen vor bei Patienten mit schwerer Niereninsuffizienz, unter Dialyse oder nach Nierentransplantation.
Die meisten Nebenwirkungen in den klinischen Studien waren geringen Schweregrades und betrafen in erster Linie Nausea, Schwindel und Beinkr�mpfe. Bei 2,8% der mit Forsteo behandelten Frauen wurden Antik�rper nachgewiesen, die mit Teriparatid kreuzreagierten.
        EOS
        assert_equal "Autorisation d�livr�e pour un m�dicament avec un nouveau principe actif: Forsteo� (t�riparatide)", mini2[:fr].heading
        assert_equal <<-EOS.strip, mini2[:fr].sections.first.to_s
Le 8 ao�t 2003, la pr�paration Forsteo�, avec pour principe actif la t�riparatide, a �t� autoris�e dans les indications suivantes:
        EOS
        assert_equal <<-EOS.strip, mini2[:fr].sections.last.to_s
Forsteo augmente l'excr�tion urinaire du calcium. Par contre, aucune modification significative de la fonction r�nale n'a �t� observ�e. Enfin, aucune donn�e n'est disponible pour les patients souffrant d'une insuffisance r�nale s�v�re, sous dialyse ou ayant subi une transplantation r�nale.
Les effets secondaires les plus fr�quemment rapport�s au cours des �tudes cliniques �taient b�nins. Il s'agissait principalement de naus�es, de vertiges et de douleurs dans les membres inf�rieurs. On a enfin mis en �vidence chez 2,8 % des femmes trait�es par Forsteo des anticorps pr�sentant une r�action crois�e avec la t�riparatide.
        EOS
      end
      def test_smj_12_2004
        eval(File.read(File.expand_path('data/smj_12_2004.rb',
                                        File.dirname(__FILE__))))
        assert_equal(5, @writer.minifis.size)
        expected = [
          "Avastin", "Emtriva", "Primovist", "Exanta", "Relestat",
        ] 
        assert_equal(expected, 
                     @writer.minifis.collect { |mini| mini[:name] })
        mini1, mini2, mini3, mini4, mini5 = @writer.minifis

        assert_equal "Zulassung des ersten Angiogenese Inhibitors gegen metastasiertes Karzinom des Kolons oder Rektums: Avastin\256 (Bevacizumab)", mini1[:de].heading
        assert_equal "Autorisation du premier inhibiteur de l'angiogen�se dans le traitement du cancer colo-rectal m�tastatique: Avastin� (b�vacizumab)", mini1[:fr].heading

        assert_equal "Wirkmechanismus:\n", 
                     mini2[:de].sections.last.subheading

        paragraph = mini2[:fr].sections.last.paragraphs.first
        format = paragraph.formats.at(1)
        assert_equal(1, format.end - format.start, "symbol-explosion")
        format = paragraph.formats.at(2)
        assert_equal(false, format.symbol?)
        assert_equal(-1, format.end)

        assert_equal "Zulassung eines Arzneimittels mit einem neuen Wirkstoff: Relestat\256 (Epinastin), Augentropfen 0,5mg/ml", mini5[:de].heading
        assert_equal "Autorisation d'un m�dicament contenant un nouveau principe actif: Relestat� (�pinastine), collyre 0,5mg/ml", mini5[:fr].heading
        assert_equal <<-EOS.strip, mini5[:fr].sections.last.to_s
Contre-indications et limitations d'utilisation:

Relestat� est contre-indiqu� chez les patients pr�sentant une hypersensibilit� � ce produit. Cette pr�paration contient en outre du chlorure de benzalkonium, un agent conservateur susceptible de causer des effets ind�sirables (k�ratopathies) qui restent cependant rares. Enfin, il convient de tenir compte du fait que le benzalkonium peut s'accumuler dans les lentilles de contact (souples) hydrophiles.
        EOS
      end
      def test_smj_02_2007
        eval(File.read(File.expand_path('data/smj_02_2007.rb',
                                        File.dirname(__FILE__))))
        assert_equal(3, @writer.minifis.size)
        expected = [
          "Sprycel", "Thyrogen", "Forthyron, ad us. vet.", 
        ] 
        assert_equal(expected, 
                     @writer.minifis.collect { |mini| mini[:name] })
        mini1, mini2, mini3 = @writer.minifis

        assert_equal "Zulassung eines Arzneimittels mit neuem Wirkstoff: Sprycel, Filmtabletten (Dasatinib)", mini1[:de].heading
        assert_equal <<-EOS.strip, mini1[:de].sections.first.to_s
Am 2. Februar 2007 wurde Sprycel, Filmtabletten 20 mg, 50 mg und 70 mg (Dasatinib) im beschleunigten Zulassungsverfahren zugelassen.
        EOS
        assert_equal <<-EOS.strip, mini1[:de].sections.last.to_s
Kontraindikationen bzw. Warnhinweise und Vorsichtsmassnahmen, Interaktionen

Kontraindikationen sind �berempfindlichkeit gegen�ber dem Wirkstoff oder einem der Hilfsstoffe, Schwangerschaft und Stillen.
Die h�ufigsten und dosislimitierenden unerw�nschten Wirkungen von Dasatinib sind Neutropenie Grad 3/4 und Thrombozytopenie Grad 3/4.
Erfahrungen bei Patienten mit Knochenmarktransplantation nach Sprycel liegen bisher nicht vor.
Schwere gastrointestinale H�morrhagien traten bei 5% der Patienten auf und erforderten im Allgemeinen ein Absetzen der Behandlung sowie Transfusionen.
Patienten unter Behandlung mit Thrombozytenaggregationshemmern oder Antikoagulantien wurden von der Teilnahme an klinischen Studien mit Sprycel ausgeschlossen. Dasatinib sollte nicht gleichzeitig mit anderen das Blutungsrisiko erh�henden Arzneimitteln verabreicht werden.
Fl�ssigkeitsretention war bei 7% der Patienten schwer ausgepr�gt und Pleura- und Perikarderg�sse, Aszites, generalisierte �deme und Lungen�deme nicht-kardialer Genese wurden beobachtet. Bei Atemnot sollte eine unverz�gliche Abkl�rung und angepasste Behandlung erfolgen.
Eine QT-Verl�ngerung wurde in klinischen Studien beobachtet. Vor Beginn der Behandlung sollte daher eine Abkl�rung durch ein Elektrokardiogramm erfolgen. Bei Patienten mit kongenitalem Long-QT-Syndrom oder bei gleichzeitiger Behandlung mit QT-verl�ngernden Arzneimitteln oder Antiarrhythmika sollte Dasatinib nur mit sehr grosser Vorsicht angewandt werden. Elektrolytst�rungen wie Hypokali�mie oder Hypomagnesi�mie sollten vorher korrigiert werden.
Patienten mit einer unkontrollierten oder relevanten Herzkreislauferkrankung wurden nicht in die klinischen Studien aufgenommen. Daher sollten diese Patienten mit Vorsicht behandelt werden.
Dasatinib ist ein Substrat von CYP 3A4 und PGP sowie ein Inhibitor von CYP 3A4 und CYP 2C8. Daher kann es bei Koadministration mit anderen Arzneimitteln, welche prim�r durch CYP 3A4 oder CYP 2C8 metabolisiert werden oder welche die Aktivit�t von CYP 3A4 und PGP beeinflussen, zu Interaktionen kommen.
Detaillierte Angaben sind der Arzneimittel-Fachinformation zu entnehmen.
        EOS
        assert_equal "Autorisation d'un m�dicament contenant un nouveau principe actif: Sprycel, comprim�s film�s (dasatinib)", mini1[:fr].heading
        assert_equal <<-EOS.strip, mini1[:fr].sections.first.to_s
Le 2 f�vrier 2007, Sprycel, comprim�s film�s 20 mg, 50 mg et 70 mg (dasatinib) a �t� autoris� au terme d'une proc�dure rapide d'autorisation.
        EOS
        assert_equal <<-EOS.strip, mini1[:fr].sections.last.to_s
Contre-indications, mises en garde et pr�cautions, interactions

Les contre-indications sont l'hypersensibilit� au principe actif ou � l'un des excipients, la grossesse et l'allaitement.
Les effets ind�sirables les plus fr�quents du dasatinib et qui obligent � limiter la dose administr�e sont la neutrop�nie de degr� 3 ou 4 et la thrombocytop�nie de degr� 3 ou 4.
On ne dispose d'aucune exp�rience chez les patients ayant subi une transplantation de moelle osseuse apr�s un traitement par Sprycel.
De graves h�morragies gastro-intestinales sont survenues chez 5 % des patients, qui ont n�cessit� en g�n�ral la suspension du traitement et des transfusions.
Les patients trait�s avec des antiagr�gants plaquettaires ou des anticoagulants ont �t� exclus des �tudes cliniques conduites avec Sprycel. Le dasatinib ne doit pas �tre administr� en m�me temps que d'autres m�dicaments qui augmentent le risque h�morragique.
Une r�tention hydrique s�v�re a �t� observ�e chez 7 % des patients, incluant des �panchements pleuraux et p�ricardiaques, des ascites, des oed�mes g�n�ralis�s et des oed�mes pulmonaires non cardiog�niques. En cas de dyspn�e, il faut imm�diatement effectuer un examen m�dical et administrer un traitement adapt�.
Un allongement de l'intervalle QT a �t� observ� lors des �tudes cliniques. Il convient donc d'effectuer un �lectrocardiogramme avant de d�buter le traitement. Par ailleurs, le dasatinib ne doit �tre administr� qu'avec la plus grande pr�caution aux patients qui pr�sentent un syndrome d'allongement cong�nital de l'intervalle QT ou qui sont trait�s par des m�dicaments antiarythmiques ou d'autres m�dicaments susceptibles d'entra�ner un allongement de l'intervalle QT. Les �ventuelles anomalies des �lectrolytes, telles que l'hypokali�mie ou l'hypomagn�s�mie, doivent �tre corrig�es avant le d�but du traitement par dasatinib.
Les patients pr�sentant des maladies cardiovasculaires incontr�l�es ou significatives n'ont pas �t� inclus dans les �tudes cliniques. Aussi convient-il de faire preuve de prudence avec ces patients.
Le dasatinib est un substrat du CYP 3A4 et de la PGP et un inhibiteur du CYP 3A4 et du CYP 2C8. Par cons�quent, il existe un risque potentiel d'interaction avec les m�dicaments principalement m�tabolis�s par le CYP 3A4 ou le CYP 2C8 ou qui influencent l'activit� du CYP 3A4 et de la PGP.
Pour de plus amples informations, il convient de consulter l'information professionnelle sur le m�dicament.
        EOS

        assert_equal "Zulassung eines Arzneimittels mit neuem Wirkstoff: Thyrogen�, Pulver zur Herstellung einer Injektionsl�sung, 0.9 mg (Thyrotropin alfa)", mini2[:de].heading
        assert_equal <<-EOS.strip, mini2[:de].sections.first.to_s
Das Pr�parat Thyrogen� mit dem Wirkstoff Thyrotropin alfa wurde am 9. Februar 2007 f�r folgende Indikation zugelassen:
        EOS
        assert_equal <<-EOS.strip, mini2[:de].sections.last.to_s
Warnhinweise und Vorsichtsmassnahmen:

Thyrogen darf nicht intraven�s verabreicht werden.
F�r vollst�ndige Informationen zum Pr�parat soll die Fachinformation konsultiert werden.
        EOS
        assert_equal "Autorisation d'un m�dicament contenant un nouveau principe actif: Thyrogen �, poudre pour solution injectable, 0.9 mg (thyrotropine alfa)", mini2[:fr].heading
        assert_equal <<-EOS.strip, mini2[:fr].sections.first.to_s
La pr�paration Thyrogen� comportant le principe actif thyrotropine alfa a �t� autoris�e le 9 f�vrier 2007 pour l'indication suivante:
        EOS
        assert_equal <<-EOS.strip, mini2[:fr].sections.last.to_s
Mises en garde et pr�cautions:

Thyrogen ne doit pas �tre administr� par voie intraveineuse.
Pour de plus amples informations, veuillez consulter l'information sur le m�dicament.
        EOS

        assert_equal "Zulassung eines Arzneimittels mit neuem Wirkstoff: Forthyron, ad us. vet., Tabletten (Levothyroxin)", mini3[:de].heading
        assert_equal(4, mini3[:de].sections.size)
        assert_equal <<-EOS.strip, mini3[:de].sections.first.to_s
Das Pr�parat Forthyron ad us.vet. wurde am 6. Februar 2007 als Tierarzneimittel f�r Hunde zugelassen.
        EOS
        assert_equal <<-EOS.strip, mini3[:de].sections.last.to_s
Das Pr�parat darf bei nicht korrigierter NNR-Insuffizienz nicht angewendet werden. Bei digitalisierten Hunden kann eine Anpassung der Digitalsidosis erforderlich sein. Bei Hunden mit Diabetis mellitus wird eine besonders sorgf�ltige �berwachung des Blutzuckerspiegels n�tig.
        EOS
        assert_equal "Autorisation d'un m�dicament contenant un nouveau principe actif: Forthyron ad us.v�t., comprim�s (l�vothyroxine)", mini3[:fr].heading
        assert_equal(4, mini3[:fr].sections.size)
        assert_equal <<-EOS.strip, mini3[:fr].sections.first.to_s
La pr�paration Forthyron ad us. v�t. a �t� autoris�e le 6 f�vrier 2007 en tant que m�dicament v�t�rinaire pour les chiens.
        EOS
        assert_equal <<-EOS.strip, mini3[:fr].sections.last.to_s
Ce m�dicament ne doit en revanche pas �tre administr� en cas d'insuffisance cortico-surr�nalienne. Chez les chiens digitalis�s, une adaptation de la dose de digitaline peut par ailleurs s'av�rer n�cessaire. Enfin, chez les chiens souffrant de diab�te sucr�, une surveillance particuli�rement �troite de la glyc�mie est imp�rative.
        EOS
      end
      def test_smj_03_2007
        eval(File.read(File.expand_path('data/smj_03_2007.rb',
                                        File.dirname(__FILE__))))
        assert_equal(5, @writer.minifis.size)
        expected = [
          "Acomplia", "Elaprase", "Procoralan", "Cortavance ad us. vet.",
          "Prac-tic ad us. vet.",
        ] 
        assert_equal(expected, 
                     @writer.minifis.collect { |mini| mini[:name] })

        mini1, mini2, mini3, mini4, mini5 = @writer.minifis
        assert_equal "Zulassung eines Arzneimittels mit neuem Wirkstoff: Acomplia�, Kapseln 20 mg (Rimonabant)", mini1[:de].heading
        assert_equal(12, mini1[:de].sections.size)
        assert_equal <<-EOS.strip, mini1[:de].sections.first.to_s
Am 15. M�rz 2007 wurden Acomplia� Kapseln 20mg von Swissmedic f�r folgende Indikation zugelassen:
        EOS
        assert_equal <<-EOS.strip, mini1[:de].sections.last.to_s
Swissmedic hat das Nutzen-Risiko-Verh�ltnis von Acomplia� f�r die zugelassene Indikation als g�nstig beurteilt, unter der Voraussetzung, dass die in der Fachinformation erw�hnten Warnhinweise und Vorsichtsmassnamen konsequent beachtet werden.
        EOS
        assert_equal "Autorisation d'un m�dicament contenant un nouveau principe actif: Acomplia�, g�lules 20 mg (rimonabant)", mini1[:fr].heading
        assert_equal(10, mini1[:fr].sections.size)
        assert_equal <<-EOS.strip, mini1[:fr].sections.first.to_s
Le 15 mars 2007, la pr�paration Acomplia� g�lules � 20 mg a �t� autoris�e par Swissmedic dans l'indication suivante:
        EOS
        assert_equal <<-EOS.strip, mini1[:fr].sections.last.to_s
Swissmedic a estim� que le rapport b�n�ficerisque d'Acomplia� �tait favorable pour l'indication autoris�e, � condition toutefois que les mises en garde et pr�cautions mentionn�es dans l'information professionnelle soient d�ment prises en compte.
        EOS

        assert_equal "Zulassung eines Arzneimittels mit neuem Wirkstoff: Elaprase�, Injektionskonzentrat, 2 mg/ml (Idursulfase)", mini2[:de].heading
        assert_equal <<-EOS.strip, mini2[:de].sections.first.to_s
Das Pr�parat Elaprase� mit dem Wirkstoff Idursulfase wurde am 20. M�rz 2007 f�r folgende Indikation zugelassen:
        EOS
        assert_equal <<-EOS.strip, mini2[:de].sections.last.to_s
Warnhinweise und Vorsichtsmassnahmen:

Mit Idursulfase behandelte Patienten k�nnen Reaktionen im Zusammenhang mit der Infusion entwickeln. W�hrend der klinischen Studien waren die h�ufigsten Reaktionen im Zusammenhang mit der Infusion Hautreaktionen (Ausschlag, Pruritus, Urtikaria), Pyrexie, Kopfschmerzen, Hypertonie und R�tung.
F�r vollst�ndige Informationen zum Pr�parat soll die Fachinformation konsultiert werden.
        EOS
        assert_equal "Autorisation d'un m�dicament contenant un nouveau principe actif: Elaprase�, solution � diluer pour perfusion, 2 mg/ml (idursulfase)", mini2[:fr].heading
        assert_equal <<-EOS.strip, mini2[:fr].sections.first.to_s
La pr�paration Elaprase� comportant le principe actif idursulfase a �t� autoris�e le 20 mars 2007 pour l'indication suivante:
        EOS
        assert_equal <<-EOS.strip, mini2[:fr].sections.last.to_s
Mises en garde et pr�cautions:

Les patients trait�s par idursulfase sont susceptibles de d�velopper des r�actions associ�es � la perfusion. Au cours des �tudes cliniques, les r�actions associ�es � la perfusion les plus fr�quemment observ�es comprenaient: r�actions cutan�es (�ruption, prurit, urticaire), pyrexie, c�phal�es, hypertension et bouff�es vasomotrices.
Pour de plus amples informations, veuillez consulter l'information sur le m�dicament.
        EOS

        assert_equal "Zulassung eines Arzneimittels mit neuem Wirkstoff: Procoralan, Filmtabletten zu 5mg bzw. 7.5mg (Ivabradin)", mini3[:de].heading
        assert_equal <<-EOS.strip, mini3[:de].sections.first.to_s
Das Pr�parat Procoralan mit dem Wirkstofff Ivabradin wurde am 19. M�rz 2007 f�r folgende Indikation zugelassen:
        EOS
        assert_equal <<-EOS.strip, mini3[:de].sections.last.to_s
Eigenschaften/Wirkungen:

Ivabradin senkt aktivit�tsabh�ngig die Herzfrequenz: Ivabradin hemmt den Herzfrequenzregulierenden If-Kanal an den Schrittmacherzellen am Sinusknoten des Herzens.
F�r vollst�ndige Informationen zum Pr�parat Procoralan soll die Fachinformation konsultiert werden.
        EOS
        assert_equal "Autorisation d'un m�dicament contenant un nouveau principe actif: Procoralan 5mg respectivement 7.5mg, comprim� pellicul� (ivabradine)", mini3[:fr].heading
        assert_equal <<-EOS.strip, mini3[:fr].sections.first.to_s
La pr�paration Procoralan contenant le principe actif ivabradine a �t� autoris�e le 19 mars 2007 pour l'indication suivante:
        EOS
        assert_equal <<-EOS.strip, mini3[:fr].sections.last.to_s
Propri�t�s/effets:

L'ivabradine agit par inhibition s�lective du courant pacemaker cardiaque If qui contr�le la d�polarisation diastolique spontan�e au niveau du noeud sinusal et r�gule la fr�quence cardiaque.
Pour des plus amples informations relatives � la pr�paration, veuillez consulter l'information professionnelle.
        EOS

        assert_equal "Zulassung eines Arzneimittels mit neuem Wirkstoff: Cortavance ad us. vet., (Hydrocortisonaceponat) Hautspray f�r Hunde", mini4[:de].heading

        assert_equal "Zulassung eines Arzneimittels mit neuem Wirkstoff: Prac-tic ad us. vet., Spot-on L�sung (Pyriprol); topisches Antiektoparasitikum gegen Zecken und Fl�he f�r Hunde", mini5[:de].heading
        assert_equal "Autorisation d'un m�dicament contenant un nouveau principe actif: Prac-tic ad us. vet., solution spot-on (pyriprole); ectoparasiticide � usage topique contre les tiques et les puces chez les chiens", mini5[:fr].heading
      end
    end
  end
end
