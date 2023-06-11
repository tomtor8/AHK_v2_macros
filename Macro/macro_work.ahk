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
  Answer := InputBox("Veľkosť kože?", "Bazalióm", "w300 h100", "15 × 8")
  Sleep 500
  Report := Format("Excízia kože veľkosti cca {1} mm, povrch belavý, mierne hrboľatý.", Answer.value)
  If (Answer.result = "OK")
    AddToClipboard(Report)
}

:cO:ce::Belavý cystický útvar priemeru cca  mm.{Left 4}
:cO:ct::Žltobelavý cystický útvar vyplnený tuhým obsahom, priemeru cca  mm.{Left 4}

:cO:cE:: {
  Sleep 500
  Answer1 := InputBox("Veľkosť kože?", "Cysta", "w300 h100", "10 × 5")
  Sleep 500
  Answer2 := InputBox("Priemer cysty?", "Cysta", "w300 h100", "10")
  Sleep 500
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
  Answer := InputBox("Veľkosť žľazy?", "Slinná žľaza", "w300 h100", "70 × 40 × 25")
  Sleep 500
  Report := Format("Slinná žľaza veľkosti cca {1} mm, svetlohnedej farby. Na reze tkanivo žľazy farby povrchu, primerane lobulizované, bez makroskopicky zreteľných ložísk.", Answer.value)
  If (Answer.result = "OK")
    AddToClipboard(Report)
}

:cO:sL:: {
  Sleep 500
  Answer1 := InputBox("Veľkosť slinnej žľazy?", "Slinná žľaza tumor", "w300 h100", "50 × 30 × 20")
  Sleep 500
  Answer2 := InputBox("Veľkosť tumoru?", "Slinná žľaza tumor", "w300 h100", "20 × 20 × 15")
  Sleep 500
  Answer3 := InputBox("Akej farby je tumor?", "Slinná žľaza tumor", "w300 h100", "sivobelavej")
  Sleep 500
  Answer4 := InputBox("Akej konzistencie je tumor?", "Slinná žľaza tumor", "w300 h100", "tuhej")
  Sleep 500
  Answer5 := InputBox("Solídneho alebo solídno-cystického charakteru?", "Slinná žľaza tumor", "w300 h100", "solídneho")
  Sleep 500
  Report := Format("Slinná žľaza veľkosti cca {1} mm, svetlohnedej farby. Na reze prítomné jedno dobre ohraničené ložisko {5} charakteru, {3} farby, {4} konzistencie, veľkosti cca {2} mm.", Answer1.value, Answer2.value, Answer3.value, Answer4.value, Answer5.value)
  If (Answer1.result = "OK" and Answer2.result = "OK" and Answer3.result = "OK" and Answer4.result = "OK" and Answer5.result = "OK")
    AddToClipboard(Report)
}

:cO:hr:: {
  Sleep 500
  Answer1 := InputBox("Veľkosť hrtana?", "Hrtan s tumorom", "w300 h100", "50 × 30 × 20")
  Sleep 500
  Answer2 := InputBox("Veľkosť tumoru?", "Hrtan s tumorom", "w300 h100", "30 × 20")
  Sleep 500
  Report := Format("Hrtan veľkosti cca {1} mm, s pravým lalokom štítnej žľazy veľkosti cca 40 × 25 × 20 mm. Štítna žľaza na reze bez ložiskových zmien. V glotickej a subglotickej oblasti vpravo prítomný sivobelavý tumor veľkosti cca {2} mm, makroskopicky bez zreteľnej infiltrácie kartilaginóznych štruktúr laryngu. Vzdialenosť novotvaru od resekčných okrajov je ... mm distálne, proximálne... Extralaryngeálne mäkké tkanivá makroskopicky bez nádorovej infiltrácie.", Answer1.value, Answer2.value)
  If (Answer1.result = "OK" and Answer2.result = "OK")
    AddToClipboard(Report)
}

/*
****************************** GYNDA **************************************
*/

