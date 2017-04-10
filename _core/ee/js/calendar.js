var cbPath = "";
             /*
preloadImage(cbPath);
preloadImage(cbPathO);
preloadImage(cbPathA);
*/

//addScript("core.js");
//addScript("lang.js");

//addCss("wnd.css");
//addCss("calendar.css");

function initCalendar(id, dateFormat)
{
   var input = document.getElementById(id);
   if (!input) return;
   input.dateFormat = dateFormat;
   var cbPath = input.getAttribute("datepickerIcon");

   var inputContainer = document.createElement("DIV");
   inputContainer.className = "dpContainer";
   inputContainer.setAttribute("id", "dpContainer");
   inputContainer.noWrap = true;
   var pNode = input.parentNode;
   pNode.insertBefore(inputContainer, input.nextSibling);
//   inputContainer.appendChild(pNode.removeChild(input));

   var calendarButton = document.createElement("IMG");
   calendarButton.setAttribute("width", "24");
   calendarButton.setAttribute("height", "24");
   calendarButton.setAttribute("align", "absMiddle");
   calendarButton.style.width=24
   calendarButton.style.height=24
   calendarButton.style.cursor = "hand";

   calendarButton.setAttribute("hspace", 2);
   calendarButton.src = cbPath;
   calendarButton.onmouseover = cbMouseOver;
   calendarButton.onmouseout = cbMouseOut;
   calendarButton.onmouseup = calendarButton.onmouseout;
   calendarButton.onmousedown = cbMouseDown;
   calendarButton.showCalendar = wnd_showCalendar;
   inputContainer.appendChild(calendarButton);
   inputContainer.dateInput = input
}

var calendar;

function cbMouseOver(e)
{
//   this.src = cbPathO;
   var evt = (e) ? e : event; if (evt) evt.cancelBubble = true;
}

function cbMouseOut(e)
{
//   this.src = cbPath;
   var evt = (e) ? e : event; if (evt) evt.cancelBubble = true;
}

function cbMouseDown(e)
{
//   this.src = cbPathA;
   var evt = (e) ? e : event; if (evt) evt.cancelBubble = true;
   this.showCalendar();
}

function wnd_showCalendar()
{
  var el = this.parentNode.dateInput;
  if (calendar != null) calendar.hide();
  else 
  {
    var calendarObject = new Calendar(false, null, dateSelected, closeHandler);
    calendar = calendarObject;
    calendarObject.setRange(1900, 2070);
    calendarObject.create();
  }
  calendar.setDateFormat(el.dateFormat);
  calendar.parseDate(el.value);
  calendar.sel = el;
  calendar.showAtElement(el);

  Calendar.addEvent(document, "mousedown", checkCalendar);
  return false;
}

function dateSelected(calendarObject, date) 
{
  calendarObject.sel.value = date;
  calendarObject.callCloseHandler();
}

function closeHandler(calendarObject) 
{
  calendarObject.hide();
  Calendar.removeEvent(document, "mousedown", checkCalendar);
  if(needReload) allReload();	
}

function checkCalendar(ev)
{
  var el = Calendar.is_ie ? Calendar.getElement(ev) : Calendar.getTargetElement(ev);

  for (; el != null; el = el.parentNode)
     if (el == calendar.element || el.tagName == "A") break;
  
  if (el == null) 
  {
    calendar.callCloseHandler();
    Calendar.stopEvent(ev);
  }
}

function preloadImage(path)
{
   var img = new Image();
   img.src = path;
   preloadImages.push(img);
}

function addCss(path)
{
   path = cssPath + path;
   document.write("<link rel='stylesheet' href='" + path + "' type='text/css'/>");
}

/*<CORE>*/
/* Copyright Mihai Bazon, 2002
 * http://students.infoiasi.ro/~mishoo
 *
 * Version: 0.9.1
 *
 * Feel free to use this script under the terms of the GNU General Public
 * License, as long as you do not remove or alter this notice.
 */

/** The Calendar object constructor. */
Calendar = function (mondayFirst, dateStr, onSelected, onClose) {
   // member variables
   this.activeDiv = null;
   this.currentDateEl = null;
   this.checkDisabled = null;
   this.timeout = null;
   this.onSelected = onSelected || null;
   this.onClose = onClose || null;
   this.dragging = false;
   this.minYear = 1970;
   this.maxYear = 2050;
   this.dateFormat = Calendar._TT["DEF_DATE_FORMAT"];
   this.ttDateFormat = Calendar._TT["TT_DATE_FORMAT"];
   this.isPopup = true;
   this.mondayFirst = mondayFirst;
   this.dateStr = dateStr;
   // HTML elements
   this.table = null;
   this.element = null;
   this.tbody = null;
   this.daynames = null;
   // Combo boxes
   this.monthsCombo = null;
   this.yearsCombo = null;
   this.hilitedMonth = null;
   this.activeMonth = null;
   this.hilitedYear = null;
   this.activeYear = null;

   // one-time initializations
   if (!Calendar._DN3) {
      // table of short day names
      var ar = new Array();
      for (var i = 8; i > 0;) {
         ar[--i] = Calendar._DN[i].substr(0, 3);
      }
      Calendar._DN3 = ar;
      // table of short month names
      ar = new Array();
      for (var i = 12; i > 0;) {
         ar[--i] = Calendar._MN[i].substr(0, 3);
      }
      Calendar._MN3 = ar;
   }
};

// ** constants

/// "static", needed for event handlers.
Calendar._C = null;

/// detect a special case of "web browser"
Calendar.is_ie = ( (navigator.userAgent.toLowerCase().indexOf("msie") != -1) &&
         (navigator.userAgent.toLowerCase().indexOf("opera") == -1) );

