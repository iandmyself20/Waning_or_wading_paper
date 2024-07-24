*variables were standardized in python with ScaleStandardize
import delimited "Wanningwadingjuly2024.csv"

duplicates drop ibge7, force

*calculating the means

egen mean_rhtotaldireta = rowtotal(rhtotaldireta2015 rhtotaldireta2016 rhtotaldireta2017 rhtotaldireta2018 rhtotaldireta2019)
egen mean_osc = rowtotal(osc2015 osc2016 osc2017 osc2018 osc2019)
egen mean_vlagricultura = rowtotal(vlagricultura2015 vlagricultura2016 vlagricultura2017 vlagricultura2018 vlagricultura2019)
egen mean_vlservicos = rowtotal(vlservicos2015 vlservicos2016 vlservicos2017 vlservicos2018 vlservicos2019)
egen mean_vlindustria = rowtotal(vlindustria2015 vlindustria2016 vlindustria2017 vlindustria2018 vlindustria2019)
egen mean_vladmpub = rowtotal(vladmpub2015 vladmpub2016 vladmpub2017 vladmpub2018 vladmpub2019)
egen mean_pibpercapita = rowtotal(pibpercapita2015 pibpercapita2016 pibpercapita2017 pibpercapita2018 pibpercapita2019)
egen mean_ideb = rowtotal(ideb2015  ideb2017 ideb2018 ideb2019)
egen mean_qt_eleitor_apto = rowtotal(qt_eleitor_apto2012  qt_eleitor_apto2016  qt_eleitor_apto2020)
egen mean_qt_eleitor_comp = rowtotal(qt_eleitor_comp2012  qt_eleitor_comp2016  qt_eleitor_comp2020)
egen mean_ammendempenho = rowtotal(ammendempenho2015 ammendempenho2016 ammendempenho2017 ammendempenho2018 ammendempenho2019)
egen mean_stn = rowtotal(stn2015 stn2016 stn2017 stn2018 stn2019)
egen mean_ammendempenho20152020 = rowtotal(ammendempenho2015 ammendempenho2016 ammendempenho2017 ammendempenho2018 ammendempenho2019 ammendempenho2020)
egen mean_ammendempenho20212023 = rowtotal(ammendempenho2021 ammendempenho2022 )
egen mean_ammendpaid20152020 = rowtotal(stn2015 stn2016 stn2017 stn2018 stn2019 stn2020)
egen mean_ammendpaid20212023 = rowtotal(stn2021 stn2022 stn2023 )
egen mean_votes = rowtotal(votos_x votos_y )
egen mean_sameparty = rowtotal (sameparty2016 sameparty2020)
egen mean_sameparty = rowtotal (sameparty2016 sameparty2020)
egen mean_pop = rowtotal (pop2015 pop2016 pop2017 pop2018 pop2019)


*Create Variables
generate mean_turnover = mean_qt_eleitor_comp /  mean_qt_eleitor_apto
rename votos_x VoteLocalElection2016
rename votos_y VoteLocalElection2020
rename mean_rhtotaldireta Localgovworkforce
rename mean_osc NumberNGO
rename mean_vlagricultura AgricultureValue
rename mean_vlservicos ServicesValue
rename mean_vlindustria IndustryValue
rename mean_vladmpub PubAdmValue
rename mean_pibpercapita GDPpercapita
rename mean_ideb PrimaryEducationIndex
rename mean_turnover ElectorateTurnout
rename mean_ammendempenho AmmendValueSettled
rename mean_stn AmmendValuePaid
rename mean_ammendempenho20152020 AmmendValueSettled20152020
rename mean_ammendempenho20212023 AmmendValueSettled20212023
rename mean_ammendpaid20152020 AmmendValuePaid20152020
rename mean_ammendpaid20212023 AmmendValuePaid20212023
rename sameparty2016 DeputyMayorSameParty2016
rename sameparty2020 DeputyMayorSameParty2020
rename total_empresas NumberPrivateCorp
rename mean_votes LocalVotesElectedDep
rename mean_sameparty DepMayorSameParty
rename mean_pop Population

 **********************************
 *THEORY TESTING **Main rationale - ammendment allocation is defined by multidimensional factors**
 ***********************************
 
 *CONTROL VARIABLES: hierarquia municipal - centrolocal, centrosubregional, capitalregional, centrozona,  nucleo
 
 pwcorr Localgovworkforce NumberNGO AgricultureValue ServicesValue IndustryValue PubAdmValue GDPpercapita PrimaryEducationIndex AmmendValueSettled AmmendValuePaid LocalVotesElectedDep DepMayorSameParty Population ElectorateTurnout centrolocal centrosubregional capitalregional centrozona intermediario nucleo , sig star(.05)
 
          | Localg~e Number~O Agricu~e Servic~e Indust~e PubAdm~e GDPper~a
-------------+---------------------------------------------------------------
Localgovwo~e |   1.0000 
             |
             |
   NumberNGO |   0.8060*  1.0000 
             |   0.0000
             |
Agricultur~e |   0.1422*  0.0616*  1.0000 
             |   0.0000   0.0000
             |
ServicesVa~e |   0.8422*  0.8906*  0.0454*  1.0000 
             |   0.0000   0.0000   0.0007
             |
IndustryVa~e |   0.7983*  0.6964*  0.0796*  0.8326*  1.0000 
             |   0.0000   0.0000   0.0000   0.0000
             |
 PubAdmValue |   0.8961*  0.6909*  0.1238*  0.6759*  0.5882*  1.0000 
             |   0.0000   0.0000   0.0000   0.0000   0.0000
             |
GDPpercapita |   0.1158*  0.0520*  0.2933*  0.0997*  0.2851*  0.0831*  1.0000 
             |   0.0000   0.0001   0.0000   0.0000   0.0000   0.0000
             |
PrimaryEdu~x |   0.0362*  0.0164   0.0954*  0.0258   0.0762* -0.0065   0.1656*
             |   0.0069   0.2224   0.0000   0.0542   0.0000   0.6287   0.0000
             |
AmmendVal~ed |   0.6287*  0.4699*  0.0617*  0.5655*  0.6263*  0.4780*  0.0718*
             |   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
             |
AmmendVal~id |   0.5074*  0.3192*  0.1314*  0.3894*  0.4804*  0.3243*  0.0673*
             |   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
             |
LocalVotes~p |   0.7677*  0.8005*  0.0389*  0.9302*  0.8422*  0.5483*  0.0649*
             |   0.0000   0.0000   0.0036   0.0000   0.0000   0.0000   0.0000
             |
DepMayorSa~y |   0.0252   0.0445* -0.0316*  0.0554*  0.0768*  0.0120   0.1020*
             |   0.0599   0.0009   0.0182   0.0000   0.0000   0.3712   0.0000
             |
  Population |   0.8981*  0.8020*  0.0755*  0.9076*  0.8493*  0.7237*  0.0792*
             |   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
             |
Electorate~t |  -0.1898* -0.0666* -0.2063* -0.0743* -0.1188* -0.1202*  0.0545*
             |   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0001
             |
 centrolocal |  -0.2904* -0.1244* -0.1766* -0.1357* -0.2604* -0.1525* -0.1484*
             |   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
             |
