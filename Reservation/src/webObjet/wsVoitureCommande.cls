Class webObjet.wsVoitureCommande Extends (%SerialObject, %XML.Adaptor, %JSON.Adaptor)
{

Property marque As %String;

Property modele As %String;

Property categorie As %String;

Property plaque As %String;

Property couleur As %String;

Property nbPlaces As %Integer;

Storage Default
{
<Data name="wsVoitureCommandeState">
<Value name="1">
<Value>nom</Value>
</Value>
<Value name="2">
<Value>categorie</Value>
</Value>
<Value name="3">
<Value>plaque</Value>
</Value>
<Value name="4">
<Value>marque</Value>
</Value>
<Value name="5">
<Value>modele</Value>
</Value>
<Value name="6">
<Value>couleur</Value>
</Value>
<Value name="7">
<Value>nbPlaces</Value>
</Value>
</Data>
<State>wsVoitureCommandeState</State>
<StreamLocation>^webObjet.wsVoitureCommandeS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