// short day names array (initialized at first constructor call)
Calendar._DN3 = null;

// short month names array (initialized at first constructor call)
Calendar._MN3 = null;

// BEGIN: UTILITY FUNCTIONS; beware that these might be moved into a separate
//        library, at some point.

Calendar.getAbsolutePos = function(el) {
   var r = { x: el.offsetLeft, y: el.offsetTop };
   if (el.offsetParent) {
      var tmp = Calendar.getAbsolutePos(el.offsetParent);
      r.x += tmp.x;
      r.y += tmp.y;
   }
   return r;
};

Calendar.isRelated = function (el, evt) {
   var related = evt.relatedTarget;
   if (!related) {
      var type = evt.type;
      if (type == "mouseover") {
         related = evt.fromElement;
      } else if (type == "mouseout") {
         related = evt.toElement;
      }
   }
   while (related) {
      if (related == el) {
         return true;
      }
      related = related.parentNode;
   }
   return false;
};

Calendar.removeClass = function(el, className) {
   if (!(el && el.className)) {
      return;
   }
   var cls = el.className.split(" ");
   var ar = new Array();
   for (var i = cls.length; i > 0;) {
      if (cls[--i] != className) {
         ar[ar.length] = cls[i];
      }
   }
   el.className = ar.join(" ");
};

Calendar.addClass = function(el, className) {
   el.className += " " + className;
};

Calendar.getElement = function(ev) {
   if (Calendar.is_ie) {
      return window.event.srcElement;
   } else {
      return ev.currentTarget;
   }
};

Calendar.getTargetElement = function(ev) {
   if (Calendar.is_ie) {
      return window.event.srcElement;
   } else {
      return ev.target;
   }
};

Calendar.stopEvent = function(ev) {
   if (Calendar.is_ie) {
      window.event.cancelBubble = true;
      window.event.returnValue = false;
   } else {
      ev.preventDefault();
      ev.stopPropagation();
   }
};

Calendar.addEvent = function(el, evname, func) {
   if (Calendar.is_ie) {
      el.attachEvent("on" + evname, func);
   } else {
      el.addEventListener(evname, func, true);
   }
};

Calendar.removeEvent = function(el, evname, func) {
   if (Calendar.is_ie) {
      el.detachEvent("on" + evname, func);
   } else {
      el.removeEventListener(evname, func, true);
   }
};

Calendar.createElement = function(type, parent) {
   var el = null;
   if (document.createElementNS) {
      // use the XHTML namespace; IE won't normally get here unless
      // _they_ "fix" the DOM2 implementation.
      el = document.createElementNS("http://www.w3.org/1999/xhtml", type);
   } else {
      el = document.createElement(type);
   }
   if (typeof parent != "undefined") {
      parent.appendChild(el);
   }
   return el;
};

// END: UTILITY FUNCTIONS

// BEGIN: CALENDAR STATIC FUNCTIONS

/** Internal -- adds a set of events to make some element behave like a button. */
Calendar._add_evs = function(el) {
   with (Calendar) {
      addEvent(el, "mouseover", dayMouseOver);
      addEvent(el, "mousedown", dayMouseDown);
      addEvent(el, "mouseout", dayMouseOut);
      if (is_ie) {
         addEvent(el, "dblclick", dayMouseDblClick);
         el.setAttribute("unselectable", true);
      }
   }
};

Calendar.findMonth = function(el) {
   if (typeof el.month != "undefined") {
      return el;
   } else if (typeof el.parentNode.month != "undefined") {
      return el.parentNode;
   }
   return null;
};

Calendar.findYear = function(el) {
   if (typeof el.year != "undefined") {
      return el;
   } else if (typeof el.parentNode.year != "undefined") {
      return el.parentNode;
   }
   return null;
};

Calendar.showMonthsCombo = function () {
   var cal = Calendar._C;
   if (!cal) {
      return false;
   }
   var cal = cal;
   var cd = cal.activeDiv;
   var mc = cal.monthsCombo;
   if (cal.hilitedMonth) {
      Calendar.removeClass(cal.hilitedMonth, "hilite");
   }
   if (cal.activeMonth) {
      Calendar.removeClass(cal.activeMonth, "active");
   }
   var mon = cal.monthsCombo.getElementsByTagName("div")[cal.date.getMonth()];
   Calendar.addClass(mon, "active");
   cal.activeMonth = mon;
   mc.style.left = cd.offsetLeft;
   mc.style.top = cd.offsetTop + cd.offsetHeight;
   mc.style.display = "block";
};

Calendar.showYearsCombo = function (fwd) {
   var cal = Calendar._C;
   if (!cal) {
      return false;
   }
   var cal = cal;
   var cd = cal.activeDiv;
   var yc = cal.yearsCombo;
   if (cal.hilitedYear) {
      Calendar.removeClass(cal.hilitedYear, "hilite");
   }
   if (cal.activeYear) {
      Calendar.removeClass(cal.activeYear, "active");
   }
   cal.activeYear = null;
   var Y = cal.date.getFullYear() + (fwd ? 1 : -1);
   var yr = yc.firstChild;
   var show = false;
   for (var i = 12; i > 0; --i) {
      if (Y >= cal.minYear && Y <= cal.maxYear) {
         yr.firstChild.data = Y;
         yr.year = Y;
         yr.style.display = "block";
         show = true;
      } else {
         yr.style.display = "none";
      }
      yr = yr.nextSibling;
      Y += fwd ? 2 : -2;
   }
   if (show) {
      yc.style.left = cd.offsetLeft;
      yc.style.top = cd.offsetTop + cd.offsetHeight;
      yc.style.display = "block";
   }
};

