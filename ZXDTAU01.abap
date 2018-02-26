*&---------------------------------------------------------------------
*&  Include           ZXDTAU01
*&---------------------------------------------------------------------

data: 
  concessionarias type ref to zcl_fi_pgto_concessionarias,
  fornecedores    type ref to zcl_fi_pgto_fornecedores,
  reguh           type zcl_fi_pgto_concessionarias=>ty_reguh,
  error           type flag,
  lt_arquivo      type table of bu_txt10000,
  meio_pagamento  type char2.

constants: 
  c_concessionarias type char2 value 'CO',
  c_fornecedor      type char2 value 'FO'.

create object concessionarias.
create object fornecedores.

concessionarias->get_data(
  exporting
    regut = t_regut
  importing
    reguh = reguh
    error = error
).

if error eq abap_false .

  concessionarias->change_file(
    exporting
      i_filename = i_filename
      reguh      = reguh
  ).

endif .

fornecedores->get_data(
  exporting
    regut = t_regut
  importing
    error = error
).

if error eq abap_false .

  fornecedores->change_file(
    exporting
      i_filename = i_filename
      reguh      = reguh
  ).

endif .

concessionarias->get_data(
  exporting
    regut   = t_regut
 ).

concessionarias->check_file(
  exporting
    i_filename  = i_filename
   importing
    t_arquivo        = lt_arquivo
    e_meio_pagamento = meio_pagamento
  ).

case meio_pagamento .

  when c_concessionarias.

    concessionarias->change_file(
      exporting
        i_filename = i_filename
        t_file     = lt_arquivo
    ).

  when c_fornecedor.

    fornecedores->get_data(
      exporting
        regut = t_regut
    ).

    fornecedores->change_file(
      exporting
        i_filename = i_filename
        t_file     = lt_arquivo
    ).

endcase.

free: 
  concessionarias, fornecedores.
