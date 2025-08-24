var myURL = _url;
var okDomains = [];
var okayToPlay = false;
okDomains.push("www.papalouie.com");
okDomains.push("papalouie.com");
okDomains.push("www.coolmathgames.com");
okDomains.push("coolmathgames.com");
var i = 0;
while(i < okDomains.length)
{
   var allowed_site = okDomains[i].toLowerCase();
   var domain = myURL.split("/")[2].toLowerCase();
   var domain_idx = domain.indexOf(allowed_site);
   trace("domain: " + domain + ", full url: " + myURL);
   if(domain_idx != -1 && domain_idx == domain.length - allowed_site.length)
   {
      trace("OK");
      okayToPlay = true;
      break;
   }
   if(domain == "" && (myURL.indexOf("file:///L|/Games/") == 0 || myURL.indexOf("file:///L:/Games/") == 0))
   {
      trace("LOCAL");
      okayToPlay = true;
      break;
   }
   i++;
}
if(!okayToPlay)
{
   _root.gotoAndStop("theft");
}
