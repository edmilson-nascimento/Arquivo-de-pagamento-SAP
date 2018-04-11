class ZCL_FI_PGTO_CONCESSIONARIAS definition
  public
  final
  create public .

public section.

  types:
    BEGIN OF ty_reguh,
        laufd TYPE reguh-laufd,
        laufi TYPE reguh-laufi,
        xvorl TYPE reguh-xvorl,
        zbukr TYPE reguh-zbukr,
        lifnr TYPE reguh-lifnr,
        kunnr TYPE reguh-kunnr,
        empfg TYPE reguh-empfg,
        vblnr TYPE reguh-vblnr,
        name1 TYPE reguh-name1,
        rzawe TYPE reguh-rzawe,
        rbetr TYPE reguh-rbetr,
        augdt TYPE reguh-augdt, "SVT - ACPM - 26.06.2017
        ausfd TYPE reguh-ausfd, "SVT - ACPM - 26.06.2017
        rwbtr TYPE reguh-rwbtr, "SVT - ACPM - 06.07.2017
      END OF ty_reguh .
  types:
    BEGIN OF ty_regup,
        laufd TYPE regup-laufd,
        laufi TYPE regup-laufi,
        xvorl TYPE regup-xvorl,
        zbukr TYPE regup-zbukr,
        lifnr TYPE regup-lifnr,
        kunnr TYPE regup-kunnr,
        empfg TYPE regup-empfg,
        vblnr TYPE regup-vblnr,
        bukrs TYPE regup-bukrs,
        belnr TYPE regup-belnr,
        gjahr TYPE regup-gjahr,
        buzei TYPE regup-buzei,
        zfbdt TYPE regup-zfbdt,
        zbd1t TYPE regup-zbd1t,
        esrnr TYPE regup-esrnr,
        esrre TYPE regup-esrre,
      END OF ty_regup .
  types:
    BEGIN OF ty_bseg,
        bukrs TYPE bseg-bukrs,
        belnr TYPE bseg-belnr,
        gjahr TYPE bseg-gjahr,
        buzei TYPE bseg-buzei,
        sgtxt TYPE bseg-sgtxt,
        fdtag TYPE bseg-fdtag,
        zfbdt TYPE bseg-zfbdt,
        zbd1t TYPE bseg-zbd1t,
      END OF ty_bseg .
  types TY_ARQUIVO type BU_TXT10000 .
  types TY_DETALHE type BU_TXT10000 .
  types:
    tab_regup   TYPE TABLE OF ty_regup .
  types:
    tab_reguh   TYPE TABLE OF ty_reguh .
  types:
    tab_bseg    TYPE TABLE OF ty_bseg .
  types:
    tab_arquivo TYPE TABLE OF bu_txt10000 .
  types:
    tab_detalhe TYPE TABLE OF ty_detalhe .

  methods CONSTRUCTOR .
  methods GET_DATA
    importing
      !REGUT type REGUT .
  methods CHANGE_FILE
    importing
      !I_FILENAME type RLGRAP-FILENAME
      !T_FILE type TAB_ARQUIVO .
  class-methods PREENCHER_ESPACO
    importing
      !CARACTER_INICIAL type I
      !CARACTER_FINAL type I
    changing
      !DETALHE type TY_DETALHE .
  class-methods DATE
    importing
      !DATE type SYDATUM
    exporting
      !DATE_FILE type CHAR8 .
  methods CHECK_FILE
    importing
      !I_FILENAME type RLGRAP-FILENAME
    exporting
      !T_ARQUIVO type TAB_ARQUIVO
      !E_MEIO_PAGAMENTO type CHAR2 .
  PROTECTED SECTION.

private section.

  constants:
    c_santander    TYPE c LENGTH 3 value '033' ##NO_TEXT.
  constants:
    c_caixa        TYPE c LENGTH 3 value '104' ##NO_TEXT.
  constants:
    c_itau         TYPE c LENGTH 3 value '341' ##NO_TEXT.
  constants:
    c_banco_brasil TYPE c LENGTH 3 value '001' ##NO_TEXT.
  class-data T_REGUH type TAB_REGUH .
  class-data T_REGUP type TAB_REGUP .
  class-data T_BSEG type TAB_BSEG .
  class-data CARACTER_SPACE type C .

  methods GET_INFO_FILE
    importing
      !ARQUIVO type TAB_ARQUIVO
    exporting
      !INICIO type CHAR1000SF
      !CABECALHO type BU_TXT10000
      !T_DETALHE type TAB_DETALHE
      !RODAPE type CHAR1000SF
      !FIM type CHAR1000SF
      !FILENAME type STRING .
  methods CHANGE_INICIO
    changing
      !INICIO type CHAR1000SF .
  methods CHANGE_CABECALHO_F
    changing
      !CABECALHO type BU_TXT10000 .
  methods CHANGE_CABECALHO_G
    changing
      !CABECALHO type BU_TXT10000 .
  methods CHANGE_INFO_DETALHES
    changing
      !T_DETALHE type TAB_DETALHE .
  methods CHANGE_INFO_DETALHES_033
    changing
      !DETALHE type TY_DETALHE .
  methods CHANGE_INFO_DETALHES_341
    changing
      !DETALHE type TY_DETALHE .
  methods CHANGE_INFO_DETALHES_104
    changing
      !DETALHE type TY_DETALHE .
  methods CHANGE_INFO_DETALHES_001
    changing
      !DETALHE type TY_DETALHE .
  methods CHANGE_INFO_DETALHES_OTHERS
    changing
      !DETALHE type TY_DETALHE .
  methods CHANGE_INFO_RODAPE
    importing
      !DETALHE type TAB_DETALHE
    changing
      !RODAPE type CHAR1000SF .
  methods CHANGE_INFO_FIM
    importing
      !DETALHE type TAB_DETALHE
    changing
      !FIM type CHAR1000SF .
  methods GET_INFO_BARCODE
    importing
      !ZBUKR type DZBUKR
      !BELNR type BELNR_D
      !GJAHR type GJAHR
      !BUZEI type BUZEI
    exporting
      !VALOR type CHAR15
    changing
      !DETALHE type TY_DETALHE .
  methods GET_INFO_TEXT
    importing
      !ID type TDID
      !LANGUAGE type SPRAS default 'P'
      !NAME type TDOBNAME
      !OBJECT type TDOBJECT
    exporting
      !TDLINE type TDLINE .
  methods SET_INFO_FILE
    importing
      !INICIO type CHAR1000SF
      !CABECALHO type BU_TXT10000
      !T_DETALHE type TAB_DETALHE
      !RODAPE type CHAR1000SF
      !FIM type CHAR1000SF
    changing
      !T_ARQUIVO type TAB_ARQUIVO .
  methods SPACE
    importing
      !BEGIN type I default 0
      !END type I default 0
    changing
      !LINE type ANY .
  methods GET_DETAIL
    importing
      !DETALHE type TY_DETALHE
    exporting
      !REGUH type TY_REGUH
      !REGUP type TY_REGUP
      !BSEG type TY_BSEG .
  methods GET_CONTA_CORRENTE_104
    exporting
      !CONTA type CHAR12
      !DIGITO type CHAR1 .
