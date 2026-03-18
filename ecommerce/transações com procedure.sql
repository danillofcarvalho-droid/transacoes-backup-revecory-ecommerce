delimiter $$

create procedure realizar_pedido(
    in p_cliente_id int,
    in p_quantidade int
)
begin
    declare v_estoque int;
    declare v_produto int;
    declare erro bool default false;
    declare continue handler for sqlexception
    set erro = true;

    start transaction;

-- pegar produto existente
    select idproduct into v_produto
    from product
    limit 1;

-- pegar estoque
    select quantity into v_estoque
    from productstorage
    where idprodstorage = 1;

    if v_estoque >= p_quantidade then

-- atualizar estoque
        update productstorage
        set quantity = quantity - p_quantidade
        where idprodstorage = 1;

        savepoint antes_pedido;

-- inserir pagamento
        insert into payments (idclient, typepayment, limitavailable)
        values (p_cliente_id, 'pix', 1000);

        set @id_pagamento = last_insert_id();

-- inserir pedido
        insert into orders (idorderclient, idorderpayment, orderstatus, orderdescription)
        values (p_cliente_id, @id_pagamento, 'confirmado', 'pedido via procedure');

        set @id_pedido = last_insert_id();

-- inserir item do pedido
        insert into productorder (idpoproduct, idpoorder, podquantity)
        values (v_produto, @id_pedido, p_quantidade);

    else
        set erro = true;
    end if;

    if erro then
        rollback;
    else
        commit;
    end if;

end$$

delimiter ;

call realizar_pedido(1, 1);