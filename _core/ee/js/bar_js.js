/***********************************************
* Cool DHTML tooltip script- © Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
***********************************************/
var tm1 = 0;
var offsetxpoint=2 //Customize x offset of tooltip
var offsetypoint=2 //Customize y offset of tooltip
var ie=document.all
var ns6=document.getElementById && !document.all
var enabletip=false
var tooltip_displayed;
var confirm_del_msg='Are you sure you want to delete ?';

if (ie||ns6)
var tipobj2=document.all? document.all["dhtmltooltip2"] : document.getElementById? document.getElementById("dhtmltooltip2") : ""

function ietruebody(){
return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body
}

function ddrivetip(thetext, thecolor, thewidth){
tooltip_displayed = false;
if (ns6||ie){
if (typeof thewidth!="undefined") tipobj2.style.width=thewidth+"px"
if (typeof thecolor!="undefined" && thecolor!="") tipobj2.style.backgroundColor=thecolor
tipobj2.innerHTML=thetext
enabletip=true

//if user define his width skip this code
if(typeof thewidth=="undefined") {
	//check if width of block is not bigger than scree width
	var maxWidth = ((document.all)?document.body.clientWidth-100:window.outerWidth-100);
	if(tipobj2.offsetWidth > maxWidth) {
		//subtract padding for transitional browser mode
		tipobj2.style.width = maxWidth-6;
	} else {
		tipobj2.style.width = tipobj2.offsetWidth-6;
	}
}

return false
}
}

function positiontip(e){
if (!tooltip_displayed) {
tooltip_displayed = true;
if (enabletip){
var curX=(ns6)?e.pageX : event.x+ietruebody().scrollLeft;
var curY=(ns6)?e.pageY : event.y+ietruebody().scrollTop;
if(ie){
curX = event.clientX+ietruebody().scrollLeft;
curY = event.clientY+ietruebody().scrollTop;
}
//Find out how close the mouse is to the corner of the window
var rightedge=ie&&!window.opera? ietruebody().clientWidth-event.clientX-offsetxpoint : window.innerWidth-e.clientX-offsetxpoint-20
var bottomedge=ie&&!window.opera? ietruebody().clientHeight-event.clientY-offsetypoint : window.innerHeight-e.clientY-offsetypoint-20

var leftedge=(offsetxpoint<0)? offsetxpoint*(-1) : -1000

//if the horizontal distance isn't enough to accomodate the width of the context menu
if (rightedge<tipobj2.offsetWidth)
//move the horizontal position of the menu to the left by it's width
tipobj2.style.left=ie? ietruebody().scrollLeft+event.clientX-tipobj2.offsetWidth+"px" : window.pageXOffset+e.clientX-tipobj2.offsetWidth+"px"
else if (curX<leftedge)
tipobj2.style.left="5px"
else
//position the horizontal position of the menu where the mouse is positioned
tipobj2.style.left=curX+offsetxpoint+"px"

//same concept with the vertical position
if (bottomedge<tipobj2.offsetHeight)
tipobj2.style.top=ie? ietruebody().scrollTop+event.clientY-tipobj2.offsetHeight-offsetypoint+"px" : window.pageYOffset+e.clientY-tipobj2.offsetHeight-offsetypoint+"px"
else
tipobj2.style.top=curY+offsetypoint+"px"
tipobj2.style.visibility="visible"
}
}
}

function hideddrivetip(){
if (ns6||ie){
tooltip_displayed = true;
enabletip=false
tipobj2.style.visibility="hidden"
tipobj2.style.left="-1000px"
tipobj2.style.backgroundColor=''
tipobj2.style.width=''
}
}
document.onmousemove=positiontip