Class msg.creerReservationDmde Extends (Ens.Request, %JSON.Adaptor)
{

// https://docs.intersystems.com/irislatest/csp/documatic/%25CSP.Documatic.cls?LIBRARY=%25SYS&CLASSNAME=%25Library.DateTime

// date accepted 2021-11-25

Property dateDeDebut As %DateTime;

// date accepted 12/31/2021 mm/dd/[yy]yy

Property dateDeFin As %DateTime;

Property categorie As %String;

Storage Default
{
<Data name="creerReservationDmdeDefaultData">
<Subscript>"creerReservationDmde"</Subscript>
<Value name="1">
<Value>datDebut</Value>
</Value>
<Value name="2">
<Value>datFin</Value>
</Value>
<Value name="3">
<Value>categorie</Value>
</Value>
<Value name="4">
<Value>dateDeDebut</Value>
</Value>
<Value name="5">
<Value>dateDeFin</Value>
</Value>
</Data>
<DefaultData>creerReservationDmdeDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
