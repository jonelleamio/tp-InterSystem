/// 
Class BP.CommandeVoiture Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='msg.commandeVoitureDmde' response='msg.commandeVoitureRpse' height='2000' width='2000' >
<context>
<property name='isOk' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='250' />
</parameters>
</property>
<property name='plaqueGen' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='250' />
</parameters>
</property>
<property name='wsVoiture' type='webObjet.wsVoiture' instantiate='0' />
<property name='wsCatalogue' type='webObjet.wsCatalogue' instantiate='0' />
</context>
<sequence xend='200' yend='1250' >
<call name='get catalogues' target='Catalogue' async='0' xpos='200' ypos='250' >
<request type='msg.consulterVoitureCatalogueDmde' >
<assign property="callrequest.marque" value="request.marque" action="set" />
<assign property="callrequest.modele" value="request.modele" action="set" />
</request>
<response type='msg.consulterVoitureCatalogueRpse' >
<assign property="context.wsCatalogue" value="callresponse.voiture" action="set" />
<assign property="context.isOk" value="callresponse.codeRetour" action="set" />
</response>
</call>
<if name='is voiture in catalogue' condition='context.isOk="OK"' xpos='200' ypos='350' xend='200' yend='1150' >
<true>
<call name='Get Plaque' target='BO.Plaque' async='0' xpos='470' ypos='500' >
<request type='msg.generationPlaqueDmde' />
<response type='msg.generationPlaqueRpse' >
<assign property="context.plaqueGen" value="callresponse.plaque" action="set" />
</response>
</call>
<transform name='WsCatalogueToWsVoiture' class='BP.WsCatalogueToWsVoiture' source='context.wsCatalogue' target='context.wsVoiture' xpos='470' ypos='600' />
<call name='CreerVoiture' target='Voiture' async='0' xpos='470' ypos='700' >
<request type='msg.creerVoitureDmde' >
<assign property="callrequest.voiture" value="context.wsVoiture" action="set" />
<assign property="callrequest.voiture.plaque" value="context.plaqueGen" action="set" />
<assign property="callrequest.voiture.couleur" value="request.couleur" action="set" />
</request>
<response type='msg.commandeVoitureRpse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
<if name='Is Voiture Created' condition='context.isOk="OK"' xpos='470' ypos='800' xend='470' yend='1050' >
<true>
<call name='Create File' target='File' async='1' xpos='740' ypos='950' >
<request type='msg.pushVoitureFileDmde' >
<assign property="callrequest.voiture" value="context.wsVoiture" action="set" />
<assign property="callrequest.voiture.couleur" value="request.couleur" action="set" />
</request>
<response type='msg.pushVoitureFileRpse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</true>
<false>
<alert name='Voiture not created' value='"Voiture not created"' xpos='470' ypos='950' />
</false>
</if>
</true>
<false>
<alert name='Not in Catalogue' value='"Not in Catalogue"' xpos='200' ypos='500' />
</false>
</if>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
