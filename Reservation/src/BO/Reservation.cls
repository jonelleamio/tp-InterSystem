Class BO.Reservation Extends Ens.BusinessOperation
{

Property Adapter As EnsLib.File.OutboundAdapter;

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method creerReservation(pRequest As msg.creerReservationDmde, Output pResponse As msg.creerReservationRpse) As %Status
{
    set pResponse = ##class(msg.creerReservationRpse).%New()

    // Implicit Joins (Arrow Syntax) https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GSQL_IMPLICITJOINS
    // You can use the –> operator any time you have a reference column within a table; that is, a column whose value is the ID of a referenced table (essentially a special case of foreign key). In this case, the Company field of Sample.Employee contains IDs of records in the Sample.Company table. You can use the –> operator anywhere you can use a column expression within a query.

    // categorie '2 places', 'Cabriolet', 'Berline', 'Monospace', '4x4', '7 places'

    /* select plaque 
    from data.Voiture 
    where categorie = 'pRequest.categorie' 
        and plaque not in (
            SELECT voiture -> plaque 
            FROM data.Reservation 
            where voiture -> categorie = 'pRequest.categorie' 
            and (
                (
                dateDeDebut >= 'pRequest.dateDeDebut' 
                and dateDeDebut <= 'pRequest.dateDeFin'
                ) 
                or (
                dateDeFin >= 'pRequest.dateDeDebut' 
                and dateDeFin <= 'pRequest.dateDeFin'
                ) 
                or (
                dateDeDebut <= 'pRequest.dateDeDebut' 
                and dateDeFin >= 'pRequest.dateDeFin'
                ) 
                or (
                dateDeDebut >= 'pRequest.dateDeDebut' 
                and dateDeFin <= 'pRequest.dateDeFin'
                )
            )
    ) */

    set sql = "select plaque "
    set sql = sql_"from data.Voiture "
    set sql = sql_"where categorie = '"_pRequest.categorie_"'"
    set sql = sql_"  and plaque not in ("
    set sql = sql_"    SELECT voiture -> plaque"
    set sql = sql_"    FROM data.Reservation"
    set sql = sql_"    where voiture -> categorie = '"_pRequest.categorie_"'"
    set sql = sql_"      and ((dateDeDebut >= '"_pRequest.dateDeDebut_"'"
    set sql = sql_"          and dateDeDebut <= '"_pRequest.dateDeFin_"')"
    set sql = sql_"        or (dateDeFin >= '"_pRequest.dateDeDebut_"'"
    set sql = sql_"          and dateDeFin <= '"_pRequest.dateDeFin_"')"
    set sql = sql_"        or (dateDeDebut <= '"_pRequest.dateDeDebut_"'"
    set sql = sql_"          and dateDeFin >= '"_pRequest.dateDeFin_"')"
    set sql = sql_"        or (dateDeDebut >= '"_pRequest.dateDeDebut_"'"
    set sql = sql_"          and dateDeFin <= '"_pRequest.dateDeFin_"')))"

    set statement=##class(%SQL.Statement).%New() 
	do statement.%Prepare(sql)

	set SQLrequest = statement.%Execute()
    do SQLrequest.%Next()

    set plaque = SQLrequest.%Get("plaque")
    set idVoiture = ##class(data.Voiture).consulterParPlaqueExists(plaque)

    if (idVoiture){
        set dataVoiture = ##class(data.Voiture).%OpenId(idVoiture)
        set reservation = ##class(data.Reservation).%New()
        set reservation.voiture = dataVoiture
        set reservation.dateDeDebut = pRequest.dateDeDebut
        set reservation.dateDeFin = pRequest.dateDeFin
        set tsc = reservation.%Save()
        if (tsc){
            set pResponse.codeRetour = "OK"
        }
        else {
            set pResponse.codeRetour = "KO"
        }
    } else {
        set pResponse.codeRetour = "KO"
    }
    
    Quit $$$OK
}

Method checkReservation(pRequest As msg.creerCheckReservationDmde, Output pResponse As msg.creerCheckReservationRpse) As %Status
{
    set pResponse = ##class(msg.creerCheckReservationRpse).%New()
    set sql = "select voiture"
    set sql = sql_" from data.Reservation"
    set sql = sql_" where voiture->plaque = '"_pRequest.plaque_"'"
    set sql = sql_" and (dateDeDebut >= GETDATE()"
    set sql = sql_" or dateDeFin >= GETDATE())"

    set statement=##class(%SQL.Statement).%New() 
	do statement.%Prepare(sql)

	set SQLrequest = statement.%Execute()
    do SQLrequest.%Next()

    if (SQLrequest.%Get("voiture")){
        set pResponse.codeRetour = "KO"
    }else{
        set pResponse.codeRetour = "OK"
    }
    
    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="msg.creerReservationDmde">
        <Method>creerReservation</Method>
    </MapItem>
    <MapItem MessageType="msg.creerCheckReservationDmde">
    <Method>checkReservation</Method>
    </MapItem>
</MapItems>
}

}
