class ZCL_FI_PGTO_FORNECEDORES definition
  public
  final
  create public .

public section.

  types:
    begin of ty_reguh,
        laufd type reguh-laufd,
        laufi type reguh-laufi,
        xvorl type reguh-xvorl,
        zbukr type reguh-zbukr,
        lifnr type reguh-lifnr,
        kunnr type reguh-kunnr,
        empfg type reguh-empfg,
        vblnr type reguh-vblnr,
        name1 type reguh-name1,
        rzawe type reguh-rzawe,
        rbetr type reguh-rbetr,
        AUGDT type reguh-AUGDT, "SVT - ACPM - 26.06.2017
        AUSFD type reguh-AUSFD, "SVT - ACPM - 26.06.2017
        RWBTR type reguh-RWBTR, "SVT - ACPM - 06.07.2017
      end of ty_reguh .
  types:
    begin of ty_regup,
        laufd type regup-laufd,
        laufi type regup-laufi,
        xvorl type regup-xvorl,
        zbukr type regup-zbukr,
        lifnr type regup-lifnr,
        kunnr type regup-kunnr,
        empfg type regup-empfg,
        vblnr type regup-vblnr,
        bukrs type regup-bukrs,
        belnr type regup-belnr,
        gjahr type regup-gjahr,
        buzei type regup-buzei,
        zfbdt type regup-zfbdt,
        zbd1t type regup-zbd1t,
        esrnr type regup-esrnr,
        esrre type regup-esrre,
      end of ty_regup .
  types:
    begin of ty_bseg,
        bukrs type bseg-bukrs,
        belnr type bseg-belnr,
        gjahr type bseg-gjahr,
        buzei type bseg-buzei,
        sgtxt type bseg-sgtxt,
        fdtag type bseg-fdtag,
        lifnr type bseg-lifnr,
        zfbdt type bseg-zfbdt,
        zbd1t type bseg-zbd1t,
      end of ty_bseg .
  types:
    begin of ty_dfkkbptaxnum,
        partner type dfkkbptaxnum-partner,
        taxtype type dfkkbptaxnum-partner,
      end of ty_dfkkbptaxnum .
  types:
    begin of ty_but0bk,
        partner type but0bk-partner,
        bkvid   type but0bk-bkvid,
        banks   type but0bk-banks,
        bankl   type but0bk-bankl,
        bankn   type but0bk-bankn,
      end of ty_but0bk .
  types:
    tab_regup        type table of ty_regup .
  types:
    tab_reguh        type table of ty_reguh .
  types:
    tab_bseg         type table of ty_bseg .
  types:
    tab_dfkkbptaxnum type table of ty_dfkkbptaxnum .
  types:
    tab_but0bk       type table of ty_but0bk .
  types TY_DETALHE type BU_TXT10000 .
  types:
    tab_arquivo      type table of bu_txt10000 .
  types:
    tab_detalhe      type table of ty_detalhe .
  types TY_ARQUIVO type BU_TXT10000 .

  class-methods GET_BANK_104
    exporting
      !BANCO type CHAR3
      !AGENCIA type CHAR4
      !CONTA type CHAR8
      !DIGITO_AGENCIA type CHAR1
      !DIGITO_CONTA type CHAR1 .
  methods GET_DATA
    importing
      !REGUT type REGUT .
  methods CHANGE_FILE
    importing
      !I_FILENAME type RLGRAP-FILENAME
      !T_FILE type TAB_ARQUIVO .
  protected section.

    methods space
      importing
        !begin type i default 0
        !end   type i default 0
      changing
        !line  type any .
