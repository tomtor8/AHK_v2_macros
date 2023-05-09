#SingleInstance Force
#Hotstring EndChars ,
SetWorkingDir A_ScriptDir

/*
****************************** SKIN **************************************
*/


:cO:hm::Excízia kože s hnedým makulóznym útvarom priemeru  mm.{Left 4}
:cO:hM::Excízia kože s tmavohnedým makulóznym útvarom priemeru  mm.{Left 4}

:cO:hp::Excízia kože s hnedým papulóznym útvarom priemeru  mm.{Left 4}
:cO:sp::Excízia kože so svetlohnedým papulóznym útvarom priemeru  mm.{Left 4}
:cO:hP::Excízia kože s tmavohnedým papulóznym útvarom priemeru  mm.{Left 4}
:cO:bp::Excízia kože s belavým papulóznym útvarom priemeru  mm.{Left 4}

:cO:mp::Excízia kože s hnedým makulopapulóznym útvarom priemeru  mm.{Left 4}

:cO:hv::Excízia kože s hnedým verukóznym útvarom priemeru  mm.{Left 4}
:cO:hV::Excízia kože s tmavohnedým verukóznym útvarom priemeru  mm.{Left 4}
:cO:bv::Excízia kože s belavým verukóznym útvarom priemeru  mm.{Left 4}

:cO:df:: {
  Report := "Excízia kože s dermálne situovaným žltobelavým tuhým ložiskom priemeru  mm."
  AddToClipboard(Report)
  Send("{Left 4}")
}

:cO:ba:: {
  Answer := InputBox("Veľkosť kože?", "Bazalióm", "w300 h130", "15x8").value
  Report := Format("Excízia kože veľkosti cca {1} mm, povrch belavý, mierne hrboľatý.", Answer)
  AddToClipboard(Report)
}

:cO:ce::Belavý cystický útvar priemeru cca  mm.{Left 4}
:cO:ct::Žltobelavý cystický útvar vyplnený tuhým obsahom, priemeru cca  mm.{Left 4}

:cO:cE:: {
  Answer1 := InputBox("Veľkosť kože?", "Cysta", "w300 h130", "10x5").value
  Answer2 := InputBox("Priemer cysty?", "Cysta", "w300 h130", "10").value
  Report := Format("Excízia kože veľkosti cca {1} mm, na reze s cystickým útvarom priemeru {2} mm, vyplneným belavým kašovitým obsahom.", Answer1, Answer2)
  AddToClipboard(Report)
}

:cO:li::Lipomatózny, dobre ohraničený ovoidný útvar priemeru cca  mm.{Left 4}

/*
****************************** ORL **************************************
*/

:cO:to::Podnebná mandľa ružovobelavej farby, veľkosti cca  mm.{Left 4}
:cO:tO::Časť podnebnej mandle ružovobelavej farby, veľkosti cca  mm.{Left 4}

:cO:ad::Ružovobelavý fragmentovaný materiál veľkosti cca  mm.{Left 4}

:cO:sn::Žltobelavý membranózny mäkký materiál veľkosti cca  mm.{Left 4}

:cO:sl:: {
  Answer := InputBox("Veľkosť žľazy?", "Slinná žľaza", "w300 h130",).value
  Report := Format("Slinná žľaza veľkosti cca {1} mm, svetlohnedej farby. Na reze tkanivo žľazy farby povrchu, primerane lobulizované, bez makroskopicky zreteľných ložísk.", Answer)
  AddToClipboard(Report)
}

:cO:hr:: {
  Answer1 := InputBox("Veľkosť hrtana?", "Hrtan s tumorom", "w300 h130", "50x30x20").value
  Answer2 := InputBox("Veľkosť tumoru?", "Hrtan s tumorom", "w300 h130", "30x20").value
  Report := Format("Hrtan veľkosti cca {1} mm, s pravým lalokom štítnej žľazy veľkosti cca 40x25x20 mm. Štítna žľaza na reze bez ložiskových zmien. V glotickej a subglotickej oblasti vpravo prítomný sivobelavý tumor veľkosti cca {2} mm, makroskopicky bez zreteľnej infiltrácie kartilaginóznych štruktúr laryngu. Vzdialenosť novotvaru od resekčných okrajov je ... mm distálne, proximálne... Extralaryngeálne mäkké tkanivá makroskopicky bez nádorovej infiltrácie.", Answer1, Answer2)
  AddToClipboard(Report)
}

/*
****************************** GYNDA **************************************
*/

:cO:ke::Hlienistý žltobelavý fragmentovaný materiál veľkosti cca  mm.{Left 4}
:cO:kE::Hnedočervený fragmentovaný materiál veľkosti cca  mm.{Left 4}

:cO:ax:: {
  Answer1 := InputBox("Pravé alebo ľavé?", "Adnexá", "w300 h130", "Pravé").value
  Answer2 := InputBox("Veľkosť ovária?", "Adnexá", "w300 h130", "25x20x15").value
  Answer3 := InputBox("Dĺžka tuby?", "Adnexá", "w300 h130", "50").value
  Answer4 := InputBox("Hrúbka tuby?", "Adnexá", "w300 h130", "5").value
  Report := Format("{1} adnexá: Ovárium veľkosti cca {2} mm, primeraného tvaru, povrch zbrázdený, žltobelavý, na reze bez ložiskových zmien. Priľahlá tuba dĺžky cca {3} mm, hrúbky cca {4} mm, hnedastej farby, bez ložiskových zmien.", Answer1, Answer2, Answer3, Answer4)
  AddToClipboard(Report)
}

AddToClipboard(MyText)
{
  A_Clipboard := MyText
  If !ClipWait(5)
  {
    MsgBox("Adding to clipboard failed!")
    Return
  }
  Send "^v"
  Sleep 500
  A_Clipboard := ""
}