Class msg.creerCheckReservationDmde Extends (Ens.Request, %JSON.Adaptor)
{

Property plaque As %String;

Storage Default
{
<Data name="creerCheckReservationDmdeDefaultData">
<Subscript>"creerCheckReservationDmde"</Subscript>
<Value name="1">
<Value>categorie</Value>
</Value>
<Value name="2">
<Value>plaque</Value>
</Value>
</Data>
<DefaultData>creerCheckReservationDmdeDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
