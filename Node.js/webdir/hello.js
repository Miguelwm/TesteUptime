#!/usr/bin/env nodejs

  // console.log(websites.site[0][1]);
  // console.log("length servidores: "+websites.site.length);

var http = require('http');
var request = require('request');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Script esta a ser executado\n');
}).listen(8080, 'localhost');
console.log('Server running at http://localhost:8080/');


var servidor="thor";
var websites;
request('http://localhost:3000/json/'+servidor+'.json', function (error, response, body) {
  if(body!=undefined) {
    websites = JSON.parse(body);
    zTeste();
    } else {console.log("servidor ausente");}
  var iTeste = setInterval(zTeste, 50*1000);
  var iVerificar = setInterval(zVerificar, 10*1000);
});


var status = new Array();

function zTeste() {

  for(i=0;i<websites.site.length;i++) {
    zRequest(i,websites.site[i][1]);
  }

}

function zRequest(id,url) {
    request(websites.site[id][1], function (error, response, body) {
      if(response!=undefined) {
        if(response.statusCode==200)  {
          status[id]="OK";
        }
      } else {status[id]="FAIL";}
    });
}

function zVerificar() {

  var ok="";
  var fail="";
  var na="";


  console.log("***************************************");
  if(websites!=undefined) {
    for(i=0;i<websites.site.length;i++) {
      console.log("* Estado site Numero: "+websites.site[i][0]+" ("+websites.site[i][1]+") - "+status[i]+"\n");
      if(status[i]=="OK") {
        ok+=websites.site[i][0]+"-";
      } else if(status[i]=="FAIL") {
        fail+=websites.site[i][0]+"-";
      } else {
        na+=websites.site[i][0]+"-";
      }
    }
  }
  console.log("***************************************");
  console.log("ok: "+ok+"\nfail: "+fail+"\nna: "+na);
  console.log(" ");
  console.log(" ");

  if(ok!="") {zDarResposta(ok,"ok");}
  if(fail!="") {zDarResposta(fail,"fail");}
  if(na!="") {zDarResposta(na,"na");}

  request('http://localhost:3000/json/'+servidor+'.json', function (error, response, body) {
  if(body!=undefined) {
    websites = JSON.parse(body);
    zTeste();
    } else {console.log("servidor ausente");}
  });
}


function zDarResposta(id,caso) {

  switch(caso) {
    case "ok":
      request("http://localhost:3000/ok/"+id, function (error, response, body) {});
      break;
    case "fail":
      request("http://localhost:3000/fail/"+id, function (error, response, body) {});
      break;
    case "na":
      request("http://localhost:3000/na/"+id, function (error, response, body) {});
      break;
    default:
      console.log("*************");
      console.log("*************");
      console.log("*************");
      console.log("FAIL NO SWITCH ");
      console.log("*************");
      console.log("*************");
      console.log("*************");
  }

}
