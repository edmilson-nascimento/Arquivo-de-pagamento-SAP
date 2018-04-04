class zcl_fi_pgto_fornecedores definition
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
      end of ty_reguh,

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
      end of ty_regup,

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
      end of ty_bseg,

      begin of ty_dfkkbptaxnum,
        partner type dfkkbptaxnum-partner,
        taxtype type dfkkbptaxnum-partner,
      end of ty_dfkkbptaxnum,

      begin of ty_but0bk,
        partner type but0bk-partner,
        bkvid   type but0bk-bkvid,
        banks   type but0bk-banks,
        bankl   type but0bk-bankl,
        bankn   type but0bk-bankn,
      end of ty_but0bk,

      ty_detalhe       type bu_txt10000,
      ty_arquivo       type bu_txt10000,
      tab_regup        type table of ty_regup,
      tab_reguh        type table of ty_reguh,
      tab_bseg         type table of ty_bseg,
      tab_dfkkbptaxnum type table of ty_dfkkbptaxnum,
      tab_but0bk       type table of ty_but0bk,
      tab_arquivo      type table of bu_txt10000,
      tab_detalhe      type table of ty_detalhe .
    
    class-methods get_bank_104
      exporting
        !banco          type char3
        !agencia        type char4
        !conta          type char8
        !digito_agencia type char1
        !digito_conta   type char1 .

    methods get_data
      importing
        !regut type regut .

    methods change_file
      importing
        !i_filename type rlgrap-filename
        !t_file     type tab_arquivo .

  protected section .

    methods space
      importing
        !begin type i default 0
        !end   type i default 0
      changing
        !line  type any .

  private section.

    constants:
      c_santander    type c length 3 value '033',
      c_caixa        type c length 3 value '104',
      c_itau         type c length 3 value '341',
      c_banco_brasil type c length 3 value '001' .

    data:
      t_reguh        type tab_reguh,
      t_regup        type tab_regup,
      t_bseg         type tab_bseg,
      t_dfkkbptaxnum type tab_dfkkbptaxnum,
      t_but0bk       type tab_but0bk .

    methods check_cenario
      importing
        !inicio type char1000sf
      changing
        !error  type flag .

    methods get_info_file
      importing
        !arquivo   type tab_arquivo
      exporting
        !inicio    type char1000sf
        !cabecalho type bu_txt10000
        !t_detalhe type tab_detalhe
        !rodape    type char1000sf
        !fim       type char1000sf
        !filename  type string .

    methods change_inicio
      changing
        !inicio type char1000sf .

    methods change_cabecalho
      changing
        !cabecalho type bu_txt10000 .

    methods change_info_detalhes
      changing
        !t_detalhe type tab_detalhe .

    methods change_info_detalhes_104
      changing
        !detalhe type ty_detalhe .

    methods change_info_detalhes_001
      changing
        !detalhe type ty_detalhe .

    methods change_info_rodape
      changing
        !rodape type char1000sf .

    methods change_info_fim
      changing
        !fim type char1000sf .

    methods set_info_file
      importing
        !inicio    type char1000sf
        !cabecalho type bu_txt10000
        !t_detalhe type tab_detalhe
        !rodape    type char1000sf
        !fim       type char1000sf
      changing
        !t_arquivo type tab_arquivo .

    methods get_pf_pj
      importing
        !detalhe     type ty_detalhe
      returning
        value(value) type char3 .

    methods get_bank_client
      importing
        !detalhe type ty_detalhe
      exporting
        !banco   type char3
        !agencia type char4
        !conta   type char8 .

    methods get_detail
      importing
        !detalhe type ty_detalhe
      exporting
        !reguh   type ty_reguh
        !regup   type ty_regup
        !bseg    type ty_bseg .
        
endclass.

class zcl_fi_pgto_fornecedores implementation.

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
*             banco          =
*             agencia        =
*             conta          =
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
*         Pos 59 a 70 – Número da conta: Preencher conforme detalhamento do item 0.16
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

    filename = i_filename.
    append lines of t_file to t_arquivo . 

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

      modify t_detalhe from detalhe index tabix .

    endloop.

  endmethod .

  method change_info_detalhes_001.

    check detalhe(3) eq c_banco_brasil .

    case detalhe+13(1) .

      when 'A' .

      when others .

    endcase.

  endmethod.

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
*         Pos 59 a 70 – Número da conta: Preencher conforme detalhamento do item 0.16
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

  method check_cenario.

    case inicio(3) .

      when c_caixa .
        error = abap_off .

      when others .
        error = abap_on .

    endcase .
  endmethod.

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

  method get_data .

    refresh:
      t_reguh, t_regup .

    select laufd laufi xvorl zbukr lifnr kunnr
           empfg vblnr name1 rzawe rbetr augdt ausfd
      from reguh
      into table t_reguh
     where laufd eq regut-laufd
       and laufi eq regut-laufi
       and zbukr eq regut-zbukr .

    if sy-subrc eq 0 .

      select laufd laufi xvorl zbukr lifnr kunnr empfg vblnr
             bukrs belnr gjahr buzei zfbdt zbd1t esrnr esrre
        from regup 
        into table t_regup
         for all entries in t_reguh
       where laufi eq regut-laufi
         and laufd eq regut-laufd
         and zbukr eq regut-zbukr
         and vblnr eq t_reguh-vblnr.

      if sy-subrc eq 0 .

        sort t_reguh by rzawe descending .

        sort t_regup by zbukr ascending
                        belnr ascending
                        gjahr ascending .

        select bukrs belnr gjahr buzei sgtxt fdtag lifnr zfbdt zbd1t
          from bseg
          into table t_bseg
           for all entries in t_regup
         where bukrs eq t_regup-zbukr
           and belnr eq t_regup-belnr
           and gjahr eq t_regup-gjahr .

        if sy-subrc eq 0 .

          select partner taxtype
            from dfkkbptaxnum
            into table t_dfkkbptaxnum
             for all entries in t_bseg
           where partner eq t_bseg-lifnr .

          if sy-subrc eq 0 .
          endif .

          select partner bkvid banks bankl bankn
            from but0bk
            into table t_but0bk
             for all entries in t_bseg
           where partner eq t_bseg-lifnr .

          if sy-subrc eq 0 .
          endif .

        endif.

      endif.

    endif.

  endmethod.

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
  
endclass .