ENDCLASS.



CLASS ZCL_FI_PGTO_CONCESSIONARIAS IMPLEMENTATION.


  METHOD change_cabecalho_f.

    IF cabecalho IS NOT INITIAL .

      CASE cabecalho(3) .

        WHEN c_santander .

          cabecalho+9(7) = '2011030' .
          CLEAR cabecalho+222(8) .
          UNPACK '0' TO cabecalho+230(10).

        WHEN c_itau .

*         cabecalho+9(7) = '2013030' .

*         20 FORNECEDORES
          cabecalho+9(2)  = '20' .
*         13 PAGAMENTO DE CONCESSIONÁRIAS
          cabecalho+11(2) = '13' .

          UNPACK '0' TO cabecalho+222(18).

        WHEN c_caixa .

          cabecalho+9(7) = '2013030' .

*         1.07 014 016 9(003) Versão do leiaute do lote
          cabecalho+13(3) = '041' .

*         1.12    39  40  2   Tipo de Compromisso 01
          cabecalho+38(2) = '01' .
*         1.13    41  44  4   Código do compromisso   0002
          cabecalho+40(4) = '0002' .
*         1.14    45  46  2   Parâmetro de transmissão    00
          cabecalho+44(2) = '00' .

          me->space(
            EXPORTING
              begin = 47
              end   = 52
            CHANGING
              line  = cabecalho
          ).

          me->get_conta_corrente_104(
            IMPORTING
*             conta  = cabecalho+53(12)
              conta  = cabecalho+58(12)
*             digito =
          ).

*         0.17    71  71  1   DV da conta (5)
          cabecalho+70(1) = '5' .
*         0.18    72  72  1   DV da agência/conta (8)
*         cabecalho+71(1) = '8' .
          cabecalho+71(1) = ' ' .

          UNPACK '0' TO cabecalho+222(18).

          me->space(
            EXPORTING
              begin = 223
              end   = 240
            CHANGING
              line  = cabecalho
          ).


        WHEN c_banco_brasil .

          cabecalho+9(2) = '98' .

*         Pagamento de guias com código de barras
          cabecalho+11(2) = '11' .

          cabecalho+45(7) = '       ' .

          me->space(
            EXPORTING
              begin = 223
              end   = 240
            CHANGING
              line  = cabecalho
          ).


        WHEN OTHERS .

          cabecalho+9(7) = '2013030' .
          UNPACK '0' TO cabecalho+222(18).

      ENDCASE.

    ENDIF .


  ENDMETHOD.


  METHOD change_cabecalho_g.

    IF cabecalho IS NOT INITIAL .

      CASE cabecalho(3) .

        WHEN c_santander .

          cabecalho+9(7) = '2011030' .
          CLEAR cabecalho+222(8) .
          UNPACK '0' TO cabecalho+230(10).

        WHEN c_itau .

*         cabecalho+9(7) = '2013030' .

*         22 TRIBUTOS
          cabecalho+9(2)  = '22' .
*         19 IPTU/ISS/OUTROS TRIBUTOS MUNICIPAIS
*         35 FGTS
*         cabecalho+11(2) = '19' .
          cabecalho+11(2) = '35' .

          UNPACK '0' TO cabecalho+222(18).

        WHEN c_caixa .

          cabecalho+9(7) = '2013030' .

*         1.07 014 016 9(003) Versão do leiaute do lote
          cabecalho+13(3) = '041' .
*         1.12    39  40  2   Tipo de Compromisso 01
          cabecalho+38(2) = '01' .
*         1.13    41  44  4   Código do compromisso   0002
          cabecalho+40(4) = '0002' .
*         1.14    45  46  2   Parâmetro de transmissão    00
          cabecalho+44(2) = '00' .

          me->space(
            EXPORTING
              begin = 47
              end   = 52
            CHANGING
              line  = cabecalho
          ).

          me->get_conta_corrente_104(
            IMPORTING
              conta  = cabecalho+58(12)
*             digito =
          ).

*         0.17    71  71  1   DV da conta (5)
          cabecalho+70(1) = '5' .
*         0.18    72  72  1   DV da agência/conta (8)
*         cabecalho+71(1) = '8' .
          cabecalho+71(1) = ' ' .

          UNPACK '0' TO cabecalho+222(18).

          me->space(
            EXPORTING
              begin = 223
              end   = 240
            CHANGING
              line  = cabecalho
          ).


        WHEN c_banco_brasil .

          cabecalho+9(2) = '98' .

*         Pagamento de guias com código de barras
          cabecalho+11(2) = '11' .

          cabecalho+45(7) = '       ' .

          me->space(
            EXPORTING
              begin = 223
              end   = 240
            CHANGING
              line  = cabecalho
          ).


        WHEN OTHERS .

          cabecalho+9(7) = '2013030' .
          UNPACK '0' TO cabecalho+222(18).

      ENDCASE.

    ENDIF .

  ENDMETHOD.


  METHOD change_file.

* Para a solução atual, será feito apenas para F
* logo, por causa de tempo de entrega, será fixo apenas para este cenário.

    DATA:
      inicio           TYPE char1000sf,
      t_cabecalho      TYPE TABLE OF char1000sf,
      cabecalho        TYPE bu_txt10000,
      t_detalhe        TYPE TABLE OF bu_txt10000,
      detalhe          LIKE LINE OF t_detalhe,
      rodape           TYPE char1000sf,
      fim              TYPE char1000sf,
      v_gjahr          TYPE bseg-gjahr,
      filename         TYPE string,
      t_arquivo        TYPE tab_arquivo,

* I - LAPM - 16/08/2017 - CH8568
      lt_reguh         TYPE tab_reguh.
* F - LAPM - 16/08/2017 - CH8568

* I - 16/08/2017 - CH8568

*    CASE reguh-rzawe .
*
*      WHEN 'F' OR 'G' .
*
*        CLEAR: inicio, cabecalho, detalhe, rodape, fim, v_gjahr.
*        REFRESH: t_cabecalho, t_detalhe, t_arquivo .
*
*        filename = i_filename.
*
*        CALL FUNCTION 'GUI_UPLOAD'
*          EXPORTING
*            filename = filename
*            filetype = 'ASC'
*          TABLES
*            data_tab = t_arquivo.

    CLEAR: inicio, cabecalho, detalhe, rodape, fim, v_gjahr.
    REFRESH: t_cabecalho, t_detalhe, t_arquivo .

    filename    = i_filename.
    lt_reguh[]  = t_reguh[].
    t_arquivo[] = t_file[].


