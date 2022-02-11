/* 1 Este exercício é livre para você inserir dados nas tabelas. Adicione vários dados em todas as tabelas. Crie vários clientes, com vários endereços. Insira muitos produtos em vários departamentos. Crie pedidos em várias datas com meses diferentes (serão necessários para os próximos exercícios). - */
 --- Os dados das tabelas estão no aqruivo Dados da Tabela.txt -----


/* 2 - Quantos clientes estão cadastrados na sua base? */
SELECT count(DISTINCT id) from cliente;

/* 3 - Qual o produto mais caro? */
SELECT * FROM produto WHERE preco = (SELECT MAX(preco) FROM produto);

/*4 - Qual o produto mais barato?*/
SELECT * FROM produto WHERE preco = (SELECT MIN(preco) FROM produto);

/* 5 - Mostre todos os produtos com seus respectivos departamentos.*/
SELECT * FROM produto inner join departamento on produto.departamento_codigo = departamento.codigo;

/* 6 - Quantos produtos há em cada departamento? Exiba o nome do departamento e a quantidade de produtos que há em cada um. (pense em COUNT e GROUP BY)*/
SELECT count(produto.codigo), departamento.codigo, departamento.nome FROM produto right outer join departamento 
on produto.departamento_codigo = departamento.codigo
group by departamento.codigo;

/* 7 - Mostre os dados dos pedidos, incluindo nomes dos clientes e nomes dos produtos que foram vendidos.*/
SELECT 
cliente.nome as "Nome do Cleinte",
produto.nome as "Nome do Produto",
pedido.status as "Status do Pedido",
pedido.data_pedido as "Data do Pedido",
item_pedido.quantidade as "Quant.",
item_pedido.valor_unitario as "Valor Unitário",
item_pedido.valor_total as "Valor Total",
item_pedido.num_sequencial as "Número do PEdido"

FROM cliente
inner join pedido on pedido.cliente_id = cliente.id
inner join item_pedido on item_pedido.pedido_numero = pedido.numero
inner join produto on produto.codigo = item_pedido.produto_codigo
WHERE pedido.status like "E";

/* 8 - Mostre quantos pedidos foram feitos por mês no ano de 2022 (caso você tenha registros neste ano, senão escolha um ano que você tenha cadastrado - Novamente pense em COUNT e GROUP BY).*/
select 
	month(data_pedido) as Mes, COUNT(*) as Quantidade
from pedido 
where data_pedido >= '2021-01-01' and data_pedido <= '2021-12-31' 
group by month(data_pedido) 
order by month(data_pedido) asc;

/* 9 - Mostre quanto foi faturado por mês (leve em conta o valor total de cada pedido - novamente pense em GROUP BY e SUM). */
select 
	month(data_pedido) as Mes, SUM(valor_final) as Soma
from pedido 
where data_pedido >= '2021-01-01' and data_pedido <= '2021-12-31' 
group by month(data_pedido) 
order by month(data_pedido) asc;

/* 10 - Mostre o valor total do estoque por departamento. */
select 
	(select nome from departamento where codigo = departamento_codigo) as Departamento, SUM(preco * estoque) as 'Valor em Estoque'
from produto
group by departamento_codigo;
