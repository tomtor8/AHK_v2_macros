#SingleInstance Force
#Hotstring EndChars `t
SetWorkingDir A_ScriptDir

; ORL

:O:vd:: {
  Report := "Sliznica krytá nerohovatejúcim viacvrstvovým dlaždicovým epitelom bez dysplázie.`nV danom materiáli bez nádorových zmien.`n "
  AddToClipboard(Report)
}

:O:ad::Histomorfologický obraz tzv. vegetationes adenoideae.{Enter}{Space}

:O:t1::Histomorfologický obraz chronickej nešpecifickej tonzilitídy.{Enter}{Space}

:O:t2::Tkanivo podnebnej mandle s obrazom reaktívnej folikulárnej a interfolikulárnej hyperplázie.{Enter}{Space}

:O:t3:: {
  Report := "Tkanivo podnebnej mandle s obrazom reaktívnej folikulárnej a interfolikulárnej hyperplázie.`nV peritonzilárnych mäkkých tkanivách prítomné hnisavé zápalové zmeny flegmonózneho charakteru.`n "
  AddToClipboard(Report)
}

:O:ps::Pravý lalok štítnej žľazy:{Enter}-{Space}
:O:ls::Ľavý lalok štítnej žľazy:{Enter}-{Space}

:O:sn:: {
  Report := "Edematózne presiaknutá respiračná sliznica s miernymi nešpecifickými chronickými zápalovými zmenami.`n"
  Report .= "V zápalovom infiltráte prítomná hojná prímes eozinofilných leukocytov.`nBez dysplázie a bez nádorových zmien.`n "
  AddToClipboard(Report)
}

; OTHER

