CREATE NONCLUSTERED INDEX indx_tblClassBooking_status_date
ON tblClassBooking (status, bookingDate);