centrosubr~l |   0.0990*  0.0198   0.1087*  0.0224   0.0633*  0.0319*  0.0399*
             |   0.0000   0.1389   0.0000   0.0951   0.0000   0.0174   0.0029
             |
capitalreg~l |   0.1240*  0.0460*  0.1226*  0.0414*  0.0870*  0.0520*  0.0357*
             |   0.0000   0.0006   0.0000   0.0020   0.0000   0.0001   0.0076
             |
  centrozona |   0.0228  -0.0048   0.1576* -0.0074   0.0023  -0.0022   0.0296*
             |   0.0886   0.7218   0.0000   0.5832   0.8651   0.8683   0.0271
             |
intermedia~o |   0.1661*  0.0475*  0.1653*  0.0461*  0.1498*  0.0585*  0.1345*
             |   0.0000   0.0004   0.0000   0.0006   0.0000   0.0000   0.0000
             |
      nucleo |   0.5119*  0.3123*  0.0582*  0.3632*  0.4558*  0.3818*  0.0664*
             |   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
             |

             | Primar~x Ammen~ed Ammen~id LocalV~p DepMay~y Popula~n Electo~t
-------------+---------------------------------------------------------------
PrimaryEdu~x |   1.0000 
             |
             |
AmmendVal~ed |   0.0342*  1.0000 
             |   0.0107
             |
AmmendVal~id |   0.0868*  0.7992*  1.0000 
             |   0.0000   0.0000
             |
LocalVotes~p |   0.0398*  0.6293*  0.4431*  1.0000 
             |   0.0030   0.0000   0.0000
             |
DepMayorSa~y |   0.0683*  0.0044  -0.0139   0.0635*  1.0000 
             |   0.0000   0.7448   0.2999   0.0000
             |
  Population |   0.0399*  0.6721*  0.5187*  0.9034*  0.0390*  1.0000 
             |   0.0029   0.0000   0.0000   0.0000   0.0036
             |
Electorate~t |  -0.1767* -0.1576* -0.2698* -0.1099* -0.0446* -0.1296*  1.0000 
             |   0.0000   0.0000   0.0000   0.0000   0.0016   0.0000
             |
 centrolocal |  -0.1580* -0.2660* -0.3939* -0.1795* -0.0428* -0.2324*  0.3148*
             |   0.0000   0.0000   0.0000   0.0000   0.0014   0.0000   0.0000
             |
centrosubr~l |   0.0616*  0.1187*  0.1671*  0.0409*  0.0003   0.0572* -0.1414*
             |   0.0000   0.0000   0.0000   0.0023   0.9793   0.0000   0.0000
             |
capitalreg~l |   0.0474*  0.1237*  0.1675*  0.0641*  0.0219   0.0818* -0.0729*
             |   0.0004   0.0000   0.0000   0.0000   0.1021   0.0000   0.0000
             |
  centrozona |   0.0902*  0.0023   0.0861*  0.0054  -0.0066   0.0090  -0.2280*
             |   0.0000   0.8667   0.0000   0.6857   0.6213   0.5024   0.0000
             |
intermedia~o |   0.1545*  0.1659*  0.3113*  0.0831*  0.0392*  0.1107* -0.3005*
             |   0.0000   0.0000   0.0000   0.0000   0.0034   0.0000   0.0000
             |
      nucleo |   0.0259   0.4148*  0.3558*  0.3937*  0.0176   0.4970* -0.0815*
             |   0.0531   0.0000   0.0000   0.0000   0.1880   0.0000   0.0000
             |

             | cent~cal cent~nal capita~l centro~a interm~o   nucleo
-------------+------------------------------------------------------
 centrolocal |   1.0000 
             |
             |
centrosubr~l |  -0.3529*  1.0000 
             |   0.0000
             |
capitalreg~l |  -0.1657* -0.0142   1.0000 
             |   0.0000   0.2879
             |
  centrozona |  -0.6740* -0.0579* -0.0272*  1.0000 
             |   0.0000   0.0000   0.0423
             |
intermedia~o |  -0.9685*  0.3644*  0.1711*  0.6959*  1.0000 
             |   0.0000   0.0000   0.0000   0.0000
             |
      nucleo |  -0.2023* -0.0174  -0.0082  -0.0332* -0.0477*  1.0000 
             |   0.0000   0.1943   0.5423   0.0132   0.0004
             |
             |



*Test first hypotheses: A alocação de emendas parlamentares é influenciada por conexões partidárias e conexão direta com o eleitor 
//(explicação padrão da teoria tradicional)


reg AmmendValueSettled DepMayorSameParty  LocalVotesElectedDep centrolocal centrosubregional capitalregional centrozona  nucleo

.
.   Source |       SS           df       MS      Number of obs   =     5,570
-------------+----------------------------------   F(7, 5562)      =    688.96
       Model |  44153.9667         7  6307.70953   Prob > F        =    0.0000
    Residual |   50922.665     5,562  9.15545936   R-squared       =    0.4644
-------------+----------------------------------   Adj R-squared   =    0.4637
       Total |  95076.6316     5,569  17.0724783   Root MSE        =    3.0258

-------------------------------------------------------------------------------------
 AmmendValueSettled |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------+----------------------------------------------------------------
  DepMayorSameParty |  -.0418203   .0094265    -4.44   0.000    -.0602998   -.0233407
LocalVotesElected~p |   1.143592   .0234889    48.69   0.000     1.097544    1.189639
        centrolocal |  -1.190918   .0939538   -12.68   0.000    -1.375104   -1.006732
  centrosubregional |   .1388787   .1489176     0.93   0.351     -.153058    .4308155
    capitalregional |    1.28432   .2648065     4.85   0.000     .7651956    1.803444
         centrozona |  -1.019577   .1113522    -9.16   0.000    -1.237871   -.8012836
             nucleo |   3.299673   .2370128    13.92   0.000     2.835035     3.76431
              _cons |   4.724262   .4511007    10.47   0.000     3.839928    5.608596
-------------------------------------------------------------------------------------

. 

 


 hettest

 
Breusch-Pagan / Cook-Weisberg test for heteroskedasticity 
         Ho: Constant variance
         Variables: fitted values of AmmendValueSettled

         chi2(1)      = 25865.76
         Prob > chi2  =   0.0000


==> teste informa heteroskedasticity


reg AmmendValueSettled DepMayorSameParty  LocalVotesElectedDep centrolocal centrosubregional capitalregional centrozona  nucleo, robust


Linear regression                               Number of obs     =      5,570
                                                F(7, 5562)        =      39.08
                                                Prob > F          =     0.0000
                                                R-squared         =     0.4644
                                                Root MSE          =     3.0258

-------------------------------------------------------------------------------------
                    |               Robust
 AmmendValueSettled |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------+----------------------------------------------------------------
  DepMayorSameParty |  -.0418203   .0101969    -4.10   0.000    -.0618101   -.0218304
LocalVotesElected~p |   1.143592   .2064176     5.54   0.000     .7389328    1.548251
        centrolocal |  -1.190918   .2637968    -4.51   0.000    -1.708063   -.6737735
  centrosubregional |   .1388787   .3355029     0.41   0.679    -.5188381    .7965955
    capitalregional |    1.28432   1.163336     1.10   0.270    -.9962728    3.564913
         centrozona |  -1.019577   .2606772    -3.91   0.000    -1.530607   -.5085484
             nucleo |   3.299673   .9402079     3.51   0.000     1.456498    5.142848
              _cons |   4.724262   1.676549     2.82   0.005     1.437571    8.010953