// event handlers

Calendar.tableMouseUp = function(ev) {
   var cal = Calendar._C;
   if (!cal) {
      return false;
   }
   if (cal.timeout) {
      clearTimeout(cal.timeout);
   }
   var el = cal.activeDiv;
   if (!el) {
      return false;
   }
   var target = Calendar.getTargetElement(ev);
   Calendar.removeClass(el, "active");
   if (target == el || target.parentNode == el) {
      Calendar.cellClick(el);
   }
   var mon = Calendar.findMonth(target);
   var date = null;
   if (mon) {
      date = new Date(cal.date);
      if (mon.month != date.getMonth()) {
         date.setMonth(mon.month);
         cal.setDate(date);
      }
   } else {
      var year = Calendar.findYear(target);
      if (year) {
         date = new Date(cal.date);
         if (year.year != date.getFullYear()) {
            date.setFullYear(year.year);
            cal.setDate(date);
         }
      }
   }
   with (Calendar) {
      removeEvent(document, "mouseup", tableMouseUp);
      removeEvent(document, "mouseover", tableMouseOver);
      removeEvent(document, "mousemove", tableMouseOver);
      cal._hideCombos();
      stopEvent(ev);
      _C = null;
   }
};

Calendar.tableMouseOver = function (ev) {
   var cal = Calendar._C;
   if (!cal) {
      return;
   }
   var el = cal.activeDiv;
   var target = Calendar.getTargetElement(ev);
   if (target == el || target.parentNode == el) {
      Calendar.addClass(el, "hilite active");
   } else {
      Calendar.removeClass(el, "active");
      Calendar.removeClass(el, "hilite");
   }
   var mon = Calendar.findMonth(target);
   if (mon) {
      if (mon.month != cal.date.getMonth()) {
         if (cal.hilitedMonth) {
            Calendar.removeClass(cal.hilitedMonth, "hilite");
         }
         Calendar.addClass(mon, "hilite");
         cal.hilitedMonth = mon;
      } else if (cal.hilitedMonth) {
         Calendar.removeClass(cal.hilitedMonth, "hilite");
      }
   } else {
      var year = Calendar.findYear(target);
      if (year) {
         if (year.year != cal.date.getFullYear()) {
            if (cal.hilitedYear) {
               Calendar.removeClass(cal.hilitedYear, "hilite");
            }
            Calendar.addClass(year, "hilite");
            cal.hilitedYear = year;
         } else if (cal.hilitedYear) {
            Calendar.removeClass(cal.hilitedYear, "hilite");
         }
      }
   }
   Calendar.stopEvent(ev);
};

Calendar.tableMouseDown = function (ev) {
   if (Calendar.getTargetElement(ev) == Calendar.getElement(ev)) {
      Calendar.stopEvent(ev);
   }
};

Calendar.calDragIt = function (ev) {
   var cal = Calendar._C;
   if (!(cal && cal.dragging)) {
      return false;
   }
   var posX;
   var posY;
   if (Calendar.is_ie) {
      posY = window.event.clientY + document.body.scrollTop; 
      posX = window.event.clientX + document.body.scrollLeft; 
   } else {
      posX = ev.pageX;
      posY = ev.pageY;
   }
   cal.hideShowCovered();
   var st = cal.element.style;
   st.left = (posX - cal.xOffs) + "px";
   st.top = (posY - cal.yOffs) + "px";
   Calendar.stopEvent(ev);
};

Calendar.calDragEnd = function (ev) {
   var cal = Calendar._C;
   if (!cal) {
      return false;
   }
   cal.dragging = false;
   with (Calendar) {
      removeEvent(document, "mousemove", calDragIt);
      removeEvent(document, "mouseover", stopEvent);
      removeEvent(document, "mouseup", calDragEnd);
      tableMouseUp(ev);
   }
   cal.hideShowCovered();
};

Calendar.dayMouseDown = function(ev) {
   var el = Calendar.getElement(ev);
   if (el.disabled) {
      return false;
   }
   var cal = el.calendar;
   cal.activeDiv = el;
   Calendar._C = cal;
   if (el.navtype != 300) with (Calendar) {
      addClass(el, "hilite active");
      addEvent(document, "mouseover", tableMouseOver);
      addEvent(document, "mousemove", tableMouseOver);
      addEvent(document, "mouseup", tableMouseUp);
   } else if (cal.isPopup) {
      cal._dragStart(ev);
   }
   Calendar.stopEvent(ev);
   if (el.navtype == -1 || el.navtype == 1) {
      cal.timeout = setTimeout("Calendar.showMonthsCombo()", 250);
   } else if (el.navtype == -2 || el.navtype == 2) {
      cal.timeout = setTimeout((el.navtype > 0) ? "Calendar.showYearsCombo(true)" : "Calendar.showYearsCombo(false)", 250);
   } else {
      cal.timeout = null;
   }
};

Calendar.dayMouseDblClick = function(ev) {
   Calendar.cellClick(Calendar.getElement(ev));
   if (Calendar.is_ie) {
      document.selection.empty();
   }
};

Calendar.dayMouseOver = function(ev) {
   var el = Calendar.getElement(ev);
   if (Calendar.isRelated(el, ev) || Calendar._C || el.disabled) {
      return false;
   }
   if (el.ttip) {
      if (el.ttip.substr(0, 1) == "_") {
         var date = null;
         with (el.calendar.date) {
            date = new Date(getFullYear(), getMonth(), el.caldate);
         }
         el.ttip = date.print(el.calendar.ttDateFormat) + el.ttip.substr(1);
      }
      el.calendar.tooltips.firstChild.data = el.ttip;
   }
   if (el.navtype != 300) {
      Calendar.addClass(el, "hilite");
   }
   Calendar.stopEvent(ev);
};