private section.

  constants:
    c_santander    type c length 3 value '033' ##NO_TEXT.
  constants:
    c_caixa        type c length 3 value '104' ##NO_TEXT.
  constants:
    c_itau         type c length 3 value '341' ##NO_TEXT.
  constants:
    c_banco_brasil type c length 3 value '001' ##NO_TEXT.
  data T_REGUH type TAB_REGUH .
  data T_REGUP type TAB_REGUP .
  data T_BSEG type TAB_BSEG .
  data T_DFKKBPTAXNUM type TAB_DFKKBPTAXNUM .
  data T_BUT0BK type TAB_BUT0BK .

  methods CHECK_CENARIO
    importing
      !INICIO type CHAR1000SF
    changing
      !ERROR type FLAG .
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
  methods CHANGE_CABECALHO
    changing
      !CABECALHO type BU_TXT10000 .
  methods CHANGE_INFO_DETALHES
    changing
      !T_DETALHE type TAB_DETALHE .
  methods CHANGE_INFO_DETALHES_104
    changing
      !DETALHE type TY_DETALHE .
  methods CHANGE_INFO_DETALHES_001
    changing
      !DETALHE type TY_DETALHE .
  methods CHANGE_INFO_RODAPE
    changing
      !RODAPE type CHAR1000SF .
  methods CHANGE_INFO_FIM
    changing
      !FIM type CHAR1000SF .
  methods SET_INFO_FILE
    importing
      !INICIO type CHAR1000SF
      !CABECALHO type BU_TXT10000
      !T_DETALHE type TAB_DETALHE
      !RODAPE type CHAR1000SF
      !FIM type CHAR1000SF
    changing
      !T_ARQUIVO type TAB_ARQUIVO .
  methods GET_PF_PJ
    importing
      !DETALHE type TY_DETALHE
    returning
      value(VALUE) type CHAR3 .
  methods GET_BANK_CLIENT
    importing
      !DETALHE type TY_DETALHE
    exporting
      !BANCO type CHAR3
      !AGENCIA type CHAR4
      !CONTA type CHAR8 .
  methods GET_DETAIL
    importing
      !DETALHE type TY_DETALHE
    exporting
      !REGUH type TY_REGUH
      !REGUP type TY_REGUP
      !BSEG type TY_BSEG .
ENDCLASS.



CLASS ZCL_FI_PGTO_FORNECEDORES IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_FI_PGTO_FORNECEDORES->CHANGE_CABECALHO
* +-------------------------------------------------------------------------------------------------+
* | [<-->] CABECALHO                      TYPE        BU_TXT10000
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method change_cabecalho.

    if cabecalho is not initial .

      case cabecalho(3) .

        when c_santander .

        when c_itau .

        when c_caixa .

*         1.19    71  71  X(001)  DV da Conta Corrente
*         1.20    72  72  X(001)  Dígito da Agência/Conta
          me->get_bank_104(
            importing
*              banco          =
*              agencia        =
*              conta          =
              digito_agencia = cabecalho+71(1)
              digito_conta   = cabecalho+70(1)
          ).

          me->space(
            exporting
              begin = 72
              end   = 72
            changing
              line  = cabecalho
          ).


*         Versão do leiaute do lote
*         cabecalho+13(3) = '045' .
          cabecalho+13(3) = '041' .

*         1.13  41  44  9(004)  Código do compromisso
          me->space(
            exporting
              begin = 41
              end   = 44
            changing
              line  = cabecalho
          ).


*         Número da conta
*         Pos 59 a 70 – Número da conta: Preencher conforme detalhamento do item 0.16, página 2 do layout (anexo).
          cabecalho+58(4) = '0003' .

*         1.30 223 230 X(008) Uso exclusivo FEBRABAN
          me->space(
            exporting
              begin = 223
              end   = 230
            changing
              line  = cabecalho
          ).

*         1.31 231 240 X(010) Ocorrências
          me->space(
            exporting
              begin = 231
              end   = 240
            changing
              line  = cabecalho
          ).


        when c_banco_brasil .

          cabecalho+9(2) = '98' .

*         Pagamento de guias com código de barras
          cabecalho+11(2) = '11' .

          me->space(
            exporting
              begin = 46
              end   = 52
            changing
              line  = cabecalho
          ).

        when others .


      endcase.

    endif .


  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_FI_PGTO_FORNECEDORES->CHANGE_FILE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_FILENAME                     TYPE        RLGRAP-FILENAME
