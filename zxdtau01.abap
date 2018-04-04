*----------------------------------------------------------------------
*-  Include           ZXDTAU01
*----------------------------------------------------------------------

data: 
  concessionarias type ref to zcl_fi_pgto_concessionarias,
  fornecedores    type ref to zcl_fi_pgto_fornecedores,
  arquivo         type table of bu_txt10000,
  meio_pagamento  type char2.

constants: 
  c_concessionarias type char2 value 'CO',
  c_fornecedor      type char2 value 'FO'.

create object concessionarias.
create object fornecedores.

concessionarias->check_file(
  exporting
    i_filename       = i_filename
  importing
    t_arquivo        = arquivo
    e_meio_pagamento = meio_pagamento   
) . 

case meio_pagamento 

  when c_concessionarias.

    concessionarias->get_data(
      exporting
        regut = t_regut
    ).  

    concessionarias->change_file(
      exporting
        i_filename = i_filename
        t_file     = arquivo
    ) .

  when c_fornecedor.

    fornecedores->get_data(
      exporting     
        regut = t_regut
    ).

    fornecedores->change_file(
      exporting
        i_filename = i_filename
        t_file     = arquivo
    ).

endcase.

*free: 
*  concessionarias, fornecedores.
*
*data:
*  envio type ref to zcl_envio_arqui_banc_neogrid .
*
*create object envio
*  exporting
*    i_regut = t_regut.
*
*envio->process_sending_file( ).
*
*free envio.
