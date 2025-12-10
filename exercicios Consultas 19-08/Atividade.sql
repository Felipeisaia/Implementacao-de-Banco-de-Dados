-- atividade-desafio - Felipe Isaia Faria

-- Questão 1:
select 
    p.ProductName as "Nome do Produto",
    s.CompanyName as "Empresa Fornecedora", 
    c.CategoryName as "Categoria",
    p.UnitPrice as "Preço Unitário",
    p.UnitsInStock as "Quantidade em Estoque"
from 
    Products p
    inner join Suppliers s on p.SupplierID = s.SupplierID
    inner join Categories c on p.CategoryID = c.CategoryID
order by 
    c.CategoryName, p.ProductName;

-- Questão 2:
select 
    p.ProductName as "Nome do Produto",
    s.CompanyName as "Empresa Fornecedora", 
    c.CategoryName as "Categoria",
    p.UnitPrice as "Preço Unitário",
    p.UnitsInStock "Quantidade em Estoque"
from 
    Products p
    inner join Suppliers s ON p.SupplierID = s.SupplierID
    inner join Categories c ON p.CategoryID = c.CategoryID
where 
    p.UnitsInStock > 0 and p.Discontinued = 0
order by 
    c.CategoryName, p.ProductName;

-- Questão 3:
SELECT 
    e.FirstName + ' ' + e.LastName AS 'Nome Completo do Vendedor',
    count(o.OrderID) AS 'Total de Vendas'
FROM 
    Employees e
    LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
group by 
    e.EmployeeID, e.FirstName, e.LastName
order by 
    'Total de Vendas' DESC;

-- Questão 4:
select 
    CONCAT(e.FirstName, ' ', e.LastName) as "Nome Completo do Vendedor",
    COUNT(o.OrderID) as "Total de Vendas"
from 
    Employees e
    join Orders o on e.EmployeeID = o.EmployeeID
group by 
    e.EmployeeID, e.FirstName, e.LastName
having 
    COUNT(o.OrderID) >= 100
order by 
    COUNT(o.OrderID) desc;

-- Questão 5:
SELECT 
    e.FirstName + ' ' + e.LastName as "Nome Completo do Vendedor",
    COUNT(et.TerritoryID) as "Qtd de Territórios"
FROM 
    Employees e
    left join EmployeeTerritories et ON e.EmployeeID = et.EmployeeID
GROUP BY 
    e.EmployeeID, e.FirstName, e.LastName
ORDER BY 
    "Qtd de Territórios" DESC;

-- Questão 6:
SELECT 
    o.OrderID AS 'ID do Pedido',
    o.OrderDate AS 'Data do Pedido',
    c.CompanyName AS 'Cliente',
    SUM((od.UnitPrice * od.Quantity) - (od.UnitPrice * od.Quantity * od.Discount)) AS 'Valor Total'
FROM 
    Orders o
    INNER JOIN Customers c ON o.CustomerID = c.CustomerID
    INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY 
    o.OrderID, o.OrderDate, c.CompanyName
ORDER BY 
    SUM((od.UnitPrice * od.Quantity) - (od.UnitPrice * od.Quantity * od.Discount)) DESC;

-- Questão 7:
select 
    od.OrderID as "ID do Pedido",
    p.ProductName as "Nome do Produto",
    p.UnitPrice as "Preço de Lista",
    od.UnitPrice as "Preço Cobrado",
    (p.UnitPrice - od.UnitPrice) as "Diferenca"
from 
    [Order Details] od
    inner join Products p on od.ProductID = p.ProductID
where 
    od.UnitPrice < p.UnitPrice
order by 
    "Diferenca" desc;