-------------------------------------------------------------------------------------

. 

. 
 estimate store H1a

. ==> sim, as variáveis influenciam o empenho das emendas e o modelo tem boa validade preditiva R-squared = 0.39


 

reg AmmendValuePaid DepMayorSameParty  LocalVotesElectedDep  centrolocal centrosubregional capitalregional centrozona  nucleo

 


      Source |       SS           df       MS      Number of obs   =     5,570
-------------+----------------------------------   F(7, 5562)      =    437.43
       Model |   34114.435         7  4873.49072   Prob > F        =    0.0000
    Residual |  61967.7963     5,562  11.1412795   R-squared       =    0.3551
-------------+----------------------------------   Adj R-squared   =    0.3542
       Total |  96082.2314     5,569  17.2530493   Root MSE        =    3.3379

-------------------------------------------------------------------------------------
    AmmendValuePaid |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------+----------------------------------------------------------------
  DepMayorSameParty |  -.0559495   .0103986    -5.38   0.000    -.0763348   -.0355641
LocalVotesElected~p |   .6757738   .0259114    26.08   0.000     .6249773    .7265702
        centrolocal |  -2.358902   .1036434   -22.76   0.000    -2.562084   -2.155721
  centrosubregional |   -.167491   .1642758    -1.02   0.308    -.4895358    .1545537
    capitalregional |   1.773115   .2921165     6.07   0.000     1.200452    2.345777
         centrozona |  -1.485217   .1228362   -12.09   0.000    -1.726024    -1.24441
             nucleo |   2.880525   .2614564    11.02   0.000     2.367968    3.393082
              _cons |   4.910073   .4976236     9.87   0.000     3.934536     5.88561
-------------------------------------------------------------------------------------




hettest


Breusch-Pagan / Cook-Weisberg test for heteroskedasticity 
         Ho: Constant variance
         Variables: fitted values of AmmendValuePaid

         chi2(1)      = 10114.94
         Prob > chi2  =   0.0000






reg AmmendValuePaid DepMayorSameParty  LocalVotesElectedDep  centrolocal centrosubregional capitalregional centrozona  nucleo, robust
 

Linear regression                               Number of obs     =      5,570
                                                F(7, 5562)        =      89.16
                                                Prob > F          =     0.0000
                                                R-squared         =     0.3551
                                                Root MSE          =     3.3379

-------------------------------------------------------------------------------------
                    |               Robust
    AmmendValuePaid |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------+----------------------------------------------------------------
  DepMayorSameParty |  -.0559495   .0110143    -5.08   0.000    -.0775418   -.0343572
LocalVotesElected~p |   .6757738   .1173935     5.76   0.000     .4456367    .9059108
        centrolocal |  -2.358902   .2731109    -8.64   0.000    -2.894306   -1.823498
  centrosubregional |   -.167491   .3276574    -0.51   0.609    -.8098275    .4748454
    capitalregional |   1.773115   1.029297     1.72   0.085    -.2447097    3.790939
         centrozona |  -1.485217   .2776405    -5.35   0.000    -2.029501   -.9409332
             nucleo |   2.880525   .9767813     2.95   0.003     .9656521    4.795398
              _cons |   4.910073   1.624914     3.02   0.003     1.724606    8.095539
-------------------------------------------------------------------------------------

. 


estimate store H1b

. ==> sim, as variáveis influenciam o pagamento das emendas e o modelo tem  validade preditiva  regular R-squared = 0.19


**Test hypotheses 2 - Para um modelo explicativo mais robusto sobre o processo de alocação de emendas parlamentares, devem ser incluídas 
///variáveis relacionadas a uma base comunitária. A rede organizacional e o perfil da população influencia a alocação das emendas. Criei um índice para 
/// refletir este conceito.

*create index

**A princípio criei este índice com a variáveis abaixo, mas a correlação entre elas é muito alta. Gostaria de entender melhor os critérios para análise da tabela de correlação das variáveis.
/// Também gerei uma segunda opção de índice.


*1o índice de base comunitária

pca Localgovworkforce NumberNGO  AgricultureValue ServicesValue IndustryValue PubAdmValue GDPpercapita PrimaryEducationIndex ElectorateTurnout NumberPrivateCorp, component(4)


Principal components/correlation                 Number of obs    =      4,990
                                                 Number of comp.  =          4
                                                 Trace            =         10
    Rotation: (unrotated = principal)            Rho              =     0.8762

    --------------------------------------------------------------------------
       Component |   Eigenvalue   Difference         Proportion   Cumulative
    -------------+------------------------------------------------------------
           Comp1 |      5.34129       3.8948             0.5341       0.5341
           Comp2 |      1.44649      .371168             0.1446       0.6788
           Comp3 |      1.07532      .175953             0.1075       0.7863
           Comp4 |      .899366      .300707             0.0899       0.8762
           Comp5 |      .598659      .259953             0.0599       0.9361
           Comp6 |      .338705      .199394             0.0339       0.9700
           Comp7 |      .139312      .034317             0.0139       0.9839
           Comp8 |      .104995     .0630117             0.0105       0.9944
           Comp9 |     .0419828     .0280957             0.0042       0.9986
          Comp10 |     .0138871            .             0.0014       1.0000
    --------------------------------------------------------------------------

Principal components (eigenvectors) 

    --------------------------------------------------------------------
        Variable |    Comp1     Comp2     Comp3     Comp4 | Unexplained 
    -------------+----------------------------------------+-------------
    Localgovwo~e |   0.4153    0.0118   -0.0579   -0.0406 |      .07355 
       NumberNGO |   0.3822   -0.1047   -0.0146    0.0118 |       .2036 
    Agricultur~e |   0.0367    0.5993    0.0725   -0.5497 |        .196 
    ServicesVa~e |   0.4198   -0.0866    0.0159    0.0140 |      .04746 
    IndustryVa~e |   0.3962    0.0619    0.0972    0.0274 |       .1452 
     PubAdmValue |   0.4041   -0.0384   -0.0237   -0.0209 |       .1244 
    GDPpercapita |   0.0679    0.5122    0.6192    0.0670 |       .1796 
    PrimaryEdu~x |   0.0330    0.4641   -0.2033    0.8038 |      .05701 
    Electorate~t |  -0.0633   -0.3647    0.7457    0.2094 |       .1487 
    NumberPriv~p |   0.4170   -0.0785    0.0078    0.0156 |      .06208 
    --------------------------------------------------------------------


*create index - 1o índice de "base comunitária"

gen pca_index_socialstructure = 0.4153 * Localgovworkforce + 0.3822 * NumberNGO + 0.4170*NumberPrivateCorp + 0.3962*IndustryValue +  0.4198*ServicesValue + 0.4041*PubAdmValue 
gen pca_index_equality = 0.5993*AgricultureValue + 0.4641 *PrimaryEducationIndex
gen pca_index_power = 0.6192  *GDPpercapita + 0.7457 *ElectorateTurnout