Calendar.dayMouseOut = function(ev) {
   with (Calendar) {
      var el = getElement(ev);
      if (isRelated(el, ev) || _C || el.disabled) {
         return false;
      }
      removeClass(el, "hilite");
      el.calendar.tooltips.firstChild.data = _TT["SEL_DATE"];
      stopEvent(ev);
   }
};

/**
 *  A generic "click" handler :) handles all types of buttons defined in this
 *  calendar.
 */
Calendar.cellClick = function(el) {
   var cal = el.calendar;
   var closing = false;
   var newdate = false;
   var date = null;
   if (typeof el.navtype == "undefined") {
      Calendar.removeClass(cal.currentDateEl, "selected");
      Calendar.addClass(el, "selected");
      closing = (cal.currentDateEl == el);
      if (!closing) {
         cal.currentDateEl = el;
      }
      cal.date.setDate(el.caldate);
      date = cal.date;
      newdate = true;
   } else {
      if (el.navtype == 200) {
         Calendar.removeClass(el, "hilite");
         cal.callCloseHandler();
         return;
      }
      date = (el.navtype == 0) ? new Date() : new Date(cal.date);
      var year = date.getFullYear();
      var mon = date.getMonth();
      var setMonth = function (mon) {
         var day = date.getDate();
         var max = date.getMonthDays();
         if (day > max) {
            date.setDate(max);
         }
         date.setMonth(mon);
      };
      switch (el.navtype) {
          case -2:
         if (year > cal.minYear) {
            date.setFullYear(year - 1);
         }
         break;
          case -1:
         if (mon > 0) {
            setMonth(mon - 1);
         } else if (year-- > cal.minYear) {
            date.setFullYear(year);
            setMonth(11);
         }
         break;
          case 1:
         if (mon < 11) {
            setMonth(mon + 1);
         } else if (year < cal.maxYear) {
            date.setFullYear(year + 1);
            setMonth(0);
         }
         break;
          case 2:
         if (year < cal.maxYear) {
            date.setFullYear(year + 1);
         }
         break;
          case 100:
         cal.setMondayFirst(!cal.mondayFirst);
         return;
      }
      if (!date.equalsTo(cal.date)) {
         cal.setDate(date);
         newdate = el.navtype == 0;
      }
   }
   if (newdate) {
      cal.callHandler();
   }
   if (closing) {
      Calendar.removeClass(el, "hilite");
      cal.callCloseHandler();
   }
};

// END: CALENDAR STATIC FUNCTIONS

// BEGIN: CALENDAR OBJECT FUNCTIONS

/**
 *  This function creates the calendar inside the given parent.  If _par is
 *  null than it creates a popup calendar inside the BODY element.  If _par is
 *  an element, be it BODY, then it creates a non-popup calendar (still
 *  hidden).  Some properties need to be set before calling this function.
 */
Calendar.prototype.create = function (_par) {
   var parent = null;
   if (! _par) {
      // default parent is the document body, in which case we create
      // a popup calendar.
      parent = document.getElementsByTagName("body")[0];
      this.isPopup = true;
   } else {
      parent = _par;
      this.isPopup = false;
   }
   this.date = this.dateStr ? new Date(this.dateStr) : new Date();

   var table = Calendar.createElement("table");
   this.table = table;
   table.cellSpacing = 0;
   table.cellPadding = 0;
   table.calendar = this;
   Calendar.addEvent(table, "mousedown", Calendar.tableMouseDown);

   var div = Calendar.createElement("div");
   this.element = div;
   div.className = "calendar";
   if (this.isPopup) {
      div.style.position = "absolute";
      div.style.display = "none";
   }
   div.appendChild(table);

   var thead = Calendar.createElement("thead", table);
   var cell = null;
   var row = null;

   var cal = this;
   var hh = function (text, cs, navtype) {
      cell = Calendar.createElement("td", row);
      cell.colSpan = cs;
      cell.className = "button";
      Calendar._add_evs(cell);
      cell.calendar = cal;
      cell.navtype = navtype;
      if (text.substr(0, 1) != "&") {
         cell.appendChild(document.createTextNode(text));
      }
      else {
         // FIXME: dirty hack for entities
         cell.innerHTML = text;
      }
      return cell;
   };

   row = Calendar.createElement("tr", thead);
   row.className = "headrow";

   hh("-", 1, 100).ttip = Calendar._TT["TOGGLE"];
   this.title = hh("", this.isPopup ? 5 : 6, 300);
   this.title.className = "title";
   if (this.isPopup) {
      this.title.ttip = Calendar._TT["DRAG_TO_MOVE"];
      this.title.style.cursor = "move";
      hh("X", 1, 200).ttip = Calendar._TT["CLOSE"];
   }

   row = Calendar.createElement("tr", thead);
   row.className = "headrow";

   hh("&#x00ab;", 1, -2).ttip = Calendar._TT["PREV_YEAR"];
   hh("&#x2039;", 1, -1).ttip = Calendar._TT["PREV_MONTH"];
   hh(Calendar._TT["TODAY"], 3, 0).ttip = Calendar._TT["GO_TODAY"];
   hh("&#x203a;", 1, 1).ttip = Calendar._TT["NEXT_MONTH"];
   hh("&#x00bb;", 1, 2).ttip = Calendar._TT["NEXT_YEAR"];

   // day names
   row = Calendar.createElement("tr", thead);
   row.className = "daynames";
   this.daynames = row;
   for (var i = 7; i > 0; --i) {
      cell = Calendar.createElement("td", row);
      cell.appendChild(document.createTextNode(""));
      if (!i) {
         cell.navtype = 100;
         cell.calendar = this;
         Calendar._add_evs(cell);
      }
   }
   this._displayWeekdays();

   var tbody = Calendar.createElement("tbody", table);
   this.tbody = tbody;

   for (i = 6; i > 0; --i) {
      row = Calendar.createElement("tr", tbody);
      for (var j = 7; j > 0; --j) {
         cell = Calendar.createElement("td", row);
         cell.appendChild(document.createTextNode(""));
         cell.calendar = this;
         Calendar._add_evs(cell);
      }
   }

   var tfoot = Calendar.createElement("tfoot", table);

   row = Calendar.createElement("tr", tfoot);
   row.className = "footrow";

   cell = hh(Calendar._TT["SEL_DATE"], 7, 300);
   cell.className = "ttip";
   if (this.isPopup) {
      cell.ttip = Calendar._TT["DRAG_TO_MOVE"];
      cell.style.cursor = "move";
   }
   this.tooltips = cell;

   div = Calendar.createElement("div", this.element);
   this.monthsCombo = div;
   div.className = "combo";
   for (i = 0; i < Calendar._MN.length; ++i) {
      var mn = Calendar.createElement("div");
      mn.className = "label";
      mn.month = i;
      mn.appendChild(document.createTextNode(Calendar._MN3[i]));
      div.appendChild(mn);
   }

   div = Calendar.createElement("div", this.element);
   this.yearsCombo = div;
   div.className = "combo";
   for (i = 12; i > 0; --i) {
      var yr = Calendar.createElement("div");
      yr.className = "label";
      yr.appendChild(document.createTextNode(""));
      div.appendChild(yr);
   }

   this._init(this.mondayFirst, this.date);
   parent.appendChild(this.element);
};

