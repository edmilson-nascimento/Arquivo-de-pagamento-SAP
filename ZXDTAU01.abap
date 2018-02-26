&---------------------------------------------------------------------
*&  Include           ZXDTAU01
&---------------------------------------------------------------------

DATA: 
  concessionarias TYPE REF TO zcl_fi_pgto_concessionarias,
  fornecedores    TYPE REF TO zcl_fi_pgto_fornecedores,
* reguh           TYPE zcl_fi_pgto_concessionarias=>ty_reguh,
* error           TYPE flag,
  lt_arquivo      TYPE TABLE OF bu_txt10000,
  lv_meio_pag     TYPE char2.

CONSTANTS: 
  c_concessionarias TYPE char2 VALUE 'CO',
  c_fornecedor      TYPE char2 VALUE 'FO'.

CREATE OBJECT concessionarias.
CREATE OBJECT fornecedores.

*concessionarias->get_data(
*  exporting
*    regut = t_regut
*  importing
*    reguh = reguh
*    error = error
*).
*
*if error eq abap_false .
*
*  concessionarias->change_file(
*    exporting
*      i_filename = i_filename
*      reguh      = reguh
*  ).
*
*endif .
*
*fornecedores->get_data(
*  exporting
*    regut = t_regut
*  importing
*    error = error
*).
*
*if error eq abap_false .
*
*  fornecedores->change_file(
*    exporting
*      i_filename = i_filename
*      reguh      = reguh
*  ).
*
*endif .

concessionarias->get_data(
  EXPORTING
    regut   = t_regut
 ).

concessionarias->check_file(
  EXPORTING
    i_filename  = i_filename
   IMPORTING
    t_arquivo        = lt_arquivo
    e_meio_pagamento = lv_meio_pag
  ).

CASE lv_meio_pag.

  WHEN c_concessionarias.

    concessionarias->change_file(
      EXPORTING
        i_filename = i_filename
        t_file     = lt_arquivo
    ).

  WHEN c_fornecedor.

    fornecedores->get_data(
      EXPORTING
        regut = t_regut
    ).

    fornecedores->change_file(
      EXPORTING
        i_filename = i_filename
        t_file     = lt_arquivo
    ).

ENDCASE.

FREE: 
  concessionarias, fornecedores.

DATA lo_envio TYPE REF TO zcl_envio_arqui_banc_neogrid.

CREATE OBJECT lo_envio
  EXPORTING
    i_regut = t_regut.

lo_envio->process_sending_file( ).

FREE lo_envio.
