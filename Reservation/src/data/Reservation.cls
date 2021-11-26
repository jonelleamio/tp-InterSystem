Class data.Reservation Extends (%Persistent, %JSON.Adaptor)
{

Property voiture As data.Voiture;

Property dateDeDebut As %TimeStamp;

Property dateDeFin As %TimeStamp;

Storage Default
{
<Data name="ReservationDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>voiture</Value>
</Value>
<Value name="3">
<Value>datDeb</Value>
</Value>
<Value name="4">
<Value>datFin</Value>
</Value>
<Value name="5">
<Value>dateDeDeb</Value>
</Value>
<Value name="6">
<Value>dateDeDebut</Value>
</Value>
<Value name="7">
<Value>dateDeFin</Value>
</Value>
</Data>
<DataLocation>^data.ReservationD</DataLocation>
<DefaultData>ReservationDefaultData</DefaultData>
<IdLocation>^data.ReservationD</IdLocation>
<IndexLocation>^data.ReservationI</IndexLocation>
<StreamLocation>^data.ReservationS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
