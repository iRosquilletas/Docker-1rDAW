-- Obtener la información de los clientes que han realizado compras superiores a 20€.

select * from Customer
where CustomerId in (
	
    select CustomerId from Invoice
    where InvoiceId in (
		
        select InvoiceId from InvoiceLine
			where Quantity > 20
    )
);

select * from Customer
where CustomerId in (
	
    select CustomerId from Invoice
    where Total > 20

)
-- la correcta es esta