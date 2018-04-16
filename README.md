# Arquivo de pagamentos #

[![N|Solid](https://wiki.scn.sap.com/wiki/download/attachments/1710/ABAP%20Development.png?version=1&modificationDate=1446673897000&api=v2)](https://www.sap.com/brazil/developer.html)

Para atender a necessidade da geração de arquivos no SAP, foram criadas duas classes, uma para atender _Pagamento de Fornecedores_ e outra para atender _Pagamento de Concessionarias_ (telefone, agua, energia e etc). Essas `Classes` são utilizadas no report [ZXDTAU01](https://github.com/edmilson-nascimento/arquivo-de-pagamento-sap/blob/master/ZXDTAU01.abap).

Nesse report [ZXDTAU01](https://github.com/edmilson-nascimento/arquivo-de-pagamento-sap/blob/master/ZXDTAU01.abap), com o intuito de simplificar melhor, a classe `zcl_fi_pgto_concessionarias` acesso arquivo e indentifica o _meio de pagamento_, de forma a identificar a classe que deve apresentar a solução. Apos, ambas classes tem o mesmo fluxo, buscam as informações do arquivo e depois fazem as devidas alterações ~~~seria mais pertinente que fosse feita uma terceira classe que busca as informações visto que são semelhantes as funcionalidades do metodo `get_data` de ambas classes**mas faltou tempo e organização por parte das definições de negócio**~.

Segue classe [zcl_fi_pgto_fornecedores](https://github.com/edmilson-nascimento/arquivo-de-pagamento-sap/blob/master/zcl_fi_pgto_fornecedores.class.abap) e a classe [zcl_fi_pgto_concessionarias](https://github.com/edmilson-nascimento/arquivo-de-pagamento-sap/blob/master/zcl_fi_pgto_concessionarias.class.abap).