*2o índice de "base comunitária"

pca Localgovworkforce NumberNGO NumberPrivateCorp  GDPpercapita PrimaryEducationIndex ElectorateTurnout , component(3)

Principal components/correlation                 Number of obs    =      4,990
                                                 Number of comp.  =          3
                                                 Trace            =          6
    Rotation: (unrotated = principal)            Rho              =     0.8297

    --------------------------------------------------------------------------
       Component |   Eigenvalue   Difference         Proportion   Cumulative
    -------------+------------------------------------------------------------
           Comp1 |      2.72817      1.53401             0.4547       0.4547
           Comp2 |      1.19416      .138079             0.1990       0.6537
           Comp3 |      1.05609      .329398             0.1760       0.8297
           Comp4 |      .726687      .523082             0.1211       0.9509
           Comp5 |      .203605      .112317             0.0339       0.9848
           Comp6 |     .0912877            .             0.0152       1.0000
    --------------------------------------------------------------------------

Principal components (eigenvectors) 

    ----------------------------------------------------------
        Variable |    Comp1     Comp2     Comp3 | Unexplained 
    -------------+------------------------------+-------------
    Localgovwo~e |   0.5705   -0.0143   -0.0243 |       .1112 
       NumberNGO |   0.5579   -0.1317    0.0173 |       .1299 
    NumberPriv~p |   0.5822   -0.0966    0.0411 |       .0622 
    GDPpercapita |   0.0826    0.4413    0.7219 |       .1984 
    PrimaryEdu~x |   0.0642    0.7531    0.0059 |       .3115 
    Electorate~t |  -0.1156   -0.4596    0.6901 |       .2084 
    ----------------------------------------------------------

	
*create index - 2o índice

gen pca_index_organizational = 0.5705 * Localgovworkforce + 0.5579 * NumberNGO + 0.5822*NumberPrivateCorp 
gen pca_index_education = 0.7531 *PrimaryEducationIndex
gen pca_index_access = 0.7219  *GDPpercapita + 0.6901 *ElectorateTurnout

	
*running regression with 1o index

reg  AmmendValueSettled pca_index_socialstructure pca_index_equality pca_index_power centrolocal centrosubregional capitalregional centrozona  nucleo

    Source |       SS           df       MS      Number of obs   =     4,990
-------------+----------------------------------   F(8, 4981)      =    731.57
       Model |  40333.7802         8  5041.72253   Prob > F        =    0.0000
    Residual |  34327.3474     4,981  6.89165778   R-squared       =    0.5402
-------------+----------------------------------   Adj R-squared   =    0.5395
       Total |  74661.1276     4,989  14.9651489   Root MSE        =    2.6252

-------------------------------------------------------------------------------------
 AmmendValueSettled |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------+----------------------------------------------------------------
pca_index_socials~e |   .2687513   .0048355    55.58   0.000     .2592715     .278231
 pca_index_equality |    .009733    .011395     0.85   0.393    -.0126063    .0320723
    pca_index_power |  -.0664099   .0133784    -4.96   0.000    -.0926375   -.0401823
        centrolocal |  -.6581015   .0868228    -7.58   0.000    -.8283123   -.4878906
  centrosubregional |   .4001668   .1378005     2.90   0.004     .1300171    .6703166
    capitalregional |   .7576611    .245336     3.09   0.002     .2766944    1.238628
         centrozona |  -.5180245   .1031582    -5.02   0.000      -.72026    -.315789
             nucleo |   3.476961   .2235839    15.55   0.000     3.038638    3.915284
              _cons |   4.535213   .4208106    10.78   0.000     3.710239    5.360187
-------------------------------------------------------------------------------------

. 



hettest


Breusch-Pagan / Cook-Weisberg test for heteroskedasticity 
         Ho: Constant variance
         Variables: fitted values of AmmendValueSettled

         chi2(1)      = 42035.95
         Prob > chi2  =   0.0000



reg  AmmendValueSettled pca_index_socialstructure pca_index_equality pca_index_power centrolocal centrosubregional capitalregional centrozona  nucleo, robust


Linear regression                               Number of obs     =      4,990
                                                F(8, 4981)        =      33.94
                                                Prob > F          =     0.0000
                                                R-squared         =     0.5402
                                                Root MSE          =     2.6252

-------------------------------------------------------------------------------------
                    |               Robust
 AmmendValueSettled |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------+----------------------------------------------------------------
pca_index_socials~e |   .2687513   .0521611     5.15   0.000     .1664925      .37101
 pca_index_equality |    .009733   .0092483     1.05   0.293    -.0083978    .0278637
    pca_index_power |  -.0664099   .0149871    -4.43   0.000    -.0957912   -.0370286
        centrolocal |  -.6581015   .2141665    -3.07   0.002    -1.077962   -.2382408
  centrosubregional |   .4001668   .2883907     1.39   0.165    -.1652059    .9655396
    capitalregional |   .7576611   .8644719     0.88   0.381    -.9370846    2.452407
         centrozona |  -.5180245   .2042377    -2.54   0.011    -.9184203   -.1176286
             nucleo |   3.476961   1.085823     3.20   0.001      1.34827    5.605652
              _cons |   4.535213   1.518159     2.99   0.003     1.558952    7.511474
-------------------------------------------------------------------------------------


. 
estimate store H2a

==> As variáveis comunitárias, ccontribuem para melhorar o modelo explicativo , a questão da igualdade não tem significância na alocação de recursos


 



reg  AmmendValuePaid pca_index_socialstructure pca_index_equality pca_index_power centrolocal centrosubregional capitalregional centrozona  nucleo 
  
  
. 
      Source |       SS           df       MS      Number of obs   =     4,990
-------------+----------------------------------   F(8, 4981)      =    421.19
       Model |  28760.7145         8  3595.08931   Prob > F        =    0.0000
    Residual |  42515.7771     4,981  8.53559067   R-squared       =    0.4035
-------------+----------------------------------   Adj R-squared   =    0.4026
       Total |  71276.4916     4,989  14.2867291   Root MSE        =    2.9216

-------------------------------------------------------------------------------------
    AmmendValuePaid |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------+----------------------------------------------------------------
pca_index_socials~e |   .1648158   .0053814    30.63   0.000     .1542659    .1753658
 pca_index_equality |   .1051258   .0126815     8.29   0.000     .0802645    .1299872
    pca_index_power |  -.1042792   .0148888    -7.00   0.000    -.1334678   -.0750906
        centrolocal |  -1.873041   .0966248   -19.38   0.000    -2.062468   -1.683614
  centrosubregional |   .0585639   .1533578     0.38   0.703    -.2420849    .3592127
    capitalregional |   .9747863   .2730337     3.57   0.000     .4395199    1.510053
         centrozona |  -1.149789   .1148044   -10.02   0.000    -1.374857    -.924722
             nucleo |   2.642018   .2488258    10.62   0.000     2.154209    3.129826
              _cons |   3.855021   .4683188     8.23   0.000      2.93691    4.773132
-------------------------------------------------------------------------------------

. 


 
hettest

Breusch-Pagan / Cook-Weisberg test for heteroskedasticity 
         Ho: Constant variance
         Variables: fitted values of AmmendValuePaid

         chi2(1)      =  8948.78
         Prob > chi2  =   0.0000



