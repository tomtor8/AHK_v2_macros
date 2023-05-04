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


:O:td::Pravý lalok štítnej žľazy
:O:ts::Ľavý lalok štítnej žľazy

:O:h2:: {
  Report := "Materiál zasielame na ďalšie vyšetrenie metódou in situ hybridizácie do Martinského bioptického centra, s.r.o. Nález Vám obratom zašleme v dodatku.`n "
  AddToClipboard(Report)
}


:*c:b1::- bez iného podstatnejšieho nálezu.{Enter}{Space}
:*c:B1::Bez iného podstatnejšieho nálezu.{Enter}{Space}
:*c:b2::- bez nádorových a iných podstatnejších zmien.{Enter}{Space}
:*c:B2::Bez nádorových a iných podstatnejších zmien.{Enter}{Space}

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

:O:gd:: {
  Report := "Sliznica pažeráka krytá čiastočne viacvrstvovým dlaždicovým epitelom, fokálne s prejavmi cylindrickej metaplázie (s gastrickým / kardiálnym fenotypom).`nStredne výrazné chronické neaktívne zápalové zmeny.`nV danom materiáli bez intestinálnej metaplázie."
  Report .= "`nNález sa môže vyskytovať v rámci diagnózy gastroezofageálnej refluxovej choroby.`nV danom materiáli bez histologických známok Barrettovho pažeráka.`nBez dysplázie.`n "
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

; gynda
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

:O:ec::Endocervikálna sliznica bez atypií.{Enter}

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