* F - 16/08/2017 - CH8568

    CHECK lines( t_arquivo ) GT 0.

    me->get_info_file(
      EXPORTING
        arquivo   = t_arquivo
      IMPORTING
        inicio    = inicio
        cabecalho = cabecalho
        t_detalhe = t_detalhe
        rodape    = rodape
        fim       = fim
        filename  = filename
     ).

    me->change_inicio(
      CHANGING
        inicio = inicio
    ).

* I - 16/08/2017 - CH8568

**    CASE reguh-rzawe.
*
*      WHEN 'F'.
*        me->change_cabecalho_f(
*          CHANGING
*            cabecalho = cabecalho
*        ).
*
*      WHEN 'G'.
*        me->change_cabecalho_g(
*          CHANGING
*            cabecalho = cabecalho
*        ).
*
*    ENDCASE.

    SORT lt_reguh BY rzawe.

    READ TABLE lt_reguh WITH KEY rzawe = 'G' BINARY SEARCH
                                             TRANSPORTING NO FIELDS.

    IF sy-subrc EQ 0.
      me->change_cabecalho_g(
        CHANGING
          cabecalho = cabecalho
      ).
    ELSE.
      me->change_cabecalho_f(
        CHANGING
          cabecalho = cabecalho
      ).
    ENDIF.
* F - 16/08/2017 - CH8568

    me->change_info_detalhes(
      CHANGING
        t_detalhe = t_detalhe
    ).

    me->change_info_rodape(
     EXPORTING detalhe = t_detalhe  " Chamado 8183
      CHANGING rodape  = rodape
    ).

    me->change_info_fim(
      EXPORTING detalhe = t_detalhe  " Chamado 8183
       CHANGING fim     = fim
    ).

    me->set_info_file(
      EXPORTING
        inicio    = inicio
        cabecalho = cabecalho
        t_detalhe = t_detalhe
        rodape    = rodape
        fim       = fim
      CHANGING
        t_arquivo = t_arquivo
    ).

    CALL FUNCTION 'GUI_DOWNLOAD'
      EXPORTING
        filename = filename
        filetype = 'ASC'
      TABLES
        data_tab = t_arquivo.

*  WHEN OTHERS.
*ENDCASE.

  ENDMETHOD.


  METHOD change_info_detalhes .

    DATA:
      vblnr   TYPE vblnr,
      zfbdt   TYPE dzfbdt,
      rbetr_c TYPE char13,
      output  TYPE char12.

    SORT: t_reguh BY vblnr ASCENDING,
          t_regup BY vblnr ASCENDING,
          t_bseg  BY bukrs ASCENDING
                     belnr ASCENDING
                     gjahr ASCENDING
                     buzei ASCENDING .

    LOOP AT t_detalhe INTO DATA(detalhe) .

      DATA(tabix) = sy-tabix .

      CASE detalhe(3) .

        WHEN c_santander .
* I - SVT - ACPM - 14.06.2017 - Retira o registro B
          IF detalhe+13(1) = 'B'.
            DELETE t_detalhe INDEX tabix.
            CONTINUE.
          ENDIF.
* I - SVT - ACPM - 14.06.2017

          me->change_info_detalhes_033(
            CHANGING
              detalhe = detalhe
          ).

        WHEN c_itau.

          me->change_info_detalhes_341(
            CHANGING
              detalhe = detalhe
          ).

        WHEN c_caixa .

          me->change_info_detalhes_104(
            CHANGING
              detalhe = detalhe
          ).

        WHEN c_banco_brasil .

          IF detalhe+13(1) EQ 'B' .

            DELETE t_detalhe INDEX tabix .

          ELSE .

            me->change_info_detalhes_001(
              CHANGING
                detalhe = detalhe
            ).

          ENDIF .

        WHEN OTHERS .

          me->change_info_detalhes_others(
            CHANGING
              detalhe = detalhe
          ).

      ENDCASE .


      DATA(len) = strlen( detalhe ) .

      IF len LT 240 . " Quantidade de registro por linha

* I - SVT - LAPM - 04.07.2017 - CH8568
        IF detalhe+229(1) IS NOT INITIAL.
          ADD 1 TO len.
        ENDIF.
* F - SVT - LAPM - 04.07.2017 - CH8568

        me->preencher_espaco(
          EXPORTING
            caracter_inicial = len
            caracter_final   = 240
          CHANGING
            detalhe          = detalhe
        ).

      ENDIF .

      MODIFY t_detalhe FROM detalhe INDEX tabix .

    ENDLOOP.

  ENDMETHOD .


  METHOD change_info_detalhes_001 .

    DATA:
      line_reguh TYPE ty_reguh,
      line_regup TYPE ty_regup,
      line_bseg  TYPE ty_bseg,
      rbetr_c    TYPE char13,
      valor      TYPE char15.

    CASE detalhe+13(1) .

      WHEN 'A' .

        me->get_detail(
          EXPORTING
            detalhe = detalhe
          IMPORTING
            reguh   = line_reguh
            regup   = line_regup
            bseg    = line_bseg
        ).

        me->get_info_barcode(
          EXPORTING
            zbukr   = line_regup-zbukr
            belnr   = line_regup-belnr
            gjahr   = line_regup-gjahr
            buzei   = '001'
           IMPORTING
           valor = valor
          CHANGING
            detalhe = detalhe
        ).

*       Posições 092 a 099: Preencher com a data de vencimento da guia
        detalhe+91(8) = detalhe+93(8) .

*       Posições 100 a 107: Preencher com a data de pagamento da guia
        detalhe+99(8) = detalhe+91(8) .

*       Posições 108 a 122: Preencher com o valor de pagamento
        valor = detalhe+122(12) .
        UNPACK valor TO valor .
        detalhe+107(15) = valor .

*       Posições 123 a 142: Foi informado "000002409654        "
        detalhe+122(20) = space .

*       Posições 163 a 230: Preencher com brancos
        detalhe+162(68) = space .

*       Posições 231 a 240: Preencher com brancos
        detalhe+230(10) = space .

      WHEN 'B' .

        me->get_detail(
          EXPORTING
            detalhe = detalhe
          IMPORTING
            reguh   = line_reguh
            regup   = line_regup
            bseg    = line_bseg
        ).