* | [--->] T_FILE                         TYPE        TAB_ARQUIVO
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method change_file.

    data:
      inicio      type char1000sf,
      t_cabecalho type table of char1000sf,
      cabecalho   type bu_txt10000,
      t_detalhe   type table of bu_txt10000,
      detalhe     like line of t_detalhe,
      rodape      type char1000sf,
      fim         type char1000sf,
      error       type flag,

      filename    type string,
      t_arquivo   type tab_arquivo.

    clear:
      inicio, cabecalho, detalhe, rodape, fim .
    refresh:
      t_cabecalho, t_detalhe, t_arquivo .

* I - 16/08/2017 - CH8568
*    if reguh-rzawe eq 'F'  .
*      exit .
*    endif .
*
*    filename = i_filename.
*
*    call function 'GUI_UPLOAD'
*      exporting
*        filename = filename
*        filetype = 'ASC'
*      tables
*        data_tab = t_arquivo.

    filename    = i_filename.
    t_arquivo[] = t_file[].

* F - 16/08/2017 - CH8568

    if lines( t_arquivo ) eq 0 .
    else .

      me->get_info_file(
        exporting
          arquivo   = t_arquivo
        importing
          inicio    = inicio
          cabecalho = cabecalho
          t_detalhe = t_detalhe
          rodape    = rodape
          fim       = fim
          filename  = filename
      ).

    endif .

*   Verificando se este cenário terá alterações (banco e etc)
    me->check_cenario(
      exporting
        inicio = inicio
      changing
        error  = error
    ).

    check error eq abap_false .

    me->change_inicio(
      changing
        inicio = inicio
    ).

    me->change_cabecalho(
      changing
        cabecalho = cabecalho
    ).

    me->change_info_detalhes(
      changing
        t_detalhe = t_detalhe
    ).

    me->change_info_rodape(
      changing
        rodape = rodape
    ).

    me->change_info_fim(
      changing
        fim = fim
    ).

    me->set_info_file(
      exporting
        inicio    = inicio
        cabecalho = cabecalho
        t_detalhe = t_detalhe
        rodape    = rodape
        fim       = fim
      changing
        t_arquivo = t_arquivo
    ).

    call function 'GUI_DOWNLOAD'
      exporting
        filename = filename
        filetype = 'ASC'
      tables
        data_tab = t_arquivo.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_FI_PGTO_FORNECEDORES->CHANGE_INFO_DETALHES
* +-------------------------------------------------------------------------------------------------+
* | [<-->] T_DETALHE                      TYPE        TAB_DETALHE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method change_info_detalhes .

    loop at t_detalhe into data(detalhe) .

      data(tabix) = sy-tabix .

      case detalhe(3) . " Banco

        when c_santander .

        when c_itau .

        when c_caixa .

          me->change_info_detalhes_104(
            changing
              detalhe = detalhe
          ).

        when others .


      endcase.


