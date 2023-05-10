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
  Sleep 500
  Answer := InputBox("Veľkosť kože?", "Bazalióm", "w300 h100", "15x8")
  Report := Format("Excízia kože veľkosti cca {1} mm, povrch belavý, mierne hrboľatý.", Answer.value)
  If (Answer.result = "OK")
    AddToClipboard(Report)
}

:cO:ce::Belavý cystický útvar priemeru cca  mm.{Left 4}
:cO:ct::Žltobelavý cystický útvar vyplnený tuhým obsahom, priemeru cca  mm.{Left 4}

:cO:cE:: {
  Sleep 500
  Answer1 := InputBox("Veľkosť kože?", "Cysta", "w300 h100", "10x5")
  Answer2 := InputBox("Priemer cysty?", "Cysta", "w300 h100", "10")
  Report := Format("Excízia kože veľkosti cca {1} mm, na reze s cystickým útvarom priemeru {2} mm, vyplneným belavým kašovitým obsahom.", Answer1.value, Answer2.value)
  If (Answer1.result = "OK" and Answer2.result = "OK")
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
  Sleep 500
  Answer := InputBox("Veľkosť žľazy?", "Slinná žľaza", "w300 h100",)
  Report := Format("Slinná žľaza veľkosti cca {1} mm, svetlohnedej farby. Na reze tkanivo žľazy farby povrchu, primerane lobulizované, bez makroskopicky zreteľných ložísk.", Answer.value)
  If (Answer.result = "OK")
    AddToClipboard(Report)
}

:cO:sL:: {
  Sleep 500
  Answer1 := InputBox("Veľkosť slinnej žľazy?", "Slinná žľaza tumor", "w300 h100", "50x30x20")
  Answer2 := InputBox("Veľkosť tumoru?", "Slinná žľaza tumor", "w300 h100", "20x20x15")
  Answer3 := InputBox("Akej farby je tumor?", "Slinná žľaza tumor", "w300 h100", "sivobelavej")
  Answer4 := InputBox("Akej konzistencie je tumor?", "Slinná žľaza tumor", "w300 h100", "tuhej")
  Answer5 := InputBox("Solídneho alebo solídno-cystického charakteru?", "Slinná žľaza tumor", "w300 h100", "solídneho")
  Report := Format("Slinná žľaza veľkosti cca {1} mm, svetlohnedej farby. Na reze prítomné jedno dobre ohraničené ložisko {5} charakteru, {3} farby, {4} konzistencie, veľkosti cca {2} mm.", Answer1.value, Answer2.value, Answer3.value, Answer4.value, Answer5.value)
  If (Answer1.result = "OK" and Answer2.result = "OK" and Answer3.result = "OK" and Answer4.result = "OK" and Answer5.result = "OK")
    AddToClipboard(Report)
}

:cO:hr:: {
  Sleep 500
  Answer1 := InputBox("Veľkosť hrtana?", "Hrtan s tumorom", "w300 h100", "50x30x20")
  Answer2 := InputBox("Veľkosť tumoru?", "Hrtan s tumorom", "w300 h100", "30x20")
  Report := Format("Hrtan veľkosti cca {1} mm, s pravým lalokom štítnej žľazy veľkosti cca 40x25x20 mm. Štítna žľaza na reze bez ložiskových zmien. V glotickej a subglotickej oblasti vpravo prítomný sivobelavý tumor veľkosti cca {2} mm, makroskopicky bez zreteľnej infiltrácie kartilaginóznych štruktúr laryngu. Vzdialenosť novotvaru od resekčných okrajov je ... mm distálne, proximálne... Extralaryngeálne mäkké tkanivá makroskopicky bez nádorovej infiltrácie.", Answer1.value, Answer2.value)
  If (Answer1.result = "OK" and Answer2.result = "OK")
    AddToClipboard(Report)
}

/*
****************************** GYNDA **************************************
*/

:cO:ke::Hlienistý žltobelavý fragmentovaný materiál veľkosti cca  mm.{Left 4}
:cO:kE::Hnedočervený fragmentovaný materiál veľkosti cca  mm.{Left 4}

:cO:ax:: {
  Sleep 500
  Answer1 := InputBox("Pravé alebo ľavé?", "Adnexá", "w300 h100", "Pravé")
  Answer2 := InputBox("Veľkosť ovária?", "Adnexá", "w300 h100", "25x20x15")
  Answer3 := InputBox("Dĺžka tuby?", "Adnexá", "w300 h100", "50")
  Answer4 := InputBox("Hrúbka tuby?", "Adnexá", "w300 h100", "5")
  Report := Format("{1} adnexá: Ovárium veľkosti cca {2} mm, primeraného tvaru, povrch zbrázdený, žltobelavý, na reze bez ložiskových zmien. Priľahlá tuba dĺžky cca {3} mm, hrúbky cca {4} mm, hnedastej farby, bez ložiskových zmien.", Answer1.value, Answer2.value, Answer3.value, Answer4.value)
  If (Answer1.result = "OK" and Answer2.result = "OK" and Answer3.result = "OK" and Answer4.result = "OK")
    AddToClipboard(Report)
}

:cO:ut:: {
  Sleep 500
  Answer1 := InputBox("Veľkosť maternice?", "Uterus", "w300 h100", "90x60x40")
  Answer2 := InputBox("Farba endometria?", "Uterus", "w300 h100", "ružovobelavé")
  Report := Format("Uterus veľkosti cca {1} mm, primeraného tvaru, seróza hnedá, hladká, portio belavé, hladké, endocervikálny kanál voľný. Endometrium {2}, bez ložiskových zmien, myometrium bez ložiskových zmien.", Answer1.value, Answer2.value)
  If (Answer1.result = "OK" and Answer2.result = "OK")
    AddToClipboard(Report)
}

:cO:tl::Tukovolymfatické tkanivo veľkosti cca  mm.{Left 4}

/*
****************************** OTHER **************************************
*/
:cO:vc::veľkosti cca  mm{Left 3}
:cO:vC::veľkosti cca  mm.{Left 4}

:cO:pb::Belavý polypoidný útvar priemeru cca  mm.{Left 4}
:cO:ph::Hnedastý polypoidný útvar priemeru cca  mm.{Left 4}

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