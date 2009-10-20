I;21;Foundation/CPObject.jI;22;Foundation/CPRunLoop.ji;9;CPEvent.ji;17;CPCompatibility.ji;18;CPDOMWindowLayer.ji;18;CPPlatformWindow.jc;23197;
var _1="dblclick",_2="mousedown",_3="mouseup",_4="mousemove",_5="mousedrag",_6="keyup",_7="keydown",_8="keypress",_9="copy",_a="paste",_b="resize",_c="mousewheel",_d="touchstart",_e="touchmove",_f="touchend",_10="touchcancel";
var _11=[];
_11["INPUT"]=YES;
_11["SELECT"]=YES;
_11["TEXTAREA"]=YES;
_11["OPTION"]=YES;
var _12,_13;
var _14={},_15={},_16={"8":1,"9":1,"16":1,"37":1,"38":1,"39":1,"40":1,"46":1,"33":1,"34":1};
var _17=17;
var _18=objj_getClass("CPPlatformWindow");
if(!_18){
objj_exception_throw(new objj_exception(OBJJClassNotFoundException,"*** Could not find definition for class \"CPPlatformWindow\""));
}
var _19=_18.isa;
class_addMethods(_18,[new objj_method(sel_getUid("_init"),function(_1a,_1b){
with(_1a){
_1a=objj_msgSendSuper({receiver:_1a,super_class:objj_getClass("CPObject")},"init");
if(_1a){
_DOMWindow=window;
_contentRect={origin:{x:0,y:0},size:{width:0,height:0}};
_windowLevels=[];
_windowLayers=objj_msgSend(CPDictionary,"dictionary");
objj_msgSend(_1a,"registerDOMWindow");
objj_msgSend(_1a,"updateFromNativeContentRect");
_charCodes={};
}
return _1a;
}
}),new objj_method(sel_getUid("nativeContentRect"),function(_1c,_1d){
with(_1c){
if(!_DOMWindow){
return objj_msgSend(_1c,"contentRect");
}
if(_DOMWindow.cpFrame){
return _DOMWindow.cpFrame();
}
var _1e={origin:{x:0,y:0},size:{width:0,height:0}};
if(window.screenTop){
_1e.origin={x:_DOMWindow.screenLeft,y:_DOMWindow.screenTop};
}else{
if(window.screenX){
_1e.origin={x:_DOMWindow.screenX,y:_DOMWindow.screenY};
}
}
if(_DOMWindow.innerWidth){
_1e.size={width:_DOMWindow.innerWidth,height:_DOMWindow.innerHeight};
}else{
if(document.documentElement&&document.documentElement.clientWidth){
_1e.size={width:_DOMWindow.document.documentElement.clientWidth,height:_DOMWindow.document.documentElement.clientHeight};
}else{
_1e.size={width:_DOMWindow.document.body.clientWidth,height:_DOMWindow.document.body.clientHeight};
}
}
return _1e;
}
}),new objj_method(sel_getUid("updateNativeContentRect"),function(_1f,_20){
with(_1f){
if(!_DOMWindow){
return;
}
if(typeof _DOMWindow["cpSetFrame"]==="function"){
return _DOMWindow.cpSetFrame(objj_msgSend(_1f,"contentRect"));
}
var _21=objj_msgSend(_1f,"contentRect").origin,_22=objj_msgSend(_1f,"nativeContentRect").origin;
_DOMWindow.moveBy(_21.x-_22.x,_21.y-_22.y);
var _23=objj_msgSend(_1f,"contentRect").size,_24=objj_msgSend(_1f,"nativeContentRect").size;
_DOMWindow.resizeBy(_23.width-_24.width,_23.height-_24.height);
}
}),new objj_method(sel_getUid("orderBack:"),function(_25,_26,_27){
with(_25){
if(_DOMWindow){
_DOMWindow.blur();
}
}
}),new objj_method(sel_getUid("registerDOMWindow"),function(_28,_29){
with(_28){
var _2a=_DOMWindow.document;
_DOMBodyElement=_2a.getElementsByTagName("body")[0];
if(objj_msgSend(CPPlatform,"supportsDragAndDrop")){
_DOMBodyElement.style["-khtml-user-select"]="none";
}
_DOMBodyElement.webkitTouchCallout="none";
_DOMFocusElement=_2a.createElement("input");
_DOMFocusElement.style.position="absolute";
_DOMFocusElement.style.zIndex="-1000";
_DOMFocusElement.style.opacity="0";
_DOMFocusElement.style.filter="alpha(opacity=0)";
_DOMBodyElement.appendChild(_DOMFocusElement);
_DOMPasteboardElement=_2a.createElement("input");
_DOMPasteboardElement.style.position="absolute";
_DOMPasteboardElement.style.top="-10000px";
_DOMPasteboardElement.style.zIndex="99";
_DOMBodyElement.appendChild(_DOMPasteboardElement);
_DOMPasteboardElement.blur();
var _2b=objj_msgSend(_28,"class"),_2c=class_getMethodImplementation(_2b,sel_getUid("dragEvent:")),_2d=function(_2e){
_2c(_28,nil,_2e);
},_2f=sel_getUid("resizeEvent:"),_30=class_getMethodImplementation(_2b,_2f),_31=function(_32){
_30(_28,nil,_32);
},_33=sel_getUid("keyEvent:"),_34=class_getMethodImplementation(_2b,_33),_35=function(_36){
_34(_28,nil,_36);
},_37=sel_getUid("mouseEvent:"),_38=class_getMethodImplementation(_2b,_37),_39=function(_3a){
_38(_28,nil,_3a);
},_3b=sel_getUid("scrollEvent:"),_3c=class_getMethodImplementation(_2b,_3b),_3d=function(_3e){
_3c(_28,nil,_3e);
},_3f=sel_getUid("touchEvent:"),_40=class_getMethodImplementation(_2b,_3f),_41=function(_42){
_40(_28,nil,_42);
};
if(_2a.addEventListener){
if(objj_msgSend(CPPlatform,"supportsDragAndDrop")){
_2a.addEventListener("dragstart",_2d,NO);
_2a.addEventListener("drag",_2d,NO);
_2a.addEventListener("dragend",_2d,NO);
_2a.addEventListener("dragover",_2d,NO);
_2a.addEventListener("dragleave",_2d,NO);
_2a.addEventListener("drop",_2d,NO);
}
_2a.addEventListener("mouseup",_39,NO);
_2a.addEventListener("mousedown",_39,NO);
_2a.addEventListener("mousemove",_39,NO);
_2a.addEventListener("keyup",_35,NO);
_2a.addEventListener("keydown",_35,NO);
_2a.addEventListener("keypress",_35,NO);
_2a.addEventListener("touchstart",_41,NO);
_2a.addEventListener("touchend",_41,NO);
_2a.addEventListener("touchmove",_41,NO);
_2a.addEventListener("touchcancel",_41,NO);
_DOMWindow.addEventListener("DOMMouseScroll",_3d,NO);
_DOMWindow.addEventListener("mousewheel",_3d,NO);
_DOMWindow.addEventListener("resize",_31,NO);
_DOMWindow.addEventListener("unload",function(){
objj_msgSend(_28,"updateFromNativeContentRect");
_2a.removeEventListener("mouseup",_39,NO);
_2a.removeEventListener("mousedown",_39,NO);
_2a.removeEventListener("mousemove",_39,NO);
_2a.removeEventListener("keyup",_35,NO);
_2a.removeEventListener("keydown",_35,NO);
_2a.removeEventListener("keypress",_35,NO);
_2a.removeEventListener("touchstart",_41,NO);
_2a.removeEventListener("touchend",_41,NO);
_2a.removeEventListener("touchmove",_41,NO);
_DOMWindow.removeEventListener("resize",_31,NO);
_DOMWindow.removeEventListener("DOMMouseScroll",_3d,NO);
_DOMWindow.removeEventListener("mousewheel",_3d,NO);
_28._DOMWindow=nil;
},NO);
}else{
_2a.attachEvent("onmouseup",_39);
_2a.attachEvent("onmousedown",_39);
_2a.attachEvent("onmousemove",_39);
_2a.attachEvent("ondblclick",_39);
_2a.attachEvent("onkeyup",_35);
_2a.attachEvent("onkeydown",_35);
_2a.attachEvent("onkeypress",_35);
_DOMWindow.attachEvent("onresize",_31);
_DOMWindow.onmousewheel=_3d;
_2a.onmousewheel=_3d;
_2a.body.ondrag=function(){
return NO;
};
_2a.body.onselectstart=function(){
return _DOMWindow.event.srcElement===_DOMPasteboardElement;
};
_DOMWindow.attachEvent("onbeforeunload",function(){
objj_msgSend(_28,"updateFromNativeContentRect");
_2a.removeEvent("onmouseup",_39);
_2a.removeEvent("onmousedown",_39);
_2a.removeEvent("onmousemove",_39);
_2a.removeEvent("ondblclick",_39);
_2a.removeEvent("onkeyup",_35);
_2a.removeEvent("onkeydown",_35);
_2a.removeEvent("onkeypress",_35);
_DOMWindow.removeEvent("onresize",_31);
_DOMWindow.onmousewheel=NULL;
_2a.onmousewheel=NULL;
_2a.body.ondrag=NULL;
_2a.body.onselectstart=NULL;
_28._DOMWindow=nil;
},NO);
}
}
}),new objj_method(sel_getUid("orderFront:"),function(_43,_44,_45){
with(_43){
if(_DOMWindow){
return _DOMWindow.focus();
}
_DOMWindow=window.open("","_blank","menubar=no,location=no,resizable=yes,scrollbars=no,status=no,left="+(_contentRect.origin.x)+",top="+(_contentRect.origin.y)+",width="+(_contentRect.size.width)+",height="+(_contentRect.size.height));
_DOMWindow.document.write("<html><head></head><body style = 'background-color:transparent;'></body></html>");
_DOMWindow.document.close();
if(!objj_msgSend(CPPlatform,"isBrowser")){
_DOMWindow.cpSetLevel(_level);
_DOMWindow.cpSetHasShadow(_hasShadow);
}
objj_msgSend(_43,"registerDOMWindow");
}
}),new objj_method(sel_getUid("orderOut:"),function(_46,_47,_48){
with(_46){
if(!_DOMWindow){
return;
}
_DOMWindow.close();
}
}),new objj_method(sel_getUid("dragEvent:"),function(_49,_4a,_4b){
with(_49){
var _4c=_4b.type,_4d=objj_msgSend(CPDragServer,"sharedDragServer"),_4e={x:_4b.clientX,y:_4b.clientY},_4f=objj_msgSend(_CPDOMDataTransferPasteboard,"DOMDataTransferPasteboard");
objj_msgSend(_4f,"_setDataTransfer:",_4b.dataTransfer);
if(_4b.type==="dragstart"){
objj_msgSend(objj_msgSend(CPRunLoop,"currentRunLoop"),"limitDateForMode:",CPDefaultRunLoopMode);
objj_msgSend(_4f,"_setPasteboard:",objj_msgSend(_4d,"draggingPasteboard"));
var _50=objj_msgSend(_4d,"draggedWindow"),_51=objj_msgSend(_50,"frame"),_52=_50._DOMElement;
_52.style.left=-(_51.size.width)+"px";
_52.style.top=-(_51.size.height)+"px";
document.getElementsByTagName("body")[0].appendChild(_52);
var _53=objj_msgSend(_4d,"draggingOffset");
_4b.dataTransfer.setDragImage(_52,_53.width,_53.height);
objj_msgSend(_4d,"draggingStartedInPlatformWindow:globalLocation:",_49,objj_msgSend(CPPlatform,"isBrowser")?_4e:{x:_4b.screenX,y:_4b.screenY});
}else{
if(_4c==="drag"){
objj_msgSend(_4d,"draggingSourceUpdatedWithGlobalLocation:",objj_msgSend(CPPlatform,"isBrowser")?_4e:{x:_4b.screenX,y:_4b.screenY});
}else{
if(_4c==="dragover"||_4c==="dragleave"){
if(_4b.preventDefault){
_4b.preventDefault();
}
var _54="none",_55=objj_msgSend(_4d,"draggingUpdatedInPlatformWindow:location:",_49,_4e);
if(_55===CPDragOperationMove||_55===CPDragOperationGeneric||_55===CPDragOperationPrivate){
_54="move";
}else{
if(_55===CPDragOperationCopy){
_54="copy";
}else{
if(_55===CPDragOperationLink){
_54="link";
}
}
}
_4b.dataTransfer.dropEffect=_54;
}else{
if(_4c==="dragend"){
objj_msgSend(_4d,"draggingEndedInPlatformWindow:globalLocation:",_49,objj_msgSend(CPPlatform,"isBrowser")?_4e:{x:_4b.screenX,y:_4b.screenY});
}else{
objj_msgSend(_4d,"performDragOperationInPlatformWindow:",_49);
if(_4b.preventDefault){
_4b.preventDefault();
}
if(_4b.stopPropagation){
_4b.stopPropagation();
}
}
}
}
}
objj_msgSend(objj_msgSend(CPRunLoop,"currentRunLoop"),"limitDateForMode:",CPDefaultRunLoopMode);
}
}),new objj_method(sel_getUid("keyEvent:"),function(_56,_57,_58){
with(_56){
var _59,_5a=_58.timeStamp?_58.timeStamp:new Date(),_5b=(_58.target||_58.srcElement),_5c=objj_msgSend(objj_msgSend(CPApp,"keyWindow"),"windowNumber"),_5d=(_58.shiftKey?CPShiftKeyMask:0)|(_58.ctrlKey?CPControlKeyMask:0)|(_58.altKey?CPAlternateKeyMask:0)|(_58.metaKey?CPCommandKeyMask:0);
if(_11[_5b.tagName]&&_5b!=_DOMFocusElement&&_5b!=_DOMPasteboardElement){
return;
}
StopDOMEventPropagation=!(_5d&(CPControlKeyMask|CPCommandKeyMask))||_15[String.fromCharCode(_58.keyCode||_58.charCode).toLowerCase()]||_14[_58.keyCode];
var _5e=NO,_5f=NO;
switch(_58.type){
case "keydown":
_keyCode=_58.keyCode;
var _60=String.fromCharCode(_keyCode).toLowerCase();
if(_60=="v"&&(_5d&CPPlatformActionKeyMask)){
_DOMPasteboardElement.select();
_DOMPasteboardElement.value="";
_5e=YES;
}else{
if((_60=="c"||_60=="x")&&(_5d&CPPlatformActionKeyMask)){
_5f=YES;
}else{
if(!CPFeatureIsCompatible(CPJavascriptRemedialKeySupport)){
return;
}else{
if(!_16[_keyCode]&&(_keyCode==_17||!(_5d&CPControlKeyMask))){
return;
}
}
}
}
case "keypress":
if((_58.target||_58.srcElement)==_DOMPasteboardElement){
return;
}
var _61=_keyCode,_62=_58.keyCode||_58.charCode,_63=(_charCodes[_61]!=nil);
_charCodes[_61]=_62;
var _60=String.fromCharCode(_62),_64=_60.toLowerCase();
_59=objj_msgSend(CPEvent,"keyEventWithType:location:modifierFlags:timestamp:windowNumber:context:characters:charactersIgnoringModifiers:isARepeat:keyCode:",CPKeyDown,location,_5d,_5a,_5c,nil,_60,_64,_63,_61);
if(_5e){
_pasteboardKeyDownEvent=_59;
window.setNativeTimeout(function(){
objj_msgSend(_56,"_checkPasteboardElement");
},0);
return;
}
break;
case "keyup":
var _61=_58.keyCode,_62=_charCodes[_61];
_charCodes[_61]=nil;
var _60=String.fromCharCode(_62),_64=_60.toLowerCase();
if(!(_5d&CPShiftKeyMask)){
_60=_64;
}
_59=objj_msgSend(CPEvent,"keyEventWithType:location:modifierFlags:timestamp:windowNumber:context:characters:charactersIgnoringModifiers:isARepeat:keyCode:",CPKeyUp,location,_5d,_5a,_5c,nil,_60,_64,NO,_61);
break;
}
if(_59){
_59._DOMEvent=_58;
objj_msgSend(CPApp,"sendEvent:",_59);
if(_5f){
var _65=objj_msgSend(CPPasteboard,"generalPasteboard"),_66=objj_msgSend(_65,"types");
if(_66.length){
if(objj_msgSend(_66,"indexOfObjectIdenticalTo:",CPStringPboardType)!=CPNotFound){
_DOMPasteboardElement.value=objj_msgSend(_65,"stringForType:",CPStringPboardType);
}else{
_DOMPasteboardElement.value=objj_msgSend(_65,"_generateStateUID");
}
_DOMPasteboardElement.select();
window.setNativeTimeout(function(){
objj_msgSend(_56,"_clearPasteboardElement");
},0);
}
return;
}
}
if(StopDOMEventPropagation){
_13(_58,_56);
}
objj_msgSend(objj_msgSend(CPRunLoop,"currentRunLoop"),"limitDateForMode:",CPDefaultRunLoopMode);
}
}),new objj_method(sel_getUid("scrollEvent:"),function(_67,_68,_69){
with(_67){
if(!_69){
_69=window.event;
}
if(CPFeatureIsCompatible(CPJavaScriptMouseWheelValues_8_15)){
var x=0,y=0,_6c=_69.target;
while(_6c.nodeType!==1){
_6c=_6c.parentNode;
}
if(_6c.offsetParent){
do{
x+=_6c.offsetLeft;
y+=_6c.offsetTop;
}while(_6c=_6c.offsetParent);
}
var _6d={x:(x+((_69.clientX-8)/15)),y:(y+((_69.clientY-8)/15))};
}else{
var _6d={x:_69.clientX,y:_69.clientY};
}
var _6e=0,_6f=0,_70=0,_71=_69.timeStamp?_69.timeStamp:new Date(),_72=(_69.shiftKey?CPShiftKeyMask:0)|(_69.ctrlKey?CPControlKeyMask:0)|(_69.altKey?CPAlternateKeyMask:0)|(_69.metaKey?CPCommandKeyMask:0);
StopDOMEventPropagation=YES;
var _73=objj_msgSend(_67,"hitTest:",_6d);
if(!_73){
return;
}
var _70=objj_msgSend(_73,"windowNumber");
_6d=objj_msgSend(_73,"convertBridgeToBase:",_6d);
if(typeof _69.wheelDeltaX!="undefined"){
_6e=_69.wheelDeltaX/120;
_6f=_69.wheelDeltaY/120;
}else{
if(_69.wheelDelta){
_6f=_69.wheelDelta/120;
}else{
if(_69.detail){
_6f=-_69.detail/3;
}else{
return;
}
}
}
if(!CPFeatureIsCompatible(CPJavaScriptNegativeMouseWheelValues)){
_6e=-_6e;
_6f=-_6f;
}
var _74=objj_msgSend(CPEvent,"mouseEventWithType:location:modifierFlags:timestamp:windowNumber:context:eventNumber:clickCount:pressure:",CPScrollWheel,_6d,_72,_71,_70,nil,-1,1,0);
_74._DOMEvent=_69;
_74._deltaX=_6e;
_74._deltaY=_6f;
objj_msgSend(CPApp,"sendEvent:",_74);
if(StopDOMEventPropagation){
_13(_69,_67);
}
objj_msgSend(objj_msgSend(CPRunLoop,"currentRunLoop"),"limitDateForMode:",CPDefaultRunLoopMode);
}
}),new objj_method(sel_getUid("resizeEvent:"),function(_75,_76,_77){
with(_75){
var _78=objj_msgSend(_75,"contentRect").size;
objj_msgSend(_75,"updateFromNativeContentRect");
var _79=_windowLevels,_7a=_windowLayers,_7b=_79.length;
while(_7b--){
var _7c=objj_msgSend(_7a,"objectForKey:",_79[_7b])._windows,_7d=_7c.length;
while(_7d--){
objj_msgSend(_7c[_7d],"resizeWithOldPlatformWindowSize:",_78);
}
}
objj_msgSend(objj_msgSend(CPRunLoop,"currentRunLoop"),"limitDateForMode:",CPDefaultRunLoopMode);
}
}),new objj_method(sel_getUid("touchEvent:"),function(_7e,_7f,_80){
with(_7e){
if(_80.touches&&(_80.touches.length==1||(_80.touches.length==0&&_80.changedTouches.length==1))){
var _81={};
switch(_80.type){
case CPDOMEventTouchStart:
_81.type=CPDOMEventMouseDown;
break;
case CPDOMEventTouchEnd:
_81.type=CPDOMEventMouseUp;
break;
case CPDOMEventTouchMove:
_81.type=CPDOMEventMouseMoved;
break;
case CPDOMEventTouchCancel:
_81.type=CPDOMEventMouseUp;
break;
}
var _82=_80.touches.length?_80.touches[0]:_80.changedTouches[0];
_81.clientX=_82.clientX;
_81.clientY=_82.clientY;
_81.timestamp=_80.timestamp;
_81.target=_80.target;
_81.shiftKey=_81.ctrlKey=_81.altKey=_81.metaKey=false;
_81.preventDefault=function(){
if(_80.preventDefault){
_80.preventDefault();
}
};
_81.stopPropagation=function(){
if(_80.stopPropagation){
_80.stopPropagation();
}
};
objj_msgSend(_7e,"_bridgeMouseEvent:",_81);
return;
}else{
if(_80.preventDefault){
_80.preventDefault();
}
if(_80.stopPropagation){
_80.stopPropagation();
}
}
}
}),new objj_method(sel_getUid("mouseEvent:"),function(_83,_84,_85){
with(_83){
var _86=_overriddenEventType||_85.type;
if(_86==="dblclick"){
_overriddenEventType=CPDOMEventMouseDown;
objj_msgSend(_83,"_bridgeMouseEvent:",_85);
_overriddenEventType=CPDOMEventMouseUp;
objj_msgSend(_83,"_bridgeMouseEvent:",_85);
_overriddenEventType=nil;
return;
}
var _87,_88={x:_85.clientX,y:_85.clientY},_89=_85.timeStamp?_85.timeStamp:new Date(),_8a=(_85.target||_85.srcElement),_8b=0,_8c=(_85.shiftKey?CPShiftKeyMask:0)|(_85.ctrlKey?CPControlKeyMask:0)|(_85.altKey?CPAlternateKeyMask:0)|(_85.metaKey?CPCommandKeyMask:0);
StopDOMEventPropagation=YES;
if(_mouseDownWindow){
_8b=objj_msgSend(_mouseDownWindow,"windowNumber");
}else{
var _8d=objj_msgSend(_83,"hitTest:",_88);
if((_85.type===CPDOMEventMouseDown)&&_8d){
_mouseDownWindow=_8d;
}
_8b=objj_msgSend(_8d,"windowNumber");
}
if(_8b){
_88=objj_msgSend(CPApp._windows[_8b],"convertPlatformWindowToBase:",_88);
}
if(_86==="mouseup"){
if(_mouseIsDown){
_87=_8e(_85,CPLeftMouseUp,_88,_8c,_89,_8b,nil,-1,_12(_lastMouseUp,_89,_88),0);
_mouseIsDown=NO;
_lastMouseUp=_87;
_mouseDownWindow=nil;
}
if(_DOMEventMode){
_DOMEventMode=NO;
return;
}
}else{
if(_86==="mousedown"){
if(_11[_8a.tagName]&&_8a!=_DOMFocusElement){
if(objj_msgSend(CPPlatform,"supportsDragAndDrop")){
_DOMBodyElement.setAttribute("draggable","false");
_DOMBodyElement.style["-khtml-user-drag"]="none";
}
_DOMEventMode=YES;
_mouseIsDown=YES;
objj_msgSend(CPApp,"sendEvent:",objj_msgSend(CPEvent,"mouseEventWithType:location:modifierFlags:timestamp:windowNumber:context:eventNumber:clickCount:pressure:",CPLeftMouseDown,_88,_8c,_89,_8b,nil,-1,_12(_lastMouseDown,_89,_88),0));
objj_msgSend(CPApp,"sendEvent:",objj_msgSend(CPEvent,"mouseEventWithType:location:modifierFlags:timestamp:windowNumber:context:eventNumber:clickCount:pressure:",CPLeftMouseUp,_88,_8c,_89,_8b,nil,-1,_12(_lastMouseDown,_89,_88),0));
return;
}else{
if(objj_msgSend(CPPlatform,"supportsDragAndDrop")){
_DOMBodyElement.setAttribute("draggable","true");
_DOMBodyElement.style["-khtml-user-drag"]="element";
}
}
_87=_8e(_85,CPLeftMouseDown,_88,_8c,_89,_8b,nil,-1,_12(_lastMouseDown,_89,_88),0);
_mouseIsDown=YES;
_lastMouseDown=_87;
}else{
if(_DOMEventMode){
return;
}
_87=_8e(_85,_mouseIsDown?CPLeftMouseDragged:CPMouseMoved,_88,_8c,_89,_8b,nil,-1,1,0);
}
}
if(_87){
_87._DOMEvent=_85;
objj_msgSend(CPApp,"sendEvent:",_87);
}
if(StopDOMEventPropagation&&(!objj_msgSend(CPPlatform,"supportsDragAndDrop")||_86!=="mousedown"&&!objj_msgSend(objj_msgSend(CPDragServer,"sharedDragServer"),"isDragging"))){
_13(_85,_83);
}
objj_msgSend(objj_msgSend(CPRunLoop,"currentRunLoop"),"limitDateForMode:",CPDefaultRunLoopMode);
}
}),new objj_method(sel_getUid("layerAtLevel:create:"),function(_8f,_90,_91,_92){
with(_8f){
var _93=objj_msgSend(_windowLayers,"objectForKey:",_91);
if(!_93&&_92){
_93=objj_msgSend(objj_msgSend(CPDOMWindowLayer,"alloc"),"initWithLevel:",_91);
objj_msgSend(_windowLayers,"setObject:forKey:",_93,_91);
var low=0,_95=_windowLevels.length-1,_96;
while(low<=_95){
_96=FLOOR((low+_95)/2);
if(_windowLevels[_96]>_91){
_95=_96-1;
}else{
low=_96+1;
}
}
objj_msgSend(_windowLevels,"insertObject:atIndex:",_91,_windowLevels[_96]>_91?_96:_96+1);
_93._DOMElement.style.zIndex=_91;
_DOMBodyElement.appendChild(_93._DOMElement);
}
return _93;
}
}),new objj_method(sel_getUid("order:window:relativeTo:"),function(_97,_98,_99,_9a,_9b){
with(_97){
var _9c=objj_msgSend(_97,"layerAtLevel:create:",objj_msgSend(_9a,"level"),_99!=CPWindowOut);
if(_99==CPWindowOut){
return objj_msgSend(_9c,"removeWindow:",_9a);
}
objj_msgSend(_9c,"insertWindow:atIndex:",_9a,(_9b?(_99==CPWindowAbove?_9b._index+1:_9b._index):CPNotFound));
}
}),new objj_method(sel_getUid("_dragHitTest:pasteboard:"),function(_9d,_9e,_9f,_a0){
with(_9d){
var _a1=_windowLevels,_a2=_windowLayers,_a3=_a1.length;
while(_a3--){
if(_a1[_a3]>=CPDraggingWindowLevel){
continue;
}
var _a4=objj_msgSend(_a2,"objectForKey:",_a1[_a3])._windows,_a5=_a4.length;
while(_a5--){
var _a6=_a4[_a5];
if(objj_msgSend(_a6,"_sharesChromeWithPlatformWindow")){
return objj_msgSend(_a6,"_dragHitTest:pasteboard:",_9f,_a0);
}
if(objj_msgSend(_a6,"containsPoint:",_9f)){
return objj_msgSend(_a6,"_dragHitTest:pasteboard:",_9f,_a0);
}
}
}
return nil;
}
}),new objj_method(sel_getUid("_propagateCurrentDOMEvent:"),function(_a7,_a8,_a9){
with(_a7){
StopDOMEventPropagation=!_a9;
}
}),new objj_method(sel_getUid("hitTest:"),function(_aa,_ab,_ac){
with(_aa){
if(_aa._only){
return _aa._only;
}
var _ad=_windowLevels,_ae=_windowLayers,_af=_ad.length,_b0=nil;
while(_af--&&!_b0){
var _b1=objj_msgSend(_ae,"objectForKey:",_ad[_af])._windows,_b2=_b1.length;
while(_b2--&&!_b0){
var _b3=_b1[_b2];
if(!_b3._ignoresMouseEvents&&objj_msgSend(_b3,"containsPoint:",_ac)){
_b0=_b3;
}
}
}
return _b0;
}
}),new objj_method(sel_getUid("_checkPasteboardElement"),function(_b4,_b5){
with(_b4){
var _b6=_DOMPasteboardElement.value;
if(objj_msgSend(_b6,"length")){
var _b7=objj_msgSend(CPPasteboard,"generalPasteboard");
if(objj_msgSend(_b7,"_stateUID")!=_b6){
objj_msgSend(_b7,"declareTypes:owner:",[CPStringPboardType],_b4);
objj_msgSend(_b7,"setString:forType:",_b6,CPStringPboardType);
}
}
objj_msgSend(_b4,"_clearPasteboardElement");
objj_msgSend(CPApp,"sendEvent:",_pasteboardKeyDownEvent);
_pasteboardKeyDownEvent=nil;
objj_msgSend(objj_msgSend(CPRunLoop,"currentRunLoop"),"limitDateForMode:",CPDefaultRunLoopMode);
}
}),new objj_method(sel_getUid("_clearPasteboardElement"),function(_b8,_b9){
with(_b8){
_DOMPasteboardElement.value="";
_DOMPasteboardElement.blur();
}
})]);
class_addMethods(_19,[new objj_method(sel_getUid("preventCharacterKeysFromPropagating:"),function(_ba,_bb,_bc){
with(_ba){
for(var i=_bc.length;i>0;i--){
_15[""+_bc[i-1].toLowerCase()]=YES;
}
}
}),new objj_method(sel_getUid("preventCharacterKeyFromPropagating:"),function(_be,_bf,_c0){
with(_be){
_15[_c0.toLowerCase()]=YES;
}
}),new objj_method(sel_getUid("clearCharacterKeysToPreventFromPropagating"),function(_c1,_c2){
with(_c1){
_15={};
}
}),new objj_method(sel_getUid("preventKeyCodesFromPropagating:"),function(_c3,_c4,_c5){
with(_c3){
for(var i=_c5.length;i>0;i--){
_14[_c5[i-1]]=YES;
}
}
}),new objj_method(sel_getUid("preventKeyCodeFromPropagating:"),function(_c7,_c8,_c9){
with(_c7){
_14[_c9]=YES;
}
}),new objj_method(sel_getUid("clearKeyCodesToPreventFromPropagating"),function(_ca,_cb){
with(_ca){
_14={};
}
})]);
var _cc=objj_msgSend(CPEvent,"class");
var _8e=function(_cd,_ce,_cf,_d0,_d1,_d2,_d3,_d4,_d5,_d6){
_cd.isa=_cc;
_cd._type=_ce;
_cd._location=_cf;
_cd._modifierFlags=_d0;
_cd._timestamp=_d1;
_cd._windowNumber=_d2;
_cd._window=nil;
_cd._context=_d3;
_cd._eventNumber=_d4;
_cd._clickCount=_d5;
_cd._pressure=_d6;
return _cd;
};
var _d7=5,_d8=(typeof document!="undefined"&&document.addEventListener)?350:1000;
var _12=function(_d9,_da,_db){
if(!_d9){
return 1;
}
var _dc=objj_msgSend(_d9,"locationInWindow");
return (_da-objj_msgSend(_d9,"timestamp")<_d8&&ABS(_dc.x-_db.x)<_d7&&ABS(_dc.y-_db.y)<_d7)?objj_msgSend(_d9,"clickCount")+1:1;
};
var _13=function(_dd,_de){
_dd.cancelBubble=true;
_dd.returnValue=false;
if(_dd.preventDefault){
_dd.preventDefault();
}
if(_dd.stopPropagation){
_dd.stopPropagation();
}
if(_dd.type===CPDOMEventMouseDown){
_de._DOMFocusElement.focus();
_de._DOMFocusElement.blur();
}
};
CPWindowObjectList=function(){
var _df=objj_msgSend(CPPlatformWindow,"primaryPlatformWindow"),_e0=_df._windowLevels,_e1=_df._windowLayers,_e2=_e0.length,_e3=[];
while(_e2--){
var _e4=objj_msgSend(_e1,"objectForKey:",_e0[_e2])._windows,_e5=_e4.length;
while(_e5--){
_e3.push(_e4[_e5]);
}
}
return _e3;
};
CPWindowList=function(){
var _e6=objj_msgSend(CPPlatformWindow,"primaryPlatformWindow"),_e7=_e6._windowLevels,_e8=_e6._windowLayers,_e9=_e7.length,_ea=[];
while(_e9--){
var _eb=objj_msgSend(_e8,"objectForKey:",_e7[_e9])._windows,_ec=_eb.length;
while(_ec--){
_ea.push(objj_msgSend(_eb[_ec],"windowNumber"));
}
}
return _ea;
};