reg  AmmendValuePaid pca_index_socialstructure pca_index_equality pca_index_power centrolocal centrosubregional capitalregional centrozona  nucleo, robust
 

Linear regression                               Number of obs     =      4,990
                                                F(8, 4981)        =      86.30
                                                Prob > F          =     0.0000
                                                R-squared         =     0.4035
                                                Root MSE          =     2.9216

-------------------------------------------------------------------------------------
                    |               Robust
    AmmendValuePaid |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------+----------------------------------------------------------------
pca_index_socials~e |   .1648158   .0326022     5.06   0.000     .1009012    .2287305
 pca_index_equality |   .1051258   .0131851     7.97   0.000     .0792771    .1309745
    pca_index_power |  -.1042792   .0145317    -7.18   0.000    -.1327678   -.0757907
        centrolocal |  -1.873041   .2229261    -8.40   0.000    -2.310075   -1.436008
  centrosubregional |   .0585639   .2884264     0.20   0.839     -.506879    .6240067
    capitalregional |   .9747863   .7730872     1.26   0.207    -.5408051    2.490378
         centrozona |  -1.149789   .2244677    -5.12   0.000    -1.589845   -.7097337
             nucleo |   2.642018    .982251     2.69   0.007     .7163731    4.567662
              _cons |   3.855021   1.411169     2.73   0.006     1.088509    6.621533
-------------------------------------------------------------------------------------


 estimate store H2b
 
 
==> As variáveis comunitárias, conforme a hipótese também oferecem um bom modelo explicativo para a alocação das emendas
elas explicam melhor do que apenas os fatores políticos (conexão partidária e conexão com o eleitor) o pagamento das emendas
visto que o modelo com o índice de 'base comunitária' obtém um R2 melhor.
empenho - H1a - tradicional = .46 H2a - comunitário = .54
pagamento - H1b - tradicional  = .35 H2b - comunitário = .40

 **Avaliando o modelo completo

reg AmmendValueSettled DepMayorSameParty  LocalVotesElectedDep pca_index_socialstructure pca_index_equality pca_index_power centrolocal centrosubregional capitalregional centrozona  nucleo


      Source |       SS           df       MS      Number of obs   =     4,990
-------------+----------------------------------   F(10, 4979)     =    616.19
       Model |  41294.2965        10  4129.42965   Prob > F        =    0.0000
    Residual |  33366.8311     4,979  6.70151258   R-squared       =    0.5531
-------------+----------------------------------   Adj R-squared   =    0.5522
       Total |  74661.1276     4,989  14.9651489   Root MSE        =    2.5887

-------------------------------------------------------------------------------------
 AmmendValueSettled |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------+----------------------------------------------------------------
  DepMayorSameParty |   -.031655   .0086767    -3.65   0.000    -.0486653   -.0146448
LocalVotesElected~p |   1.058666   .0915245    11.57   0.000     .8792373    1.238094
pca_index_socials~e |   .0285557   .0213584     1.34   0.181    -.0133161    .0704276
 pca_index_equality |   .0058077   .0112445     0.52   0.606    -.0162365     .027852
    pca_index_power |   -.017171     .01382    -1.24   0.214    -.0442644    .0099223
        centrolocal |  -.7500967   .0859998    -8.72   0.000    -.9186942   -.5814992
  centrosubregional |   .3676058   .1359603     2.70   0.007     .1010638    .6341478
    capitalregional |   .8259089   .2419961     3.41   0.001     .3514899    1.300328
         centrozona |  -.6080737   .1020386    -5.96   0.000    -.8081143   -.4080332
             nucleo |   3.233285   .2214204    14.60   0.000     2.799203    3.667366
              _cons |   4.426402     .41685    10.62   0.000     3.609193    5.243612
-------------------------------------------------------------------------------------

. 


 
hettest

Breusch-Pagan / Cook-Weisberg test for heteroskedasticity 
         Ho: Constant variance
         Variables: fitted values of AmmendValueSettled

         chi2(1)      = 42291.03
         Prob > chi2  =   0.0000





reg AmmendValueSettled DepMayorSameParty  LocalVotesElectedDep pca_index_socialstructure pca_index_equality pca_index_power centrolocal centrosubregional capitalregional centrozona  nucleo, robust

 

Linear regression                               Number of obs     =      4,990
                                                F(10, 4979)       =      28.68
                                                Prob > F          =     0.0000
                                                R-squared         =     0.5531
                                                Root MSE          =     2.5887

-------------------------------------------------------------------------------------
                    |               Robust
 AmmendValueSettled |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------+----------------------------------------------------------------
  DepMayorSameParty |   -.031655   .0087057    -3.64   0.000    -.0487221    -.014588
LocalVotesElected~p |   1.058666   .3426423     3.09   0.002      .386936    1.730396
pca_index_socials~e |   .0285557   .0885042     0.32   0.747    -.1449515     .202063
 pca_index_equality |   .0058077   .0094529     0.61   0.539    -.0127241    .0243396
    pca_index_power |   -.017171   .0167354    -1.03   0.305    -.0499797    .0156377
        centrolocal |  -.7500967   .2127202    -3.53   0.000    -1.167122   -.3330713
  centrosubregional |   .3676058   .2838345     1.30   0.195    -.1888349    .9240465
    capitalregional |   .8259089   .8505483     0.97   0.332    -.8415406    2.493358
         centrozona |  -.6080737   .2025653    -3.00   0.003    -1.005191   -.2109566
             nucleo |   3.233285   1.083665     2.98   0.003     1.108823    5.357746
              _cons |   4.426402   1.509528     2.93   0.003     1.467062    7.385742
-------------------------------------------------------------------------------------

. 



===>  os fatores comunitários não são estatisticamente significativas no modelo completo de empenho das despesas

estimate store H3a


reg AmmendValuePaid DepMayorSameParty  LocalVotesElectedDep pca_index_socialstructure pca_index_equality pca_index_power centrolocal centrosubregional capitalregional centrozona  nucleo

 
  Source |       SS           df       MS      Number of obs   =     4,990
-------------+----------------------------------   F(10, 4979)     =    344.26
       Model |  29136.4773        10  2913.64773   Prob > F        =    0.0000
    Residual |  42140.0143     4,979  8.46354976   R-squared       =    0.4088
-------------+----------------------------------   Adj R-squared   =    0.4076
       Total |  71276.4916     4,989  14.2867291   Root MSE        =    2.9092

-------------------------------------------------------------------------------------
    AmmendValuePaid |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------+----------------------------------------------------------------
  DepMayorSameParty |  -.0427233   .0097509    -4.38   0.000    -.0618395   -.0236072
LocalVotesElected~p |   .5377134   .1028555     5.23   0.000     .3360714    .7393555
pca_index_socials~e |   .0434248   .0240026     1.81   0.070    -.0036308    .0904804
 pca_index_equality |   .1021003   .0126366     8.08   0.000      .077327    .1268737
    pca_index_power |  -.0754622    .015531    -4.86   0.000    -.1059098   -.0450147
        centrolocal |  -1.933554   .0966468   -20.01   0.000    -2.123024   -1.744084
  centrosubregional |   .0292722   .1527924     0.19   0.848    -.2702683    .3288127
    capitalregional |   1.011875   .2719557     3.72   0.000     .4787217    1.545028
         centrozona |   -1.20951   .1146712   -10.55   0.000    -1.434316   -.9847039
             nucleo |   2.506517   .2488327    10.07   0.000     2.018695    2.994338
              _cons |   3.907042   .4684569     8.34   0.000      2.98866    4.825424