/**
 *  (RE)Initializes the calendar to the given date and style (if mondayFirst is
 *  true it makes Monday the first day of week, otherwise the weeks start on
 *  Sunday.
 */
Calendar.prototype._init = function (mondayFirst, date) {
   var today = new Date();
   var year = date.getFullYear();
   if (year < this.minYear) {
      year = this.minYear;
      date.setFullYear(year);
   } else if (year > this.maxYear) {
      year = this.maxYear;
      date.setFullYear(year);
   }
   this.mondayFirst = mondayFirst;
   this.date = new Date(date);
   var month = date.getMonth();
   var mday = date.getDate();
   var no_days = date.getMonthDays();
   date.setDate(1);
   var wday = date.getDay();
   var MON = mondayFirst ? 1 : 0;
   var SAT = mondayFirst ? 5 : 6;
   var SUN = mondayFirst ? 6 : 0;
   if (mondayFirst) {
      wday = (wday > 0) ? (wday - 1) : 6;
   }
   var iday = 1;
   var row = this.tbody.firstChild;
   var MN = Calendar._MN3[month];
   var hasToday = ((today.getFullYear() == year) && (today.getMonth() == month));
   var todayDate = today.getDate();
   for (var i = 0; i < 6; ++i) {
      if (iday > no_days) {
         row.className = "emptyrow";
         row = row.nextSibling;
         continue;
      }
      var cell = row.firstChild;
      row.className = "daysrow";
      for (var j = 0; j < 7; ++j) {
         if ((!i && j < wday) || iday > no_days) {
            cell.className = "emptycell";
            cell = cell.nextSibling;
            continue;
         }
         cell.firstChild.data = iday;
         cell.className = "day";
         cell.disabled = false;
         if (typeof this.checkDisabled == "function") {
            date.setDate(iday);
            if (this.checkDisabled(date)) {
               cell.className += " disabled";
               cell.disabled = true;
            }
         }
         if (!cell.disabled) {
            cell.caldate = iday;
            cell.ttip = "_";
            if (iday == mday) {
               cell.className += " selected";
               this.currentDateEl = cell;
            }
            if (hasToday && (iday == todayDate)) {
               cell.className += " today";
               cell.ttip += Calendar._TT["PART_TODAY"];
            }
            if (wday == SAT || wday == SUN) {
               cell.className += " weekend";
            }
         }
         ++iday;
         ((++wday) ^ 7) || (wday = 0);
         cell = cell.nextSibling;
      }
      row = row.nextSibling;
   }
   this.title.firstChild.data = Calendar._MN[month] + ", " + year;
   // PROFILE
   // this.tooltips.firstChild.data = "Generated in " + ((new Date()) - today) + " ms";
};

/**
 *  Calls _init function above for going to a certain date (but only if the
 *  date is different than the currently selected one).
 */
Calendar.prototype.setDate = function (date) {
   if (!date.equalsTo(this.date)) {
      this._init(this.mondayFirst, date);
   }
};

/** Modifies the "mondayFirst" parameter (EU/US style). */
Calendar.prototype.setMondayFirst = function (mondayFirst) {
   this._init(mondayFirst, this.date);
   this._displayWeekdays();
};

/**
 *  Allows customization of what dates are enabled.  The "unaryFunction"
 *  parameter must be a function object that receives the date (as a JS Date
 *  object) and returns a boolean value.  If the returned value is true then
 *  the passed date will be marked as disabled.
 */
Calendar.prototype.setDisabledHandler = function (unaryFunction) {
   this.checkDisabled = unaryFunction;
};