*      case detalhe+13(1) .
*
*        when 'A' .
*
*          read table t_reguh into data(reguh)
*            with key vblnr = detalhe+73(10)
*            binary search.
*
**         Temporario / Verificando outra posição
*          if sy-subrc eq 0 .
*          else .
*
*            read table t_reguh into reguh
*              with key vblnr = detalhe+182(10)
*              binary search.
*
*          endif .
*
*          if sy-subrc eq 0 .
*
*            read table t_regup into data(regup)
*              with key vblnr = reguh-vblnr
*              binary search.
*
*            if sy-subrc eq 0 .
*
*              gjahr = regup-laufd(4) .
*
*              read table t_bseg into data(bseg)
*                with key bukrs = regup-zbukr
*                         belnr = regup-belnr
*                         gjahr = regup-gjahr
*                binary search.
*
*              if sy-subrc eq 0 .
*
*                me->get_info_barcode(
*                  exporting
*                    zbukr   = regup-zbukr
*                    belnr   = regup-belnr
*                    gjahr   = regup-gjahr
*                    buzei   = '001'
*                  changing
*                    detalhe = detalhe
*                ).
*
*                detalhe+65(30) = reguh-name1.
*                vblnr          = regup-vblnr.
*                zfbdt+6(2)     = bseg-zfbdt+6(2) + bseg-zbd1t.
*
*
*              else .
*
*                continue .
*
*              endif .
*
*            else .
*
*              continue .
*
*            endif .
*
*          else .
*
*            continue .
*
*          endif .
*
*
*          case detalhe(3) .
*
*            when '033' .
*
*              detalhe+11(2) = '11' .
*
**             Data de Vencimento
*              me->date(
*                exporting
*                  date      = bseg-zfbdt
*                importing
*                  date_file = detalhe+91(8)
*              ) .
*
**             Data de Pagamento
*              me->date(
*                exporting
*                  date      = bseg-fdtag
*                importing
*                  date_file = detalhe+99(8)
*              ) .
*
**             Valor do Pagamento
*              detalhe+107(14) = detalhe+120(14) .
*
**             Filter
*              me->preencher_espaco(
*                exporting
*                  caracter_inicial = 163
*                  caracter_final   = 230
*                changing
*                  detalhe          = detalhe
*              ).
*            when '341' .
*
**             Data de Vencimento
*              detalhe+95(2)     = bseg-zfbdt+6(2).
*              detalhe+97(2)     = bseg-zfbdt+4(2).
*              detalhe+99(4)     = bseg-zfbdt(4).
*              detalhe+103(3)    = 'REA'.
*
*              clear detalhe+106(15).
*
*              move reguh-rbetr to rbetr_c .
*
*              unpack rbetr_c      to detalhe+121(15) .
*              detalhe+136(2)    = reguh-laufd+6(2).
*              detalhe+138(2)    = reguh-laufd+4(2).
*              detalhe+140(4)    = reguh-laufd(4).
*
*              unpack rbetr_c        to detalhe+144(15).
*
*              clear detalhe+159(15).
*
*              unpack regup-belnr    to detalhe+174(20).
*
*              unpack '0'              to detalhe+195(45).
*
*            when '104' .
*
**             Número documento atribuído pela empresa
**             detalhe+74(6) = '' .
*
**             Filler
*              me->preencher_espaco(
*                exporting
*                  caracter_inicial = 80
*                  caracter_final   = 92
*                changing
*                  detalhe          = detalhe
*              ).
*
**             Data de Vencimento
*              detalhe+95(2)     = bseg-zfbdt+6(2).
*              detalhe+97(2)     = bseg-zfbdt+4(2).
*              detalhe+99(4)     = bseg-zfbdt(4).
*              detalhe+103(3)    = 'REA'.
*
*              clear detalhe+106(15).
*
*              move reguh-rbetr to rbetr_c .
*
**             Número do documento banco
*              unpack '0' to detalhe+134(8) .
*
*              unpack rbetr_c      to detalhe+121(15) .
*              detalhe+136(2)    = reguh-laufd+6(2).
*              detalhe+138(2)    = reguh-laufd+4(2).
*              detalhe+140(4)    = reguh-laufd(4).
*
*              unpack rbetr_c        to detalhe+144(15).
*
**             Indicador de forma de parcelamento
*              detalhe+149(1)    = '1' .
*
**             Número parcela
*              detalhe+152(2)    = '00' .
*
*              clear detalhe+159(15).
*
*              unpack regup-belnr    to detalhe+174(20).
*
*              unpack '0'              to detalhe+195(45).
*
**             Finalidade DOC
*              detalhe+217(2)    = '07' .
*
*            when others .
*
**             Data de Vencimento
*              detalhe+95(2)     = bseg-zfbdt+6(2).
*              detalhe+97(2)     = bseg-zfbdt+4(2).
*              detalhe+99(4)     = bseg-zfbdt(4).
*              detalhe+103(3)    = 'REA'.
*
*              clear detalhe+106(15).
*
*              move reguh-rbetr to rbetr_c .
*
*              unpack rbetr_c      to detalhe+121(15) .
*              detalhe+136(2)    = reguh-laufd+6(2).
*              detalhe+138(2)    = reguh-laufd+4(2).
*              detalhe+140(4)    = reguh-laufd(4).
*
*              unpack rbetr_c        to detalhe+144(15).
*
*              clear detalhe+159(15).
*
*              unpack regup-belnr    to detalhe+174(20).
*
*              unpack '0'              to detalhe+195(45).
*
*
*          endcase .
*
*        when 'B' .
*
*          case detalhe(3) .
*
*            when '033' .
*
*              clear detalhe+240 .
*              detalhe+210(4)  = sy-uzeit(4) .
*              detalhe+214(10) = '          ' .
*              detalhe+225(4)  = '0000' .
*
*              detalhe+229(1)  = '0' .
*
*              me->preencher_espaco(
*                exporting
*                  caracter_inicial = 231
*                  caracter_final   = 232
*                changing
*                  detalhe          = detalhe
*              ).
*
*            when '104' .
*
*              me->preencher_espaco(
*                exporting
*                  caracter_inicial = 226
*                  caracter_final   = 240
*                changing
*                  detalhe          = detalhe
*              ).
*
*            when others .
*
*          endcase.
*
*
*        when others .
*
*      endcase.
*
*
*
*      data(len) = strlen( detalhe ) .
*
*      if len lt 240 . " Quantidade de registro por linha
*
*        me->preencher_espaco(
*          exporting
*            caracter_inicial = len
*            caracter_final   = 240
*          changing
*            detalhe          = detalhe
*        ).
*
*      endif .

      modify t_detalhe from detalhe index tabix .

    endloop.

  endmethod .


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_FI_PGTO_FORNECEDORES->CHANGE_INFO_DETALHES_001
* +-------------------------------------------------------------------------------------------------+
* | [<-->] DETALHE                        TYPE        TY_DETALHE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method change_info_detalhes_001.

    check detalhe(3) eq c_banco_brasil .

    case detalhe+13(1) .

      when 'A' .

      when others .

    endcase.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_FI_PGTO_FORNECEDORES->CHANGE_INFO_DETALHES_104
