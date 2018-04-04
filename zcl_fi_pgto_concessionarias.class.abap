
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
      end of ty_reguh ,

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
        !t_file     type tab_arquivo .

    class-methods preencher_espaco
      importing
        !caracter_inicial type i
        !caracter_final   type i
      changing
        !detalhe type ty_detalhe .

    class-methods date
      importing
        !date      type sydatum
      exporting
        !date_file type char8 .

    methods check_file
      importing
        !i_filename       type rlgrap-filename
      exporting
        !t_arquivo        type tab_arquivo
        !e_meio_pagamento type char2 .
      

  protected section.


  private section.

    constants:
      c_santander    type c length 3 value '033',
      c_caixa        type c length 3 value '104',
      c_itau         type c length 3 value '341',
      c_banco_brasil type c length 3 value '001' .

    class-data:
      t_reguh        type tab_reguh,
      t_regup        type tab_regup,
      t_bseg         type tab_bseg,
      caracter_space type c .

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
        !rodape  type char1000sf .
    
    methods change_info_fim
      importing
        !detalhe type tab_detalhe
      changing
        !fim     type char1000sf .
    
    methods get_info_barcode
      importing
        !zbukr   type dzbukr
        !belnr   type belnr_d
        !gjahr   type gjahr
        !buzei   type buzei
      exporting
        !valor   type char15
      changing
        !detalhe type ty_detalhe .

    methods get_info_text
      importing
        !id       type tdid
        !language type spras default 'p'
        !name     type tdobname
        !object   type tdobject
      exporting
        !tdline   type tdline .

    methods set_info_file
      importing
        !inicio    type char1000sf
        !cabecalho type bu_txt10000
        !t_detalhe type tab_detalhe
        !rodape    type char1000sf
        !fim       type char1000sf
      changing
        !t_arquivo type tab_arquivo .

    methods space
      importing
        !begin type i default 0
        !end   type i default 0
      changing
        !line  type any .

    methods get_detail
      importing
        !detalhe type ty_detalhe
      exporting
        !reguh  type ty_reguh
        !regup  type ty_regup
        !bseg   type ty_bseg .

    methods get_conta_corrente_104
      exporting
        !conta  type char12
        !digito type char1 .