-------------------------------------------------------------------------------------

. 
 
==> sem análise robusta, o resultado demonstra o que eu esperaria teoricamente, uma composição de fatores de conexão política, de conexão com eleitor e comunitários como explicativos da alocação das emendas.

hettest

Breusch-Pagan / Cook-Weisberg test for heteroskedasticity 
         Ho: Constant variance
         Variables: fitted values of AmmendValuePaid

         chi2(1)      =  8958.53
         Prob > chi2  =   0.0000


. 

reg AmmendValuePaid DepMayorSameParty  LocalVotesElectedDep pca_index_socialstructure pca_index_equality pca_index_power centrolocal centrosubregional capitalregional centrozona  nucleo, robust

Linear regression                               Number of obs     =      4,990
                                                F(10, 4979)       =      71.63
                                                Prob > F          =     0.0000
                                                R-squared         =     0.4088
                                                Root MSE          =     2.9092

-------------------------------------------------------------------------------------
                    |               Robust
    AmmendValuePaid |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------+----------------------------------------------------------------
  DepMayorSameParty |  -.0427233   .0097533    -4.38   0.000     -.061844   -.0236027
LocalVotesElected~p |   .5377134   .3084201     1.74   0.081    -.0669259    1.142353
pca_index_socials~e |   .0434248   .0742711     0.58   0.559    -.1021792    .1890288
 pca_index_equality |   .1021003   .0130403     7.83   0.000     .0765357     .127665
    pca_index_power |  -.0754622    .015616    -4.83   0.000    -.1060765    -.044848
        centrolocal |  -1.933554   .2248564    -8.60   0.000    -2.374371   -1.492736
  centrosubregional |   .0292722   .2867459     0.10   0.919     -.532876    .5914204
    capitalregional |   1.011875   .7697365     1.31   0.189    -.4971479    2.520897
         centrozona |   -1.20951   .2262472    -5.35   0.000    -1.653054   -.7659656
             nucleo |   2.506517   1.006452     2.49   0.013      .533427    4.479606
              _cons |   3.907042   1.440444     2.71   0.007     1.083137    6.730948
-------------------------------------------------------------------------------------

. 
estimate store H3b



===> os fatores comunitários de igualdade e poder desempenham possuem significância estatística na influência do pagamento das emendas. Entretanto, eu esperava que a estrutura social fosse significante, uma vez que para pagar a emenda
precisa ter capacidade organizacional de propor e executar projetos 



 estout H1a H1b H2a H2b H3a H3b, cells(b(star fmt(3)) se(par fmt(2)))legend label varlabels(_cons constant)  stats(r2 df_r bic)


--------------------------------------------------------------------------------------------------------------------
                              H1a             H1b             H2a             H2b             H3a             H3b   
                             b/se            b/se            b/se            b/se            b/se            b/se   
--------------------------------------------------------------------------------------------------------------------
DepMayorSameParty          -0.042***       -0.056***                                       -0.032***       -0.043***
                           (0.01)          (0.01)                                          (0.01)          (0.01)   
LocalVotesElectedDep        1.144***        0.676***                                        1.059**         0.538   
                           (0.21)          (0.12)                                          (0.34)          (0.31)   
Centrolocal                -1.191***       -2.359***       -0.658**        -1.873***       -0.750***       -1.934***
                           (0.26)          (0.27)          (0.21)          (0.22)          (0.21)          (0.22)   
CentroSubregional           0.139          -0.167           0.400           0.059           0.368           0.029   
                           (0.34)          (0.33)          (0.29)          (0.29)          (0.28)          (0.29)   
CapitalRegional             1.284           1.773           0.758           0.975           0.826           1.012   
                           (1.16)          (1.03)          (0.86)          (0.77)          (0.85)          (0.77)   
CentroZona                 -1.020***       -1.485***       -0.518*         -1.150***       -0.608**        -1.210***
                           (0.26)          (0.28)          (0.20)          (0.22)          (0.20)          (0.23)   
Nucleo                      3.300***        2.881**         3.477**         2.642**         3.233**         2.507*  
                           (0.94)          (0.98)          (1.09)          (0.98)          (1.08)          (1.01)   
pca_index_socialst~e                                        0.269***        0.165***        0.029           0.043   
                                                           (0.05)          (0.03)          (0.09)          (0.07)   
pca_index_equality                                          0.010           0.105***        0.006           0.102***
                                                           (0.01)          (0.01)          (0.01)          (0.01)   
pca_index_power                                            -0.066***       -0.104***       -0.017          -0.075***
                                                           (0.01)          (0.01)          (0.02)          (0.02)   
constant                    4.724**         4.910**         4.535**         3.855**         4.426**         3.907** 
                           (1.68)          (1.62)          (1.52)          (1.41)          (1.51)          (1.44)   
--------------------------------------------------------------------------------------------------------------------
r2                          0.464           0.355           0.540           0.404           0.553           0.409   
df_r                     5562.000        5562.000        4981.000        4981.000        4979.000        4979.000   
bic                     28201.902       29295.331       23860.890       24928.416       23736.304       24901.147   
--------------------------------------------------------------------------------------------------------------------
* p<0.05, ** p<0.01, *** p<0.001

***********************
**Running with 2o index
************************

reg  AmmendValueSettled pca_index_organizational pca_index_education pca_index_access centrolocal centrosubregional capitalregional centrozona  nucleo, robust


Linear regression                               Number of obs     =      4,990
                                                F(8, 4981)        =      27.59
                                                Prob > F          =     0.0000
                                                R-squared         =     0.5078
                                                Root MSE          =     2.7162

------------------------------------------------------------------------------------------
                         |               Robust
      AmmendValueSettled |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------------------+----------------------------------------------------------------
pca_index_organizational |   .4309508   .0853321     5.05   0.000     .2636623    .5982394
     pca_index_education |  -.0174438   .0080239    -2.17   0.030     -.033174   -.0017135
        pca_index_access |  -.0154946   .0084111    -1.84   0.066    -.0319841    .0009949
             centrolocal |  -.6821859   .2235881    -3.05   0.002    -1.120517   -.2438548
       centrosubregional |    .327676   .2925259     1.12   0.263    -.2458036    .9011555
         capitalregional |   .6913883    .865342     0.80   0.424    -1.005063     2.38784
              centrozona |  -.5541909   .2113743    -2.62   0.009    -.9685776   -.1398042
                  nucleo |   3.903429   1.094189     3.57   0.000     1.758337    6.048521
                   _cons |   4.774691   1.533535     3.11   0.002     1.768287    7.781094
------------------------------------------------------------------------------------------


estimate store H4a

reg  AmmendValuePaid pca_index_organizational pca_index_education pca_index_access centrolocal centrosubregional capitalregional centrozona  nucleo, robust

Linear regression                               Number of obs     =      4,990
                                                F(8, 4981)        =      79.95
                                                Prob > F          =     0.0000
                                                R-squared         =     0.3892
                                                Root MSE          =     2.9563

