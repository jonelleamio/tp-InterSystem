Class /// Description
Class BO.Reservation Extends Ens.BusinessOperation
{

Property Adapter As Ens.OutboundAdapter;

Parameter ADAPTER = "Ens.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method creerVoiture(pRequest As Ens.creerVoitureDmde, Output pResponse As Ens.creerVoitureRpse ) As %Status
{
    
    Return $$$ERROR($$$NotImplemented)
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="Ens.creerVoitureDmde">
        <Method>creerVoiture</Method>
    </MapItem>
</MapItems>
}
}