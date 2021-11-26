Class msg.supprVoitureDmde Extends Ens.Request
{

Property plaque As %String;

Storage Default
{
<Data name="supprVoitureDmdeDefaultData">
<Subscript>"supprVoitureDmde"</Subscript>
<Value name="1">
<Value>plaque</Value>
</Value>
</Data>
<DefaultData>supprVoitureDmdeDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
