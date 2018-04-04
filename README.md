# Arquivo de pagamentos #

[![N|Solid](https://wiki.scn.sap.com/wiki/download/attachments/1710/ABAP%20Development.png?version=1&modificationDate=1446673897000&api=v2)](https://www.sap.com/brazil/developer.html)

Para atender a necessidade da geração de arquivos no SAP, foram criadas duas classes, uma para atender _Pagamento de Fornecedores_ e outra para atender _Pagamento de Concessionarias_ (telefone, agua, energia e etc). Essas `Classes` são utilizadas no report [!N|Solid](ZXDTAU01)](https://github.com/edmilson-nascimento/arquivo-de-pagamento-sap/blob/master/ZXDTAU01.abap).

Nesse report [!N|Solid](ZXDTAU01)](https://github.com/edmilson-nascimento/arquivo-de-pagamento-sap/blob/master/ZXDTAU01.abap)

Existem vários exemplos e modelos diferente de usar a classe `CL_GUI_ALV_GRID` para exibir relatórios ALV. Sempre que a classe é utilizada, ela necessita de um `container` para que o ALV seja exibido. Ao invés de criar um `container` pra isso, eu preferi utilizar o próprio `container`, que é gerado quando se cria a tela `1000` em um relatório, que no caso, é a tela de seleção. Sim, eu ~~posso~~ vou utilizar o container na tela de seleção para exibir o ALV como eu aprendi com [Gerson Lívio](mailto:gerson@litsolutions.com.br).
A funcionalidade de `SELECT ROWS` foi implementada tambem e será utilizada para selecionar as linhas referentes as ações que desejo fazer.

Para isso eu criei uma classe local básica `GCL_REPORT` com os seguintes métodos:

* public section
	* [search](#search)
	* [generate_grid](#generate_grid)

* protected

* private section
	* [fieldcat](#fieldcat)
	* [call_screen_default](#call_screen_default)
	* [handler_toolbar](#handler_toolbar)
	* [handler_user_command](#handler_toolbar)
	* [handler_hotspot_click](#handler_toolbar)
	* [executa_on_off](#executa_on_off)
	* [refresh](#refresh)

## Informações exibidas ##
