USE chinook;
SELECT Name
FROM track
WHERE track.TrackId IN (
        SELECT invoiceline.TrackId
        FROM invoiceline
        WHERE invoiceline.InvoiceId IN (
            SELECT invoice.InvoiceId
                FROM invoice
                WHERE invoice.CustomerId IN (
                    SELECT customer.CustomerId
                        FROM customer
                        WHERE customer.FirstName = 'Luis' 
                        AND customer.LastName = 'Rojas'
				)));