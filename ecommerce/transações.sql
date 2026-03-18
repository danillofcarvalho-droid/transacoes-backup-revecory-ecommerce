use ecommerce;

set autocommit = 0;

start transaction;

-- atualizar estoque
update productstorage
set quantity = quantity - 1
where idprodstorage = 1;

-- inserir pagamento
insert into payments (idclient, typepayment, limitavailable)
values (1, 'pix', 1000);

-- salvar id do pagamento
set @id_pagamento = last_insert_id();

-- inserir pedido
insert into orders (idorderclient, idorderpayment, orderstatus, orderdescription)
values (1, @id_pagamento, 'confirmado', 'pedido teste');

-- salvar id do pedido
set @id_pedido = last_insert_id();

-- pegar o produto
set @id_produto = (select idproduct from product limit 1);

-- inserir item do pedido
insert into productorder (idpoproduct, idpoorder, podquantity)
values (@id_produto, @id_pedido, 1);

commit;