* +-------------------------------------------------------------------------------------------------+
* | [<-->] DETALHE                        TYPE        TY_DETALHE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method change_info_detalhes_104 .

    check detalhe(3) eq c_caixa .

*   Verificando segumento
    case detalhe+13(1) .

      when 'A' .

*       A.12 030 041 9(012) Conta Corrente Destino

*       030 a 033 - preencher com a operação da conta
        detalhe+29(3) = me->get_pf_pj( detalhe = detalhe ) .
*       De 034 a 041 - preencher com o número da conta corrente
        me->get_bank_client(
          exporting
            detalhe = detalhe
           importing
*            banco   =
*            agencia =
             conta   = detalhe+33(8)
        ).


*       Número documento atribuído pela empresa
        detalhe+73(1) = '0' .

*       Filler
        zcl_fi_pgto_concessionarias=>preencher_espaco(
          exporting
            caracter_inicial = 80
            caracter_final   = 92
          changing
            detalhe          = detalhe
        ).

*       Número do documento banco
        unpack '0' to detalhe+134(9) .

*       Quantidade de parcelas
        detalhe+146(2) = '01' .

*       Indicador de bloqueio
        detalhe+148(1) = 'N' .

*       Indicador de forma de parcelamento
        detalhe+149(1) = '1' .

*       Período ou dia de vencimento
        detalhe+150(2) = detalhe+93(2) . "Dia da proposta

*       Número parcela
        detalhe+152(2) = '00' .

*       Finalidade DOC
        detalhe+217(2) = '07' .

*       A.36 231 240 X(010) Ocorrências
        me->space(
          exporting
            begin = 231
            end   = 240
          changing
            line  = detalhe
        ).


      when 'B' .

*       B.10 063 067 9(005) Número no local
        write detalhe+62(5)  to detalhe+62(5) .
        unpack detalhe+62(5) to detalhe+62(5) .

        translate detalhe+62(5) using ' 0' .

        zcl_fi_pgto_concessionarias=>preencher_espaco(
          exporting
            caracter_inicial = 226
            caracter_final   = 240
          changing
            detalhe          = detalhe
        ).

      when others .

    endcase.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_FI_PGTO_FORNECEDORES->CHANGE_INFO_FIM