*       Data de Vencimento
        detalhe+95(2)     = line_bseg-zfbdt+6(2).
        detalhe+97(2)     = line_bseg-zfbdt+4(2).
        detalhe+99(4)     = line_bseg-zfbdt(4).
        detalhe+103(3)    = 'REA'.

        CLEAR detalhe+106(15).

        MOVE line_reguh-rbetr TO rbetr_c .

        UNPACK rbetr_c      TO detalhe+121(15) .
        detalhe+136(2)    = line_reguh-laufd+6(2).
        detalhe+138(2)    = line_reguh-laufd+4(2).
        detalhe+140(4)    = line_reguh-laufd(4).

        UNPACK rbetr_c        TO detalhe+144(15).

        CLEAR detalhe+159(15).

        UNPACK line_regup-belnr    TO detalhe+174(20).

        UNPACK '0'              TO detalhe+195(45).
      WHEN OTHERS .

    ENDCASE.

  ENDMETHOD.


  METHOD change_info_detalhes_033 .

    DATA:
      line_bseg TYPE ty_bseg .
* I - SVT - ACPM - 13.06.2017
    DATA:
      line_reguh   TYPE ty_reguh,
      line_regup   TYPE ty_regup,
      rbetr_c      TYPE char13,
      l_codigo(44) TYPE n,
      l_char(18),
      l_valor(15)  TYPE n.
* V - SVT - ACPM - 13.06.2017

    CLEAR: l_codigo, l_valor.

    CASE detalhe+13(1) .

      WHEN 'A' .