:cO:kn:: {
  Sleep 500
  Answer1 := InputBox("Veľkosť konizátu?", "Konizát", "w300 h100", "20 × 20 × 10")
  Sleep 500
  Answer2 := InputBox("Akej farby je sliznica?", "Konizát", "w300 h100", "belavej")
  Sleep 500
  Answer3 := InputBox("Textúra sliznice? hladká / zrnitá ?", "Konizát", "w300 h100", "hladká")
  Sleep 500
  Answer4 := InputBox("Označený stehom? a / n", "Konizát", "w300 h100", "a")
  Sleep 500
  Report := "Konizát veľkosti cca " . Answer1.value . " mm, "
  Report .= (Answer4.value = "a") ? "označený stehom, " : ""
  Report .= "sliznica " . Answer2.value . " farby, " . Answer3.value . ", bez ložiskových zmien."
  If (Answer1.result = "OK" and Answer2.result = "OK" and Answer3.result = "OK" and Answer4.result = "OK")
    AddToClipboard(Report)
}


:cO:ke::Hlienistý žltobelavý fragmentovaný materiál veľkosti cca  mm.{Left 4}
:cO:kE::Hnedočervený fragmentovaný materiál veľkosti cca  mm.{Left 4}

:cO:ax:: {
  Sleep 500
  Answer1 := InputBox("Pravé alebo ľavé?", "Adnexá", "w300 h100", "Pravé")
  Sleep 500
  Answer2 := InputBox("Veľkosť ovária?", "Adnexá", "w300 h100", "25 × 20 × 15")
  Sleep 500
  Answer3 := InputBox("Dĺžka tuby?", "Adnexá", "w300 h100", "50")
  Sleep 500
  Answer4 := InputBox("Hrúbka tuby?", "Adnexá", "w300 h100", "5")
  Sleep 500
  Report := Format("{1} adnexá: Ovárium veľkosti cca {2} mm, primeraného tvaru, povrch zbrázdený, žltobelavý, na reze bez ložiskových zmien. Priľahlá tuba dĺžky cca {3} mm, hrúbky cca {4} mm, hnedastej farby, bez ložiskových zmien.", Answer1.value, Answer2.value, Answer3.value, Answer4.value)
  If (Answer1.result = "OK" and Answer2.result = "OK" and Answer3.result = "OK" and Answer4.result = "OK")
    AddToClipboard(Report)
}

:cO:ut:: {
  Sleep 500
  Answer1 := InputBox("Veľkosť maternice?", "Uterus", "w300 h100", "90 × 60 × 40")
  Sleep 500
  Answer2 := InputBox("Farba endometria?", "Uterus", "w300 h100", "ružovobelavé")
  Sleep 500
  Report := Format("Uterus veľkosti cca {1} mm, primeraného tvaru, seróza hnedá, hladká, portio belavé, hladké, endocervikálny kanál voľný. Endometrium {2}, bez ložiskových zmien, myometrium bez ložiskových zmien.", Answer1.value, Answer2.value)
  If (Answer1.result = "OK" and Answer2.result = "OK")
    AddToClipboard(Report)
}

:cO:tl::Tukovolymfatické tkanivo veľkosti cca  mm.{Left 4}


:cO:pr:: {
  Sleep 500
  Answer1 := InputBox("Celková veľkosť mliečnej žľazy v mm?", "Kvadrant", "w300 h100", "70 × 40 × 30")
  Sleep 500
  Answer2 := InputBox("Veľkosť tumoru?", "Kvadrant", "w300 h100", "15 × 10")
  Sleep 500
  Answer3 := InputBox("Vzdialenosť od najbližšieho okraja?", "Kvadrant", "w300 h100", "5")
  Sleep 500
  Answer4 := InputBox("Od ktorého okraja je najbližšie", "Cholecysta", "w300 h100", "dorzálneho")
  Sleep 500
  Report := Format("Tkanivo mliečnej žľazy veľkosti cca {1} mm, označené 1 stehom / bez označenia stehom, s priľahlým nenápadným kožným krytom veľkosti cca  mm / bez kožného krytu. Na reznej ploche prítomné jedno neostro dobre ohraničené ložisko sivobelavej farby, tuhej tuhoelastickej konzistencie, veľkosti cca {2} mm. Ložisko je vzdialené od najbližšieho resekčného okraja ({4}) makroskopicky {3} mm.", Answer1.value, Answer2.value, Answer3.value, Answer4.value)
  If (Answer1.result = "OK" and Answer2.result = "OK" and Answer3.result = "OK" and Answer4.result = "OK")
    AddToClipboard(Report)
}