* +-------------------------------------------------------------------------------------------------+
* | [<-->] FIM                            TYPE        CHAR1000SF
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method change_info_fim.

    if fim is not initial .

      case fim(3) .

        when c_santander .

        when c_itau .

        when c_caixa .

*         9.08 036 240 X(205) Uso exclusivo FEBRABAN
          me->space(
            exporting
              begin = 036
              end   = 240
            changing
              line  = fim
          ).

        when others .

      endcase.

    endif .

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_FI_PGTO_FORNECEDORES->CHANGE_INFO_RODAPE
* +-------------------------------------------------------------------------------------------------+
* | [<-->] RODAPE                         TYPE        CHAR1000SF
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method change_info_rodape .

    if rodape is not initial .

      case rodape(3) .

        when c_santander .

        when c_itau .

        when c_caixa .

*         Número aviso débito
          unpack '0' to rodape+59(6) .

*         5.09 066 230 X(165) Uso exclusivo FEBRABAN-2
          me->space(
            exporting
              begin = 066
              end   = 230
            changing
              line  = rodape
          ).

*         5.10 231 240 X(010) Ocorrências
          me->space(
            exporting
              begin = 231
              end   = 240
            changing
              line  = rodape
          ).

        when others .

      endcase.

    endif .


  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_FI_PGTO_FORNECEDORES->CHANGE_INICIO
* +-------------------------------------------------------------------------------------------------+
* | [<-->] INICIO                         TYPE        CHAR1000SF
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method change_inicio.

    if inicio is not initial .

      case inicio(3) .

        when c_santander .

        when c_itau .

        when c_caixa .

**        Versão do leiaute do lote
          me->space(
            exporting
              begin = 43
              end   = 45
            changing
              line  = inicio
          ).

          inicio+45(4) = '0000' .

*         Número da conta
*         Pos 59 a 70 – Número da conta: Preencher conforme detalhamento do item 0.16, página 2 do layout (anexo).
          inicio+58(4) = '0003' .

          unpack '0' to inicio+201(39).
*         Versão do layout do arquivo
          inicio+163(3) = '080' .

*         Densidade de gravação
          inicio+166(5) = '01600' .

*         0.30 Uso exclusivo FEBRABAN
          me->space(
            exporting
              begin = 212
              end   = 222
            changing
              line  = inicio
          ).

*         0.31 Ident. Cobrança
          me->space(
            exporting
              begin = 223
              end   = 225
            changing
              line  = inicio
          ).

*         Uso exclusivo das VAN
          inicio+225(3) = '000' .

*         0.33 Tipo de serviço
          me->space(
            exporting
              begin = 229
              end   = 230
            changing
              line  = inicio
          ).

*         0.34 Ocorrência Cob. Sem papel
          me->space(
            exporting
              begin = 231
              end   = 240
            changing
              line  = inicio
          ).


        when c_banco_brasil .


        when others .

      endcase.

    endif .

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_FI_PGTO_FORNECEDORES->CHECK_CENARIO
* +-------------------------------------------------------------------------------------------------+
* | [--->] INICIO                         TYPE        CHAR1000SF
* | [<-->] ERROR                          TYPE        FLAG
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method check_cenario.

    case inicio(3) .

      when c_caixa .
        error = abap_off .

      when others .
        error = abap_on .

    endcase .
  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_FI_PGTO_FORNECEDORES=>GET_BANK_104