/** Customization of allowed year range for the calendar. */
Calendar.prototype.setRange = function (a, z) {
   this.minYear = a;
   this.maxYear = z;
};

/** Calls the first user handler (selectedHandler). */
Calendar.prototype.callHandler = function () {
   if (this.onSelected) {
      this.onSelected(this, this.date.print(this.dateFormat));
   }
};

/** Calls the second user handler (closeHandler). */
Calendar.prototype.callCloseHandler = function () {
   if (this.onClose) {
      this.onClose(this);
   }
   this.hideShowCovered();
};

/** Removes the calendar object from the DOM tree and destroys it. */
Calendar.prototype.destroy = function () {
   var el = this.element.parentNode;
   el.removeChild(this.element);
   Calendar._C = null;
   delete el;
};

/**
 *  Moves the calendar element to a different section in the DOM tree (changes
 *  its parent).
 */
Calendar.prototype.reparent = function (new_parent) {
   var el = this.element;
   el.parentNode.removeChild(el);
   new_parent.appendChild(el);
};

/** Shows the calendar. */
Calendar.prototype.show = function () {
   this.element.style.display = "block";
   this.hideShowCovered();
};

/**
 *  Hides the calendar.  Also removes any "hilite" from the class of any TD
 *  element.
 */
Calendar.prototype.hide = function () {
   var trs = this.table.getElementsByTagName("td");
   for (var i = trs.length; i > 0; ) {
      Calendar.removeClass(trs[--i], "hilite");
   }
   this.element.style.display = "none";
};

/**
 *  Shows the calendar at a given absolute position (beware that, depending on
 *  the calendar element style -- position property -- this might be relative
 *  to the parent's containing rectangle).
 */
Calendar.prototype.showAt = function (x, y) {
   var s = this.element.style;
   s.left = x + "px";
   s.top = y + "px";
   this.show();
};

/** Shows the calendar near a given element. */
Calendar.prototype.showAtElement = function (el) {
   var p = Calendar.getAbsolutePos(el);

      var cw = 200;
      var ch = 238;

   if (Calendar.is_ie)
   {
      var posX = getWndX(el) + el.offsetWidth + 18; if (posX + ch > document.body.scrollLeft + document.body.offsetWidth) posX = document.body.scrollLeft + document.body.offsetWidth - ch
      var posY = p.y + el.offsetHeight; if (posY + cw > document.body.scrollTop + document.body.offsetHeight) posY = getWndY(el) - cw;
      //document.body.scrollTop + document.body.offsetHeight - cw - el.offsetHeight
      this.showAt(posX, posY);
   }
   else
   {
      this.showAt(getWndX(el) + el.offsetWidth + 18, p.y + el.offsetHeight);
   }
};

function getWndC(object, c)
{
    pos = 0;
    while (object != null) 
    {
        pos += (c == "y") ? object.offsetTop : object.offsetLeft;
        object = object.offsetParent;
    }
    return pos;
}

function getWndX(object) {return getWndC(object, "x")}
function getWndY(object) {return getWndC(object, "y")}


/** Customizes the date format. */
Calendar.prototype.setDateFormat = function (str) {
   this.dateFormat = str;
};

/** Customizes the tooltip date format. */
Calendar.prototype.setTtDateFormat = function (str) {
   this.ttDateFormat = str;
};

/**
 *  Tries to identify the date represented in a string.  If successful it also
 *  calls this.setDate which moves the calendar to the given date.
 */
Calendar.prototype.parseDate = function (str, fmt) {
   var y = 0;
   var m = -1;
   var d = 0;
   var a = str.split(/\W+/);
   if (!fmt) {
      fmt = this.dateFormat;
   }
   var b = fmt.split(/\W+/);
   var i = 0, j = 0;
   for (i = 0; i < a.length; ++i) {
      if (b[i] == "D" || b[i] == "DD") {
         continue;
      }
      if (b[i] == "d" || b[i] == "dd") {
         d = a[i];
      }
      if (b[i] == "m" || b[i] == "mm") {
         m = a[i]-1;
      }
      if (b[i] == "y") {
         y = a[i];
      }
      if (b[i] == "yy") {
         y = parseInt(a[i]) + 1900;
      }
      if (b[i] == "M" || b[i] == "MM") {
         for (j = 0; j < 12; ++j) {
            if (Calendar._MN[j].substr(0, a[i].length).toLowerCase() == a[i].toLowerCase()) { m = j; break; }
         }
      }
   }
   if (y != 0 && m != -1 && d != 0) {
      this.setDate(new Date(y, m, d));
      return;
   }
   y = 0; m = -1; d = 0;
   for (i = 0; i < a.length; ++i) {
      if (a[i].search(/[a-zA-Z]+/) != -1) {
         var t = -1;
         for (j = 0; j < 12; ++j) {
            if (Calendar._MN[j].substr(0, a[i].length).toLowerCase() == a[i].toLowerCase()) { t = j; break; }
         }
         if (t != -1) {
            if (m != -1) {
               d = m+1;
            }
            m = t;
         }
      } else if (parseInt(a[i]) <= 12 && m == -1) {
         m = a[i]-1;
      } else if (parseInt(a[i]) > 31 && y == 0) {
         y = a[i];
      } else if (d == 0) {
         d = a[i];
      }
   }
   if (y == 0) {
      var today = new Date();
      y = today.getFullYear();
   }
   if (m != -1 && d != 0) {
      this.setDate(new Date(y, m, d));
   }
};

