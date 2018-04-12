class zcl_fi_pgto_concessionarias definition
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
          augdt type reguh-augdt,
          ausfd type reguh-ausfd,
          rwbtr type reguh-rwbtr,
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
          zfbdt type bseg-zfbdt,
          zbd1t type bseg-zbd1t,
        end of ty_bseg,
      ty_arquivo  type bu_txt10000,
      ty_detalhe  type bu_txt10000,
      tab_regup   type table of ty_regup,
      tab_reguh   type table of ty_reguh,
      tab_bseg    type table of ty_bseg,
      tab_arquivo type table of bu_txt10000,
      tab_detalhe type table of ty_detalhe .

    methods constructor .
    methods get_data
      importing
        !regut type regut .
    methods change_file
      importing
        !i_filename type rlgrap-filename
        !t_file type tab_arquivo .
    class-methods preencher_espaco
      importing
        !caracter_inicial type i
        !caracter_final type i
      changing
        !detalhe type ty_detalhe .
    class-methods date
      importing
        !date type sydatum
      exporting
        !date_file type char8 .
    methods check_file
      importing
        !i_filename type rlgrap-filename
      exporting
        !t_arquivo type tab_arquivo
        !e_meio_pagamento type char2 .

  protected section.

  private section.

    constants:
      c_santander    type c length 3 value '033' ##no_text.
    constants:
      c_caixa        type c length 3 value '104' ##no_text.
    constants:
      c_itau         type c length 3 value '341' ##no_text.
    constants:
      c_banco_brasil type c length 3 value '001' ##no_text.
    class-data t_reguh type tab_reguh .
    class-data t_regup type tab_regup .
    class-data t_bseg type tab_bseg .
    class-data caracter_space type c .

  methods get_info_file
    importing
      !arquivo type tab_arquivo
    exporting
      !inicio type char1000sf
      !cabecalho type bu_txt10000
      !t_detalhe type tab_detalhe
      !rodape type char1000sf
      !fim type char1000sf
      !filename type string .
  methods change_inicio
    changing
      !inicio type char1000sf .
  methods change_cabecalho_f
    changing
      !cabecalho type bu_txt10000 .
  methods change_cabecalho_g
    changing
      !cabecalho type bu_txt10000 .
  methods change_info_detalhes
    changing
      !t_detalhe type tab_detalhe .
  methods change_info_detalhes_033
    changing
      !detalhe type ty_detalhe .
  methods change_info_detalhes_341
    changing
      !detalhe type ty_detalhe .
  methods change_info_detalhes_104
    changing
      !detalhe type ty_detalhe .
  methods change_info_detalhes_001
    changing
      !detalhe type ty_detalhe .
  methods change_info_detalhes_others
    changing
      !detalhe type ty_detalhe .
  methods change_info_rodape
    importing
      !detalhe type tab_detalhe
    changing
      !rodape type char1000sf .
  methods change_info_fim
    importing
      !detalhe type tab_detalhe
    changing
      !fim type char1000sf .
  methods get_info_barcode
    importing
      !zbukr type dzbukr
      !belnr type belnr_d
      !gjahr type gjahr
      !buzei type buzei
    exporting
      !valor type char15
    changing
      !detalhe type ty_detalhe .
  methods get_info_text
    importing
      !id type tdid
      !language type spras default 'p'
      !name type tdobname
      !object type tdobject
    exporting
      !tdline type tdline .
  methods set_info_file
    importing
      !inicio type char1000sf
      !cabecalho type bu_txt10000
      !t_detalhe type tab_detalhe
      !rodape type char1000sf
      !fim type char1000sf
    changing
      !t_arquivo type tab_arquivo .
  methods space
    importing
      !begin type i default 0
      !end type i default 0
    changing
      !line type any .
  methods get_detail
    importing
      !detalhe type ty_detalhe
    exporting
      !reguh type ty_reguh
      !regup type ty_regup
      !bseg type ty_bseg .
  methods get_conta_corrente_104
    exporting
      !conta type char12
      !digito type char1 .
endclass.



class zcl_fi_pgto_concessionarias implementation.


  method change_cabecalho_f.

    if cabecalho is not initial .

      case cabecalho(3) .

        when c_santander .

          cabecalho+9(7) = '2011030' .
          clear cabecalho+222(8) .
          unpack '0' to cabecalho+230(10).

        when c_itau .

*         cabecalho+9(7) = '2013030' .

*         20 fornecedores
          cabecalho+9(2)  = '20' .
*         13 pagamento de concessionárias
          cabecalho+11(2) = '13' .

          unpack '0' to cabecalho+222(18).

        when c_caixa .

          cabecalho+9(7) = '2013030' .

*         1.07 014 016 9(003) versão do leiaute do lote
          cabecalho+13(3) = '041' .

*         1.12    39  40  2   tipo de compromisso 01
          cabecalho+38(2) = '01' .
*         1.13    41  44  4   código do compromisso   0002
          cabecalho+40(4) = '0002' .
*         1.14    45  46  2   parâmetro de transmissão    00
          cabecalho+44(2) = '00' .

          me->space(
            exporting
              begin = 47
              end   = 52
            changing
              line  = cabecalho
          ).

          me->get_conta_corrente_104(
            importing
*             conta  = cabecalho+53(12)
              conta  = cabecalho+58(12)
*             digito =
          ).