:O:zk:: {
  try {
    Report := FileRead("inflammatory_skin.txt")
    AddToClipboard(Report)
  } catch as Err {
    MsgBox("The file inflammatory_skin.txt was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

:Oc:bk::bakterioskopicky
:Oc:Bk::Bakterioskopicky

:O:h2:: {
  Report := "Materiál zasielame na ďalšie vyšetrenie metódou in situ hybridizácie na Oddelenie patológie UNLP v Košiciach. Nález Vám obratom zašleme v dodatku.`n "
  AddToClipboard(Report)
}

:Oc:b1::- bez iného podstatnejšieho nálezu.{Enter}{Space}
:Oc:B1::Bez iného podstatnejšieho nálezu.{Enter}{Space}
:Oc:b2::- bez nádorových a iných podstatnejších zmien.{Enter}{Space}
:Oc:B2::Bez nádorových a iných podstatnejších zmien.{Enter}{Space}

:O:km::Kompletná extirpácia lézie.{Enter}{Space}

:cO:mo:: {
  Sleep 300
  Answer1 := InputBox("Číslo parafínového bločku?", "Martin oznámkenka", "w300 h100", "230")
  Sleep 300

  Report := Format("Materiál (1 parafínový bloček a 1 HE preparát číslo {1}) zasielame na vyšetrenie  do Konzultačného centra bioptickej diagnostiky ochorení krvotvorby na Ústave patologickej anatómie v Martine. Po obdržaní konzultačného nálezu Vám ho zašleme obratom v dodatku. Ďakujeme za pochopenie.", Answer1.value)
  If (Answer1.result = "OK")
    AddToClipboard(Report)
}

:cO:ml:: {
  Sleep 300
  Answer1 := InputBox("Číslo parafínového bločku?", "Martin list", "w300 h100", "230")
  Sleep 300

  Report := Format(
    "
    (
      prof. MUDr. Lukáš Plank, CSc., prim. MUDr. Peter Szépe, CSc.
      ------------------------------------------------------------------
      Vážený pán profesor, vážený pán primár,
      prosím láskavo o konzultačné vyšetrenie biopsie kostnej drene s priloženým klinickým nálezom.
      Zasielame 1 HE preparát a 1 parafínový bloček s číslom {1}.
      Ďakujeme
      {2}
      MUDr. Tomáš Torday 
      Medicyt s.r.o. Košice
    )",
  Answer1.value, " ")
  If (Answer1.result = "OK")
    AddToClipboard(Report)
}

:O:rb:: {
  Sleep 500
  Answer1 := InputBox("Doručená o ktorej?", "RPOB", "w300 h100", "09:15")
  Sleep 300
  Answer2 := InputBox("Hlásená o ktorej?", "RPOB", "w300 h100", "09:30")
  Sleep 300
  Report := "[I]Rýchla peroperačná biopsia:[/I]`n"
  Report .= "Materiál doručený o " . Answer1.value
  Report .= " hod., nález telefonicky hlásený o " . Answer2.value . " hod.`n`n"
  Report .= "[I]Predbežný záver peroperačnej biopsie:[/I] "
  If (Answer1.result = "OK" and Answer2.result = "OK")
    AddToClipboard(Report)
}


; SKIN

:Oc:me:: {
  try {
    Run("melanoma.exe")
  } catch as Err {
    MsgBox("The script melanoma.exe was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

:O:zk:: {
  try {
    Report := FileRead("inflammatory_skin.txt")
    AddToClipboard(Report)
  } catch as Err {
    MsgBox("The file inflammatory_skin.txt was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

:Oc:nv:: {
  try {
    Run("nevus.ahk")
  } catch as Err {
    MsgBox("The script for nevus micro report was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

:Oc:bc:: {
  try {
    Run("bcc.ahk")
  } catch as Err {
    MsgBox("The script for BCC micro report was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

:Oc:sc:: {
  try {
    Run("scc.ahk")
  } catch as Err {
    MsgBox("The script for SCC micro report was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

:O:ce::EPIDERMOVÁ CYSTA
:O:ct::TRICHILÉMOVÁ CYSTA


:O:fp:: {
  Report := "[B]FIBROEPITELOVÝ POLYP[/B]`nKompletná extirpácia lézie.`n "
  AddToClipboard(Report)
}

:O:ak:: {
  Report := "[B]AKTINICKÁ KERATÓZA[/B]`nKompletná extirpácia lézie.`n "
  AddToClipboard(Report)
}

:O:kh:: {
  Report := "[B]KAPILÁRNY HEMANGIÓM[/B]`nKompletná extirpácia lézie.`n "
  AddToClipboard(Report)
}

:O:sk:: {
  Report := "[B]SEBOROICKÁ KERATÓZA[/B]`nKompletná extirpácia lézie.`n "
  AddToClipboard(Report)
}

:O:nf:: {
  Report := "[B]NEUROFIBRÓM[/B]`nKompletná extirpácia lézie.`n "
  AddToClipboard(Report)
}

:O:df:: {
  Report := "[B]DERMATOFIBRÓM (benígny fibrózny histiocytóm)[/B]`nKompletná extirpácia lézie.`n "
  AddToClipboard(Report)
}

:O:ns:: {
  Report := "Nekompletná extirpácia lézie, ktorej štruktúry sa nachádzajú v oblasti spodiny materiálu.`n "
  AddToClipboard(Report)
}

:O:np:: {
  Report := "Nekompletná extirpácia lézie, ktorej štruktúry sa nachádzajú v oblasti periférneho resekčného okraja materiálu.`n "
  AddToClipboard(Report)
}

; GIT

:Oc:hc:: {
  try {
    Report := FileRead("colorectal_ca_resekat.txt")
    AddToClipboard(Report)
  } catch as Err {
    MsgBox("The file colorectal_ca_resekat.txt was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

:Oc:ib:: {
  try {
    Run("ibd.exe")
  } catch as Err {
    MsgBox("The script ibd.exe was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

:Oc:cl:: {
  try {
    Run("celiakia.exe")
  } catch as Err {
    MsgBox("The script celiakia.exe was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

:Oc:zr:: {
  Report := "Sliznica typu antra žalúdka s obrazom foveolárnej hyperplázie.`n"
  Report .= "Prítomné reaktívne zmeny povrchového i foveolárneho epitelu.`n"
  Report .= "Bez zápalových zmien v lamina propria.`n"
  Report .= "Bez intestinálnej metaplázie.`n"
  Report .= "Bez dysplázie.`n"
  Report .= "Imunohistochemicky [I]nedokazujeme[/I] prítomnosť Helicobacter pylori.`n"
  Report .= "Uvedené histologické zmeny sa môžu vyskytovať v rámci REAKTÍVNEJ / CHEMICKEJ GASTROPATIE.`n "
  AddToClipboard(Report)
}


:Oc:zz:: {
  try {
    Run("Gastritis.exe")
  } catch as Err {
    MsgBox("The script gastritis.exe was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

:O:dn:: {
  Report := "Sliznica duodena v limitoch histologickej normy.`nBez atrofie klkov a bez zvýšeného zastúpenia intraepitelových lymfocytov.`n "
  AddToClipboard(Report)
}

:O:hn:: {
  Report := "Sliznica hrubého čreva v limitoch histologickej normy.`nBez zápalových a iných podstatnejších zmien.`n "
  AddToClipboard(Report)
}

:Oc:zn:: {
  Report := "Sliznica antra žalúdka v limitoch histologickej normy.`nBez zápalových zmien.`nBez metaplázie, bez atrofie.`nImunohistochemicky nedokazujeme prítomnosť Helicobacter pylori.`n "
  AddToClipboard(Report)
}

:Oc:zN:: {
  Report := "Sliznica tela žalúdka v limitoch histologickej normy.`nBez zápalových zmien.`nBez metaplázie, bez atrofie.`nImunohistochemicky nedokazujeme prítomnosť Helicobacter pylori.`n "
  AddToClipboard(Report)
}

:O:pg:: {
  Report := "Sliznica pažeráka krytá čiastočne viacvrstvovým dlaždicovým epitelom, fokálne s prejavmi cylindrickej metaplázie (s gastrickým / kardiálnym fenotypom).`nStredne výrazné chronické neaktívne zápalové zmeny.`nV danom materiáli bez intestinálnej metaplázie."
  Report .= "`nNález sa môže vyskytovať v rámci diagnózy gastroezofageálnej refluxovej choroby.`nV danom materiáli bez histologických známok Barrettovho pažeráka.`nBez dysplázie.`n "
  AddToClipboard(Report)
}

:O:pb:: {
  Report := "Sliznica krytá viacvrstvovým dlaždicovým a cylindrickým epitelom s foveolárnym / gastrickým a tiež intestinálnym fenotypom.`nStredne výrazné chronické neaktívne zápalové zmeny.`nHistologický obraz je konzistentný s diagnózou [B]Barrettovho pažeráka bez dysplázie[/B].`n "
  AddToClipboard(Report)
}

:O:h-:: {
  Report := "Imunohistochemicky nedokazujeme prítomnosť Helicobacter pylori."
  AddToClipboard(Report)
}

:O:h+:: {
  Report := "Imunohistochemicky dokazujeme prítomnosť Helicobacter pylori v malom množstve (+)."
  AddToClipboard(Report)
}
:O:h++:: {
  Report := "Imunohistochemicky dokazujeme prítomnosť Helicobacter pylori v stredne veľkom množstve (++)."
  AddToClipboard(Report)
}
:O:h+++:: {
  Report := "Imunohistochemicky dokazujeme prítomnosť Helicobacter pylori vo veľkom množstve (+++)."
  AddToClipboard(Report)
}

:O:hl:: {
  Report := "Prítomnosť H. pylori je potrebné potvrdiť / vylúčiť ďalšími laboratórnymi vyšetreniami."
  AddToClipboard(Report)
}

:O:zp:: {
  Report := "Prítomné niektoré cytologické a architektonické zmeny žliazok, ktoré sa môžu vyskytovať v rámci efektu PPI."
  AddToClipboard(Report)
}

:O:za:: {
  Report := "Sliznica tela žalúdka so stredne výraznou chronickou gastritídou.`nBez aktivity zápalového procesu."
  Report .= "`nPrítomná rozsiahla intestinálna a pseudopylorická metaplázia a atrofia.`nBez dysplázie."
  Report .= "`nImunohistochemicky (chromogranin A) dokazujeme prítomnosť lineárnej ECL cell hyperplázie a absenciu G buniek (imunohistochemické farbenie na gastrin).`nImunohistochemicky nedokazujeme prítomnosť H. pylori."
  Report .= "`n `nChronická gastritída predominantne tela žalúdka, H.pylori negatívna, s ECL cell hyperpláziou, s rozsiahlou intestinálnou / pseudopylorickou metapláziou a atrofiou. Nález je sugestívny pre diagnózu autoimúnneho typu gastritídy."
  AddToClipboard(Report)
}

:O:ch:: {
  Report := "Mierna chronická nešpecifická cholecystitída.`nCholesterolóza sliznice.`n "
  AddToClipboard(Report)
}

:Oc:ap::Akútna ulcerózne-flegmonózna apendicitída s viscerálnou hnisavou peritonitídou.{Enter}{Space}
:Oc:aP::Štruktúry apendixu s nevýraznými nešpecifickými reaktívnymi zmenami.{Enter}{Space}

:Oc:at::TUBULÁRNY ADENÓM s low-grade dyspláziou{Enter}{Space}
:Oc:av::TUBULOVILLÓZNY ADENÓM s low-grade dyspláziou{Enter}{Space}
:Oc:aT::TUBULÁRNY ADENÓM s high-grade dyspláziou{Enter}{Space}
:Oc:aV::TUBULOVILLÓZNY ADENÓM s high-grade dyspláziou{Enter}{Space}

:O:hp::HYPERPLASTICKÝ POLYP{Enter}{Space}

:O:mt:: {
  Report := "Sliznica hrubého čreva bez dysplázie a bez nádorových a iných podstatnejších zmien.`nNález môže byť v klinickej korelácii (v prípade drobnej polypoidnej lézie) konzistentný s diagnózou tzv. mucosal tag (polypoidná elevácia normálnej sliznice hrubého čreva).`nV prípade väčšej lézie (pri podozrení na nereprezentatívny odber) odporúčame zvážiť opakované bioptické vyšetrenie.`n "
  AddToClipboard(Report)
}


; GYN

:Oc:pr:: {
  try {
    Report := FileRead("prsnik_resekat.txt")
    AddToClipboard(Report)
  } catch as Err {
    MsgBox("The file prsnik_resekat.txt was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

:Oc:pR:: {
  try {
    Report := FileRead("prsnik_nat.txt")
    AddToClipboard(Report)
  } catch as Err {
    MsgBox("The file prsnik_nat.txt was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

:Oc:cb:: {
  try {
    Run("ccb.exe")
  } catch as Err {
    MsgBox("The script ccb.exe was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

:Oc:pe::ENDOCERVIKÁLNY POLYP bez atypií
:Oc:pE::ENDOMETRIÁLNY POLYP bez atypií

:O:ep:: {
  Report := "Endometrium proliferačného charakteru, bez atypií, bez hyperplázie.`n"
  AddToClipboard(Report)
}

:O:e1:: {
  Report := "Endometrium vo fáze včasnej sekrécie, bez atypií, bez hyperplázie.`n"
  AddToClipboard(Report)
}

:O:e2:: {
  Report := "Endometrium vo fáze vyvinutej sekrécie, bez atypií, bez hyperplázie.`n"
  AddToClipboard(Report)
}

:O:e3:: {
  Report := "Endometrium vo fáze pokročilej sekrécie, bez atypií, bez hyperplázie.`n"
  AddToClipboard(Report)
}

:Oc:ed:: {
  Report := "Endometrium dysfunkčného proliferačného charakteru, bez atypií, bez hyperplázie.`n"
  AddToClipboard(Report)
}

:Oc:eD:: {
  Report := "Endometrium dysfunkčného sekrečného charakteru, bez atypií, bez hyperplázie.`n"
  AddToClipboard(Report)
}

:Oc:eh:: {
  Report := "Endometrium s obrazom SIMPLEXNEJ HYPERPLÁZIE BEZ ATYPIÍ.`n"
  AddToClipboard(Report)
}

:Oc:eH:: {
  Report := "Endometrium s obrazom ATYPICKEJ HYPERPLÁZIE (komplexná atypická hyperplázia endometria).`n"
  AddToClipboard(Report)
}

:O:ec::Endocervikálna sliznica bez atypií.{Enter}

:Oc:kN:: {
  Report := "Konizát vyšetrený kompletne:`n- cervikálny viacvrstvový dlaždicový epitel fokálne s prejavmi`n[B]high-grade skvamóznej intraepitelovej lézie (HSIL/CIN3)[/B]"
  Report .= "`n- imunohistochemicky p16 s pozitívnou expresiou, zvýšená proliferačná aktivita Ki-67 v teréne HSIL`n- resekčné okraje ektocervikálne i endocervikálne bez evidentnej dysplázie`n- bez invazívnych nádorových zmien.`n "
  AddToClipboard(Report)
}

:Oc:kn:: {
  Report := "Konizát vyšetrený kompletne:`n- epidermizované ektrópium cervikálnej sliznice`n- chronické nešpecifické zápalové zmeny`n- fokálne reaktívne zmeny epitelu"
  Report .= "`n- imunohistochemicky p16 negat., proliferačná aktivita Ki-67 nezvýšená`n- [B]bez dysplázie a bez nádorových zmien.[/B]`n "
  AddToClipboard(Report)
}

:O:pa:: {
  Report := "[I]Pravé adnexá:[/I]`nOvárium`n- bez nádorových a iných podstatnejších zmien.`nTuba`n- bez nádorových a iných podstatnejších histologických zmien.`n "
  AddToClipboard(Report)
}

:O:la:: {
  Report := "[I]Ľavé adnexá:[/I]`nOvárium`n- bez nádorových a iných podstatnejších zmien.`nTuba`n- bez nádorových a iných podstatnejších histologických zmien.`n "
  AddToClipboard(Report)
}

:O:rg:: {
  Report := "[B]RESIDUA POST GRAVIDITATEM INTRAUTERINAM[/B]`n- prítomné tiež súčasti placentárneho implantačného miesta`n- bez atypickej proliferácie trofoblastu.`n "
  AddToClipboard(Report)
}

:Oc:ut:: {
  try {
    Run("uterus.ahk")
  } catch as Err {
    MsgBox("The script for uterus micro report was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

:Oc:ue:: {
  try {
    Run("uterus_EmCa.ahk")
  } catch as Err {
    MsgBox("The script for uterus endometrial carcinoma report was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

:O:pc:: {
  try {
    Run("prostata_ca.ahk")
  } catch as Err {
    MsgBox("The script for prostate_ca micro report was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

:Oc:pn:: {
  Report := "[I]1. Pravý lalok:[/I]`n"
  Report .= "- tkanivo prostaty bez nádorových zmien a bez high-grade PIN.`n `n"
  Report .= "[I]2. Ľavý lalok:[/I]`n"
  Report .= "- tkanivo prostaty bez nádorových zmien a bez high-grade PIN.`n `n"
  Report .= "Imunohistochemická analýza: AMACR bez expresie, cytokeratin 5/6 a p63 exprimuje pozitívne v bazálnych bunkách.`n "
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