* +-------------------------------------------------------------------------------------------------+
* | [<---] BANCO                          TYPE        CHAR3
* | [<---] AGENCIA                        TYPE        CHAR4
* | [<---] CONTA                          TYPE        CHAR8
* | [<---] DIGITO_AGENCIA                 TYPE        CHAR1
* | [<---] DIGITO_CONTA                   TYPE        CHAR1
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_bank_104.

    select acc_id, banks, bankl, acc_num, acc_type_id, valid_from, valid_to, control_key
     up to 1 rows
      from fclm_bam_amd
      into @data(line)
     where acc_type_id eq 'CX01'
       and valid_from le @sy-datum
       and valid_to   ge @sy-datum .
    endselect .

    if sy-subrc eq 0 .

      try .

          banco   = line-bankl(3) .

          agencia = line-bankl+4 .

          conta   = line-acc_num .
          unpack conta to conta .

          digito_agencia  = line-control_key(1) .
          digito_conta    = line-control_key+1(1) .

        catch cx_sy_range_out_of_bounds .

      endtry.

    endif .

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_FI_PGTO_FORNECEDORES->GET_BANK_CLIENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] DETALHE                        TYPE        TY_DETALHE
* | [<---] BANCO                          TYPE        CHAR3
* | [<---] AGENCIA                        TYPE        CHAR4
* | [<---] CONTA                          TYPE        CHAR8
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_bank_client.

    data:
      line_bseg type ty_bseg .

    me->get_detail(
      exporting
        detalhe = detalhe
       importing
*        reguh   =
*        regup   =
         bseg    = line_bseg
    ).

    if line_bseg is not initial .

      read table t_but0bk into data(line)
        with key partner = line_bseg-lifnr .

      if sy-subrc eq 0 .

        banco   = line-bankl(3) .

        agencia = line-bankl+4 .

        conta   = line-bankn .
        unpack '0' to conta .

      endif .

    endif .

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_FI_PGTO_FORNECEDORES->GET_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] REGUT                          TYPE        REGUT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_data .

    REFRESH:
      t_reguh, t_regup .

    SELECT laufd laufi xvorl zbukr lifnr kunnr
           empfg vblnr name1 rzawe rbetr augdt ausfd
      FROM reguh
      INTO TABLE t_reguh
     WHERE laufd EQ regut-laufd
       AND laufi EQ regut-laufi
       AND zbukr EQ regut-zbukr .

    IF sy-subrc EQ 0 .

      SELECT laufd laufi xvorl zbukr lifnr kunnr empfg vblnr
             bukrs belnr gjahr buzei zfbdt zbd1t esrnr esrre
        FROM regup INTO TABLE t_regup
         FOR ALL ENTRIES IN t_reguh
       WHERE laufi EQ regut-laufi
         AND laufd EQ regut-laufd
         AND zbukr EQ regut-zbukr
         AND vblnr EQ t_reguh-vblnr.

      IF sy-subrc EQ 0 .

        SORT t_reguh BY rzawe DESCENDING .

        SORT t_regup BY zbukr ASCENDING
                        belnr ASCENDING
                        gjahr ASCENDING .

        SELECT bukrs belnr gjahr buzei sgtxt fdtag lifnr zfbdt zbd1t
          FROM bseg
          INTO TABLE t_bseg
           FOR ALL ENTRIES IN t_regup
         WHERE bukrs EQ t_regup-zbukr
           AND belnr EQ t_regup-belnr
           AND gjahr EQ t_regup-gjahr .

        IF sy-subrc EQ 0.

          SELECT partner taxtype
            FROM dfkkbptaxnum
            INTO TABLE t_dfkkbptaxnum
             FOR ALL ENTRIES IN t_bseg
           WHERE partner EQ t_bseg-lifnr .

          IF sy-subrc EQ 0 .
          ENDIF .

          SELECT partner bkvid banks bankl bankn
            FROM but0bk
            INTO TABLE t_but0bk
             FOR ALL ENTRIES IN t_bseg
           WHERE partner EQ t_bseg-lifnr .

          IF sy-subrc EQ 0 .
          ENDIF .

        ENDIF.

      ENDIF.

    ENDIF.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_FI_PGTO_FORNECEDORES->GET_DETAIL
* +-------------------------------------------------------------------------------------------------+
* | [--->] DETALHE                        TYPE        TY_DETALHE
* | [<---] REGUH                          TYPE        TY_REGUH
* | [<---] REGUP                          TYPE        TY_REGUP
* | [<---] BSEG                           TYPE        TY_BSEG
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_detail.

    read table t_reguh into reguh
      with key vblnr = detalhe+73(10)
      binary search.

    if sy-subrc eq 0 .
    else .

      read table t_reguh into reguh
        with key vblnr = detalhe+182(10)
        binary search.

    endif .

    if sy-subrc eq 0 .

      read table t_regup into regup
        with key vblnr = reguh-vblnr
        binary search.

      if sy-subrc eq 0 .

        read table t_bseg into bseg
          with key bukrs = regup-zbukr
                   belnr = regup-belnr
                   gjahr = regup-gjahr
          binary search.
      endif.
    endif.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_FI_PGTO_FORNECEDORES->GET_INFO_FILE
