# Projeto E-commerce – Banco de Dados MySQL

## Descrição

Este projeto tem como objetivo aplicar conceitos fundamentais de banco de dados utilizando MySQL, incluindo: transações. procedures com controle de erro e backup e recovery.

O banco de dados simula um sistema de e-commerce com clientes, produtos, pedidos, pagamentos e controle de estoque.

---

## Estrutura do Banco

O banco de dados `ecommerce` contém as seguintes tabelas principais:

* `clients`
* `product`
* `orders`
* `payments`
* `productstorage`
* `supplier`
* `seller`
* `productorder`
* `productsupplier`
* `delivery`

---

## PARTE 1 – TRANSAÇÕES

Foi implementada uma transação para simular um pedido:

* Verificação de estoque
* Atualização do estoque
* Inserção de pagamento
* Criação do pedido
* Inserção do item do pedido



## PARTE 2 – PROCEDURE COM TRANSAÇÃO

Foi criada uma procedure com controle de erro utilizando:

* `start transaction`
* `rollback`
* `commit`
* `handler`


## PARTE 3 – BACKUP E RECOVERY

###  Backup

Foi utilizado o comando:

```bash
mysqldump -u root -p ecommerce > ecommerce_backup.sql
```

Também foi possível gerar backup completo com:

```bash
mysqldump -u root -p --routines --triggers --events ecommerce > ecommerce_full.sql
```

---

### Recovery

Para restaurar o banco:

```bash
mysql -u root -p ecommerce < ecommerce_backup.sql
```

Observação:
Foi necessário remover a linha `SET @@GLOBAL.GTID_PURGED` do arquivo para evitar erro de GTID.

---


## Tecnologias utilizadas

* MySQL Server 9.x
* MySQL Workbench
* Prompt de Comando (CMD)

---


Desenvolvido por: **Danilo**
