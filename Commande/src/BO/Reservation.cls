Class BO.Reservation Extends EnsLib.REST.Operation
{

Property Adapter As EnsLib.HTTP.OutboundAdapter;

Parameter ADAPTER = "EnsLib.HTTP.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method creerVoiture(pRequest As msg.creerVoitureDmde, Output pResponse As msg.creerVoitureRpse) As %Status
{
    set pResponse = ##class(msg.creerVoitureRpse).%New()

    set httpRequest = ##class(%Net.HttpRequest).%New()

    // set url for methode creerVoitureRpse in namespace reservation
    set ..Adapter.URL = "/api/reservation/voiture/"

    set voiture = ##class(data.Voiture).%New()
    do ##class(Transform.WsVoitureToVoiture).Transform(pRequest.voiture,.voiture)

    // convert object to JSON
    do ..ObjectToJSONStream(voiture, .EntityBody)

    set httpRequest.EntityBody = EntityBody

    set tsc = ..Adapter.SendFormDataArray(.httpResponse, "POST", httpRequest)

    // from response : convert json to object
    do ..JSONStreamToObject(httpResponse.Data,.pResponse,"msg.creerVoitureRpse",1)

    Quit $$$OK
}

Method supprimerVoiture(pRequest As msg.supprVoitureDmde, Output pResponse As msg.supprVoitureRpse) As %Status
{
    set pResponse = ##class(msg.supprVoitureRpse).%New()

    set httpRequest = ##class(%Net.HttpRequest).%New()

    // set url for methode supprimerVoiture in namespace reservation
    set ..Adapter.URL = "/api/reservation/supprimerVoiture/"

    // convert object to JSON
    do ..ObjectToJSONStream(pRequest, .EntityBody)

    set httpRequest.EntityBody = EntityBody

    set tsc = ..Adapter.SendFormDataArray(.httpResponse, "POST", httpRequest)

    // from response : convert json to object
    do ..JSONStreamToObject(httpResponse.Data,.pResponse,"msg.supprVoitureRpse",1)

    Quit $$$OK
}

Method checkReservation(pRequest As msg.Reservation.checkReservationDmde, Output pResponse As msg.Reservation.checkReservationRpse) As %Status
{
    set pResponse = ##class(msg.Reservation.checkReservationRpse).%New()

    set httpRequest = ##class(%Net.HttpRequest).%New()

    // set url for methode supprimerVoiture in namespace reservation
    set ..Adapter.URL = "/api/reservation/supprimerVoiture/"

    // convert object to JSON
    do ..ObjectToJSONStream(pRequest, .EntityBody)

    set httpRequest.EntityBody = EntityBody

    set tsc = ..Adapter.SendFormDataArray(.httpResponse, "POST", httpRequest)

    // from response : convert json to object
    do ..JSONStreamToObject(httpResponse.Data,.pResponse,"msg.Reservation.checkReservationRpse",1)

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="msg.creerVoitureDmde">
        <Method>creerVoiture</Method>
    </MapItem>
    <MapItem MessageType="msg.supprVoitureDmde">
        <Method>supprimerVoiture</Method>
    </MapItem>
    <MapItem MessageType="msg.Reservation.checkReservationDmde">
        <Method>checkReservation</Method>
    </MapItem>

</MapItems>
}

}
