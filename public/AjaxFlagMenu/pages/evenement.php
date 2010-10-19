<?php
$div='<script language="JavaScript" type="text/javascript" >
	  $(".area").corner("4px;");
	  </script>
	  <div  class="area" >
	  <h2>Evenement.</h2>
	  async (booléen): par défault, toutes les requêtes sont asynchrones (ce paramètres vaut true par défaut). Si vous avez besoin de requêtes synchrones, passez cette fonction à false. A nter que les requêtes synchrones bloque temporairement le naviguateur de l\'utilisateur tant que la requête n\'est pas terminée.
beforeSend (fonction): un pre-callback permettant de modifier l\'objet XMLHttpRequest avant qu\'il soit envoyé. A utiliser pour envoyer des entêtes personnalisés par exemple etc. Seul l\'objet XMLHttpRequest est passé en argument de cette fonction.
complete (fonction): fonction à appeler lorsque la requête se termine (après que les callbakcs de succès et d\'erreurs soient éxécutés). La fonction dispose de deux arguments: l\'objet XMLHttpRequest et une chaine de caractère décrivant le type de succès de la requête.
contentType (String): Quand vous envoyez des données au serveur, utilisez ce paramètre. Par défaut, il vaut "application/x-www-form-urlencoded", ce qui correspond dans la plupart des cas.
data (objet|string): Donnée à envoyer au serveur. Elle est converti en String, si elle ne l\'est pas déja. Consultez l\'option processData pour empêcher teh processus automatique. L\'objet doit être formée de paires de la forme clé/valeur. Si la valeur est un tableau, jQuery serialise les dofférentes données du tableau avec la même clé. Par exemple: {foo:["bar1", "bar2"]} devient \'&foo=bar1&foo=bar2\'. Ce paramètre n\'est pas nécéssaire pour les requêtes utilisant le paramètre GET.
dataType (string): format des données qui seront renvoyées du serveur. Si aucune type n\'est spécifié, jQuery utilisera le type MIME pour déterminer le format adéquat: responseXMl ou ResponseText. Voici la liste des types disponibles:
"xml": retourne un document XML qui pourra être traité par jQuery.
"html": retourne du code HTML au format texte, inclus l\'évaluation des script tags.
"script": évalue la réponse en Javascript et retourne cette dernière au format texte.
"json": évalue la réponse en JSON et retourne un objet Javascript.
error (fonction): Fonction à appeler si la requête échoue. La fonction dispose de trois arguments: l\'objet XMLHttpRequest, une chaine de caractère décrivant le type d\'erreur rencontré, et un objet d\'exception, dans la cas ou ce dernier a été généré.
global (booléen): permet le déclenchement du gestionnaire d\'évènement global de AJAX. Par défaut, il vaut true. Passez false à cette option si vous voulez empêcher les déclenchementd d\'évènements de type ajaxStart ou ajaxStop.
ifModified (booléen): la requête se termine avec succès seulement si les données retournées sont différentes de la dernière requête. Les entêtes sont utilisés pour cette opération. Par défaut, cette option vaut "false".
processData (booléen): permet de ne pas passer en chaine de caractère les données passée à l\'option "data". Si vous souhaitez envoyer des documents DOM, ou d\'autres données non traitables, passez cette option à false.
success (fonction): Fonction à appeler si la requête s\'éxécute avec succès. Un seul argument est passé en paramètre: les données retournées par le serveur, format suivant le format défini par l\'option "dataType".
timeout (entier): spécifie un timeout local en millisecondes pour la requête. Ce timeout prendra le pas sur le timeout global (défini par la fonction $.ajaxTimeout()) pour la requête.
type (string): type de la requête (GET ou POST), par défaut, vaut GET. D\'autres méthodes d\'envoi HTTP peuvent être utilisées, comme PUT ou DELETE, mais celles-ci ne sont pas supportées par tous les naviguateurs.
url (string): URL de la requête.
	  </div>';

echo $div;
?>