*         0.17    71  71  1   dv da conta (5)
          cabecalho+70(1) = '5' .
*         0.18    72  72  1   dv da agência/conta (8)
*         cabecalho+71(1) = '8' .
          cabecalho+71(1) = ' ' .

          unpack '0' to cabecalho+222(18).

          me->space(
            exporting
              begin = 223
              end   = 240
            changing
              line  = cabecalho
          ).


        when c_banco_brasil .

          cabecalho+9(2) = '98' .

*         pagamento de guias com código de barras
          cabecalho+11(2) = '11' .

          cabecalho+45(7) = '       ' .

          me->space(
            exporting
              begin = 223
              end   = 240
            changing
              line  = cabecalho
          ).


        when others .

          cabecalho+9(7) = '2013030' .
          unpack '0' to cabecalho+222(18).

      endcase.

    endif .


  endmethod.


  method change_cabecalho_g.

    if cabecalho is not initial .

      case cabecalho(3) .

        when c_santander .

          cabecalho+9(7) = '2011030' .
          clear cabecalho+222(8) .
          unpack '0' to cabecalho+230(10).

        when c_itau .

*         cabecalho+9(7) = '2013030' .

*         22 tributos
          cabecalho+9(2)  = '22' .
*         19 iptu/iss/outros tributos municipais
*         35 fgts
*         cabecalho+11(2) = '19' .
          cabecalho+11(2) = '35' .

          unpack '0' to cabecalho+222(18).

        when c_caixa .

          cabecalho+9(7) = '2013030' .

*         1.07 014 016 9(003) versão do leiaute do lote
          cabecalho+13(3) = '041' .
*         1.12    39  40  2   tipo de compromisso 01
          cabecalho+38(2) = '01' .
*         1.13    41  44  4   código do compromisso   0002
          cabecalho+40(4) = '0002' .
*         1.14    45  46  2   parâmetro de transmissão    00
          cabecalho+44(2) = '00' .

          me->space(
            exporting
              begin = 47
              end   = 52
            changing
              line  = cabecalho
          ).

          me->get_conta_corrente_104(
            importing
              conta  = cabecalho+58(12)
*             digito =
          ).

*         0.17    71  71  1   dv da conta (5)
          cabecalho+70(1) = '5' .
*         0.18    72  72  1   dv da agência/conta (8)
*         cabecalho+71(1) = '8' .
          cabecalho+71(1) = ' ' .

          unpack '0' to cabecalho+222(18).

          me->space(
            exporting
              begin = 223
              end   = 240
            changing
              line  = cabecalho
          ).


        when c_banco_brasil .

          cabecalho+9(2) = '98' .

*         pagamento de guias com código de barras
          cabecalho+11(2) = '11' .

          cabecalho+45(7) = '       ' .

          me->space(
            exporting
              begin = 223
              end   = 240
            changing
              line  = cabecalho
          ).


        when others .

          cabecalho+9(7) = '2013030' .
          unpack '0' to cabecalho+222(18).

      endcase.

    endif .

  endmethod.


  method change_file.

* para a solução atual, será feito apenas para f
* logo, por causa de tempo de entrega, será fixo apenas para este cenário.

    data:
      inicio           type char1000sf,
      t_cabecalho      type table of char1000sf,
      cabecalho        type bu_txt10000,
      t_detalhe        type table of bu_txt10000,
      detalhe          like line of t_detalhe,
      rodape           type char1000sf,
      fim              type char1000sf,
      v_gjahr          type bseg-gjahr,
      filename         type string,
      t_arquivo        type tab_arquivo,

* i - lapm - 16/08/2017 - ch8568
      lt_reguh         type tab_reguh.
* f - lapm - 16/08/2017 - ch8568

* i - 16/08/2017 - ch8568

*    case reguh-rzawe .
*
*      when 'f' or 'g' .
*
*        clear: inicio, cabecalho, detalhe, rodape, fim, v_gjahr.
*        refresh: t_cabecalho, t_detalhe, t_arquivo .
*
*        filename = i_filename.
*
*        call function 'gui_upload'
*          exporting
*            filename = filename
*            filetype = 'asc'
*          tables
*            data_tab = t_arquivo.

    clear: inicio, cabecalho, detalhe, rodape, fim, v_gjahr.
    refresh: t_cabecalho, t_detalhe, t_arquivo .

    filename    = i_filename.
    lt_reguh[]  = t_reguh[].
    t_arquivo[] = t_file[].


* f - 16/08/2017 - ch8568

    check lines( t_arquivo ) gt 0.

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

    me->change_inicio(
      changing
        inicio = inicio
    ).

* i - 16/08/2017 - ch8568

**    case reguh-rzawe.
*
*      when 'f'.
*        me->change_cabecalho_f(
*          changing
*            cabecalho = cabecalho
*        ).
*
*      when 'g'.
*        me->change_cabecalho_g(
*          changing
*            cabecalho = cabecalho
*        ).
*
*    endcase.

    sort lt_reguh by rzawe.

    read table lt_reguh with key rzawe = 'g' binary search
                                             transporting no fields.

    if sy-subrc eq 0.
      me->change_cabecalho_g(
        changing
          cabecalho = cabecalho
      ).
    else.
      me->change_cabecalho_f(
        changing
          cabecalho = cabecalho
      ).
    endif.