:cO:pR:: {
  Sleep 500
  Answer1 := InputBox("Lateralita?", "Prsník", "w300 h100", "Ľavý")
  Sleep 500
  Answer2 := InputBox("Celková veľkosť prsníka v mm?", "Prsník", "w300 h100", "180 × 150 × 30")
  Sleep 500
  Answer3 := InputBox("Veľkosť kožného krytu v mm?", "Prsník", "w300 h100", "170 × 140")
  Sleep 500
  Answer4 := InputBox("Veľkosť tumoru?", "Prsník", "w300 h100", "25 × 20")
  Sleep 500
  Answer5 := InputBox("V ktorej oblasti sa nachádza tumor?", "Prsník", "w300 h100", "horného laterálneho kvadrantu")
  Sleep 500
  Answer6 := InputBox("Vzdialenosť od najbližšieho okraja?", "Prsník", "w300 h100", "10")
  Sleep 500

  Report := Format("{1} prsník veľkosti cca {2} mm, kožný kryt veľkosti cca {3} mm, nenápadný. Na reze v oblasti {5} prítomné neostro ohraničené ložisko sivožltej farby, veľkosti cca {4} mm, vzdialené od najbližšieho okraja (zadnej fascie) cca {6} mm. Zvyšné tkanivo mliečnej žľazy bez iných makroskopicky zreteľných zmien.", Answer1.value, Answer2.value, Answer3.value, Answer4.value, Answer5.value, Answer6.value)
  If (Answer1.result = "OK" and Answer2.result = "OK" and Answer3.result = "OK" and Answer4.result = "OK" and Answer5.result = "OK" and Answer6.result = "OK")
    AddToClipboard(Report)
}

/*
****************************** GIT **************************************
*/

:cO:ch:: {
  Sleep 500
  Answer1 := InputBox("Veľkosť žlčníka?", "Cholecysta", "w300 h100", "70 × 40")
  Sleep 500
  Answer2 := InputBox("Akej farby je sliznica?", "Cholecysta", "w300 h100", "zelenej")
  Sleep 500
  Answer3 := InputBox("Jahoda? a / n", "Cholecysta", "w300 h100", "n")
  Sleep 500
  Answer4 := InputBox("Stena zhrubnutá? a / n", "Cholecysta", "w300 h100", "n")
  Sleep 500
  Report := "Cholecysta veľkosti cca " . Answer1.value . " mm, "
  Report .= (Answer4.value = "n") ? "stena primeranej hrúbky, " : "stena zhrubnutá, tuhoelastickej konzistencie, "
  Report .= "sliznica " . Answer2.value . " farby, "
  Report .= (Answer3.value = "n") ? "bez ložiskových zmien." : "s početnými žltými plošnými bodkovitými ložiskami."
  If (Answer1.result = "OK" and Answer2.result = "OK" and Answer3.result = "OK" and Answer4.result = "OK")
    AddToClipboard(Report)
}

:cO:ap:: {
  Sleep 500
  Answer1 := InputBox("Dĺžka apendixu v mm?", "Apendix", "w300 h100", "80")
  Sleep 500
  Answer2 := InputBox("Hrúbka apendixu v mm?", "Apendix", "w300 h100", "7")
  Sleep 500
  Answer3 := InputBox("Seróza je akej farby?", "Apendix", "w300 h100", "svetlohnedej")
  Sleep 500
  Answer4 := InputBox("Lúmen obliterovaný? a / n", "Apendix", "w300 h100", "n")
  Sleep 500

  Report := "Appendix vermiformis dĺžky cca " . Answer1.value . " mm, hrúbky cca " . Answer2.value . " mm, "
  Report .= "seróza  " . Answer3.value . " farby, hladká, stena na reze farby povrchu, "
  Report .= (Answer4.value = "n") ? "lúmen ostro konturovaný, bez ložiskových zmien." : "lúmen segmentálne obliterovaný, bez iných ložiskových zmien."
  If (Answer1.result = "OK" and Answer2.result = "OK" and Answer3.result = "OK" and Answer4.result = "OK")
    AddToClipboard(Report)
}
; apendix zápal
:cO:aP:: {
  Sleep 500
  Answer1 := InputBox("Dĺžka apendixu v mm?", "Apendix", "w300 h100", "80")
  Sleep 500
  Answer2 := InputBox("Hrúbka apendixu v mm?", "Apendix", "w300 h100", "7")
  Sleep 500
  Answer3 := InputBox("Seróza je akej farby?", "Apendix", "w300 h100", "žltohnedej")
  Sleep 500
  Answer4 := InputBox("Lúmen obliterovaný? a / n", "Apendix", "w300 h100", "n")
  Sleep 500

  Report := "Appendix vermiformis dĺžky cca " . Answer1.value . " mm, hrúbky cca " . Answer2.value . " mm, "
  Report .= "seróza  " . Answer3.value . " farby, zdrsnená, stena na reze farby povrchu, "
  Report .= (Answer4.value = "n") ? "lúmen neostro konturovaný, bez ložiskových zmien." : "lúmen neostro konturovaný, segmentálne obliterovaný, bez iných ložiskových zmien."
  If (Answer1.result = "OK" and Answer2.result = "OK" and Answer3.result = "OK" and Answer4.result = "OK")
    AddToClipboard(Report)
}