------------------------------------------------------------------------------------------
                         |               Robust
         AmmendValuePaid |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------------------+----------------------------------------------------------------
pca_index_organizational |   .2721338   .0590073     4.61   0.000     .1564534    .3878142
     pca_index_education |   .0352443   .0098708     3.57   0.000     .0158931    .0545954
        pca_index_access |  -.0382267   .0098314    -3.89   0.000    -.0575005   -.0189528
             centrolocal |  -1.832506    .229848    -7.97   0.000    -2.283109   -1.381902
       centrosubregional |   .1508174   .2911253     0.52   0.604    -.4199164    .7215512
         capitalregional |   1.190988   .7743755     1.54   0.124    -.3271291    2.709105
              centrozona |  -1.036319   .2289555    -4.53   0.000    -1.485172   -.5874649
                  nucleo |   2.931991   .9818415     2.99   0.003      1.00715    4.856833
                   _cons |   4.463771   1.421774     3.14   0.002     1.676468    7.251075
------------------------------------------------------------------------------------------

estimate store H4b

reg AmmendValueSettled DepMayorSameParty  LocalVotesElectedDep  pca_index_organizational pca_index_education pca_index_access centrolocal centrosubregional capitalregional centrozona  nucleo,robust



Linear regression                               Number of obs     =      4,990
                                                F(10, 4979)       =      25.18
                                                Prob > F          =     0.0000
                                                R-squared         =     0.5564
                                                Root MSE          =     2.5792

------------------------------------------------------------------------------------------
                         |               Robust
      AmmendValueSettled |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------------------+----------------------------------------------------------------
       DepMayorSameParty |  -.0339251   .0091345    -3.71   0.000    -.0518327   -.0160175
    LocalVotesElectedDep |   1.576018   .3764291     4.19   0.000     .8380509    2.313984
pca_index_organizational |  -.1657389   .1363448    -1.22   0.224    -.4330347    .1015569
     pca_index_education |  -.0142606   .0083001    -1.72   0.086    -.0305323    .0020112
        pca_index_access |  -.0035666    .008789    -0.41   0.685    -.0207969    .0136638
             centrolocal |  -.8203921   .2086392    -3.93   0.000    -1.229417   -.4113674
       centrosubregional |   .3897457   .2826225     1.38   0.168    -.1643189    .9438102
         capitalregional |   .9465164   .8454094     1.12   0.263    -.7108585    2.603891
              centrozona |  -.6480612   .1985104    -3.26   0.001    -1.037229   -.2588932
                  nucleo |   3.198367   1.065208     3.00   0.003      1.11009    5.286643
                   _cons |   4.535279   1.489232     3.05   0.002     1.615728     7.45483
------------------------------------------------------------------------------------------


estimate store H5a

===> no modelo completo com o segundo índice, como no primeiro, as variáveis de base comunitária não explicam o empenho da emenda


reg AmmendValuePaid DepMayorSameParty  LocalVotesElectedDep  pca_index_organizational pca_index_education pca_index_access centrolocal centrosubregional capitalregional centrozona  nucleo,robust

Linear regression                               Number of obs     =      4,990
                                                F(10, 4979)       =      69.88
                                                Prob > F          =     0.0000
                                                R-squared         =     0.4015
                                                Root MSE          =     2.9271

------------------------------------------------------------------------------------------
                         |               Robust
         AmmendValuePaid |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------------------+----------------------------------------------------------------
       DepMayorSameParty |  -.0470036   .0097435    -4.82   0.000    -.0661051    -.027902
    LocalVotesElectedDep |   .7045382    .229323     3.07   0.002     .2549641    1.154112
pca_index_organizational |   .0064677   .0974707     0.07   0.947    -.1846178    .1975532
     pca_index_education |    .039292   .0098767     3.98   0.000     .0199293    .0586547
        pca_index_access |  -.0295794    .009617    -3.08   0.002    -.0484328   -.0107259
             centrolocal |  -1.909961   .2276396    -8.39   0.000    -2.356235   -1.463687
       centrosubregional |   .1611879   .2853907     0.56   0.572    -.3983036    .7206794
         capitalregional |   1.303304    .770363     1.69   0.091    -.2069465    2.813555
              centrozona |  -1.096713   .2258362    -4.86   0.000    -1.539452    -.653975
                  nucleo |   2.603791   1.009823     2.58   0.010     .6240923    4.583489
                   _cons |   4.478375   1.433063     3.13   0.002      1.66894     7.28781
------------------------------------------------------------------------------------------
 

estimate store H5b

==> no modelo completo com o segundo índice, como no primeiro, educação e acesso explicam o pagamento das emendas. Entretanto o fator organizacional, que eu esperaria efeito, não possui significância estatística.


 estout  H4a H4b H5a H5b, cells(b(star fmt(3)) se(par fmt(2)))legend label varlabels(_cons constant)  stats(r2 df_r bic)
 

------------------------------------------------------------------------------------
                              H4a             H4b             H5a             H5b   
                             b/se            b/se            b/se            b/se   
------------------------------------------------------------------------------------
pca_index_organiza~l        0.431***        0.272***       -0.166           0.006   
                           (0.09)          (0.06)          (0.14)          (0.10)   
pca_index_education        -0.017*          0.035***       -0.014           0.039***
                           (0.01)          (0.01)          (0.01)          (0.01)   
pca_index_access           -0.015          -0.038***       -0.004          -0.030** 
                           (0.01)          (0.01)          (0.01)          (0.01)   
Centrolocal                -0.682**        -1.833***       -0.820***       -1.910***
                           (0.22)          (0.23)          (0.21)          (0.23)   
CentroSubregional           0.328           0.151           0.390           0.161   
                           (0.29)          (0.29)          (0.28)          (0.29)   
CapitalRegional             0.691           1.191           0.947           1.303   
                           (0.87)          (0.77)          (0.85)          (0.77)   
CentroZona                 -0.554**        -1.036***       -0.648**        -1.097***
                           (0.21)          (0.23)          (0.20)          (0.23)   
Nucleo                      3.903***        2.932**         3.198**         2.604** 
                           (1.09)          (0.98)          (1.07)          (1.01)   
DepMayorSameParty                                          -0.034***       -0.047***
                                                           (0.01)          (0.01)   
LocalVotesElectedDep                                        1.576***        0.705** 
                                                           (0.38)          (0.23)   
constant                    4.775**         4.464**         4.535**         4.478** 
                           (1.53)          (1.42)          (1.49)          (1.43)   
------------------------------------------------------------------------------------
r2                          0.508           0.389           0.556           0.401   
df_r                     4981.000        4981.000        4979.000        4979.000   
bic                     24200.972       25046.507       23699.563       24962.409   
------------------------------------------------------------------------------------
* p<0.05, ** p<0.01, *** p<0.001


==> é estranho a questão organizacional não influenciar a alocação das emendas, já que a capacidade de organizações não governamentais e governos
para realizar os projetos, em tese, contribuiria para atrair mais emendas. Ou é isso mesmo, a alocação das emendas está desvinculada com 
a capacidade organizacional?


**Separando por eleição para ver se os efeitos mudam