Calendar.prototype.hideShowCovered = function () {
   var tags = new Array("applet", "iframe", "select");
   var el = this.element;

   var p = Calendar.getAbsolutePos(el);
   var EX1 = p.x;
   var EX2 = el.offsetWidth + EX1;
   var EY1 = p.y;
   var EY2 = el.offsetHeight + EY1;

   for (var k = tags.length; k > 0; ) {
      var ar = document.getElementsByTagName(tags[--k]);
      var cc = null;

      for (var i = ar.length; i > 0;) {
         cc = ar[--i];

         p = Calendar.getAbsolutePos(cc);
         var CX1 = p.x;
         var CX2 = cc.offsetWidth + CX1;
         var CY1 = p.y;
         var CY2 = cc.offsetHeight + CY1;

         if ((CX1 > EX2) || (CX2 < EX1) || (CY1 > EY2) || (CY2 < EY1)) {
            cc.style.visibility = "visible";
         } else {
            cc.style.visibility = "hidden";
         }
      }
   }
};

/** Internal function; it displays the bar with the names of the weekday. */
Calendar.prototype._displayWeekdays = function () {
   var MON = this.mondayFirst ? 0 : 1;
   var SUN = this.mondayFirst ? 6 : 0;
   var SAT = this.mondayFirst ? 5 : 6;
   var cell = this.daynames.firstChild;
   for (var i = 0; i < 7; ++i) {
      cell.className = "day name";
      if (!i) {
         cell.ttip = this.mondayFirst ? Calendar._TT["SUN_FIRST"] : Calendar._TT["MON_FIRST"];
         cell.navtype = 100;
         cell.calendar = this;
         Calendar._add_evs(cell);
      }
      if (i == SUN || i == SAT) {
         Calendar.addClass(cell, "weekend");
      }
      cell.firstChild.data = Calendar._DN3[i + 1 - MON];
      cell = cell.nextSibling;
   }
};

/** Internal function.  Hides all combo boxes that might be displayed. */
Calendar.prototype._hideCombos = function () {
   this.monthsCombo.style.display = "none";
   this.yearsCombo.style.display = "none";
};

/** Internal function.  Starts dragging the element. */
Calendar.prototype._dragStart = function (ev) {
   if (this.dragging) {
      return;
   }
   this.dragging = true;
   var posX;
   var posY;
   if (Calendar.is_ie) {
      posY = window.event.clientY + document.body.scrollTop;
      posX = window.event.clientX + document.body.scrollLeft;
   } else {
      posY = ev.clientY + window.scrollY;
      posX = ev.clientX + window.scrollX;
   }
   var st = this.element.style;
   this.xOffs = posX - parseInt(st.left);
   this.yOffs = posY - parseInt(st.top);
   with (Calendar) {
      addEvent(document, "mousemove", calDragIt);
      addEvent(document, "mouseover", stopEvent);
      addEvent(document, "mouseup", calDragEnd);
   }
};

// BEGIN: DATE OBJECT PATCHES

/** Adds the number of days array to the Date object. */
Date._MD = new Array(31,28,31,30,31,30,31,31,30,31,30,31);

/** Returns the number of days in the current month */
Date.prototype.getMonthDays = function() {
   var year = this.getFullYear();
   var month = this.getMonth();
   if (((0 == (year%4)) && ( (0 != (year%100)) || (0 == (year%400)))) && month == 1) {
      return 29;
   } else {
      return Date._MD[month];
   }
};

/** Checks dates equality (ignores time) */
Date.prototype.equalsTo = function(date) {
   return ((this.getFullYear() == date.getFullYear()) &&
      (this.getMonth() == date.getMonth()) &&
      (this.getDate() == date.getDate()));
};

/** Prints the date in a string according to the given format. */
Date.prototype.print = function (frm) {
   var str = new String(frm);
   var m = this.getMonth();
   var d = this.getDate();
   var y = this.getFullYear();
   var w = this.getDay();
   var s = new Array();
   s["d"] = d;
   s["dd"] = (d < 10) ? ("0" + d) : d;
   s["m"] = 1+m;
   s["mm"] = (m < 9) ? ("0" + (1+m)) : (1+m);
   s["y"] = y;
   s["yy"] = new String(y).substr(2, 2);
   with (Calendar) {
      s["D"] = _DN3[w];
      s["DD"] = _DN[w];
      s["M"] = _MN3[m];
      s["MM"] = _MN[m];
   }
   var re = /(.*)(\W|^)(d|dd|m|mm|y|yy|MM|M|DD|D)(\W|$)(.*)/;
   while (re.exec(str) != null) {
      str = RegExp.$1 + RegExp.$2 + s[RegExp.$3] + RegExp.$4 + RegExp.$5;
   }
   return str;
};

// END: DATE OBJECT PATCHES
/*</CORE>*/
/*<LANG>*/
Calendar._DN = new Array
("Sunday",
 "Monday",
 "Tuesday",
 "Wednesday",
 "Thursday",
 "Friday",
 "Saturday",
 "Sunday");
Calendar._MN = new Array
("January",
 "February",
 "March",
 "April",
 "May",
 "June",
 "July",
 "August",
 "September",
 "October",
 "November",
 "December");

// tooltips
Calendar._TT = {};
Calendar._TT["TOGGLE"] = "Toggle first day of week";
Calendar._TT["PREV_YEAR"] = "Prev. year (hold for menu)";
Calendar._TT["PREV_MONTH"] = "Prev. month (hold for menu)";
Calendar._TT["GO_TODAY"] = "Go Today";
Calendar._TT["NEXT_MONTH"] = "Next month (hold for menu)";
Calendar._TT["NEXT_YEAR"] = "Next year (hold for menu)";
Calendar._TT["SEL_DATE"] = "Select date";
Calendar._TT["DRAG_TO_MOVE"] = "Drag to move";
Calendar._TT["PART_TODAY"] = " (today)";
Calendar._TT["MON_FIRST"] = "Display Monday first";
Calendar._TT["SUN_FIRST"] = "Display Sunday first";
Calendar._TT["CLOSE"] = "Close";
Calendar._TT["TODAY"] = "Today";