:cO:hc:: {
  Sleep 500
  Answer1 := InputBox("Dĺžka čreva v mm?", "Hrubé črevo tumor", "w300 h100", "200")
  Sleep 500

  Report := Format("Resekát segmentu hrubého čreva dĺžky cca {1} mm, seróza hladká, nenarušená, hnedastá. Po narezaní čreva intraluminálne vo vzdialenosti cca  mm od proximálneho resekčného okraja, cca  mm od distálneho resekčného okraja a cca  mm od radiálneho resekčného okraja prítomné tumorózne ložisko sivobelavej farby, miskovitého / polypoidného tvaru, veľkosti cca  mm, cirkulárne rastúce, postihujúce segment črevnej steny dĺžky cca  mm. Ložisko na reze infiltruje transmurálne do perikolického tukového tkaniva. Perikolické tukové tkanivo oddelené do Carnoyovho roztoku.", Answer1.value)
  If (Answer1.result = "OK")
    AddToClipboard(Report)
}


:cO:hC:: {
  Sleep 500
  Answer1 := InputBox("Dĺžka hrubého čreva v mm?", "Pravostranné hrubé črevo tumor", "w300 h100", "500")
  Sleep 500
  Answer2 := InputBox("Dĺžka terminálneho ilea v mm?", "Pravostranné hrubé črevo tumor", "w300 h100", "50")
  Sleep 500
  Answer3 := InputBox("Dĺžka apendixu v mm?", "Pravostranné hrubé črevo tumor", "w300 h100", "70")
  Sleep 500
  Report := Format("Resekát segmentu hrubého čreva dĺžky cca {1} mm a priľahlého terminálneho ilea dĺžky cca {2} mm. Appendix vermiformis dĺžky cca {3} mm, makroskopicky nenápadný. Seróza čreva hladká, nenarušená, hnedastá. Po narezaní intraluminálne v hrubom čreve vo vzdialenosti cca  mm od proximálneho resekčného okraja, cca  mm od distálneho resekčného okraja a cca  mm od radiálneho resekčného okraja prítomné tumorózne ložisko sivobelavej farby, miskovitého / polypoidného tvaru, veľkosti cca  mm, cirkulárne rastúce, postihujúce segment črevnej steny dĺžky cca  mm. Ložisko na reze infiltruje transmurálne do perikolického tukového tkaniva. Perikolické tukové tkanivo oddelené do Carnoyovho roztoku.", Answer1.value, Answer2.value, Answer3.value)
  If (Answer1.result = "OK" and Answer2.result = "OK" and Answer3.result = "OK")
    AddToClipboard(Report)
}

/*
****************************** OTHER **************************************
*/
:cO:vc::veľkosti cca  mm{Left 3}
:cO:vC::veľkosti cca  mm.{Left 4}

:cO:pb::Belavý polypoidný útvar priemeru cca  mm.{Left 4}
:cO:ph::Hnedastý polypoidný útvar priemeru cca  mm.{Left 4}

; fragmentovaný materiál
:cO:fr:: {
  Sleep 500
  Answer1 := InputBox("Veľkosť materiálu?", "Fragmenty", "w300 h100", "20 × 10")
  Sleep 500
  Answer2 := InputBox("Akej farby je materiál?", "Fragmenty", "w300 h100", "hnedastej")
  Sleep 500
  Answer3 := InputBox("Akej konzistencie je materiál?", "Fragmenty", "w300 h100", "tuhoelastickej")
  Sleep 500

  Report := Format("Fragmentovaný materiál nepravidelného tvaru, veľkosti cca {1} mm, {2} farby, {3} konzistencie.", Answer1.value, Answer2.value, Answer3.value)
  If (Answer1.result = "OK" and Answer2.result = "OK")
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