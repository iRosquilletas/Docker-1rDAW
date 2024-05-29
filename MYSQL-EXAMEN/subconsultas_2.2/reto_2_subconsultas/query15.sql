USE chinook;
SELECT InvoiceId, Total,
    CASE
        WHEN Total > 100 THEN Total * 0.1
        ELSE 0
    END AS Descuento
FROM Invoice;