Class msg.Reservation.checkReservationDmde Extends (Ens.Request, %JSON.Adaptor)
{

Property plaque As %String;

Storage Default
{
<Data name="checkReservationDmdeDefaultData">
<Subscript>"checkReservationDmde"</Subscript>
<Value name="1">
<Value>plaque</Value>
</Value>
</Data>
<DefaultData>checkReservationDmdeDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
