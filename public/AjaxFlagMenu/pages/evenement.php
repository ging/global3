<script language="JavaScript" type="text/javascript" >
	  $(".area").corner("4px;");
	  </script>
	  <div  class="area" >
	  <h2>Evenement.</h2>
	  async (bool�en): par d�fault, toutes les requ�tes sont asynchrones (ce param�tres vaut true par d�faut). Si vous avez besoin de requ�tes synchrones, passez cette fonction � false. A nter que les requ�tes synchrones bloque temporairement le naviguateur de l\'utilisateur tant que la requ�te n\'est pas termin�e.
beforeSend (fonction): un pre-callback permettant de modifier l\'objet XMLHttpRequest avant qu\'il soit envoy�. A utiliser pour envoyer des ent�tes personnalis�s par exemple etc. Seul l\'objet XMLHttpRequest est pass� en argument de cette fonction.
complete (fonction): fonction � appeler lorsque la requ�te se termine (apr�s que les callbakcs de succ�s et d\'erreurs soient �x�cut�s). La fonction dispose de deux arguments: l\'objet XMLHttpRequest et une chaine de caract�re d�crivant le type de succ�s de la requ�te.
contentType (String): Quand vous envoyez des donn�es au serveur, utilisez ce param�tre. Par d�faut, il vaut "application/x-www-form-urlencoded", ce qui correspond dans la plupart des cas.
data (objet|string): Donn�e � envoyer au serveur. Elle est converti en String, si elle ne l\'est pas d�ja. Consultez l\'option processData pour emp�cher teh processus automatique. L\'objet doit �tre form�e de paires de la forme cl�/valeur. Si la valeur est un tableau, jQuery serialise les doff�rentes donn�es du tableau avec la m�me cl�. Par exemple: {foo:["bar1", "bar2"]} devient \'&foo=bar1&foo=bar2\'. Ce param�tre n\'est pas n�c�ssaire pour les requ�tes utilisant le param�tre GET.
dataType (string): format des donn�es qui seront renvoy�es du serveur. Si aucune type n\'est sp�cifi�, jQuery utilisera le type MIME pour d�terminer le format ad�quat: responseXMl ou ResponseText. Voici la liste des types disponibles:
"xml": retourne un document XML qui pourra �tre trait� par jQuery.
"html": retourne du code HTML au format texte, inclus l\'�valuation des script tags.
"script": �value la r�ponse en Javascript et retourne cette derni�re au format texte.
"json": �value la r�ponse en JSON et retourne un objet Javascript.
error (fonction): Fonction � appeler si la requ�te �choue. La fonction dispose de trois arguments: l\'objet XMLHttpRequest, une chaine de caract�re d�crivant le type d\'erreur rencontr�, et un objet d\'exception, dans la cas ou ce dernier a �t� g�n�r�.
global (bool�en): permet le d�clenchement du gestionnaire d\'�v�nement global de AJAX. Par d�faut, il vaut true. Passez false � cette option si vous voulez emp�cher les d�clenchementd d\'�v�nements de type ajaxStart ou ajaxStop.
ifModified (bool�en): la requ�te se termine avec succ�s seulement si les donn�es retourn�es sont diff�rentes de la derni�re requ�te. Les ent�tes sont utilis�s pour cette op�ration. Par d�faut, cette option vaut "false".
processData (bool�en): permet de ne pas passer en chaine de caract�re les donn�es pass�e � l\'option "data". Si vous souhaitez envoyer des documents DOM, ou d\'autres donn�es non traitables, passez cette option � false.
success (fonction): Fonction � appeler si la requ�te s\'�x�cute avec succ�s. Un seul argument est pass� en param�tre: les donn�es retourn�es par le serveur, format suivant le format d�fini par l\'option "dataType".
timeout (entier): sp�cifie un timeout local en millisecondes pour la requ�te. Ce timeout prendra le pas sur le timeout global (d�fini par la fonction $.ajaxTimeout()) pour la requ�te.
type (string): type de la requ�te (GET ou POST), par d�faut, vaut GET. D\'autres m�thodes d\'envoi HTTP peuvent �tre utilis�es, comme PUT ou DELETE, mais celles-ci ne sont pas support�es par tous les naviguateurs.
url (string): URL de la requ�te.
	  </div>

