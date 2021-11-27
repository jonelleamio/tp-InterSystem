Class BO.Voiture Extends Ens.BusinessOperation
{

Property Adapter As Ens.OutboundAdapter;

Parameter ADAPTER = "Ens.OutboundAdapter";

Parameter INVOCATION = "Queue";

// Method creerVoiture(pRequest As msg.creerVoitureCommandeDmde, Output pResponse As msg.creerVoitureRpse) As %Status

Method creerVoiture(pRequest As msg.creerVoitureDmde, Output pResponse As msg.creerVoitureRpse) As %Status
{
    
    set pResponse = ##class(msg.creerVoitureRpse).%New()
    set voiture = ##class(data.Voiture).%New()

    // do ##class(Transform.TransformVoitureCommandeToVoiture).Transform(pRequest.voiture,.voiture)

    // set voiture.nom = pRequest.voiture.marque_" "_pRequest.voiture.modele
    // set voiture.categorie = pRequest.voiture.categorie
    // set voiture.plaque = pRequest.voiture.plaque

    set voiture.nom = pRequest.nom
    set voiture.categorie = pRequest.categorie
    set voiture.plaque = pRequest.plaque
    set tsc = voiture.%Save()

    if 'tsc {
        set pResponse.codeRetour = "KO"
        set pResponse.libErreur = "Error: technique lors de la creation"
        Quit $$$OK
    }

    set pResponse.codeRetour = "OK"

    Quit $$$OK
}

Method supprVoiture(pRequest As msg.supprVoitureDmde, Output pResponse As msg.supprVoitureRpse) As %Status
{
    
    set pResponse = ##class(msg.supprVoitureRpse).%New()
    if (##class(data.Voiture).consulterParPlaqueExists(pRequest.plaque,.idVoiture)) {

        set tsc = ##class(data.Voiture).%DeleteId(idVoiture)

        if 'tsc {
            set pResponse.codeRetour = "KO"
            set pResponse.libErreur = "Error: technique lors de la suppr"
            Quit $$$OK
        }

    }
    else {
            set pResponse.codeRetour = "KO"
            set pResponse.libErreur = "Error: plaque Introuvable"
            Quit $$$OK
    }

    set pResponse.codeRetour = "OK"
    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="msg.creerVoitureDmde">
        <Method>creerVoiture</Method>
    </MapItem>
</MapItems>
}

}