// date formats
Calendar._TT["DEF_DATE_FORMAT"] = "y-mm-dd";
Calendar._TT["TT_DATE_FORMAT"] = "D, M d";
/*</LANG>*/
/*</CSS>*/
document.write("<style type=\"text/css\">")
document.write(".calendar {  z-Index: 1; position: relative;  display: none;  border-top: 2px solid #fff;  border-right: 2px solid #000;  border-bottom: 2px solid #000;  border-left: 2px solid #fff;  font-size: 11px;  color: #000;  cursor: default;  background: #d4d0c8;  font-family: tahoma,verdana,sans-serif;}.calendar table {  border-top: 1px solid #000;  border-right: 1px solid #fff;  border-bottom: 1px solid #fff;  border-left: 1px solid #000;  font-size: 11px;  color: #000;  cursor: default;  background: #d4d0c8;  font-family: tahoma,verdana,sans-serif;}/* Header part -- contains navigation buttons and day names. */.calendar .button { text-align: center;  padding: 1px;  border-top: 1px solid #fff;  border-right: 1px solid #000;  border-bottom: 1px solid #000;  border-left: 1px solid #fff;}.calendar thead .title { font-weight: bold;  padding: 1px;  border: 1px solid #000;  background: #848078;  color: #fff;  text-align: center;}.calendar thead .headrow { /* Row <TR> containing navigation buttons */}.calendar thead .daynames { /* Row <TR> containing the day names */}.calendar thead .name { /* Cells <TD> containing the day names */  border-bottom: 1px solid #000;  padding: 2px;  text-align: center;  background: #f4f0e8;}.calendar thead .weekend { /* How a weekend day name shows in header */  color: #f00;}.calendar thead .hilite { /* How do the buttons in header appear when hover */  border-top: 2px solid #fff;  border-right: 2px solid #000;  border-bottom: 2px solid #000;  border-left: 2px solid #fff;  padding: 0px;  background: #e4e0d8;}.calendar thead .active { /* Active (pressed) buttons in header */  padding: 2px 0px 0px 2px;  border-top: 1px solid #000;  border-right: 1px solid #fff;  border-bottom: 1px solid #fff;  border-left: 1px solid #000;  background: #c4c0b8;}/* The body part -- contains all the days in month. */.calendar tbody .day { /* Cells <TD> containing month days dates */  width: 2em;  text-align: right;  padding: 2px 4px 2px 2px;}.calendar tbody .hilite { /* Hovered cells <TD> */  padding: 1px 3px 1px 1px;  border-top: 1px solid #fff;  border-right: 1px solid #000;  border-bottom: 1px solid #000;  border-left: 1px solid #fff;}.calendar tbody .active { /* Active (pressed) cells <TD> */  padding: 2px 2px 0px 2px;  border-top: 1px solid #000;  border-right: 1px solid #fff;  border-bottom: 1px solid #fff;  border-left: 1px solid #000;}.calendar tbody .selected { /* Cell showing selected date */  font-weight: bold;  border-top: 1px solid #000;  border-right: 1px solid #fff;  border-bottom: 1px solid #fff;  border-left: 1px solid #000;  padding: 2px 2px 0px 2px;  background: #e4e0d8;}.calendar tbody .weekend { /* Cells showing weekend days */  color: #f00;}.calendar tbody .today { /* Cell showing today date */  font-weight: bold;  color: #00f;}.calendar tbody .disabled { color: #999; }.calendar tbody .emptycell { /* Empty cells (the best is to hide them) */  visibility: hidden;}.calendar tbody .emptyrow { display: none;} .calendar tfoot .footrow { }.calendar tfoot .ttip { /* Tooltip (status bar) cell <TD> */  background: #f4f0e8;  padding: 1px;  border: 1px solid #000;  background: #848078;  color: #fff;  text-align: center;}.calendar tfoot .hilite { /* Hover style for buttons in footer */  border-top: 1px solid #fff;  border-right: 1px solid #000;  border-bottom: 1px solid #000;  border-left: 1px solid #fff;  padding: 1px;  background: #e4e0d8;}.calendar tfoot .active { /* Active (pressed) style for buttons in footer */  padding: 2px 0px 0px 2px;  border-top: 1px solid #000;  border-right: 1px solid #fff;  border-bottom: 1px solid #fff;  border-left: 1px solid #000;}/* Combo boxes (menus that display months/years for direct selection) */.combo {  position: absolute;  display: none;  width: 4em;  top: 0px;  left: 0px;  cursor: default;  border-top: 1px solid #fff;  border-right: 1px solid #000;  border-bottom: 1px solid #000;  border-left: 1px solid #fff;  background: #e4e0d8;  font-size: smaller;  padding: 1px;}.combo .label {  text-align: center;  padding: 1px;}.combo .active {  background: #c4c0b8;  padding: 0px;  border-top: 1px solid #000;  border-right: 1px solid #fff;  border-bottom: 1px solid #fff;  border-left: 1px solid #000;}.combo .hilite {  background: #048;  color: #fea;}");
document.write(".dpContainer {display: inline;}");
document.write("</style>")
/* The main calendar widget.  DIV containing a table. */