* I - SVT - ACPM - 13.06.2017 - Gera registro O, como arquivo Itaú
        me->get_detail(
           EXPORTING
             detalhe = detalhe
           IMPORTING
             reguh   = line_reguh
             regup   = line_regup
             bseg    = line_bseg

*        me->get_detail(
*          exporting
*            detalhe = detalhe
*          importing
**             reguh   =
**             regup   =
*            bseg    = line_bseg
      ).

        me->get_info_barcode(
               EXPORTING
                 zbukr   = line_regup-zbukr
                 belnr   = line_regup-belnr
                 gjahr   = line_regup-gjahr
                 buzei   = '001'
               CHANGING
                 detalhe = detalhe
        ).

* Nome Concessionária
        detalhe+61(30) = line_reguh-name1.

*       vblnr          = line_regup-vblnr.
*       zfbdt+6(2)     = line_bseg-zfbdt+6(2) + line_bseg-zbd1t.

* I - SVT - LAPM - 11.10.2017 - CH8183 - Campos comentados

**       Data de Vencimento
*        detalhe+95(2)     = line_bseg-zfbdt+6(2).
*        detalhe+97(2)     = line_bseg-zfbdt+4(2).
*        detalhe+99(4)     = line_bseg-zfbdt(4).
*        detalhe+103(3)    = 'REA'.

*        CLEAR detalhe+106(15).

*        MOVE line_reguh-rbetr TO rbetr_c .

*        UNPACK rbetr_c      TO detalhe+121(15) .
*        detalhe+136(2)    = line_reguh-laufd+6(2).
*        detalhe+138(2)    = line_reguh-laufd+4(2).
*        detalhe+140(4)    = line_reguh-laufd(4).
*
*        UNPACK rbetr_c        TO detalhe+144(15).

*        CLEAR detalhe+159(15).

*        UNPACK line_regup-belnr TO detalhe+174(20).
*
*        UNPACK '0'              TO detalhe+195(45).

* F - SVT - LAPM - 11.10.2017 - CH8183 - Campos comentados

* I - SVT - ACPM - 13.06.2017 - ajustes Arquivo SANTANDER

*Código de barras
        MOVE detalhe+17(44) TO l_codigo.
        CLEAR detalhe+17(44).
        WRITE l_codigo TO detalhe+17(44) RIGHT-JUSTIFIED.

*Data de vencimento
        CONCATENATE line_reguh-augdt+6(2) line_reguh-augdt+4(2) line_reguh-augdt(4)
               INTO detalhe+91(8).
*Data de Pagamento
        CONCATENATE line_reguh-ausfd+6(2) line_reguh-ausfd+4(2) line_reguh-ausfd(4)
               INTO detalhe+99(8).

*Valor de Pagamento
        MOVE line_reguh-rwbtr TO l_char.
        MOVE l_char+3(15) TO l_valor.
        CLEAR detalhe+107(15).
        WRITE l_valor TO detalhe+107(15) RIGHT-JUSTIFIED.

* I - SVT - LAPM - 11.10.2017 - CH8183 -  Nº Documento Cliente , Nº Documento banco e Filler

* Nº Documento Cliente
        UNPACK line_regup-belnr TO detalhe+122(20).

* Nº Documento banco
        UNPACK '0' TO detalhe+142(20).

* Filler
*        detalhe+162(67) = space.
        CLEAR detalhe+163(67).

* F - SVT - LAPM - 11.10.2017 - CH8183


* F - SVT - ACPM - 13.06.2017 - ajustes Arquivo SANTANDER

* I - SVT - ACPM - 06.07.2017 - CH8183
        detalhe+231(11) = space.
* F - SVT - ACPM - 06.07.2017 - CH8183


*        detalhe+11(2) = '11' .
*
**       Data de Vencimento
*        me->date(
*          exporting
*            date      = line_bseg-zfbdt
*          importing
*            date_file = detalhe+91(8)
*        ) .
*
**         Data de Pagamento
*        me->date(
*          exporting
*            date      = line_bseg-fdtag
*          importing
*            date_file = detalhe+99(8)
*        ) .
*
**       Data do Pagamento 094 101 9(008) DDMMAAAA
*        detalhe+93(8) = detalhe+91(8) .
*
**       Tipo da Moeda 102 104 X(003) Nota G005
*        detalhe+101(3) = 'BRL' .
*
**       Quantidade de Moeda 105 119 9(010)V5 Zeros
*        me->space(
*          exporting
*            begin = 105
*            end   = 119
*          changing
*            line  = detalhe
*        ).
*
**       Filter
*        me->preencher_espaco(
*          exporting
*            caracter_inicial = 163
**           caracter_final   = 230
*            caracter_final   = 220
*          changing
*            detalhe          = detalhe
*        ).
*
**       Finalidade de TED 220 224 X(05) Nota G013 B
*        me->space(
*          exporting
*            begin = 220
*            end   = 224
*          changing
*            line  = detalhe
*        ).
*
**       Filler 227 229 X(010) Brancos
*        me->space(
*          exporting
*            begin = 227
*            end   = 229
*          changing
*            line  = detalhe
*        ).
*
**       Emissão de Aviso ao Favorecido 230 230 X(001) Nota G018
**       detalhe+229(1) = '0' .
*
*      when 'B' .
*
**       Número do Local do Favorecido 063 067 9(005) Opciona
*        unpack '0' to detalhe+62(5) .
*
**       CEP do Favorecido 118 125 9(008) Opcional
*        unpack '0' to detalhe+117(8) .
*
*        clear detalhe+240 .
*        detalhe+210(4)  = sy-uzeit(4) .
*        detalhe+214(10) = '          ' .
*        detalhe+225(4)  = '0000' .
*
*        detalhe+229(1)  = '0' .
*
**       Filler 231 231 X(001 ) Nota G007
*        me->space(
*          exporting
*            begin = 231
*            end   = 231
*          changing
*            line  = detalhe
*        ).
*
**       TED para Instituição Financeira 232 232 X(001) Nota G029
*        me->space(
*          exporting
*            begin = 232
*            end   = 232
*          changing
*            line  = detalhe
*        ).
*
**       Identificação da IF no SPB 233 240 X(008) Nota G030
*        me->space(
*          exporting
*            begin = 233
*            end   = 240
*          changing
*            line  = detalhe
*        ).

* F - SVT - ACPM - 13.06.2017
      WHEN 'B' .

      WHEN OTHERS .

    ENDCASE.

  ENDMETHOD.


  METHOD change_info_detalhes_104 .

    DATA:
      line_reguh TYPE ty_reguh,
      line_regup TYPE ty_regup,
      line_bseg  TYPE ty_bseg,
      rbetr_c    TYPE char13,
      htype      TYPE datatype_d.

    CASE detalhe+13(1) .

      WHEN 'A' .

        me->get_detail(
          EXPORTING
            detalhe = detalhe
          IMPORTING
            reguh   = line_reguh
            regup   = line_regup
            bseg    = line_bseg
        ).

        me->get_info_barcode(
          EXPORTING
            zbukr   = line_regup-zbukr
            belnr   = line_regup-belnr
            gjahr   = line_regup-gjahr
            buzei   = '001'
          CHANGING
            detalhe = detalhe
        ).

        detalhe+13(1) = 'K' .

*       Retorno de erro
*       Reg:3 Posição 57,17 deveria ser branco. Encontrado:004853611
        me->space(
          EXPORTING
            begin = 57
            end   = 73
          CHANGING
            line  = detalhe
        ).

*       Filler
        me->preencher_espaco(
          EXPORTING
            caracter_inicial = 80
            caracter_final   = 92
          CHANGING
            detalhe          = detalhe
        ).

        me->get_detail(
          EXPORTING
            detalhe = detalhe
          IMPORTING
            reguh   = line_reguh
            regup   = line_regup
            bseg    = line_bseg
        ).

*       A.20 102 104 X(003) Tipo da moeda
*       detalhe+101(3)

*       A.19 094 101 9(008) Data Vencimento
        me->date(
          EXPORTING
            date      = line_bseg-zfbdt
          IMPORTING
            date_file = detalhe+93(8)
        ).

*       A.21 105 119 9(010)V99999 Quantidade de moeda

*       A.22 120 134 9(013)V99 Valor Lançamento


**       Data de Vencimento
*        detalhe+95(2)     = line_bseg-zfbdt+6(2).
*        detalhe+97(2)     = line_bseg-zfbdt+4(2).
*        detalhe+99(4)     = line_bseg-zfbdt(4).
*        detalhe+103(3)    = 'REA'.
*        clear detalhe+106(15).
*
*       Número do documento banco
        UNPACK '0' TO detalhe+134(8) .

        UNPACK rbetr_c      TO detalhe+121(15) .
        detalhe+136(2)    = line_reguh-laufd+6(2).
        detalhe+138(2)    = line_reguh-laufd+4(2).
        detalhe+140(4)    = line_reguh-laufd(4).

*       Reg:3 Posição 144,11 deveria ser branco. Encontrado:70000010000
*       A.24 144 146 X(003) Filler
*       A.25 147 148 9(002) Quantidade de Parcelas
        me->space(
          EXPORTING
            begin = 144
            end   = 154
          CHANGING
            line  = detalhe
        ).

*       A.30 155 162 9(008) Data da Efetivação
*        me->date(
*          exporting
*            date      = line_bseg-zfbdt
*          importing
*           date_file = detalhe+154(8)
*        ).
        UNPACK '0' TO detalhe+154(8) .

*        A.31 163 177 9(013) V99 Valor Real Efetivado
        detalhe+163(13) = rbetr_c .
        UNPACK detalhe+163(13) TO detalhe+163(13) .

*        move line_reguh-rbetr to rbetr_c .
*        unpack rbetr_c        to detalhe+144(15).
*
**       Indicador de forma de parcelamento
*        detalhe+149(1)    = '1' .
*
**       Número parcela
*        detalhe+152(2)    = '00' .

*       clear detalhe+159(15).

        UNPACK line_regup-belnr TO detalhe+174(20).

        UNPACK '0'              TO detalhe+195(45).

**      Finalidade DOC
*       detalhe+217(2)    = '07' .

*       A.33 218 219 9(002) Finalidade DOC
        me->space(
          EXPORTING
            begin = 218
            end   = 219
          CHANGING
            line  = detalhe
        ).

*       A.34 220 229 X(010) Uso FEBRABAN
        me->space(
          EXPORTING
            begin = 220
            end   = 229
          CHANGING
            line  = detalhe
        ).

*       Reg:3 Posição 231,10 deveria ser branco. Encontrado:0000000000
        me->space(
          EXPORTING
            begin = 231
            end   = 240
          CHANGING
            line  = detalhe
        ).

      WHEN 'B' .

*       B.10 063 067 9(005) Número no local
        CALL FUNCTION 'NUMERIC_CHECK'
          EXPORTING
            string_in = detalhe+62(5)
          IMPORTING
*           string_out =
            htype     = htype.

        IF htype EQ 'NUMC' .
          UNPACK detalhe+62(5) TO detalhe+62(5) .
        ELSE .
          UNPACK '0' TO detalhe+62(5) .
        ENDIF .


*       A.30 155 162 9(008) Data da Efetivação
        me->space(
          EXPORTING
            begin = 155
            end   = 162
          CHANGING
            line  = detalhe
        ).

        UNPACK '0' TO detalhe+135(75) .

        me->preencher_espaco(
          EXPORTING
            caracter_inicial = 226
            caracter_final   = 240
          CHANGING
            detalhe          = detalhe
        ).

      WHEN OTHERS .

    ENDCASE.

  ENDMETHOD.


  METHOD change_info_detalhes_341 .

    DATA:
      line_reguh TYPE ty_reguh,
      line_regup TYPE ty_regup,
      line_bseg  TYPE ty_bseg,
      rbetr_c    TYPE char13.

    CASE detalhe+13(1) .

      WHEN 'A'.

        me->get_detail(
          EXPORTING
            detalhe = detalhe
          IMPORTING
            reguh   = line_reguh
            regup   = line_regup
            bseg    = line_bseg
        ).
* I - SVT - LAPM - 04.07.2017 - CH8568
* Modificar seleção

        me->get_info_barcode(
          EXPORTING
            zbukr   = line_regup-zbukr
            belnr   = line_regup-belnr
            gjahr   = line_regup-gjahr
            buzei   = '001'
          CHANGING
            detalhe = detalhe
        ).
* F - SVT - LAPM - 04.07.2017 - CH8568

        detalhe+65(30) = line_reguh-name1.
*       vblnr          = line_regup-vblnr.
*       zfbdt+6(2)     = line_bseg-zfbdt+6(2) + line_bseg-zbd1t.

*       Data de Vencimento
        detalhe+95(2)     = line_bseg-zfbdt+6(2).
        detalhe+97(2)     = line_bseg-zfbdt+4(2).
        detalhe+99(4)     = line_bseg-zfbdt(4).
        detalhe+103(3)    = 'REA'.

        CLEAR detalhe+106(15).

        MOVE line_reguh-rbetr TO rbetr_c .

        UNPACK rbetr_c      TO detalhe+121(15) .
        detalhe+136(2)    = line_reguh-laufd+6(2).
        detalhe+138(2)    = line_reguh-laufd+4(2).
        detalhe+140(4)    = line_reguh-laufd(4).

        UNPACK rbetr_c TO detalhe+144(15).

        CLEAR detalhe+159(15).

        UNPACK line_regup-belnr TO detalhe+174(20).

        UNPACK '0' TO detalhe+195(45).

      WHEN 'B' .

      WHEN OTHERS .

    ENDCASE.

  ENDMETHOD.


  METHOD change_info_detalhes_others .

    DATA:
      line_reguh TYPE ty_reguh,
      line_regup TYPE ty_regup,
      line_bseg  TYPE ty_bseg,
      rbetr_c    TYPE char13.

    CASE detalhe+13(1) .

      WHEN 'A' .

        me->get_detail(
          EXPORTING
            detalhe = detalhe
          IMPORTING
            reguh   = line_reguh
            regup   = line_regup
            bseg    = line_bseg
        ).

        me->get_info_barcode(
          EXPORTING
            zbukr   = line_regup-zbukr
            belnr   = line_regup-belnr
            gjahr   = line_regup-gjahr
            buzei   = '001'
          CHANGING
            detalhe = detalhe
        ).


      WHEN 'B' .

        me->get_detail(
          EXPORTING
            detalhe = detalhe
          IMPORTING
            reguh   = line_reguh
            regup   = line_regup
            bseg    = line_bseg
        ).

*       Data de Vencimento
        detalhe+95(2)     = line_bseg-zfbdt+6(2).
        detalhe+97(2)     = line_bseg-zfbdt+4(2).
        detalhe+99(4)     = line_bseg-zfbdt(4).
        detalhe+103(3)    = 'REA'.

        CLEAR detalhe+106(15).

        MOVE line_reguh-rbetr TO rbetr_c .

        UNPACK rbetr_c      TO detalhe+121(15) .
        detalhe+136(2)    = line_reguh-laufd+6(2).
        detalhe+138(2)    = line_reguh-laufd+4(2).
        detalhe+140(4)    = line_reguh-laufd(4).

        UNPACK rbetr_c        TO detalhe+144(15).

        CLEAR detalhe+159(15).

        UNPACK line_regup-belnr    TO detalhe+174(20).

        UNPACK '0'              TO detalhe+195(45).
      WHEN OTHERS .

    ENDCASE.

  ENDMETHOD.


  METHOD change_info_fim.

    DATA: lv_lines_detalhe(6) TYPE n.

    CASE fim(3) .

      WHEN c_santander .

        UNPACK '0' TO fim+35(205).

        " Início - EFP - 22.09.2017 - Chamado 8183

* I - SVT - ACPM - 26.06.2017
*Trailler
        "       SUBTRACT 1 FROM fim+28(1).
* F - SVT - ACPM - 26.06.2017

        " Quantidade total de linhas   Fazer ??/
        lv_lines_detalhe = lines( detalhe ).
        ADD 4 TO lv_lines_detalhe. " Header + Trailer + Rodape + fim

        fim+23(6) = lv_lines_detalhe.
        " Fim    - EFP - 22.09.2017 - Chamado 8183

      WHEN c_caixa .

        me->space(
          EXPORTING
            begin = 36
            end   = 240
          CHANGING
            line  = fim
        ).

      WHEN c_itau .

        UNPACK '0' TO fim+35(205).

      WHEN c_banco_brasil .

        UNPACK '0' TO fim+35(205).

      WHEN OTHERS .

        UNPACK '0' TO fim+35(205).

    ENDCASE.

  ENDMETHOD.


  METHOD change_info_rodape .

    DATA:
      change              TYPE ty_detalhe,
      total               TYPE c LENGTH 18,
* I - LAPM - 22/09/2017 - CH8183
      lv_lines_detalhe(6) TYPE n.
* F - LAPM - 22/09/2017 - CH81/83

    CASE rodape(3) .

      WHEN c_santander .

        change = rodape .

* I - SVT - ACPM - 26.06.2017

*       Número Aviso de Débito 060 065 9(006) Nota G020
        UNPACK '0' TO change+59(6) .



* I - SVT - LAPM - 11.10.2017 - CH8183
* Campo Filler

*        UNPACK '0' TO change+65(174) .
*
*        me->preencher_espaco(
*          EXPORTING
*            caracter_inicial = 231
*            caracter_final   = 240
*          CHANGING
*            detalhe          = change
*        ).

        me->preencher_espaco(
          EXPORTING
            caracter_inicial = 66
            caracter_final   = 240
          CHANGING
            detalhe          = change
        ).

* F - LAPM - 22/09/2017 - CH8183

        rodape = change .

*Trailler

* I - LAPM - 22/09/2017 - CH8183
* Quantidade total de linhas do segmento

*        SUBTRACT 1 FROM rodape+22(1).

        lv_lines_detalhe = lines( detalhe ).
        ADD 2 TO lv_lines_detalhe. " Header + Trailer

        rodape+17(6) = lv_lines_detalhe.
* F - LAPM - 22/09/2017 - CH8183


* F - SVT - ACPM - 26.06.2017

      WHEN c_itau .

        rodape+41(18)           = rodape+23(18).
        UNPACK '0'                TO rodape+59(181).


      WHEN c_caixa .

*       Reg:5 TRAILLER LOTE Posição 66,175 deveria ser branco.
        me->space(
          EXPORTING
            begin = 66
            end   = 240
          CHANGING
            line  = rodape
        ).


*      when c_santander .
*
**       Número Aviso de Débito 060 065 9(006)
*        unpack '0' to rodape+59(6) .
*
**       Filler 066 230 X(165)
*        me->space(
*          exporting
*            begin = 66
*            end   = 230
*          changing
*            line  = rodape
*        ).

      WHEN OTHERS .

        rodape+41(18)           = rodape+23(18).
        UNPACK '0'                TO rodape+59(181).


    ENDCASE.


  ENDMETHOD.


  METHOD change_inicio.

    DATA: change TYPE ty_detalhe.

    IF inicio IS NOT INITIAL .

      CASE inicio(3) .

        WHEN c_santander .

* I - SVT - LAPM - 8183 - 11/12/2017

*          UNPACK '0' TO inicio+201(39).
           UNPACK '0' TO inicio+201(10).

*         " posição 212 a 230 em branco

         change = inicio.

         me->preencher_espaco(
          EXPORTING
            caracter_inicial = 212
            caracter_final   = 231
          CHANGING
            detalhe          = change
         ).

          inicio = change.

          UNPACK '0' TO inicio+230(10).

* F - SVT - LAPM - 8183 - 11/12/2017

        WHEN c_caixa .

          space(
            EXPORTING
              begin = 42
              end   = 42
            CHANGING
              line  = inicio
          ).

          me->space(
            EXPORTING
              begin = 43
              end   = 45
            CHANGING
              line  = inicio
          ).

          UNPACK '0' TO  inicio+45(4) .

          me->get_conta_corrente_104(
            IMPORTING
              conta  = inicio+58(12)
*             digito =
          ).

*         0.17    71  71  1   DV da conta (5)
          inicio+70(1) = '5' .
*         0.18    72  72  1   DV da agência/conta (8)
*         inicio+71(1) = '8' .
          inicio+71(1) = ' ' .


          UNPACK '0' TO inicio+201(39).
*         Versão do layout do arquivo
          inicio+163(3) = '080' .

*         Densidade de gravação
          inicio+166(5) = '01600' .

          me->space(
            EXPORTING
              begin = 212
              end   = 225
            CHANGING
              line  = inicio
          ).

          me->space(
            EXPORTING
              begin = 229
              end   = 240
            CHANGING
              line  = inicio
          ).

*         Uso exclusivo das VAN
          inicio+225(3) = '000' .


        WHEN c_itau .

          UNPACK '0' TO inicio+201(39).

        WHEN c_banco_brasil .

          inicio+45(7) = '       ' .

          UNPACK '0' TO inicio+201(39).

        WHEN OTHERS .

          UNPACK '0' TO inicio+201(39).

      ENDCASE.

    ENDIF .


  ENDMETHOD.


  METHOD check_file.

    DATA:lw_inicio    TYPE char1000sf,
         lw_cabecalho TYPE bu_txt10000,
         lt_detalhe   TYPE TABLE OF bu_txt10000,
         lw_detalhe   TYPE bu_txt10000,
         lw_rodape    TYPE char1000sf,
         lw_fim       TYPE char1000sf,
         lv_filename  TYPE string,
         lt_arquivo   TYPE tab_arquivo,
         lt_reguh     TYPE tab_reguh,
         lw_reguh     TYPE ty_reguh.

    lv_filename = i_filename.
    lt_reguh[]  = t_reguh[].

    CALL FUNCTION 'GUI_UPLOAD'
      EXPORTING
        filename = lv_filename
        filetype = 'ASC'
      TABLES
        data_tab = lt_arquivo.

    t_arquivo[] = lt_arquivo[].

    me->get_info_file(
     EXPORTING
     arquivo   = lt_arquivo
     IMPORTING
     inicio    = lw_inicio
     cabecalho = lw_cabecalho
     t_detalhe = lt_detalhe
     rodape    = lw_rodape
     fim       = lw_fim
     filename  = lv_filename
    ).

    CHECK lt_detalhe IS NOT INITIAL.

    SORT lt_reguh BY vblnr.

    e_meio_pagamento = 'CO'. " Concessionaria

    LOOP AT lt_detalhe INTO lw_detalhe.

* I - LAPM - 21/09/2017 - CH8183

* Para o Santander os segmentos diferentes de A e J são opcionais,
* portanto não é necessário verificar.

      IF lw_detalhe(3) EQ c_santander AND
         ( lw_detalhe+13(1) NE 'A' AND lw_detalhe+13(1) NE 'J' ).
        CONTINUE.
      ENDIF.
* F - LAPM - 21/09/2017 - CH8183

      CLEAR lw_reguh.
      READ TABLE lt_reguh INTO lw_reguh WITH KEY vblnr = lw_detalhe+73(10)
                                                 BINARY SEARCH.

      IF lw_reguh-rzawe NE 'F'.  " Valor null também corresponde ao fornecedor
        e_meio_pagamento = 'FO'. " Fornecedor
      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD constructor .

    caracter_space = cl_abap_conv_in_ce=>uccp( '00a0' ) .

  ENDMETHOD.


  METHOD date .

    DATA:
       output TYPE char12 .

    CALL FUNCTION 'CONVERSION_EXIT_PDATE_OUTPUT'
      EXPORTING
        input  = date
      IMPORTING
        output = output.

    TRANSLATE output USING '. ' .
    CONDENSE  output NO-GAPS .

    date_file = output .

  ENDMETHOD.


  METHOD get_conta_corrente_104.

    DATA:
      local_agencia      TYPE char4,
      local_conta        TYPE char8,
      local_digito_conta TYPE char1,
      local_operacao     TYPE char3 VALUE '003'.

    zcl_fi_pgto_fornecedores=>get_bank_104(
       IMPORTING
*        banco          =
         agencia        = local_agencia
         conta          = local_conta
*        sdigito_agencia =
         digito_conta   = local_digito_conta
    ).

*   concatenate local_agencia local_operacao local_conta+3 into conta .
    CONCATENATE local_operacao '0' local_conta INTO conta .

  ENDMETHOD.


  METHOD get_data.

    REFRESH: t_reguh, t_regup.

    SELECT laufd laufi xvorl zbukr lifnr kunnr
           empfg vblnr name1 rzawe rbetr augdt ausfd rwbtr
    FROM reguh
    INTO TABLE t_reguh
    WHERE laufd EQ regut-laufd
      AND laufi EQ regut-laufi
      AND zbukr EQ regut-zbukr.
*      and xvorl eq space.

    CHECK sy-subrc EQ 0 .

    SELECT laufd laufi xvorl zbukr lifnr kunnr empfg vblnr
           bukrs belnr gjahr buzei zfbdt zbd1t esrnr esrre
    FROM regup INTO TABLE t_regup
    FOR ALL ENTRIES IN t_reguh
    WHERE laufi EQ regut-laufi
      AND laufd EQ regut-laufd
      AND zbukr EQ regut-zbukr
*       and xvorl eq space
      AND vblnr EQ t_reguh-vblnr.

    IF sy-subrc EQ 0 .

      SORT t_reguh BY rzawe DESCENDING .

      SORT t_regup BY zbukr ASCENDING
                      belnr ASCENDING
                      gjahr ASCENDING .

      SELECT bukrs belnr gjahr buzei sgtxt fdtag zfbdt zbd1t
      FROM bseg
      INTO TABLE t_bseg
      FOR ALL ENTRIES IN t_regup
      WHERE bukrs EQ t_regup-zbukr
        AND belnr EQ t_regup-belnr
        AND gjahr EQ t_regup-gjahr .

    ENDIF.



  ENDMETHOD.


  METHOD get_detail .

    READ TABLE t_reguh INTO reguh
      WITH KEY vblnr = detalhe+73(10)
      BINARY SEARCH.

    IF sy-subrc EQ 0 .
    ELSE .

      READ TABLE t_reguh INTO reguh
        WITH KEY vblnr = detalhe+182(10)
        BINARY SEARCH.

    ENDIF .

    IF sy-subrc EQ 0 .

      READ TABLE t_regup INTO regup
        WITH KEY vblnr = reguh-vblnr
        BINARY SEARCH.

      IF sy-subrc EQ 0 .

        READ TABLE t_bseg INTO bseg
          WITH KEY bukrs = regup-zbukr
                   belnr = regup-belnr
                   gjahr = regup-gjahr
          BINARY SEARCH.

        IF sy-subrc EQ 0 .
        ENDIF.

      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD get_info_barcode .

    DATA: name TYPE tdobname,
          line TYPE tdline.

    CONCATENATE zbukr belnr gjahr buzei INTO name.

    me->get_info_text(
      EXPORTING
        id       = '0001'
*       language = 'P'
        name     = name
        object   = 'DOC_ITEM'
      IMPORTING
        tdline   = line
    ).

* I - SVT - LAPM - 04.07.2017 - CH8568
* Gerar o Seguimento O para todos os requistros

    detalhe+13(1) = 'O'.
    UNPACK '0' TO detalhe+14(3).
* F - SVT - LAPM - 04.07.2017 - CH8568

    DATA(lenght) = strlen( line ).

    IF lenght EQ 0.

* I - SVT - LAPM - 04.07.2017 - CH8568
      detalhe+17(44) = space. " Código de Barra

* F - SVT - LAPM - 04.07.2017 - CH8568
    ELSE.

      CASE lenght.

        WHEN 43 .
*         Se o codigo de barras tiver 43 posições
          detalhe+17(43)  = line .

        WHEN OTHERS.
* Se o codigo de barras tiver 48 posições

* I - SVT - LAPM - 04.07.2017 - CH8568
*          detalhe+13(1) = 'O'.
*          UNPACK '0' TO detalhe+14(3).
* F - SVT - LAPM - 04.07.2017 - CH8568

* I - SVT - ACPM - 06.07.2017 - CH8183
          line+47(1) = space.
          line+11(1) = space.
          line+23(1) = space.
          line+35(1) = space.
          CONDENSE line NO-GAPS.
          detalhe+17(44)  = line .
* F - SVT - ACPM - 06.07.2017 - CH8183

          valor = line+36 .
          UNPACK valor TO valor .

      ENDCASE.

    ENDIF .

  ENDMETHOD .


  METHOD get_info_file .

    DATA: detalhe LIKE LINE OF t_detalhe .

    LOOP AT arquivo INTO DATA(line) .

      CASE line+7(1).

        WHEN '0'.
          MOVE line TO inicio.

        WHEN '1'.
          MOVE line TO cabecalho.

        WHEN '3'.
          MOVE line TO detalhe.
          APPEND detalhe TO t_detalhe.
          CLEAR  detalhe.

        WHEN '5'.
          MOVE line TO rodape.

        WHEN '9'.
          MOVE line TO fim.

      ENDCASE.

    ENDLOOP.

  ENDMETHOD .


  METHOD get_info_text.

    DATA: t_lines TYPE TABLE OF tline .

    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        id                      = id
        language                = language
        name                    = name
        object                  = object
      TABLES
        lines                   = t_lines
      EXCEPTIONS
        id                      = 1
        language                = 2
        name                    = 3
        not_found               = 4
        object                  = 5
        reference_check         = 6
        wrong_access_to_archive = 7
        OTHERS                  = 8.

    CHECK sy-subrc EQ 0.

    READ TABLE t_lines INTO DATA(line) INDEX 1.

    IF sy-subrc EQ 0 .
      tdline = line-tdline .
    ENDIF .

  ENDMETHOD .


  METHOD preencher_espaco .

    DATA:
      contador TYPE i .

    contador = caracter_inicial - 1 .

    IF caracter_inicial LE caracter_final .

      DO .

        IF contador EQ caracter_final .
          EXIT .
        ENDIF .

        detalhe+contador(1) = caracter_space .

        contador = contador + 1 .

      ENDDO .

    ENDIF.

  ENDMETHOD .


  METHOD set_info_file .

    DATA:
      arquivo TYPE ty_arquivo .

    REFRESH:
      t_arquivo .

    MOVE   inicio  TO arquivo .
    APPEND arquivo TO t_arquivo .
    CLEAR  arquivo .

    MOVE   cabecalho TO arquivo .
    APPEND arquivo TO t_arquivo .
    CLEAR  arquivo .

    LOOP AT t_detalhe INTO DATA(detalhe) .
      MOVE   detalhe TO arquivo .
      APPEND arquivo TO t_arquivo .
      CLEAR  arquivo .
    ENDLOOP.

    MOVE   rodape  TO arquivo.
    APPEND arquivo TO t_arquivo .
    CLEAR  arquivo .

    MOVE   fim     TO arquivo.
    APPEND arquivo TO t_arquivo .
    CLEAR  arquivo .

  ENDMETHOD .


  METHOD space .

    DATA:
       change TYPE zcl_fi_pgto_concessionarias=>ty_detalhe .

    IF begin GT end .
      EXIT .
    ENDIF .

    IF strlen( line ) LE 10000 .

      change = line .

      zcl_fi_pgto_concessionarias=>preencher_espaco(
        EXPORTING
          caracter_inicial = begin
          caracter_final   = end
        CHANGING
          detalhe          = change
      ).

      line = change .

    ENDIF .

  ENDMETHOD.
  
ENDCLASS.