* +-------------------------------------------------------------------------------------------------+
* | [--->] ARQUIVO                        TYPE        TAB_ARQUIVO
* | [<---] INICIO                         TYPE        CHAR1000SF
* | [<---] CABECALHO                      TYPE        BU_TXT10000
* | [<---] T_DETALHE                      TYPE        TAB_DETALHE
* | [<---] RODAPE                         TYPE        CHAR1000SF
* | [<---] FIM                            TYPE        CHAR1000SF
* | [<---] FILENAME                       TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_info_file .

    data:
      detalhe like line of t_detalhe .


    loop at arquivo into data(line) .

      case line+3(5) .

        when '00000' .
          move line to inicio.

        when '00011' .
          move line to cabecalho.

        when '00013' .
          move line to detalhe.
          append detalhe to t_detalhe .
          clear  detalhe.

        when '00015'.
          move line to rodape.

        when '99999'.
          move line to fim.

        when others .

      endcase.

    endloop.

  endmethod .


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_FI_PGTO_FORNECEDORES->GET_PF_PJ
* +-------------------------------------------------------------------------------------------------+
* | [--->] DETALHE                        TYPE        TY_DETALHE
* | [<-()] VALUE                          TYPE        CHAR3
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_pf_pj.

    data:
      line_bseg type ty_bseg .

    me->get_detail(
      exporting
        detalhe = detalhe
       importing
*        reguh   =
*        regup   =
         bseg    = line_bseg
    ).

    if line_bseg is not initial .

      read table t_dfkkbptaxnum into data(line)
        with key partner = line_bseg-lifnr .

      if sy-subrc eq 0 .

        if line-taxtype eq 'BR1' .
          value = '003' .
        else .
          value = '001' .
        endif .

      endif .

    else .

      value = '003' .
      exit .

    endif .

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_FI_PGTO_FORNECEDORES->SET_INFO_FILE
* +-------------------------------------------------------------------------------------------------+
* | [--->] INICIO                         TYPE        CHAR1000SF
* | [--->] CABECALHO                      TYPE        BU_TXT10000
* | [--->] T_DETALHE                      TYPE        TAB_DETALHE
* | [--->] RODAPE                         TYPE        CHAR1000SF
* | [--->] FIM                            TYPE        CHAR1000SF
* | [<-->] T_ARQUIVO                      TYPE        TAB_ARQUIVO
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method set_info_file .

    data:
      arquivo type ty_arquivo .

    refresh:
      t_arquivo .

    move   inicio  to arquivo .
    append arquivo to t_arquivo .
    clear  arquivo .

    move   cabecalho to arquivo .
    append arquivo to t_arquivo .
    clear  arquivo .

    loop at t_detalhe into data(detalhe) .
      move   detalhe to arquivo .
      append arquivo to t_arquivo .
      clear  arquivo .
    endloop.

    move   rodape  to arquivo.
    append arquivo to t_arquivo .
    clear  arquivo .

    move   fim     to arquivo.
    append arquivo to t_arquivo .
    clear  arquivo .

  endmethod .


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_FI_PGTO_FORNECEDORES->SPACE
* +-------------------------------------------------------------------------------------------------+
* | [--->] BEGIN                          TYPE        I (default =0)
* | [--->] END                            TYPE        I (default =0)
* | [<-->] LINE                           TYPE        ANY
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method space .

    data:
       change type zcl_fi_pgto_concessionarias=>ty_detalhe .

    if begin gt end .
      exit .
    endif .

    if strlen( line ) le 10000 .

      change = line .

      zcl_fi_pgto_concessionarias=>preencher_espaco(
        exporting
          caracter_inicial = begin
          caracter_final   = end
        changing
          detalhe          = change
      ).

      line = change .

    endif .

  endmethod.
ENDCLASS.