reg AmmendValueSettled20152020 DeputyMayorSameParty2016 VoteLocalElection2016 pca_index_socialstructure pca_index_equality pca_index_power centrolocal centrosubregional capitalregional centrozona  nucleo,robust

Linear regression                               Number of obs     =      4,936
                                                F(10, 4925)       =      31.45
                                                Prob > F          =     0.0000
                                                R-squared         =     0.5445
                                                Root MSE          =      3.146

-------------------------------------------------------------------------------------------
                          |               Robust
AmmendValueSettl~20152020 |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------------+----------------------------------------------------------------
 DeputyMayorSameParty2016 |  -.0493886   .0162937    -3.03   0.002    -.0813314   -.0174457
    VoteLocalElection2016 |   2.632938    .506496     5.20   0.000      1.63998    3.625896
pca_index_socialstructure |   .0216224   .0886536     0.24   0.807    -.1521781    .1954229
       pca_index_equality |    .001009    .011141     0.09   0.928    -.0208323    .0228503
          pca_index_power |  -.0177501   .0178463    -0.99   0.320    -.0527368    .0172366
              centrolocal |   -1.03768   .2964797    -3.50   0.000    -1.618912   -.4564475
        centrosubregional |   .1857392   .3476901     0.53   0.593    -.4958884    .8673669
          capitalregional |   .7139184   .9074896     0.79   0.431    -1.065166    2.493003
               centrozona |   -.874162    .281339    -3.11   0.002    -1.425712   -.3226122
                   nucleo |   3.417267   1.291457     2.65   0.008     .8854346    5.949099
                    _cons |   4.286794   1.771857     2.42   0.016     .8131636    7.760424
-------------------------------------------------------------------------------------------

==> na eleição para prefeito em 2016, apenas os fatores da teoria tradicional explicaram o empenho das emendas


reg AmmendValuePaid20152020 DeputyMayorSameParty2016 VoteLocalElection2016 pca_index_socialstructure pca_index_equality pca_index_power centrolocal centrosubregional capitalregional centrozona  nucleo,robust



Linear regression                               Number of obs     =      4,936
                                                F(10, 4925)       =      80.15
                                                Prob > F          =     0.0000
                                                R-squared         =     0.4446
                                                Root MSE          =     3.4284

-------------------------------------------------------------------------------------------
                          |               Robust
  AmmendValuePaid20152020 |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------------+----------------------------------------------------------------
 DeputyMayorSameParty2016 |  -.0573853    .015326    -3.74   0.000    -.0874312   -.0273395
    VoteLocalElection2016 |   1.586144   .5748922     2.76   0.006     .4590992    2.713189
pca_index_socialstructure |   .0436314   .0714843     0.61   0.542    -.0965097    .1837726
       pca_index_equality |   .1181712   .0154261     7.66   0.000     .0879292    .1484131
          pca_index_power |  -.0959996   .0165831    -5.79   0.000    -.1285098   -.0634893
              centrolocal |  -2.345606    .280687    -8.36   0.000    -2.895878   -1.795334
        centrosubregional |   .0053566   .3513346     0.02   0.988    -.6834159    .6941291
          capitalregional |   1.412842   .8605191     1.64   0.101    -.2741591    3.099843
               centrozona |  -1.488157   .2836124    -5.25   0.000    -2.044164   -.9321503
                   nucleo |   2.551067   1.123335     2.27   0.023     .3488297    4.753304
                    _cons |   4.335317   1.655806     2.62   0.009     1.089199    7.581434
-------------------------------------------------------------------------------------------

==> na eleição para prefeito em 2016, os fatores comunitários de igualdade e poder ajudam a explicar o pagamento das emendas.



reg AmmendValueSettled20212023 DeputyMayorSameParty2020 VoteLocalElection2020 pca_index_socialstructure pca_index_equality pca_index_power centrolocal centrosubregional capitalregional centrozona  nucleo,robust



Linear regression                               Number of obs     =      4,935
                                                F(10, 4924)       =       8.01
                                                Prob > F          =     0.0000
                                                R-squared         =     0.2808
                                                Root MSE          =     1.6538

-------------------------------------------------------------------------------------------
                          |               Robust
AmmendValueSettl~20212023 |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------------+----------------------------------------------------------------
 DeputyMayorSameParty2020 |  -.0091256    .009658    -0.94   0.345    -.0280596    .0098083
    VoteLocalElection2020 |   .1468601   .3273839     0.45   0.654    -.4949584    .7886786
pca_index_socialstructure |   .0897753   .0758349     1.18   0.237    -.0588949    .2384455
       pca_index_equality |  -.0006071   .0063844    -0.10   0.924    -.0131233    .0119091
          pca_index_power |  -.0273749   .0131975    -2.07   0.038     -.053248   -.0015019
              centrolocal |  -.2493882   .2191942    -1.14   0.255    -.6791065      .18033
        centrosubregional |  -.1503819   .1481702    -1.01   0.310    -.4408616    .1400978
          capitalregional |  -.2884868   .2573745    -1.12   0.262    -.7930556    .2160821
               centrozona |  -.2506095   .1927717    -1.30   0.194    -.6285279    .1273089
                   nucleo |   .7257646   .6430474     1.13   0.259     -.534895    1.986424
                    _cons |   .2721414   .7960125     0.34   0.732    -1.288398    1.832681
-------------------------------------------------------------------------------------------

==> na eleição para prefeito de 2020, os fatores tradicionais e comunitários não explicam o empenho das emendas


reg AmmendValuePaid20212023 DeputyMayorSameParty2020 VoteLocalElection2020 pca_index_socialstructure pca_index_equality pca_index_power centrolocal centrosubregional capitalregional centrozona  nucleo,robust


Linear regression                               Number of obs     =      4,935
                                                F(10, 4924)       =      52.49
                                                Prob > F          =     0.0000
                                                R-squared         =     0.3534
                                                Root MSE          =     3.6e+06

-------------------------------------------------------------------------------------------
                          |               Robust
  AmmendValuePaid20212023 |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------------+----------------------------------------------------------------
 DeputyMayorSameParty2020 |  -67962.71   29735.22    -2.29   0.022      -126257   -9668.422
    VoteLocalElection2020 |   156185.8   936715.4     0.17   0.868     -1680194     1992566
pca_index_socialstructure |   190725.4   107742.8     1.77   0.077    -20498.66    401949.4
       pca_index_equality |   78252.46   23729.47     3.30   0.001     31732.11    124772.8
          pca_index_power |  -155069.4   23596.89    -6.57   0.000    -201329.9     -108809
              centrolocal |   -1875910   267434.6    -7.01   0.000     -2400201    -1351619
        centrosubregional |  -64680.17   361767.8    -0.18   0.858    -773906.3      644546
          capitalregional |    1107232   837599.7     1.32   0.186    -534837.1     2749301
               centrozona |   -1317954   276946.8    -4.76   0.000     -1860893   -775014.4
                   nucleo |    2738816    1212083     2.26   0.024     362591.7     5115039
                    _cons |    6624865    1655856     4.00   0.000      3378648     9871082
-------------------------------------------------------------------------------------------

==> na eleição para prefeito de 2020, a vinculação partidária, a igualdade e o poder explicam o pagamento das emendas.

 