* f - 16/08/2017 - ch8568

    me->change_info_detalhes(
      changing
        t_detalhe = t_detalhe
    ).

    me->change_info_rodape(
     exporting detalhe = t_detalhe  " chamado 8183
      changing rodape  = rodape
    ).

    me->change_info_fim(
      exporting detalhe = t_detalhe  " chamado 8183
       changing fim     = fim
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

    call function 'gui_download'
      exporting
        filename = filename
        filetype = 'asc'
      tables
        data_tab = t_arquivo.

*  when others.
*endcase.

  endmethod.


  method change_info_detalhes .

    data:
      vblnr   type vblnr,
      zfbdt   type dzfbdt,
      rbetr_c type char13,
      output  type char12.

    sort: t_reguh by vblnr ascending,
          t_regup by vblnr ascending,
          t_bseg  by bukrs ascending
                     belnr ascending
                     gjahr ascending
                     buzei ascending .

    loop at t_detalhe into data(detalhe) .

      data(tabix) = sy-tabix .

      case detalhe(3) .

        when c_santander .
* i - svt - acpm - 14.06.2017 - retira o registro b
          if detalhe+13(1) = 'b'.
            delete t_detalhe index tabix.
            continue.
          endif.
* i - svt - acpm - 14.06.2017

          me->change_info_detalhes_033(
            changing
              detalhe = detalhe
          ).

        when c_itau.

          me->change_info_detalhes_341(
            changing
              detalhe = detalhe
          ).

        when c_caixa .

          me->change_info_detalhes_104(
            changing
              detalhe = detalhe
          ).

        when c_banco_brasil .

          if detalhe+13(1) eq 'b' .

            delete t_detalhe index tabix .

          else .

            me->change_info_detalhes_001(
              changing
                detalhe = detalhe
            ).

          endif .

        when others .

          me->change_info_detalhes_others(
            changing
              detalhe = detalhe
          ).

      endcase .


      data(len) = strlen( detalhe ) .

      if len lt 240 . " quantidade de registro por linha

* i - svt - lapm - 04.07.2017 - ch8568
        if detalhe+229(1) is not initial.
          add 1 to len.
        endif.
* f - svt - lapm - 04.07.2017 - ch8568

        me->preencher_espaco(
          exporting
            caracter_inicial = len
            caracter_final   = 240
          changing
            detalhe          = detalhe
        ).

      endif .

      modify t_detalhe from detalhe index tabix .

    endloop.

  endmethod .


  method change_info_detalhes_001 .

    data:
      line_reguh type ty_reguh,
      line_regup type ty_regup,
      line_bseg  type ty_bseg,
      rbetr_c    type char13,
      valor      type char15.

    case detalhe+13(1) .

      when 'a' .

        me->get_detail(
          exporting
            detalhe = detalhe
          importing
            reguh   = line_reguh
            regup   = line_regup
            bseg    = line_bseg
        ).

        me->get_info_barcode(
          exporting
            zbukr   = line_regup-zbukr
            belnr   = line_regup-belnr
            gjahr   = line_regup-gjahr
            buzei   = '001'
           importing
           valor = valor
          changing
            detalhe = detalhe
        ).

*       posições 092 a 099: preencher com a data de vencimento da guia
        detalhe+91(8) = detalhe+93(8) .

*       posições 100 a 107: preencher com a data de pagamento da guia
        detalhe+99(8) = detalhe+91(8) .

*       posições 108 a 122: preencher com o valor de pagamento
        valor = detalhe+122(12) .
        unpack valor to valor .
        detalhe+107(15) = valor .

*       posições 123 a 142: foi informado "000002409654        "
        detalhe+122(20) = space .

*       posições 163 a 230: preencher com brancos
        detalhe+162(68) = space .

*       posições 231 a 240: preencher com brancos
        detalhe+230(10) = space .

      when 'b' .

        me->get_detail(
          exporting
            detalhe = detalhe
          importing
            reguh   = line_reguh
            regup   = line_regup
            bseg    = line_bseg
        ).

*       data de vencimento
        detalhe+95(2)     = line_bseg-zfbdt+6(2).
        detalhe+97(2)     = line_bseg-zfbdt+4(2).
        detalhe+99(4)     = line_bseg-zfbdt(4).
        detalhe+103(3)    = 'rea'.

        clear detalhe+106(15).

        move line_reguh-rbetr to rbetr_c .

        unpack rbetr_c      to detalhe+121(15) .
        detalhe+136(2)    = line_reguh-laufd+6(2).
        detalhe+138(2)    = line_reguh-laufd+4(2).
        detalhe+140(4)    = line_reguh-laufd(4).

        unpack rbetr_c        to detalhe+144(15).

        clear detalhe+159(15).

        unpack line_regup-belnr    to detalhe+174(20).

        unpack '0'              to detalhe+195(45).
      when others .

    endcase.

  endmethod.


  method change_info_detalhes_033 .

    data:
      line_bseg type ty_bseg .
* i - svt - acpm - 13.06.2017
    data:
      line_reguh   type ty_reguh,
      line_regup   type ty_regup,
      rbetr_c      type char13,
      l_codigo(44) type n,
      l_char(18),
      l_valor(15)  type n.
* v - svt - acpm - 13.06.2017

    clear: l_codigo, l_valor.

    case detalhe+13(1) .

      when 'a' .

* i - svt - acpm - 13.06.2017 - gera registro o, como arquivo itaú
        me->get_detail(
           exporting
             detalhe = detalhe
           importing
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
               exporting
                 zbukr   = line_regup-zbukr
                 belnr   = line_regup-belnr
                 gjahr   = line_regup-gjahr
                 buzei   = '001'
               changing
                 detalhe = detalhe
        ).

* nome concessionária
        detalhe+61(30) = line_reguh-name1.

*       vblnr          = line_regup-vblnr.
*       zfbdt+6(2)     = line_bseg-zfbdt+6(2) + line_bseg-zbd1t.

* i - svt - lapm - 11.10.2017 - ch8183 - campos comentados

**       data de vencimento
*        detalhe+95(2)     = line_bseg-zfbdt+6(2).
*        detalhe+97(2)     = line_bseg-zfbdt+4(2).
*        detalhe+99(4)     = line_bseg-zfbdt(4).
*        detalhe+103(3)    = 'rea'.

*        clear detalhe+106(15).

*        move line_reguh-rbetr to rbetr_c .

*        unpack rbetr_c      to detalhe+121(15) .
*        detalhe+136(2)    = line_reguh-laufd+6(2).
*        detalhe+138(2)    = line_reguh-laufd+4(2).
*        detalhe+140(4)    = line_reguh-laufd(4).
*
*        unpack rbetr_c        to detalhe+144(15).

*        clear detalhe+159(15).

*        unpack line_regup-belnr to detalhe+174(20).
*
*        unpack '0'              to detalhe+195(45).

* f - svt - lapm - 11.10.2017 - ch8183 - campos comentados

* i - svt - acpm - 13.06.2017 - ajustes arquivo santander

*código de barras
        move detalhe+17(44) to l_codigo.
        clear detalhe+17(44).
        write l_codigo to detalhe+17(44) right-justified.

*data de vencimento
        concatenate line_reguh-augdt+6(2) line_reguh-augdt+4(2) line_reguh-augdt(4)
               into detalhe+91(8).
*data de pagamento
        concatenate line_reguh-ausfd+6(2) line_reguh-ausfd+4(2) line_reguh-ausfd(4)
               into detalhe+99(8).

*valor de pagamento
        move line_reguh-rwbtr to l_char.
        move l_char+3(15) to l_valor.
        clear detalhe+107(15).
        write l_valor to detalhe+107(15) right-justified.

* i - svt - lapm - 11.10.2017 - ch8183 -  nº documento cliente , nº documento banco e filler

* nº documento cliente
        unpack line_regup-belnr to detalhe+122(20).

* nº documento banco
        unpack '0' to detalhe+142(20).

* filler
*        detalhe+162(67) = space.
        clear detalhe+163(67).

* f - svt - lapm - 11.10.2017 - ch8183


* f - svt - acpm - 13.06.2017 - ajustes arquivo santander

* i - svt - acpm - 06.07.2017 - ch8183
        detalhe+231(11) = space.
* f - svt - acpm - 06.07.2017 - ch8183


*        detalhe+11(2) = '11' .
*
**       data de vencimento
*        me->date(
*          exporting
*            date      = line_bseg-zfbdt
*          importing
*            date_file = detalhe+91(8)
*        ) .
*
**         data de pagamento
*        me->date(
*          exporting
*            date      = line_bseg-fdtag
*          importing
*            date_file = detalhe+99(8)
*        ) .
*
**       data do pagamento 094 101 9(008) ddmmaaaa
*        detalhe+93(8) = detalhe+91(8) .
*
**       tipo da moeda 102 104 x(003) nota g005
*        detalhe+101(3) = 'brl' .
*
**       quantidade de moeda 105 119 9(010)v5 zeros
*        me->space(
*          exporting
*            begin = 105
*            end   = 119
*          changing
*            line  = detalhe
*        ).
*
**       filter
*        me->preencher_espaco(
*          exporting
*            caracter_inicial = 163
**           caracter_final   = 230
*            caracter_final   = 220
*          changing
*            detalhe          = detalhe
*        ).
*
**       finalidade de ted 220 224 x(05) nota g013 b
*        me->space(
*          exporting
*            begin = 220
*            end   = 224
*          changing
*            line  = detalhe
*        ).
*
**       filler 227 229 x(010) brancos
*        me->space(
*          exporting
*            begin = 227
*            end   = 229
*          changing
*            line  = detalhe
*        ).
*
**       emissão de aviso ao favorecido 230 230 x(001) nota g018
**       detalhe+229(1) = '0' .
*
*      when 'b' .
*
**       número do local do favorecido 063 067 9(005) opciona
*        unpack '0' to detalhe+62(5) .
*
**       cep do favorecido 118 125 9(008) opcional
*        unpack '0' to detalhe+117(8) .
*
*        clear detalhe+240 .
*        detalhe+210(4)  = sy-uzeit(4) .
*        detalhe+214(10) = '          ' .
*        detalhe+225(4)  = '0000' .
*
*        detalhe+229(1)  = '0' .
*
**       filler 231 231 x(001 ) nota g007
*        me->space(
*          exporting
*            begin = 231
*            end   = 231
*          changing
*            line  = detalhe
*        ).
*
**       ted para instituição financeira 232 232 x(001) nota g029
*        me->space(
*          exporting
*            begin = 232
*            end   = 232
*          changing
*            line  = detalhe
*        ).
*
**       identificação da if no spb 233 240 x(008) nota g030
*        me->space(
*          exporting
*            begin = 233
*            end   = 240
*          changing
*            line  = detalhe
*        ).

* f - svt - acpm - 13.06.2017
      when 'b' .

      when others .

    endcase.

  endmethod.


  method change_info_detalhes_104 .

    data:
      line_reguh type ty_reguh,
      line_regup type ty_regup,
      line_bseg  type ty_bseg,
      rbetr_c    type char13,
      htype      type datatype_d.

    case detalhe+13(1) .

      when 'a' .

        me->get_detail(
          exporting
            detalhe = detalhe
          importing
            reguh   = line_reguh
            regup   = line_regup
            bseg    = line_bseg
        ).

        me->get_info_barcode(
          exporting
            zbukr   = line_regup-zbukr
            belnr   = line_regup-belnr
            gjahr   = line_regup-gjahr
            buzei   = '001'
          changing
            detalhe = detalhe
        ).

        detalhe+13(1) = 'k' .

*       retorno de erro
*       reg:3 posição 57,17 deveria ser branco. encontrado:004853611
        me->space(
          exporting
            begin = 57
            end   = 73
          changing
            line  = detalhe
        ).

*       filler
        me->preencher_espaco(
          exporting
            caracter_inicial = 80
            caracter_final   = 92
          changing
            detalhe          = detalhe
        ).

        me->get_detail(
          exporting
            detalhe = detalhe
          importing
            reguh   = line_reguh
            regup   = line_regup
            bseg    = line_bseg
        ).

*       a.20 102 104 x(003) tipo da moeda
*       detalhe+101(3)

*       a.19 094 101 9(008) data vencimento
        me->date(
          exporting
            date      = line_bseg-zfbdt
          importing
            date_file = detalhe+93(8)
        ).

*       a.21 105 119 9(010)v99999 quantidade de moeda

*       a.22 120 134 9(013)v99 valor lançamento


**       data de vencimento
*        detalhe+95(2)     = line_bseg-zfbdt+6(2).
*        detalhe+97(2)     = line_bseg-zfbdt+4(2).
*        detalhe+99(4)     = line_bseg-zfbdt(4).
*        detalhe+103(3)    = 'rea'.
*        clear detalhe+106(15).
*
*       número do documento banco
        unpack '0' to detalhe+134(8) .

        unpack rbetr_c      to detalhe+121(15) .
        detalhe+136(2)    = line_reguh-laufd+6(2).
        detalhe+138(2)    = line_reguh-laufd+4(2).
        detalhe+140(4)    = line_reguh-laufd(4).

*       reg:3 posição 144,11 deveria ser branco. encontrado:70000010000
*       a.24 144 146 x(003) filler
*       a.25 147 148 9(002) quantidade de parcelas
        me->space(
          exporting
            begin = 144
            end   = 154
          changing
            line  = detalhe
        ).

*       a.30 155 162 9(008) data da efetivação
*        me->date(
*          exporting
*            date      = line_bseg-zfbdt
*          importing
*           date_file = detalhe+154(8)
*        ).
        unpack '0' to detalhe+154(8) .

*        a.31 163 177 9(013) v99 valor real efetivado
        detalhe+163(13) = rbetr_c .
        unpack detalhe+163(13) to detalhe+163(13) .

*        move line_reguh-rbetr to rbetr_c .
*        unpack rbetr_c        to detalhe+144(15).
*
**       indicador de forma de parcelamento
*        detalhe+149(1)    = '1' .
*
**       número parcela
*        detalhe+152(2)    = '00' .

*       clear detalhe+159(15).

        unpack line_regup-belnr to detalhe+174(20).

        unpack '0'              to detalhe+195(45).

**      finalidade doc
*       detalhe+217(2)    = '07' .

*       a.33 218 219 9(002) finalidade doc
        me->space(
          exporting
            begin = 218
            end   = 219
          changing
            line  = detalhe
        ).

*       a.34 220 229 x(010) uso febraban
        me->space(
          exporting
            begin = 220
            end   = 229
          changing
            line  = detalhe
        ).

*       reg:3 posição 231,10 deveria ser branco. encontrado:0000000000
        me->space(
          exporting
            begin = 231
            end   = 240
          changing
            line  = detalhe
        ).

      when 'b' .

*       b.10 063 067 9(005) número no local
        call function 'numeric_check'
          exporting
            string_in = detalhe+62(5)
          importing
*           string_out =
            htype     = htype.

        if htype eq 'numc' .
          unpack detalhe+62(5) to detalhe+62(5) .
        else .
          unpack '0' to detalhe+62(5) .
        endif .


*       a.30 155 162 9(008) data da efetivação
        me->space(
          exporting
            begin = 155
            end   = 162
          changing
            line  = detalhe
        ).

        unpack '0' to detalhe+135(75) .

        me->preencher_espaco(
          exporting
            caracter_inicial = 226
            caracter_final   = 240
          changing
            detalhe          = detalhe
        ).

      when others .

    endcase.

  endmethod.


  method change_info_detalhes_341 .

    data:
      line_reguh type ty_reguh,
      line_regup type ty_regup,
      line_bseg  type ty_bseg,
      rbetr_c    type char13.

    case detalhe+13(1) .

      when 'a'.

        me->get_detail(
          exporting
            detalhe = detalhe
          importing
            reguh   = line_reguh
            regup   = line_regup
            bseg    = line_bseg
        ).
* i - svt - lapm - 04.07.2017 - ch8568
* modificar seleção

        me->get_info_barcode(
          exporting
            zbukr   = line_regup-zbukr
            belnr   = line_regup-belnr
            gjahr   = line_regup-gjahr
            buzei   = '001'
          changing
            detalhe = detalhe
        ).
* f - svt - lapm - 04.07.2017 - ch8568

        detalhe+65(30) = line_reguh-name1.
*       vblnr          = line_regup-vblnr.
*       zfbdt+6(2)     = line_bseg-zfbdt+6(2) + line_bseg-zbd1t.

*       data de vencimento
        detalhe+95(2)     = line_bseg-zfbdt+6(2).
        detalhe+97(2)     = line_bseg-zfbdt+4(2).
        detalhe+99(4)     = line_bseg-zfbdt(4).
        detalhe+103(3)    = 'rea'.

        clear detalhe+106(15).

        move line_reguh-rbetr to rbetr_c .

        unpack rbetr_c      to detalhe+121(15) .
        detalhe+136(2)    = line_reguh-laufd+6(2).
        detalhe+138(2)    = line_reguh-laufd+4(2).
        detalhe+140(4)    = line_reguh-laufd(4).

        unpack rbetr_c to detalhe+144(15).

        clear detalhe+159(15).

        unpack line_regup-belnr to detalhe+174(20).

        unpack '0' to detalhe+195(45).

      when 'b' .

      when others .

    endcase.

  endmethod.


  method change_info_detalhes_others .

    data:
      line_reguh type ty_reguh,
      line_regup type ty_regup,
      line_bseg  type ty_bseg,
      rbetr_c    type char13.

    case detalhe+13(1) .

      when 'a' .

        me->get_detail(
          exporting
            detalhe = detalhe
          importing
            reguh   = line_reguh
            regup   = line_regup
            bseg    = line_bseg
        ).

        me->get_info_barcode(
          exporting
            zbukr   = line_regup-zbukr
            belnr   = line_regup-belnr
            gjahr   = line_regup-gjahr
            buzei   = '001'
          changing
            detalhe = detalhe
        ).


      when 'b' .

        me->get_detail(
          exporting
            detalhe = detalhe
          importing
            reguh   = line_reguh
            regup   = line_regup
            bseg    = line_bseg
        ).

*       data de vencimento
        detalhe+95(2)     = line_bseg-zfbdt+6(2).
        detalhe+97(2)     = line_bseg-zfbdt+4(2).
        detalhe+99(4)     = line_bseg-zfbdt(4).
        detalhe+103(3)    = 'rea'.

        clear detalhe+106(15).

        move line_reguh-rbetr to rbetr_c .

        unpack rbetr_c      to detalhe+121(15) .
        detalhe+136(2)    = line_reguh-laufd+6(2).
        detalhe+138(2)    = line_reguh-laufd+4(2).
        detalhe+140(4)    = line_reguh-laufd(4).

        unpack rbetr_c        to detalhe+144(15).

        clear detalhe+159(15).

        unpack line_regup-belnr    to detalhe+174(20).

        unpack '0'              to detalhe+195(45).
      when others .

    endcase.

  endmethod.


  method change_info_fim.

    data: lv_lines_detalhe(6) type n.

    case fim(3) .

      when c_santander .

        unpack '0' to fim+35(205).

        " início - efp - 22.09.2017 - chamado 8183

* i - svt - acpm - 26.06.2017
*trailler
        "       subtract 1 from fim+28(1).
* f - svt - acpm - 26.06.2017

        " quantidade total de linhas   fazer ??/
        lv_lines_detalhe = lines( detalhe ).
        add 4 to lv_lines_detalhe. " header + trailer + rodape + fim

        fim+23(6) = lv_lines_detalhe.
        " fim    - efp - 22.09.2017 - chamado 8183

      when c_caixa .

        me->space(
          exporting
            begin = 36
            end   = 240
          changing
            line  = fim
        ).

      when c_itau .

        unpack '0' to fim+35(205).

      when c_banco_brasil .

        unpack '0' to fim+35(205).

      when others .

        unpack '0' to fim+35(205).

    endcase.

  endmethod.


  method change_info_rodape .

    data:
      change              type ty_detalhe,
      total               type c length 18,
* i - lapm - 22/09/2017 - ch8183
      lv_lines_detalhe(6) type n.
* f - lapm - 22/09/2017 - ch81/83

    case rodape(3) .

      when c_santander .

        change = rodape .

* i - svt - acpm - 26.06.2017

*       número aviso de débito 060 065 9(006) nota g020
        unpack '0' to change+59(6) .



* i - svt - lapm - 11.10.2017 - ch8183
* campo filler

*        unpack '0' to change+65(174) .
*
*        me->preencher_espaco(
*          exporting
*            caracter_inicial = 231
*            caracter_final   = 240
*          changing
*            detalhe          = change
*        ).

        me->preencher_espaco(
          exporting
            caracter_inicial = 66
            caracter_final   = 240
          changing
            detalhe          = change
        ).

* f - lapm - 22/09/2017 - ch8183

        rodape = change .

*trailler

* i - lapm - 22/09/2017 - ch8183
* quantidade total de linhas do segmento

*        subtract 1 from rodape+22(1).

        lv_lines_detalhe = lines( detalhe ).
        add 2 to lv_lines_detalhe. " header + trailer

        rodape+17(6) = lv_lines_detalhe.
* f - lapm - 22/09/2017 - ch8183


* f - svt - acpm - 26.06.2017

      when c_itau .

        rodape+41(18)           = rodape+23(18).
        unpack '0'                to rodape+59(181).


      when c_caixa .

*       reg:5 trailler lote posição 66,175 deveria ser branco.
        me->space(
          exporting
            begin = 66
            end   = 240
          changing
            line  = rodape
        ).


*      when c_santander .
*
**       número aviso de débito 060 065 9(006)
*        unpack '0' to rodape+59(6) .
*
**       filler 066 230 x(165)
*        me->space(
*          exporting
*            begin = 66
*            end   = 230
*          changing
*            line  = rodape
*        ).

      when others .

        rodape+41(18)           = rodape+23(18).
        unpack '0'                to rodape+59(181).


    endcase.


  endmethod.


  method change_inicio.

    data: change type ty_detalhe.

    if inicio is not initial .

      case inicio(3) .

        when c_santander .

* i - svt - lapm - 8183 - 11/12/2017

*          unpack '0' to inicio+201(39).
           unpack '0' to inicio+201(10).

*         " posição 212 a 230 em branco

         change = inicio.

         me->preencher_espaco(
          exporting
            caracter_inicial = 212
            caracter_final   = 231
          changing
            detalhe          = change
         ).

          inicio = change.

          unpack '0' to inicio+230(10).

* f - svt - lapm - 8183 - 11/12/2017

        when c_caixa .

          space(
            exporting
              begin = 42
              end   = 42
            changing
              line  = inicio
          ).

          me->space(
            exporting
              begin = 43
              end   = 45
            changing
              line  = inicio
          ).

          unpack '0' to  inicio+45(4) .

          me->get_conta_corrente_104(
            importing
              conta  = inicio+58(12)
*             digito =
          ).

*         0.17    71  71  1   dv da conta (5)
          inicio+70(1) = '5' .
*         0.18    72  72  1   dv da agência/conta (8)
*         inicio+71(1) = '8' .
          inicio+71(1) = ' ' .


          unpack '0' to inicio+201(39).
*         versão do layout do arquivo
          inicio+163(3) = '080' .

*         densidade de gravação
          inicio+166(5) = '01600' .

          me->space(
            exporting
              begin = 212
              end   = 225
            changing
              line  = inicio
          ).

          me->space(
            exporting
              begin = 229
              end   = 240
            changing
              line  = inicio
          ).

*         uso exclusivo das van
          inicio+225(3) = '000' .


        when c_itau .

          unpack '0' to inicio+201(39).

        when c_banco_brasil .

          inicio+45(7) = '       ' .

          unpack '0' to inicio+201(39).

        when others .

          unpack '0' to inicio+201(39).

      endcase.

    endif .


  endmethod.


  method check_file.

    data:lw_inicio    type char1000sf,
         lw_cabecalho type bu_txt10000,
         lt_detalhe   type table of bu_txt10000,
         lw_detalhe   type bu_txt10000,
         lw_rodape    type char1000sf,
         lw_fim       type char1000sf,
         lv_filename  type string,
         lt_arquivo   type tab_arquivo,
         lt_reguh     type tab_reguh,
         lw_reguh     type ty_reguh.

    lv_filename = i_filename.
    lt_reguh[]  = t_reguh[].

    call function 'gui_upload'
      exporting
        filename = lv_filename
        filetype = 'asc'
      tables
        data_tab = lt_arquivo.

    t_arquivo[] = lt_arquivo[].

    me->get_info_file(
     exporting
     arquivo   = lt_arquivo
     importing
     inicio    = lw_inicio
     cabecalho = lw_cabecalho
     t_detalhe = lt_detalhe
     rodape    = lw_rodape
     fim       = lw_fim
     filename  = lv_filename
    ).

    check lt_detalhe is not initial.

    sort lt_reguh by vblnr.

    e_meio_pagamento = 'co'. " concessionaria

    loop at lt_detalhe into lw_detalhe.

* i - lapm - 21/09/2017 - ch8183

* para o santander os segmentos diferentes de a e j são opcionais,
* portanto não é necessário verificar.

      if lw_detalhe(3) eq c_santander and
         ( lw_detalhe+13(1) ne 'a' and lw_detalhe+13(1) ne 'j' ).
        continue.
      endif.
* f - lapm - 21/09/2017 - ch8183

      clear lw_reguh.
      read table lt_reguh into lw_reguh with key vblnr = lw_detalhe+73(10)
                                                 binary search.

      if lw_reguh-rzawe ne 'f'.  " valor null também corresponde ao fornecedor
        e_meio_pagamento = 'fo'. " fornecedor
      endif.

    endloop.

  endmethod.


  method constructor .

    caracter_space = cl_abap_conv_in_ce=>uccp( '00a0' ) .

  endmethod.


  method date .

    data:
       output type char12 .

    call function 'conversion_exit_pdate_output'
      exporting
        input  = date
      importing
        output = output.

    translate output using '. ' .
    condense  output no-gaps .

    date_file = output .

  endmethod.


  method get_conta_corrente_104.

    data:
      local_agencia      type char4,
      local_conta        type char8,
      local_digito_conta type char1,
      local_operacao     type char3 value '003'.

    zcl_fi_pgto_fornecedores=>get_bank_104(
       importing
*        banco          =
         agencia        = local_agencia
         conta          = local_conta
*        sdigito_agencia =
         digito_conta   = local_digito_conta
    ).

*   concatenate local_agencia local_operacao local_conta+3 into conta .
    concatenate local_operacao '0' local_conta into conta .

  endmethod.


  method get_data.

    refresh: t_reguh, t_regup.

    select laufd laufi xvorl zbukr lifnr kunnr
           empfg vblnr name1 rzawe rbetr augdt ausfd rwbtr
    from reguh
    into table t_reguh
    where laufd eq regut-laufd
      and laufi eq regut-laufi
      and zbukr eq regut-zbukr.
*      and xvorl eq space.

    check sy-subrc eq 0 .

    select laufd laufi xvorl zbukr lifnr kunnr empfg vblnr
           bukrs belnr gjahr buzei zfbdt zbd1t esrnr esrre
    from regup into table t_regup
    for all entries in t_reguh
    where laufi eq regut-laufi
      and laufd eq regut-laufd
      and zbukr eq regut-zbukr
*       and xvorl eq space
      and vblnr eq t_reguh-vblnr.

    if sy-subrc eq 0 .

      sort t_reguh by rzawe descending .

      sort t_regup by zbukr ascending
                      belnr ascending
                      gjahr ascending .

      select bukrs belnr gjahr buzei sgtxt fdtag zfbdt zbd1t
      from bseg
      into table t_bseg
      for all entries in t_regup
      where bukrs eq t_regup-zbukr
        and belnr eq t_regup-belnr
        and gjahr eq t_regup-gjahr .

    endif.



  endmethod.


  method get_detail .

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

        if sy-subrc eq 0 .
        endif.

      endif.

    endif.

  endmethod.


  method get_info_barcode .

    data: name type tdobname,
          line type tdline.

    concatenate zbukr belnr gjahr buzei into name.

    me->get_info_text(
      exporting
        id       = '0001'
*       language = 'p'
        name     = name
        object   = 'doc_item'
      importing
        tdline   = line
    ).

* i - svt - lapm - 04.07.2017 - ch8568
* gerar o seguimento o para todos os requistros

    detalhe+13(1) = 'o'.
    unpack '0' to detalhe+14(3).
* f - svt - lapm - 04.07.2017 - ch8568

    data(lenght) = strlen( line ).

    if lenght eq 0.

* i - svt - lapm - 04.07.2017 - ch8568
      detalhe+17(44) = space. " código de barra

* f - svt - lapm - 04.07.2017 - ch8568
    else.

      case lenght.

        when 43 .
*         se o codigo de barras tiver 43 posições
          detalhe+17(43)  = line .

        when others.
* se o codigo de barras tiver 48 posições

* i - svt - lapm - 04.07.2017 - ch8568
*          detalhe+13(1) = 'o'.
*          unpack '0' to detalhe+14(3).
* f - svt - lapm - 04.07.2017 - ch8568

* i - svt - acpm - 06.07.2017 - ch8183
          line+47(1) = space.
          line+11(1) = space.
          line+23(1) = space.
          line+35(1) = space.
          condense line no-gaps.
          detalhe+17(44)  = line .
* f - svt - acpm - 06.07.2017 - ch8183

          valor = line+36 .
          unpack valor to valor .

      endcase.

    endif .

  endmethod .


  method get_info_file .

    data: detalhe like line of t_detalhe .

    loop at arquivo into data(line) .

      case line+7(1).

        when '0'.
          move line to inicio.

        when '1'.
          move line to cabecalho.

        when '3'.
          move line to detalhe.
          append detalhe to t_detalhe.
          clear  detalhe.

        when '5'.
          move line to rodape.

        when '9'.
          move line to fim.

      endcase.

    endloop.

  endmethod .


  method get_info_text.

    data: t_lines type table of tline .

    call function 'read_text'
      exporting
        id                      = id
        language                = language
        name                    = name
        object                  = object
      tables
        lines                   = t_lines
      exceptions
        id                      = 1
        language                = 2
        name                    = 3
        not_found               = 4
        object                  = 5
        reference_check         = 6
        wrong_access_to_archive = 7
        others                  = 8.

    check sy-subrc eq 0.

    read table t_lines into data(line) index 1.

    if sy-subrc eq 0 .
      tdline = line-tdline .
    endif .

  endmethod .


  method preencher_espaco .

    data:
      contador type i .

    contador = caracter_inicial - 1 .

    if caracter_inicial le caracter_final .

      do .

        if contador eq caracter_final .
          exit .
        endif .

        detalhe+contador(1) = caracter_space .

        contador = contador + 1 .

      enddo .

    endif.

  endmethod .


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
  
endclass.
