/* Timeline API
 *  Copyright Massachusetts Institute of Technology 
 *  and Contributors 2006-2009 ~ Some rights reserved 
 *  Timeline is open source software and is licensed 
 *  under the BSD license.
 *  http://www.simile-widgets.org/timeline/           
 */
var Timeline = new Object();
Timeline.Platform = new Object();
(function() {
	try {
		(function() {
			if (typeof Timeline_urlPrefix == "string") {
				Timeline.urlPrefix = Timeline_urlPrefix
			} else {
				var l = document.documentElement.getElementsByTagName("head");
				for ( var k = 0; k < l.length; k++) {
					var e = l[k].getElementsByTagName("script");
					for ( var j = 0; j < e.length; j++) {
						var f = e[j].src;
						var g = f.indexOf("timeline-1.2.js");
						if (g >= 0) {
							Timeline.urlPrefix = f.substr(0, g);
							return
						}
					}
				}
				throw new Error(
						"Failed to derive URL prefix for Timeline API code files")
			}
		})();
		var b;
		var d = function() {
			return document.getElementsByTagName("head")[0]
		};
		var a = function(f) {
			if (document.body == null) {
				try {
					document.write("<link rel='stylesheet' href='" + f
							+ "' type='text/css'/>");
					return
				} catch (h) {
				}
			}
			var g = document.createElement("link");
			g.setAttribute("rel", "stylesheet");
			g.setAttribute("type", "text/css");
			g.setAttribute("href", f);
			d().appendChild(g)
		};
		b = function(e, g) {
			for ( var f = 0; f < g.length; f++) {
				a(e + g[f])
			}
		};
		b(Timeline.urlPrefix, [ "timeline-1.2.css" ]);
		Timeline.Platform.serverLocale = "en";
		Timeline.Platform.clientLocale = "en"
	} catch (c) {
		alert(c)
	}
})();
Timeline.strings = {};
Timeline.strings.en = {
	wikiLinkLabel : "Discuss"
};
Timeline.create = function(c, b, a, d) {
	return new Timeline._Impl(c, b, a, d)
};
Timeline.HORIZONTAL = 0;
Timeline.VERTICAL = 1;
Timeline._defaultTheme = null;
Timeline.createBandInfo = function(h) {
	var g = ("theme" in h) ? h.theme : Timeline.getDefaultTheme();
	var f = ("eventSource" in h) ? h.eventSource : null;
	var e = new Timeline.LinearEther({
		centersOn : ("date" in h) ? h.date : new Date(),
		interval : Timeline.DateTime.gregorianUnitLengths[h.intervalUnit],
		pixelsPerInterval : h.intervalPixels
	});
	var c = new Timeline.GregorianEtherPainter({
		unit : h.intervalUnit,
		multiple : ("multiple" in h) ? h.multiple : 1,
		theme : g,
		align : ("align" in h) ? h.align : undefined
	});
	var d = new Timeline.StaticTrackBasedLayout({
		eventSource : f,
		ether : e,
		showText : ("showEventText" in h) ? h.showEventText : true,
		theme : g
	});
	var a = {
		showText : ("showEventText" in h) ? h.showEventText : true,
		layout : d,
		theme : g
	};
	if ("trackHeight" in h) {
		a.trackHeight = h.trackHeight
	}
	if ("trackGap" in h) {
		a.trackGap = h.trackGap
	}
	var b = new Timeline.DurationEventPainter(a);
	return {
		width : h.width,
		eventSource : f,
		timeZone : ("timeZone" in h) ? h.timeZone : 0,
		ether : e,
		etherPainter : c,
		eventPainter : b
	}
};
Timeline.createHotZoneBandInfo = function(h) {
	var g = ("theme" in h) ? h.theme : Timeline.getDefaultTheme();
	var f = ("eventSource" in h) ? h.eventSource : null;
	var e = new Timeline.HotZoneEther({
		centersOn : ("date" in h) ? h.date : new Date(),
		interval : Timeline.DateTime.gregorianUnitLengths[h.intervalUnit],
		pixelsPerInterval : h.intervalPixels,
		zones : h.zones
	});
	var c = new Timeline.HotZoneGregorianEtherPainter({
		unit : h.intervalUnit,
		zones : h.zones,
		theme : g,
		align : ("align" in h) ? h.align : undefined
	});
	var d = new Timeline.StaticTrackBasedLayout({
		eventSource : f,
		ether : e,
		theme : g
	});
	var a = {
		showText : ("showEventText" in h) ? h.showEventText : true,
		layout : d,
		theme : g
	};
	if ("trackHeight" in h) {
		a.trackHeight = h.trackHeight
	}
	if ("trackGap" in h) {
		a.trackGap = h.trackGap
	}
	var b = new Timeline.DurationEventPainter(a);
	return {
		width : h.width,
		eventSource : f,
		timeZone : ("timeZone" in h) ? h.timeZone : 0,
		ether : e,
		etherPainter : c,
		eventPainter : b
	}
};
Timeline.getDefaultTheme = function() {
	if (Timeline._defaultTheme == null) {
		Timeline._defaultTheme = Timeline.ClassicTheme.create(Timeline.Platform
				.getDefaultLocale())
	}
	return Timeline._defaultTheme
};
Timeline.setDefaultTheme = function(a) {
	Timeline._defaultTheme = a
};
Timeline.loadXML = function(a, c) {
	var d = function(g, e, f) {
		alert("Failed to load data xml from " + a + "\n" + g)
	};
	var b = function(f) {
		var e = f.responseXML;
		if (!e.documentElement && f.responseStream) {
			e.load(f.responseStream)
		}
		c(e, a)
	};
	Timeline.XmlHttp.get(a, d, b)
};
Timeline.loadJSON = function(url, f) {
	var fError = function(statusText, status, xmlhttp) {
		alert("Failed to load json data from " + url + "\n" + statusText)
	};
	var fDone = function(xmlhttp) {
		f(eval("(" + xmlhttp.responseText + ")"), url)
	};
	Timeline.XmlHttp.get(url, fError, fDone)
};
Timeline._Impl = function(c, b, a, d) {
	this._containerDiv = c;
	this._bandInfos = b;
	this._orientation = a == null ? Timeline.HORIZONTAL : a;
	this._unit = (d != null) ? d : Timeline.NativeDateUnit;
	this._initialize()
};
Timeline._Impl.prototype.dispose = function() {
	for ( var a = 0; a < this._bands.length; a++) {
		this._bands[a].dispose()
	}
	this._bands = null;
	this._bandInfos = null;
	this._containerDiv.innerHTML = ""
};
Timeline._Impl.prototype.getBandCount = function() {
	return this._bands.length
};
Timeline._Impl.prototype.getBand = function(a) {
	return this._bands[a]
};
Timeline._Impl.prototype.layout = function() {
	this._distributeWidths()
};
Timeline._Impl.prototype.paint = function() {
	for ( var a = 0; a < this._bands.length; a++) {
		this._bands[a].paint()
	}
};
Timeline._Impl.prototype.getDocument = function() {
	return this._containerDiv.ownerDocument
};
Timeline._Impl.prototype.addDiv = function(a) {
	this._containerDiv.appendChild(a)
};
Timeline._Impl.prototype.removeDiv = function(a) {
	this._containerDiv.removeChild(a)
};
Timeline._Impl.prototype.isHorizontal = function() {
	return this._orientation == Timeline.HORIZONTAL
};
Timeline._Impl.prototype.isVertical = function() {
	return this._orientation == Timeline.VERTICAL
};
Timeline._Impl.prototype.getPixelLength = function() {
	return this._orientation == Timeline.HORIZONTAL ? this._containerDiv.offsetWidth
			: this._containerDiv.offsetHeight
};
Timeline._Impl.prototype.getPixelWidth = function() {
	return this._orientation == Timeline.VERTICAL ? this._containerDiv.offsetWidth
			: this._containerDiv.offsetHeight
};
Timeline._Impl.prototype.getUnit = function() {
	return this._unit
};
Timeline._Impl.prototype.loadXML = function(b, d) {
	var a = this;
	var e = function(h, f, g) {
		alert("Failed to load data xml from " + b + "\n" + h);
		a.hideLoadingMessage()
	};
	var c = function(g) {
		try {
			var f = g.responseXML;
			if (!f.documentElement && g.responseStream) {
				f.load(g.responseStream)
			}
			d(f, b)
		} finally {
			a.hideLoadingMessage()
		}
	};
	this.showLoadingMessage();
	window.setTimeout(function() {
		Timeline.XmlHttp.get(b, e, c)
	}, 0)
};
Timeline._Impl.prototype.loadJSON = function(url, f) {
	var tl = this;
	var fError = function(statusText, status, xmlhttp) {
		alert("Failed to load json data from " + url + "\n" + statusText);
		tl.hideLoadingMessage()
	};
	var fDone = function(xmlhttp) {
		try {
			f(eval("(" + xmlhttp.responseText + ")"), url)
		} finally {
			tl.hideLoadingMessage()
		}
	};
	this.showLoadingMessage();
	window.setTimeout(function() {
		Timeline.XmlHttp.get(url, fError, fDone)
	}, 0)
};
Timeline._Impl.prototype._initialize = function() {
	var g = this._containerDiv;
	var d = g.ownerDocument;
	g.className = g.className.split(" ").concat("timeline-container").join(" ");
	while (g.firstChild) {
		g.removeChild(g.firstChild)
	}
	var a = Timeline.Graphics
			.createTranslucentImage(d,
					"http://static.simile.mit.edu/timeline/api/images/copyright-vertical.png");
	a.className = "timeline-copyright";
	a.title = "Timeline (c) SIMILE - http://simile.mit.edu/timeline/";
	Timeline.DOM.registerEvent(a, "click", function() {
		window.location = "http://simile.mit.edu/timeline/"
	});
	g.appendChild(a);
	this._bands = [];
	for ( var b = 0; b < this._bandInfos.length; b++) {
		var f = new Timeline._Band(this, this._bandInfos[b], b);
		this._bands.push(f)
	}
	this._distributeWidths();
	for ( var b = 0; b < this._bandInfos.length; b++) {
		var e = this._bandInfos[b];
		if ("syncWith" in e) {
			this._bands[b].setSyncWithBand(this._bands[e.syncWith],
					("highlight" in e) ? e.highlight : false)
		}
	}
	var c = Timeline.Graphics.createMessageBubble(d);
	c.containerDiv.className = "timeline-message-container";
	g.appendChild(c.containerDiv);
	c.contentDiv.className = "timeline-message";
	c.contentDiv.innerHTML = "<img src='" + Timeline.urlPrefix
			+ "../images/progress-running.gif' /> Loading...";
	this.showLoadingMessage = function() {
		c.containerDiv.style.display = "block"
	};
	this.hideLoadingMessage = function() {
		c.containerDiv.style.display = "none"
	}
};
Timeline._Impl.prototype._distributeWidths = function() {
	var b = this.getPixelLength();
	var a = this.getPixelWidth();
	var d = 0;
	for ( var e = 0; e < this._bands.length; e++) {
		var j = this._bands[e];
		var k = this._bandInfos[e];
		var f = k.width;
		var h = f.indexOf("%");
		if (h > 0) {
			var g = parseInt(f.substr(0, h));
			var c = g * a / 100
		} else {
			var c = parseInt(f)
		}
		j.setBandShiftAndWidth(d, c);
		j.setViewLength(b);
		d += c
	}
};
Timeline._Band = function(f, g, c) {
	this._timeline = f;
	this._bandInfo = g;
	this._index = c;
	this._locale = ("locale" in g) ? g.locale : Timeline.Platform
			.getDefaultLocale();
	this._timeZone = ("timeZone" in g) ? g.timeZone : 0;
	this._labeller = ("labeller" in g) ? g.labeller : f.getUnit()
			.createLabeller(this._locale, this._timeZone);
	this._dragging = false;
	this._changing = false;
	this._originalScrollSpeed = 5;
	this._scrollSpeed = this._originalScrollSpeed;
	this._onScrollListeners = [];
	var a = this;
	this._syncWithBand = null;
	this._syncWithBandHandler = function(b) {
		a._onHighlightBandScroll()
	};
	this._selectorListener = function(b) {
		a._onHighlightBandScroll()
	};
	var e = this._timeline.getDocument().createElement("div");
	e.className = "timeline-band-input";
	this._timeline.addDiv(e);
	this._keyboardInput = document.createElement("input");
	this._keyboardInput.type = "text";
	e.appendChild(this._keyboardInput);
	Timeline.DOM.registerEventWithObject(this._keyboardInput, "keydown", this,
			this._onKeyDown);
	Timeline.DOM.registerEventWithObject(this._keyboardInput, "keyup", this,
			this._onKeyUp);
	this._div = this._timeline.getDocument().createElement("div");
	this._div.className = "timeline-band";
	this._timeline.addDiv(this._div);
	Timeline.DOM.registerEventWithObject(this._div, "mousedown", this,
			this._onMouseDown);
	Timeline.DOM.registerEventWithObject(this._div, "mousemove", this,
			this._onMouseMove);
	Timeline.DOM.registerEventWithObject(this._div, "mouseup", this,
			this._onMouseUp);
	Timeline.DOM.registerEventWithObject(this._div, "mouseout", this,
			this._onMouseOut);
	Timeline.DOM.registerEventWithObject(this._div, "dblclick", this,
			this._onDblClick);
	this._innerDiv = this._timeline.getDocument().createElement("div");
	this._innerDiv.className = "timeline-band-inner";
	this._div.appendChild(this._innerDiv);
	this._ether = g.ether;
	g.ether.initialize(f);
	this._etherPainter = g.etherPainter;
	g.etherPainter.initialize(this, f);
	this._eventSource = g.eventSource;
	if (this._eventSource) {
		this._eventListener = {
			onAddMany : function() {
				a._onAddMany()
			},
			onClear : function() {
				a._onClear()
			}
		};
		this._eventSource.addListener(this._eventListener)
	}
	this._eventPainter = g.eventPainter;
	g.eventPainter.initialize(this, f);
	this._decorators = ("decorators" in g) ? g.decorators : [];
	for ( var d = 0; d < this._decorators.length; d++) {
		this._decorators[d].initialize(this, f)
	}
	this._bubble = null
};
Timeline._Band.SCROLL_MULTIPLES = 5;
Timeline._Band.prototype.dispose = function() {
	this.closeBubble();
	if (this._eventSource) {
		this._eventSource.removeListener(this._eventListener);
		this._eventListener = null;
		this._eventSource = null
	}
	this._timeline = null;
	this._bandInfo = null;
	this._labeller = null;
	this._ether = null;
	this._etherPainter = null;
	this._eventPainter = null;
	this._decorators = null;
	this._onScrollListeners = null;
	this._syncWithBandHandler = null;
	this._selectorListener = null;
	this._div = null;
	this._innerDiv = null;
	this._keyboardInput = null;
	this._bubble = null
};
Timeline._Band.prototype.addOnScrollListener = function(a) {
	this._onScrollListeners.push(a)
};
Timeline._Band.prototype.removeOnScrollListener = function(b) {
	for ( var a = 0; a < this._onScrollListeners.length; a++) {
		if (this._onScrollListeners[a] == b) {
			this._onScrollListeners.splice(a, 1);
			break
		}
	}
};
Timeline._Band.prototype.setSyncWithBand = function(b, a) {
	if (this._syncWithBand) {
		this._syncWithBand.removeOnScrollListener(this._syncWithBandHandler)
	}
	this._syncWithBand = b;
	this._syncWithBand.addOnScrollListener(this._syncWithBandHandler);
	this._highlight = a;
	this._positionHighlight()
};
Timeline._Band.prototype.getLocale = function() {
	return this._locale
};
Timeline._Band.prototype.getTimeZone = function() {
	return this._timeZone
};
Timeline._Band.prototype.getLabeller = function() {
	return this._labeller
};
Timeline._Band.prototype.getIndex = function() {
	return this._index
};
Timeline._Band.prototype.getEther = function() {
	return this._ether
};
Timeline._Band.prototype.getEtherPainter = function() {
	return this._etherPainter
};
Timeline._Band.prototype.getEventSource = function() {
	return this._eventSource
};
Timeline._Band.prototype.getEventPainter = function() {
	return this._eventPainter
};
Timeline._Band.prototype.layout = function() {
	this.paint()
};
Timeline._Band.prototype.paint = function() {
	this._etherPainter.paint();
	this._paintDecorators();
	this._paintEvents()
};
Timeline._Band.prototype.softLayout = function() {
	this.softPaint()
};
Timeline._Band.prototype.softPaint = function() {
	this._etherPainter.softPaint();
	this._softPaintDecorators();
	this._softPaintEvents()
};
Timeline._Band.prototype.setBandShiftAndWidth = function(a, d) {
	var c = this._keyboardInput.parentNode;
	var b = a + Math.floor(d / 2);
	if (this._timeline.isHorizontal()) {
		this._div.style.top = a + "px";
		this._div.style.height = d + "px";
		c.style.top = b + "px";
		c.style.left = "-1em"
	} else {
		this._div.style.left = a + "px";
		this._div.style.width = d + "px";
		c.style.left = b + "px";
		c.style.top = "-1em"
	}
};
Timeline._Band.prototype.getViewWidth = function() {
	if (this._timeline.isHorizontal()) {
		return this._div.offsetHeight
	} else {
		return this._div.offsetWidth
	}
};
Timeline._Band.prototype.setViewLength = function(a) {
	this._viewLength = a;
	this._recenterDiv();
	this._onChanging()
};
Timeline._Band.prototype.getViewLength = function() {
	return this._viewLength
};
Timeline._Band.prototype.getTotalViewLength = function() {
	return Timeline._Band.SCROLL_MULTIPLES * this._viewLength
};
Timeline._Band.prototype.getViewOffset = function() {
	return this._viewOffset
};
Timeline._Band.prototype.getMinDate = function() {
	return this._ether.pixelOffsetToDate(this._viewOffset)
};
Timeline._Band.prototype.getMaxDate = function() {
	return this._ether.pixelOffsetToDate(this._viewOffset
			+ Timeline._Band.SCROLL_MULTIPLES * this._viewLength)
};
Timeline._Band.prototype.getMinVisibleDate = function() {
	return this._ether.pixelOffsetToDate(0)
};
Timeline._Band.prototype.getMaxVisibleDate = function() {
	return this._ether.pixelOffsetToDate(this._viewLength)
};
Timeline._Band.prototype.getCenterVisibleDate = function() {
	return this._ether.pixelOffsetToDate(this._viewLength / 2)
};
Timeline._Band.prototype.setMinVisibleDate = function(a) {
	if (!this._changing) {
		this._moveEther(Math.round(-this._ether.dateToPixelOffset(a)))
	}
};
Timeline._Band.prototype.setMaxVisibleDate = function(a) {
	if (!this._changing) {
		this._moveEther(Math.round(this._viewLength
				- this._ether.dateToPixelOffset(a)))
	}
};
Timeline._Band.prototype.setCenterVisibleDate = function(a) {
	if (!this._changing) {
		this._moveEther(Math.round(this._viewLength / 2
				- this._ether.dateToPixelOffset(a)))
	}
};
Timeline._Band.prototype.dateToPixelOffset = function(a) {
	return this._ether.dateToPixelOffset(a) - this._viewOffset
};
Timeline._Band.prototype.pixelOffsetToDate = function(a) {
	return this._ether.pixelOffsetToDate(a + this._viewOffset)
};
Timeline._Band.prototype.createLayerDiv = function(c) {
	var b = this._timeline.getDocument().createElement("div");
	b.className = "timeline-band-layer";
	b.style.zIndex = c;
	this._innerDiv.appendChild(b);
	var a = this._timeline.getDocument().createElement("div");
	a.className = "timeline-band-layer-inner";
	if (Timeline.Platform.browser.isIE) {
		a.style.cursor = "move"
	} else {
		a.style.cursor = "-moz-grab"
	}
	b.appendChild(a);
	return a
};
Timeline._Band.prototype.removeLayerDiv = function(a) {
	this._innerDiv.removeChild(a.parentNode)
};
Timeline._Band.prototype.closeBubble = function() {
	if (this._bubble != null) {
		this._bubble.close();
		this._bubble = null
	}
};
Timeline._Band.prototype.openBubbleForPoint = function(d, b, c, a) {
	this.closeBubble();
	this._bubble = Timeline.Graphics.createBubbleForPoint(this._timeline
			.getDocument(), d, b, c, a);
	return this._bubble.content
};
Timeline._Band.prototype.scrollToCenter = function(b) {
	var a = this._ether.dateToPixelOffset(b);
	if (a < -this._viewLength / 2) {
		this.setCenterVisibleDate(this.pixelOffsetToDate(a + this._viewLength))
	} else {
		if (a > 3 * this._viewLength / 2) {
			this.setCenterVisibleDate(this.pixelOffsetToDate(a
					- this._viewLength))
		}
	}
	this._autoScroll(Math.round(this._viewLength / 2
			- this._ether.dateToPixelOffset(b)))
};
Timeline._Band.prototype._onMouseDown = function(b, a, c) {
	this.closeBubble();
	this._dragging = true;
	this._dragX = a.clientX;
	this._dragY = a.clientY
};
Timeline._Band.prototype._onMouseMove = function(d, a, e) {
	if (this._dragging) {
		var c = a.clientX - this._dragX;
		var b = a.clientY - this._dragY;
		this._dragX = a.clientX;
		this._dragY = a.clientY;
		this._moveEther(this._timeline.isHorizontal() ? c : b);
		this._positionHighlight()
	}
};
Timeline._Band.prototype._onMouseUp = function(b, a, c) {
	this._dragging = false;
	this._keyboardInput.focus()
};
Timeline._Band.prototype._onMouseOut = function(b, a, d) {
	var c = Timeline.DOM.getEventRelativeCoordinates(a, b);
	c.x += this._viewOffset;
	if (c.x < 0 || c.x > b.offsetWidth || c.y < 0 || c.y > b.offsetHeight) {
		this._dragging = false
	}
};
Timeline._Band.prototype._onDblClick = function(b, a, d) {
	var c = Timeline.DOM.getEventRelativeCoordinates(a, b);
	var e = c.x - (this._viewLength / 2 - this._viewOffset);
	this._autoScroll(-e)
};
Timeline._Band.prototype._onKeyDown = function(b, a, c) {
	if (!this._dragging) {
		switch (a.keyCode) {
		case 27:
			break;
		case 37:
		case 38:
			this._scrollSpeed = Math
					.min(50, Math.abs(this._scrollSpeed * 1.05));
			this._moveEther(this._scrollSpeed);
			break;
		case 39:
		case 40:
			this._scrollSpeed = -Math.min(50, Math
					.abs(this._scrollSpeed * 1.05));
			this._moveEther(this._scrollSpeed);
			break;
		default:
			return true
		}
		this.closeBubble();
		Timeline.DOM.cancelEvent(a);
		return false
	}
	return true
};
Timeline._Band.prototype._onKeyUp = function(b, a, c) {
	if (!this._dragging) {
		this._scrollSpeed = this._originalScrollSpeed;
		switch (a.keyCode) {
		case 35:
			this.setCenterVisibleDate(this._eventSource.getLatestDate());
			break;
		case 36:
			this.setCenterVisibleDate(this._eventSource.getEarliestDate());
			break;
		case 33:
			this._autoScroll(this._timeline.getPixelLength());
			break;
		case 34:
			this._autoScroll(-this._timeline.getPixelLength());
			break;
		default:
			return true
		}
		this.closeBubble();
		Timeline.DOM.cancelEvent(a);
		return false
	}
	return true
};
Timeline._Band.prototype._autoScroll = function(e) {
	var c = this;
	var d = Timeline.Graphics.createAnimation(function(a, b) {
		c._moveEther(b)
	}, 0, e, 1000);
	d.run()
};
Timeline._Band.prototype._moveEther = function(a) {
	this.closeBubble();
	this._viewOffset += a;
	this._ether.shiftPixels(-a);
	if (this._timeline.isHorizontal()) {
		this._div.style.left = this._viewOffset + "px"
	} else {
		this._div.style.top = this._viewOffset + "px"
	}
	if (this._viewOffset > -this._viewLength * 0.5
			|| this._viewOffset < -this._viewLength
					* (Timeline._Band.SCROLL_MULTIPLES - 1.5)) {
		this._recenterDiv()
	} else {
		this.softLayout()
	}
	this._onChanging()
};
Timeline._Band.prototype._onChanging = function() {
	this._changing = true;
	this._fireOnScroll();
	this._setSyncWithBandDate();
	this._changing = false
};
Timeline._Band.prototype._fireOnScroll = function() {
	for ( var a = 0; a < this._onScrollListeners.length; a++) {
		this._onScrollListeners[a](this)
	}
};
Timeline._Band.prototype._setSyncWithBandDate = function() {
	if (this._syncWithBand) {
		var a = this._ether.pixelOffsetToDate(this.getViewLength() / 2);
		this._syncWithBand.setCenterVisibleDate(a)
	}
};
Timeline._Band.prototype._onHighlightBandScroll = function() {
	if (this._syncWithBand) {
		var a = this._syncWithBand.getCenterVisibleDate();
		var b = this._ether.dateToPixelOffset(a);
		this._moveEther(Math.round(this._viewLength / 2 - b));
		if (this._highlight) {
			this._etherPainter.setHighlight(this._syncWithBand
					.getMinVisibleDate(), this._syncWithBand
					.getMaxVisibleDate())
		}
	}
};
Timeline._Band.prototype._onAddMany = function() {
	this._paintEvents()
};
Timeline._Band.prototype._onClear = function() {
	this._paintEvents()
};
Timeline._Band.prototype._positionHighlight = function() {
	if (this._syncWithBand) {
		var a = this._syncWithBand.getMinVisibleDate();
		var b = this._syncWithBand.getMaxVisibleDate();
		if (this._highlight) {
			this._etherPainter.setHighlight(a, b)
		}
	}
};
Timeline._Band.prototype._recenterDiv = function() {
	this._viewOffset = -this._viewLength
			* (Timeline._Band.SCROLL_MULTIPLES - 1) / 2;
	if (this._timeline.isHorizontal()) {
		this._div.style.left = this._viewOffset + "px";
		this._div.style.width = (Timeline._Band.SCROLL_MULTIPLES * this._viewLength)
				+ "px"
	} else {
		this._div.style.top = this._viewOffset + "px";
		this._div.style.height = (Timeline._Band.SCROLL_MULTIPLES * this._viewLength)
				+ "px"
	}
	this.layout()
};
Timeline._Band.prototype._paintEvents = function() {
	this._eventPainter.paint()
};
Timeline._Band.prototype._softPaintEvents = function() {
	this._eventPainter.softPaint()
};
Timeline._Band.prototype._paintDecorators = function() {
	for ( var a = 0; a < this._decorators.length; a++) {
		this._decorators[a].paint()
	}
};
Timeline._Band.prototype._softPaintDecorators = function() {
	for ( var a = 0; a < this._decorators.length; a++) {
		this._decorators[a].softPaint()
	}
};
Timeline.Platform.os = {
	isMac : false,
	isWin : false,
	isWin32 : false,
	isUnix : false
};
Timeline.Platform.browser = {
	isIE : false,
	isNetscape : false,
	isMozilla : false,
	isFirefox : false,
	isOpera : false,
	isSafari : false,
	majorVersion : 0,
	minorVersion : 0
};
(function() {
	var c = navigator.appName.toLowerCase();
	var a = navigator.userAgent.toLowerCase();
	Timeline.Platform.os.isMac = (a.indexOf("mac") != -1);
	Timeline.Platform.os.isWin = (a.indexOf("win") != -1);
	Timeline.Platform.os.isWin32 = Timeline.Platform.isWin
			&& (a.indexOf("95") != -1 || a.indexOf("98") != -1
					|| a.indexOf("nt") != -1 || a.indexOf("win32") != -1 || a
					.indexOf("32bit") != -1);
	Timeline.Platform.os.isUnix = (a.indexOf("x11") != -1);
	Timeline.Platform.browser.isIE = (c.indexOf("microsoft") != -1);
	Timeline.Platform.browser.isNetscape = (c.indexOf("netscape") != -1);
	Timeline.Platform.browser.isMozilla = (a.indexOf("mozilla") != -1);
	Timeline.Platform.browser.isFirefox = (a.indexOf("firefox") != -1);
	Timeline.Platform.browser.isOpera = (c.indexOf("opera") != -1);
	var e = function(g) {
		var f = g.split(".");
		Timeline.Platform.browser.majorVersion = parseInt(f[0]);
		Timeline.Platform.browser.minorVersion = parseInt(f[1])
	};
	var b = function(h, g, j) {
		var f = h.indexOf(g, j);
		return f >= 0 ? f : h.length
	};
	if (Timeline.Platform.browser.isMozilla) {
		var d = a.indexOf("mozilla/");
		if (d >= 0) {
			e(a.substring(d + 8, b(a, " ", d)))
		}
	}
	if (Timeline.Platform.browser.isIE) {
		var d = a.indexOf("msie ");
		if (d >= 0) {
			e(a.substring(d + 5, b(a, ";", d)))
		}
	}
	if (Timeline.Platform.browser.isNetscape) {
		var d = a.indexOf("rv:");
		if (d >= 0) {
			e(a.substring(d + 3, b(a, ")", d)))
		}
	}
	if (Timeline.Platform.browser.isFirefox) {
		var d = a.indexOf("firefox/");
		if (d >= 0) {
			e(a.substring(d + 8, b(a, " ", d)))
		}
	}
})();
Timeline.Platform.getDefaultLocale = function() {
	return Timeline.Platform.clientLocale
};
Timeline.SortedArray = function(b, a) {
	this._a = (a instanceof Array) ? a : [];
	this._compare = b
};
Timeline.SortedArray.prototype.add = function(c) {
	var a = this;
	var b = this.find(function(d) {
		return a._compare(d, c)
	});
	if (b < this._a.length) {
		this._a.splice(b, 0, c)
	} else {
		this._a.push(c)
	}
};
Timeline.SortedArray.prototype.remove = function(c) {
	var a = this;
	var b = this.find(function(d) {
		return a._compare(d, c)
	});
	while (b < this._a.length && this._compare(this._a[b], c) == 0) {
		if (this._a[b] == c) {
			this._a.splice(b, 1);
			return true
		} else {
			b++
		}
	}
	return false
};
Timeline.SortedArray.prototype.removeAll = function() {
	this._a = []
};
Timeline.SortedArray.prototype.elementAt = function(a) {
	return this._a[a]
};
Timeline.SortedArray.prototype.length = function() {
	return this._a.length
};
Timeline.SortedArray.prototype.find = function(g) {
	var e = 0;
	var d = this._a.length;
	while (e < d) {
		var f = Math.floor((e + d) / 2);
		var h = g(this._a[f]);
		if (f == e) {
			return h < 0 ? e + 1 : e
		} else {
			if (h < 0) {
				e = f
			} else {
				d = f
			}
		}
	}
	return e
};
Timeline.SortedArray.prototype.getFirst = function() {
	return (this._a.length > 0) ? this._a[0] : null
};
Timeline.SortedArray.prototype.getLast = function() {
	return (this._a.length > 0) ? this._a[this._a.length - 1] : null
};
Timeline.EventIndex = function(b) {
	var a = this;
	this._unit = (b != null) ? b : Timeline.NativeDateUnit;
	this._events = new Timeline.SortedArray(function(d, c) {
		return a._unit.compare(d.getStart(), c.getStart())
	});
	this._indexed = true
};
Timeline.EventIndex.prototype.getUnit = function() {
	return this._unit
};
Timeline.EventIndex.prototype.add = function(a) {
	this._events.add(a);
	this._indexed = false
};
Timeline.EventIndex.prototype.removeAll = function() {
	this._events.removeAll();
	this._indexed = false
};
Timeline.EventIndex.prototype.getCount = function() {
	return this._events.length()
};
Timeline.EventIndex.prototype.getIterator = function(a, b) {
	if (!this._indexed) {
		this._index()
	}
	return new Timeline.EventIndex._Iterator(this._events, a, b, this._unit)
};
Timeline.EventIndex.prototype.getAllIterator = function() {
	return new Timeline.EventIndex._AllIterator(this._events)
};
Timeline.EventIndex.prototype.getEarliestDate = function() {
	var a = this._events.getFirst();
	return (a == null) ? null : a.getStart()
};
Timeline.EventIndex.prototype.getLatestDate = function() {
	var a = this._events.getLast();
	if (a == null) {
		return null
	}
	if (!this._indexed) {
		this._index()
	}
	var c = a._earliestOverlapIndex;
	var b = this._events.elementAt(c).getEnd();
	for ( var d = c + 1; d < this._events.length(); d++) {
		b = this._unit.later(b, this._events.elementAt(d).getEnd())
	}
	return b
};
Timeline.EventIndex.prototype._index = function() {
	var d = this._events.length();
	for ( var e = 0; e < d; e++) {
		var c = this._events.elementAt(e);
		c._earliestOverlapIndex = e
	}
	var g = 1;
	for ( var e = 0; e < d; e++) {
		var c = this._events.elementAt(e);
		var b = c.getEnd();
		g = Math.max(g, e + 1);
		while (g < d) {
			var a = this._events.elementAt(g);
			var f = a.getStart();
			if (this._unit.compare(f, b) < 0) {
				a._earliestOverlapIndex = e;
				g++
			} else {
				break
			}
		}
	}
	this._indexed = true
};
Timeline.EventIndex._Iterator = function(b, a, d, c) {
	this._events = b;
	this._startDate = a;
	this._endDate = d;
	this._unit = c;
	this._currentIndex = b.find(function(e) {
		return c.compare(e.getStart(), a)
	});
	if (this._currentIndex - 1 >= 0) {
		this._currentIndex = this._events.elementAt(this._currentIndex - 1)._earliestOverlapIndex
	}
	this._currentIndex--;
	this._maxIndex = b.find(function(e) {
		return c.compare(e.getStart(), d)
	});
	this._hasNext = false;
	this._next = null;
	this._findNext()
};
Timeline.EventIndex._Iterator.prototype = {
	hasNext : function() {
		return this._hasNext
	},
	next : function() {
		if (this._hasNext) {
			var a = this._next;
			this._findNext();
			return a
		} else {
			return null
		}
	},
	_findNext : function() {
		var b = this._unit;
		while ((++this._currentIndex) < this._maxIndex) {
			var a = this._events.elementAt(this._currentIndex);
			if (b.compare(a.getStart(), this._endDate) < 0
					&& b.compare(a.getEnd(), this._startDate) > 0) {
				this._next = a;
				this._hasNext = true;
				return
			}
		}
		this._next = null;
		this._hasNext = false
	}
};
Timeline.EventIndex._AllIterator = function(a) {
	this._events = a;
	this._index = 0
};
Timeline.EventIndex._AllIterator.prototype = {
	hasNext : function() {
		return this._index < this._events.length()
	},
	next : function() {
		return this._index < this._events.length() ? this._events
				.elementAt(this._index++) : null
	}
};
Timeline.DateTime = new Object();
Timeline.DateTime.MILLISECOND = 0;
Timeline.DateTime.SECOND = 1;
Timeline.DateTime.MINUTE = 2;
Timeline.DateTime.HOUR = 3;
Timeline.DateTime.DAY = 4;
Timeline.DateTime.WEEK = 5;
Timeline.DateTime.MONTH = 6;
Timeline.DateTime.YEAR = 7;
Timeline.DateTime.DECADE = 8;
Timeline.DateTime.CENTURY = 9;
Timeline.DateTime.MILLENNIUM = 10;
Timeline.DateTime.EPOCH = -1;
Timeline.DateTime.ERA = -2;
Timeline.DateTime.gregorianUnitLengths = [];
(function() {
	var c = Timeline.DateTime;
	var b = c.gregorianUnitLengths;
	b[c.MILLISECOND] = 1;
	b[c.SECOND] = 1000;
	b[c.MINUTE] = b[c.SECOND] * 60;
	b[c.HOUR] = b[c.MINUTE] * 60;
	b[c.DAY] = b[c.HOUR] * 24;
	b[c.WEEK] = b[c.DAY] * 7;
	b[c.MONTH] = b[c.DAY] * 31;
	b[c.YEAR] = b[c.DAY] * 365;
	b[c.DECADE] = b[c.YEAR] * 10;
	b[c.CENTURY] = b[c.YEAR] * 100;
	b[c.MILLENNIUM] = b[c.YEAR] * 1000
})();
Timeline.DateTime.parseGregorianDateTime = function(i) {
	if (i == null) {
		return null
	} else {
		if (i instanceof Date) {
			return i
		}
	}
	var b = i.toString();
	if (b.length > 0 && b.length < 8) {
		var c = b.indexOf(" ");
		if (c > 0) {
			var a = parseInt(b.substr(0, c));
			var g = b.substr(c + 1);
			if (g.toLowerCase() == "bc") {
				a = 1 - a
			}
		} else {
			var a = parseInt(b)
		}
		var h = new Date(0);
		h.setUTCFullYear(a);
		return h
	}
	try {
		return new Date(Date.parse(b))
	} catch (f) {
		return null
	}
};
Timeline.DateTime._iso8601DateRegExp = "^(-?)([0-9]{4})("
		+ [ "(-?([0-9]{2})(-?([0-9]{2}))?)", "(-?([0-9]{3}))",
				"(-?W([0-9]{2})(-?([1-7]))?)" ].join("|") + ")?$";
Timeline.DateTime.setIso8601Date = function(i, g) {
	var k = Timeline.DateTime._iso8601DateRegExp;
	var j = g.match(new RegExp(k));
	if (!j) {
		throw new Error("Invalid date string: " + g)
	}
	var b = (j[1] == "-") ? -1 : 1;
	var l = b * j[2];
	var h = j[5];
	var c = j[7];
	var f = j[9];
	var a = j[11];
	var o = (j[13]) ? j[13] : 1;
	i.setUTCFullYear(l);
	if (f) {
		i.setUTCMonth(0);
		i.setUTCDate(Number(f))
	} else {
		if (a) {
			i.setUTCMonth(0);
			i.setUTCDate(1);
			var n = i.getUTCDay();
			var m = (n) ? n : 7;
			var e = Number(o) + (7 * Number(a));
			if (m <= 4) {
				i.setUTCDate(e + 1 - m)
			} else {
				i.setUTCDate(e + 8 - m)
			}
		} else {
			if (h) {
				i.setUTCDate(1);
				i.setUTCMonth(h - 1)
			}
			if (c) {
				i.setUTCDate(c)
			}
		}
	}
	return i
};
Timeline.DateTime.setIso8601Time = function(h, f) {
	var g = "Z|(([-+])([0-9]{2})(:?([0-9]{2}))?)$";
	var i = f.match(new RegExp(g));
	var c = 0;
	if (i) {
		if (i[0] != "Z") {
			c = (Number(i[3]) * 60) + Number(i[5]);
			c *= ((i[2] == "-") ? 1 : -1)
		}
		f = f.substr(0, f.length - i[0].length)
	}
	var j = "^([0-9]{2})(:?([0-9]{2})(:?([0-9]{2})(.([0-9]+))?)?)?$";
	var i = f.match(new RegExp(j));
	if (!i) {
		dojo.debug("invalid time string: " + f);
		return false
	}
	var k = i[1];
	var b = Number((i[3]) ? i[3] : 0);
	var e = (i[5]) ? i[5] : 0;
	var a = i[7] ? (Number("0." + i[7]) * 1000) : 0;
	h.setUTCHours(k);
	h.setUTCMinutes(b);
	h.setUTCSeconds(e);
	h.setUTCMilliseconds(a);
	return h
};
Timeline.DateTime.setIso8601 = function(b, a) {
	var c = (a.indexOf("T") == -1) ? a.split(" ") : a.split("T");
	Timeline.DateTime.setIso8601Date(b, c[0]);
	if (c.length == 2) {
		Timeline.DateTime.setIso8601Time(b, c[1])
	}
	return b
};
Timeline.DateTime.parseIso8601DateTime = function(a) {
	try {
		return Timeline.DateTime.setIso8601(new Date(0), a)
	} catch (b) {
		return null
	}
};
Timeline.DateTime.roundDownToInterval = function(b, h, k, l, a) {
	var e = k * Timeline.DateTime.gregorianUnitLengths[Timeline.DateTime.HOUR];
	var j = new Date(b.getTime() + e);
	var f = function(m) {
		m.setUTCMilliseconds(0);
		m.setUTCSeconds(0);
		m.setUTCMinutes(0);
		m.setUTCHours(0)
	};
	var c = function(m) {
		f(m);
		m.setUTCDate(1);
		m.setUTCMonth(0)
	};
	switch (h) {
	case Timeline.DateTime.MILLISECOND:
		var i = j.getUTCMilliseconds();
		j.setUTCMilliseconds(i - (i % l));
		break;
	case Timeline.DateTime.SECOND:
		j.setUTCMilliseconds(0);
		var i = j.getUTCSeconds();
		j.setUTCSeconds(i - (i % l));
		break;
	case Timeline.DateTime.MINUTE:
		j.setUTCMilliseconds(0);
		j.setUTCSeconds(0);
		var i = j.getUTCMinutes();
		j
				.setTime(j.getTime()
						- (i % l)
						* Timeline.DateTime.gregorianUnitLengths[Timeline.DateTime.MINUTE]);
		break;
	case Timeline.DateTime.HOUR:
		j.setUTCMilliseconds(0);
		j.setUTCSeconds(0);
		j.setUTCMinutes(0);
		var i = j.getUTCHours();
		j.setUTCHours(i - (i % l));
		break;
	case Timeline.DateTime.DAY:
		f(j);
		break;
	case Timeline.DateTime.WEEK:
		f(j);
		var g = (j.getUTCDay() + 7 - a) % 7;
		j
				.setTime(j.getTime()
						- g
						* Timeline.DateTime.gregorianUnitLengths[Timeline.DateTime.DAY]);
		break;
	case Timeline.DateTime.MONTH:
		f(j);
		j.setUTCDate(1);
		var i = j.getUTCMonth();
		j.setUTCMonth(i - (i % l));
		break;
	case Timeline.DateTime.YEAR:
		c(j);
		var i = j.getUTCFullYear();
		j.setUTCFullYear(i - (i % l));
		break;
	case Timeline.DateTime.DECADE:
		c(j);
		j.setUTCFullYear(Math.floor(j.getUTCFullYear() / 10) * 10);
		break;
	case Timeline.DateTime.CENTURY:
		c(j);
		j.setUTCFullYear(Math.floor(j.getUTCFullYear() / 100) * 100);
		break;
	case Timeline.DateTime.MILLENNIUM:
		c(j);
		j.setUTCFullYear(Math.floor(j.getUTCFullYear() / 1000) * 1000);
		break
	}
	b.setTime(j.getTime() - e)
};
Timeline.DateTime.roundUpToInterval = function(d, f, c, a, b) {
	var e = d.getTime();
	Timeline.DateTime.roundDownToInterval(d, f, c, a, b);
	if (d.getTime() < e) {
		d.setTime(d.getTime() + Timeline.DateTime.gregorianUnitLengths[f] * a)
	}
};
Timeline.DateTime.incrementByInterval = function(a, b) {
	switch (b) {
	case Timeline.DateTime.MILLISECOND:
		a.setTime(a.getTime() + 1);
		break;
	case Timeline.DateTime.SECOND:
		a.setTime(a.getTime() + 1000);
		break;
	case Timeline.DateTime.MINUTE:
		a
				.setTime(a.getTime()
						+ Timeline.DateTime.gregorianUnitLengths[Timeline.DateTime.MINUTE]);
		break;
	case Timeline.DateTime.HOUR:
		a
				.setTime(a.getTime()
						+ Timeline.DateTime.gregorianUnitLengths[Timeline.DateTime.HOUR]);
		break;
	case Timeline.DateTime.DAY:
		a.setUTCDate(a.getUTCDate() + 1);
		break;
	case Timeline.DateTime.WEEK:
		a.setUTCDate(a.getUTCDate() + 7);
		break;
	case Timeline.DateTime.MONTH:
		a.setUTCMonth(a.getUTCMonth() + 1);
		break;
	case Timeline.DateTime.YEAR:
		a.setUTCFullYear(a.getUTCFullYear() + 1);
		break;
	case Timeline.DateTime.DECADE:
		a.setUTCFullYear(a.getUTCFullYear() + 10);
		break;
	case Timeline.DateTime.CENTURY:
		a.setUTCFullYear(a.getUTCFullYear() + 100);
		break;
	case Timeline.DateTime.MILLENNIUM:
		a.setUTCFullYear(a.getUTCFullYear() + 1000);
		break
	}
};
Timeline.DateTime.removeTimeZoneOffset = function(b, a) {
	return new Date(b.getTime() + a
			* Timeline.DateTime.gregorianUnitLengths[Timeline.DateTime.HOUR])
};
Timeline.Debug = new Object();
Timeline.Debug.log = function(a) {
};
Timeline.Debug.exception = function(a) {
	alert("Caught exception: " + (Timeline.Platform.isIE ? a.message : a))
};
Timeline.DOM = new Object();
Timeline.DOM.registerEventWithObject = function(b, a, d, c) {
	Timeline.DOM.registerEvent(b, a, function(f, e, g) {
		return c.call(d, f, e, g)
	})
};
Timeline.DOM.registerEvent = function(c, b, d) {
	var a = function(e) {
		e = (e) ? e : ((event) ? event : null);
		if (e) {
			var f = (e.target) ? e.target : ((e.srcElement) ? e.srcElement
					: null);
			if (f) {
				f = (f.nodeType == 1 || f.nodeType == 9) ? f : f.parentNode
			}
			return d(c, e, f)
		}
		return true
	};
	if (Timeline.Platform.browser.isIE) {
		c.attachEvent("on" + b, a)
	} else {
		c.addEventListener(b, a, false)
	}
};
Timeline.DOM.getPageCoordinates = function(a) {
	var c = 0;
	var b = 0;
	if (a.nodeType != 1) {
		a = a.parentNode
	}
	while (a != null) {
		c += a.offsetLeft;
		b += a.offsetTop;
		a = a.offsetParent
	}
	return {
		left : c,
		top : b
	}
};
Timeline.DOM.getEventRelativeCoordinates = function(a, b) {
	if (Timeline.Platform.browser.isIE) {
		return {
			x : a.offsetX,
			y : a.offsetY
		}
	} else {
		var c = Timeline.DOM.getPageCoordinates(b);
		return {
			x : a.pageX - c.left,
			y : a.pageY - c.top
		}
	}
};
Timeline.DOM.cancelEvent = function(a) {
	a.returnValue = false;
	a.cancelBubble = true;
	if ("preventDefault" in a) {
		a.preventDefault()
	}
};
Timeline.Graphics = new Object();
Timeline.Graphics.pngIsTranslucent = (!Timeline.Platform.browser.isIE)
		|| (Timeline.Platform.browser.majorVersion > 6);
Timeline.Graphics.createTranslucentImage = function(c, a, d) {
	var b;
	if (Timeline.Graphics.pngIsTranslucent) {
		b = c.createElement("img");
		b.setAttribute("src", a)
	} else {
		b = c.createElement("img");
		b.style.display = "inline";
		b.style.width = "1px";
		b.style.height = "1px";
		b.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"
				+ a + "', sizingMethod='image')"
	}
	b.style.verticalAlign = (d != null) ? d : "middle";
	return b
};
Timeline.Graphics.setOpacity = function(b, a) {
	if (Timeline.Platform.browser.isIE) {
		b.style.filter = "progid:DXImageTransform.Microsoft.Alpha(Style=0,Opacity="
				+ a + ")"
	} else {
		var c = (a / 100).toString();
		b.style.opacity = c;
		b.style.MozOpacity = c
	}
};
Timeline.Graphics._bubbleMargins = {
	top : 33,
	bottom : 42,
	left : 33,
	right : 40
};
Timeline.Graphics._arrowOffsets = {
	top : 0,
	bottom : 9,
	left : 1,
	right : 8
};
Timeline.Graphics._bubblePadding = 15;
Timeline.Graphics._bubblePointOffset = 6;
Timeline.Graphics._halfArrowWidth = 18;
Timeline.Graphics.createBubbleForPoint = function(u, c, b, l, p) {
	function r() {
		if (typeof window.innerWidth == "number") {
			return {
				w : window.innerWidth,
				h : window.innerHeight
			}
		} else {
			if (document.documentElement
					&& document.documentElement.clientWidth) {
				return {
					w : document.documentElement.clientWidth,
					h : document.documentElement.clientHeight
				}
			} else {
				if (document.body && document.body.clientWidth) {
					return {
						w : document.body.clientWidth,
						h : document.body.clientHeight
					}
				}
			}
		}
	}
	var k = {
		_closed : false,
		_doc : u,
		close : function() {
			if (!this._closed) {
				this._doc.body.removeChild(this._div);
				this._doc = null;
				this._div = null;
				this._content = null;
				this._closed = true
			}
		}
	};
	var m = r();
	var g = m.w;
	var f = m.h;
	var d = Timeline.Graphics._bubbleMargins;
	l = parseInt(l, 10);
	p = parseInt(p, 10);
	var n = d.left + l + d.right;
	var s = d.top + p + d.bottom;
	var o = Timeline.Graphics.pngIsTranslucent;
	var i = Timeline.urlPrefix;
	var a = function(x, w, y, v) {
		x.style.position = "absolute";
		x.style.width = y + "px";
		x.style.height = v + "px";
		if (o) {
			x.style.background = "url(" + w + ")"
		} else {
			x.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"
					+ w + "', sizingMethod='crop')"
		}
	};
	var j = u.createElement("div");
	j.style.width = n + "px";
	j.style.height = s + "px";
	j.style.position = "absolute";
	j.style.zIndex = 1000;
	k._div = j;
	var h = u.createElement("div");
	h.style.width = "100%";
	h.style.height = "100%";
	h.style.position = "relative";
	j.appendChild(h);
	var q = function(x, A, z, y, w) {
		var v = u.createElement("div");
		v.style.left = A + "px";
		v.style.top = z + "px";
		a(v, x, y, w);
		h.appendChild(v)
	};
	q(i + "images/bubble-top-left.png", 0, 0, d.left, d.top);
	q(i + "images/bubble-top.png", d.left, 0, l, d.top);
	q(i + "images/bubble-top-right.png", d.left + l, 0, d.right, d.top);
	q(i + "images/bubble-left.png", 0, d.top, d.left, p);
	q(i + "images/bubble-right.png", d.left + l, d.top, d.right, p);
	q(i + "images/bubble-bottom-left.png", 0, d.top + p, d.left, d.bottom);
	q(i + "images/bubble-bottom.png", d.left, d.top + p, l, d.bottom);
	q(i + "images/bubble-bottom-right.png", d.left + l, d.top + p, d.right,
			d.bottom);
	var t = u.createElement("div");
	t.style.left = (n - d.right + Timeline.Graphics._bubblePadding - 16 - 2)
			+ "px";
	t.style.top = (d.top - Timeline.Graphics._bubblePadding + 1) + "px";
	t.style.cursor = "pointer";
	a(t, i + "images/close-button.png", 16, 16);
	Timeline.DOM.registerEventWithObject(t, "click", k, k.close);
	h.appendChild(t);
	var e = u.createElement("div");
	e.style.position = "absolute";
	e.style.left = d.left + "px";
	e.style.top = d.top + "px";
	e.style.width = l + "px";
	e.style.height = p + "px";
	e.style.overflow = "auto";
	e.style.background = "white";
	h.appendChild(e);
	k.content = e;
	(function() {
		if (c - Timeline.Graphics._halfArrowWidth
				- Timeline.Graphics._bubblePadding > 0
				&& c + Timeline.Graphics._halfArrowWidth
						+ Timeline.Graphics._bubblePadding < g) {
			var x = c - Math.round(l / 2) - d.left;
			x = c < (g / 2) ? Math.max(x,
					-(d.left - Timeline.Graphics._bubblePadding)) : Math.min(x,
					g + (d.right - Timeline.Graphics._bubblePadding) - n);
			if (b - Timeline.Graphics._bubblePointOffset - s > 0) {
				var v = u.createElement("div");
				v.style.left = (c - Timeline.Graphics._halfArrowWidth - x)
						+ "px";
				v.style.top = (d.top + p) + "px";
				a(v, i + "images/bubble-bottom-arrow.png", 37, d.bottom);
				h.appendChild(v);
				j.style.left = x + "px";
				j.style.top = (b - Timeline.Graphics._bubblePointOffset - s + Timeline.Graphics._arrowOffsets.bottom)
						+ "px";
				return
			} else {
				if (b + Timeline.Graphics._bubblePointOffset + s < f) {
					var v = u.createElement("div");
					v.style.left = (c - Timeline.Graphics._halfArrowWidth - x)
							+ "px";
					v.style.top = "0px";
					a(v, i + "images/bubble-top-arrow.png", 37, d.top);
					h.appendChild(v);
					j.style.left = x + "px";
					j.style.top = (b + Timeline.Graphics._bubblePointOffset - Timeline.Graphics._arrowOffsets.top)
							+ "px";
					return
				}
			}
		}
		var w = b - Math.round(p / 2) - d.top;
		w = b < (f / 2) ? Math.max(w,
				-(d.top - Timeline.Graphics._bubblePadding)) : Math.min(w, f
				+ (d.bottom - Timeline.Graphics._bubblePadding) - s);
		if (c - Timeline.Graphics._bubblePointOffset - n > 0) {
			var v = u.createElement("div");
			v.style.left = (d.left + l) + "px";
			v.style.top = (b - Timeline.Graphics._halfArrowWidth - w) + "px";
			a(v, i + "images/bubble-right-arrow.png", d.right, 37);
			h.appendChild(v);
			j.style.left = (c - Timeline.Graphics._bubblePointOffset - n + Timeline.Graphics._arrowOffsets.right)
					+ "px";
			j.style.top = w + "px"
		} else {
			var v = u.createElement("div");
			v.style.left = "0px";
			v.style.top = (b - Timeline.Graphics._halfArrowWidth - w) + "px";
			a(v, i + "images/bubble-left-arrow.png", d.left, 37);
			h.appendChild(v);
			j.style.left = (c + Timeline.Graphics._bubblePointOffset - Timeline.Graphics._arrowOffsets.left)
					+ "px";
			j.style.top = w + "px"
		}
	})();
	u.body.appendChild(j);
	return k
};
Timeline.Graphics.createMessageBubble = function(h) {
	var g = h.createElement("div");
	if (Timeline.Graphics.pngIsTranslucent) {
		var i = h.createElement("div");
		i.style.height = "33px";
		i.style.background = "url(" + Timeline.urlPrefix
				+ "images/message-top-left.png) top left no-repeat";
		i.style.paddingLeft = "44px";
		g.appendChild(i);
		var c = h.createElement("div");
		c.style.height = "33px";
		c.style.background = "url(" + Timeline.urlPrefix
				+ "images/message-top-right.png) top right no-repeat";
		i.appendChild(c);
		var f = h.createElement("div");
		f.style.background = "url(" + Timeline.urlPrefix
				+ "images/message-left.png) top left repeat-y";
		f.style.paddingLeft = "44px";
		g.appendChild(f);
		var a = h.createElement("div");
		a.style.background = "url(" + Timeline.urlPrefix
				+ "images/message-right.png) top right repeat-y";
		a.style.paddingRight = "44px";
		f.appendChild(a);
		var d = h.createElement("div");
		a.appendChild(d);
		var b = h.createElement("div");
		b.style.height = "55px";
		b.style.background = "url(" + Timeline.urlPrefix
				+ "images/message-bottom-left.png) bottom left no-repeat";
		b.style.paddingLeft = "44px";
		g.appendChild(b);
		var e = h.createElement("div");
		e.style.height = "55px";
		e.style.background = "url(" + Timeline.urlPrefix
				+ "images/message-bottom-right.png) bottom right no-repeat";
		b.appendChild(e)
	} else {
		g.style.border = "2px solid #7777AA";
		g.style.padding = "20px";
		g.style.background = "white";
		Timeline.Graphics.setOpacity(g, 90);
		var d = h.createElement("div");
		g.appendChild(d)
	}
	return {
		containerDiv : g,
		contentDiv : d
	}
};
Timeline.Graphics.createAnimation = function(a, d, c, b) {
	return new Timeline.Graphics._Animation(a, d, c, b)
};
Timeline.Graphics._Animation = function(a, d, c, b) {
	this.f = a;
	this.from = d;
	this.to = c;
	this.current = d;
	this.duration = b;
	this.start = new Date().getTime();
	this.timePassed = 0
};
Timeline.Graphics._Animation.prototype.run = function() {
	var b = this;
	window.setTimeout(function() {
		b.step()
	}, 100)
};
Timeline.Graphics._Animation.prototype.step = function() {
	this.timePassed += 100;
	var b = this.timePassed / this.duration;
	var a = -Math.cos(b * Math.PI) / 2 + 0.5;
	var d = a * (this.to - this.from) + this.from;
	try {
		this.f(d, d - this.current)
	} catch (c) {
	}
	this.current = d;
	if (this.timePassed < this.duration) {
		this.run()
	}
};
Timeline.HTML = new Object();
Timeline.HTML._e2uHash = {};
(function() {
	e2uHash = Timeline.HTML._e2uHash;
	e2uHash.nbsp = "\u00A0[space]";
	e2uHash.iexcl = "\u00A1";
	e2uHash.cent = "\u00A2";
	e2uHash.pound = "\u00A3";
	e2uHash.curren = "\u00A4";
	e2uHash.yen = "\u00A5";
	e2uHash.brvbar = "\u00A6";
	e2uHash.sect = "\u00A7";
	e2uHash.uml = "\u00A8";
	e2uHash.copy = "\u00A9";
	e2uHash.ordf = "\u00AA";
	e2uHash.laquo = "\u00AB";
	e2uHash.not = "\u00AC";
	e2uHash.shy = "\u00AD";
	e2uHash.reg = "\u00AE";
	e2uHash.macr = "\u00AF";
	e2uHash.deg = "\u00B0";
	e2uHash.plusmn = "\u00B1";
	e2uHash.sup2 = "\u00B2";
	e2uHash.sup3 = "\u00B3";
	e2uHash.acute = "\u00B4";
	e2uHash.micro = "\u00B5";
	e2uHash.para = "\u00B6";
	e2uHash.middot = "\u00B7";
	e2uHash.cedil = "\u00B8";
	e2uHash.sup1 = "\u00B9";
	e2uHash.ordm = "\u00BA";
	e2uHash.raquo = "\u00BB";
	e2uHash.frac14 = "\u00BC";
	e2uHash.frac12 = "\u00BD";
	e2uHash.frac34 = "\u00BE";
	e2uHash.iquest = "\u00BF";
	e2uHash.Agrave = "\u00C0";
	e2uHash.Aacute = "\u00C1";
	e2uHash.Acirc = "\u00C2";
	e2uHash.Atilde = "\u00C3";
	e2uHash.Auml = "\u00C4";
	e2uHash.Aring = "\u00C5";
	e2uHash.AElig = "\u00C6";
	e2uHash.Ccedil = "\u00C7";
	e2uHash.Egrave = "\u00C8";
	e2uHash.Eacute = "\u00C9";
	e2uHash.Ecirc = "\u00CA";
	e2uHash.Euml = "\u00CB";
	e2uHash.Igrave = "\u00CC";
	e2uHash.Iacute = "\u00CD";
	e2uHash.Icirc = "\u00CE";
	e2uHash.Iuml = "\u00CF";
	e2uHash.ETH = "\u00D0";
	e2uHash.Ntilde = "\u00D1";
	e2uHash.Ograve = "\u00D2";
	e2uHash.Oacute = "\u00D3";
	e2uHash.Ocirc = "\u00D4";
	e2uHash.Otilde = "\u00D5";
	e2uHash.Ouml = "\u00D6";
	e2uHash.times = "\u00D7";
	e2uHash.Oslash = "\u00D8";
	e2uHash.Ugrave = "\u00D9";
	e2uHash.Uacute = "\u00DA";
	e2uHash.Ucirc = "\u00DB";
	e2uHash.Uuml = "\u00DC";
	e2uHash.Yacute = "\u00DD";
	e2uHash.THORN = "\u00DE";
	e2uHash.szlig = "\u00DF";
	e2uHash.agrave = "\u00E0";
	e2uHash.aacute = "\u00E1";
	e2uHash.acirc = "\u00E2";
	e2uHash.atilde = "\u00E3";
	e2uHash.auml = "\u00E4";
	e2uHash.aring = "\u00E5";
	e2uHash.aelig = "\u00E6";
	e2uHash.ccedil = "\u00E7";
	e2uHash.egrave = "\u00E8";
	e2uHash.eacute = "\u00E9";
	e2uHash.ecirc = "\u00EA";
	e2uHash.euml = "\u00EB";
	e2uHash.igrave = "\u00EC";
	e2uHash.iacute = "\u00ED";
	e2uHash.icirc = "\u00EE";
	e2uHash.iuml = "\u00EF";
	e2uHash.eth = "\u00F0";
	e2uHash.ntilde = "\u00F1";
	e2uHash.ograve = "\u00F2";
	e2uHash.oacute = "\u00F3";
	e2uHash.ocirc = "\u00F4";
	e2uHash.otilde = "\u00F5";
	e2uHash.ouml = "\u00F6";
	e2uHash.divide = "\u00F7";
	e2uHash.oslash = "\u00F8";
	e2uHash.ugrave = "\u00F9";
	e2uHash.uacute = "\u00FA";
	e2uHash.ucirc = "\u00FB";
	e2uHash.uuml = "\u00FC";
	e2uHash.yacute = "\u00FD";
	e2uHash.thorn = "\u00FE";
	e2uHash.yuml = "\u00FF";
	e2uHash.quot = "\u0022";
	e2uHash.amp = "\u0026";
	e2uHash.lt = "\u003C";
	e2uHash.gt = "\u003E";
	e2uHash.OElig = "";
	e2uHash.oelig = "\u0153";
	e2uHash.Scaron = "\u0160";
	e2uHash.scaron = "\u0161";
	e2uHash.Yuml = "\u0178";
	e2uHash.circ = "\u02C6";
	e2uHash.tilde = "\u02DC";
	e2uHash.ensp = "\u2002";
	e2uHash.emsp = "\u2003";
	e2uHash.thinsp = "\u2009";
	e2uHash.zwnj = "\u200C";
	e2uHash.zwj = "\u200D";
	e2uHash.lrm = "\u200E";
	e2uHash.rlm = "\u200F";
	e2uHash.ndash = "\u2013";
	e2uHash.mdash = "\u2014";
	e2uHash.lsquo = "\u2018";
	e2uHash.rsquo = "\u2019";
	e2uHash.sbquo = "\u201A";
	e2uHash.ldquo = "\u201C";
	e2uHash.rdquo = "\u201D";
	e2uHash.bdquo = "\u201E";
	e2uHash.dagger = "\u2020";
	e2uHash.Dagger = "\u2021";
	e2uHash.permil = "\u2030";
	e2uHash.lsaquo = "\u2039";
	e2uHash.rsaquo = "\u203A";
	e2uHash.euro = "\u20AC";
	e2uHash.fnof = "\u0192";
	e2uHash.Alpha = "\u0391";
	e2uHash.Beta = "\u0392";
	e2uHash.Gamma = "\u0393";
	e2uHash.Delta = "\u0394";
	e2uHash.Epsilon = "\u0395";
	e2uHash.Zeta = "\u0396";
	e2uHash.Eta = "\u0397";
	e2uHash.Theta = "\u0398";
	e2uHash.Iota = "\u0399";
	e2uHash.Kappa = "\u039A";
	e2uHash.Lambda = "\u039B";
	e2uHash.Mu = "\u039C";
	e2uHash.Nu = "\u039D";
	e2uHash.Xi = "\u039E";
	e2uHash.Omicron = "\u039F";
	e2uHash.Pi = "\u03A0";
	e2uHash.Rho = "\u03A1";
	e2uHash.Sigma = "\u03A3";
	e2uHash.Tau = "\u03A4";
	e2uHash.Upsilon = "\u03A5";
	e2uHash.Phi = "\u03A6";
	e2uHash.Chi = "\u03A7";
	e2uHash.Psi = "\u03A8";
	e2uHash.Omega = "\u03A9";
	e2uHash.alpha = "\u03B1";
	e2uHash.beta = "\u03B2";
	e2uHash.gamma = "\u03B3";
	e2uHash.delta = "\u03B4";
	e2uHash.epsilon = "\u03B5";
	e2uHash.zeta = "\u03B6";
	e2uHash.eta = "\u03B7";
	e2uHash.theta = "\u03B8";
	e2uHash.iota = "\u03B9";
	e2uHash.kappa = "\u03BA";
	e2uHash.lambda = "\u03BB";
	e2uHash.mu = "\u03BC";
	e2uHash.nu = "\u03BD";
	e2uHash.xi = "\u03BE";
	e2uHash.omicron = "\u03BF";
	e2uHash.pi = "\u03C0";
	e2uHash.rho = "\u03C1";
	e2uHash.sigmaf = "\u03C2";
	e2uHash.sigma = "\u03C3";
	e2uHash.tau = "\u03C4";
	e2uHash.upsilon = "\u03C5";
	e2uHash.phi = "\u03C6";
	e2uHash.chi = "\u03C7";
	e2uHash.psi = "\u03C8";
	e2uHash.omega = "\u03C9";
	e2uHash.thetasym = "\u03D1";
	e2uHash.upsih = "\u03D2";
	e2uHash.piv = "\u03D6";
	e2uHash.bull = "\u2022";
	e2uHash.hellip = "\u2026";
	e2uHash.prime = "\u2032";
	e2uHash.Prime = "\u2033";
	e2uHash.oline = "\u203E";
	e2uHash.frasl = "\u2044";
	e2uHash.weierp = "\u2118";
	e2uHash.image = "\u2111";
	e2uHash.real = "\u211C";
	e2uHash.trade = "\u2122";
	e2uHash.alefsym = "\u2135";
	e2uHash.larr = "\u2190";
	e2uHash.uarr = "\u2191";
	e2uHash.rarr = "\u2192";
	e2uHash.darr = "\u2193";
	e2uHash.harr = "\u2194";
	e2uHash.crarr = "\u21B5";
	e2uHash.lArr = "\u21D0";
	e2uHash.uArr = "\u21D1";
	e2uHash.rArr = "\u21D2";
	e2uHash.dArr = "\u21D3";
	e2uHash.hArr = "\u21D4";
	e2uHash.forall = "\u2200";
	e2uHash.part = "\u2202";
	e2uHash.exist = "\u2203";
	e2uHash.empty = "\u2205";
	e2uHash.nabla = "\u2207";
	e2uHash.isin = "\u2208";
	e2uHash.notin = "\u2209";
	e2uHash.ni = "\u220B";
	e2uHash.prod = "\u220F";
	e2uHash.sum = "\u2211";
	e2uHash.minus = "\u2212";
	e2uHash.lowast = "\u2217";
	e2uHash.radic = "\u221A";
	e2uHash.prop = "\u221D";
	e2uHash.infin = "\u221E";
	e2uHash.ang = "\u2220";
	e2uHash.and = "\u2227";
	e2uHash.or = "\u2228";
	e2uHash.cap = "\u2229";
	e2uHash.cup = "\u222A";
	e2uHash["int"] = "\u222B";
	e2uHash.there4 = "\u2234";
	e2uHash.sim = "\u223C";
	e2uHash.cong = "\u2245";
	e2uHash.asymp = "\u2248";
	e2uHash.ne = "\u2260";
	e2uHash.equiv = "\u2261";
	e2uHash.le = "\u2264";
	e2uHash.ge = "\u2265";
	e2uHash.sub = "\u2282";
	e2uHash.sup = "\u2283";
	e2uHash.nsub = "\u2284";
	e2uHash.sube = "\u2286";
	e2uHash.supe = "\u2287";
	e2uHash.oplus = "\u2295";
	e2uHash.otimes = "\u2297";
	e2uHash.perp = "\u22A5";
	e2uHash.sdot = "\u22C5";
	e2uHash.lceil = "\u2308";
	e2uHash.rceil = "\u2309";
	e2uHash.lfloor = "\u230A";
	e2uHash.rfloor = "\u230B";
	e2uHash.lang = "\u2329";
	e2uHash.rang = "\u232A";
	e2uHash.loz = "\u25CA";
	e2uHash.spades = "\u2660";
	e2uHash.clubs = "\u2663";
	e2uHash.hearts = "\u2665";
	e2uHash.diams = "\u2666"
})();
Timeline.HTML.deEntify = function(c) {
	e2uHash = Timeline.HTML._e2uHash;
	var b = /&(\w+?);/;
	while (b.test(c)) {
		var a = c.match(b);
		c = c.replace(b, e2uHash[a[1]])
	}
	return c
};
Timeline.XmlHttp = new Object();
Timeline.XmlHttp._onReadyStateChange = function(a, d, b) {
	switch (a.readyState) {
	case 4:
		try {
			if (a.status == 0 || a.status == 200) {
				if (b) {
					b(a)
				}
			} else {
				if (d) {
					d(a.statusText, a.status, a)
				}
			}
		} catch (c) {
			Timeline.Debug.exception(c)
		}
		break
	}
};
Timeline.XmlHttp._createRequest = function() {
	if (Timeline.Platform.browser.isIE) {
		var a = [ "Msxml2.XMLHTTP", "Microsoft.XMLHTTP", "Msxml2.XMLHTTP.4.0" ];
		for ( var b = 0; b < a.length; b++) {
			try {
				var c = a[b];
				var d = function() {
					return new ActiveXObject(c)
				};
				var h = d();
				Timeline.XmlHttp._createRequest = d;
				return h
			} catch (g) {
			}
		}
		throw new Error("Failed to create an XMLHttpRequest object")
	} else {
		try {
			var d = function() {
				return new XMLHttpRequest()
			};
			var h = d();
			Timeline.XmlHttp._createRequest = d;
			return h
		} catch (g) {
			throw new Error("Failed to create an XMLHttpRequest object")
		}
	}
};
Timeline.XmlHttp.get = function(a, d, c) {
	var b = Timeline.XmlHttp._createRequest();
	b.open("GET", a, true);
	b.onreadystatechange = function() {
		Timeline.XmlHttp._onReadyStateChange(b, d, c)
	};
	b.send(null)
};
Timeline.XmlHttp.post = function(b, a, e, d) {
	var c = Timeline.XmlHttp._createRequest();
	c.open("POST", b, true);
	c.onreadystatechange = function() {
		Timeline.XmlHttp._onReadyStateChange(c, e, d)
	};
	c.send(a)
};
Timeline.XmlHttp._forceXML = function(a) {
	try {
		a.overrideMimeType("text/xml")
	} catch (b) {
		a.setrequestheader("Content-Type", "text/xml")
	}
};
Timeline.SpanHighlightDecorator = function(a) {
	this._unit = ("unit" in a) ? a.unit : Timeline.NativeDateUnit;
	this._startDate = (typeof a.startDate == "string") ? this._unit
			.parseFromObject(a.startDate) : a.startDate;
	this._endDate = (typeof a.endDate == "string") ? this._unit
			.parseFromObject(a.endDate) : a.endDate;
	this._startLabel = a.startLabel;
	this._endLabel = a.endLabel;
	this._color = a.color;
	this._opacity = ("opacity" in a) ? a.opacity : 100
};
Timeline.SpanHighlightDecorator.prototype.initialize = function(b, a) {
	this._band = b;
	this._timeline = a;
	this._layerDiv = null
};
Timeline.SpanHighlightDecorator.prototype.paint = function() {
	if (this._layerDiv != null) {
		this._band.removeLayerDiv(this._layerDiv)
	}
	this._layerDiv = this._band.createLayerDiv(10);
	this._layerDiv.setAttribute("name", "span-highlight-decorator");
	this._layerDiv.style.display = "none";
	var e = this._band.getMinDate();
	var c = this._band.getMaxDate();
	if (this._unit.compare(this._startDate, c) < 0
			&& this._unit.compare(this._endDate, e) > 0) {
		e = this._unit.later(e, this._startDate);
		c = this._unit.earlier(c, this._endDate);
		var d = this._band.dateToPixelOffset(e);
		var i = this._band.dateToPixelOffset(c);
		var g = this._timeline.getDocument();
		var f = function() {
			var j = g.createElement("table");
			j.insertRow(0).insertCell(0);
			return j
		};
		var b = g.createElement("div");
		b.style.position = "absolute";
		b.style.overflow = "hidden";
		b.style.background = this._color;
		if (this._opacity < 100) {
			Timeline.Graphics.setOpacity(b, this._opacity)
		}
		this._layerDiv.appendChild(b);
		var h = f();
		h.style.position = "absolute";
		h.style.overflow = "hidden";
		h.style.fontSize = "300%";
		h.style.fontWeight = "bold";
		h.style.color = this._color;
		h.rows[0].cells[0].innerHTML = this._startLabel;
		this._layerDiv.appendChild(h);
		var a = f();
		a.style.position = "absolute";
		a.style.overflow = "hidden";
		a.style.fontSize = "300%";
		a.style.fontWeight = "bold";
		a.style.color = this._color;
		a.rows[0].cells[0].innerHTML = this._endLabel;
		this._layerDiv.appendChild(a);
		if (this._timeline.isHorizontal()) {
			b.style.left = d + "px";
			b.style.width = (i - d) + "px";
			b.style.top = "0px";
			b.style.height = "100%";
			h.style.right = (this._band.getTotalViewLength() - d) + "px";
			h.style.width = (this._startLabel.length) + "em";
			h.style.top = "0px";
			h.style.height = "100%";
			h.style.textAlign = "right";
			a.style.left = i + "px";
			a.style.width = (this._endLabel.length) + "em";
			a.style.top = "0px";
			a.style.height = "100%"
		} else {
			b.style.top = d + "px";
			b.style.height = (i - d) + "px";
			b.style.left = "0px";
			b.style.width = "100%";
			h.style.bottom = d + "px";
			h.style.height = "1.5px";
			h.style.left = "0px";
			h.style.width = "100%";
			a.style.top = i + "px";
			a.style.height = "1.5px";
			a.style.left = "0px";
			a.style.width = "100%"
		}
	}
	this._layerDiv.style.display = "block"
};
Timeline.SpanHighlightDecorator.prototype.softPaint = function() {
};
Timeline.PointHighlightDecorator = function(a) {
	this._unit = ("unit" in a) ? a.unit : Timeline.NativeDateUnit;
	this._date = (typeof a.date == "string") ? this._unit
			.parseFromObject(a.date) : a.date;
	this._width = ("width" in a) ? a.width : 10;
	this._color = a.color;
	this._opacity = ("opacity" in a) ? a.opacity : 100
};
Timeline.PointHighlightDecorator.prototype.initialize = function(b, a) {
	this._band = b;
	this._timeline = a;
	this._layerDiv = null
};
Timeline.PointHighlightDecorator.prototype.paint = function() {
	if (this._layerDiv != null) {
		this._band.removeLayerDiv(this._layerDiv)
	}
	this._layerDiv = this._band.createLayerDiv(10);
	this._layerDiv.setAttribute("name", "span-highlight-decorator");
	this._layerDiv.style.display = "none";
	var c = this._band.getMinDate();
	var e = this._band.getMaxDate();
	if (this._unit.compare(this._date, e) < 0
			&& this._unit.compare(this._date, c) > 0) {
		var b = this._band.dateToPixelOffset(this._date);
		var a = b - Math.round(this._width / 2);
		var d = this._timeline.getDocument();
		var f = d.createElement("div");
		f.style.position = "absolute";
		f.style.overflow = "hidden";
		f.style.background = this._color;
		if (this._opacity < 100) {
			Timeline.Graphics.setOpacity(f, this._opacity)
		}
		this._layerDiv.appendChild(f);
		if (this._timeline.isHorizontal()) {
			f.style.left = a + "px";
			f.style.width = this._width + "px";
			f.style.top = "0px";
			f.style.height = "100%"
		} else {
			f.style.top = a + "px";
			f.style.height = this._width + "px";
			f.style.left = "0px";
			f.style.width = "100%"
		}
	}
	this._layerDiv.style.display = "block"
};
Timeline.PointHighlightDecorator.prototype.softPaint = function() {
};
Timeline.GregorianEtherPainter = function(a) {
	this._params = a;
	this._theme = a.theme;
	this._unit = a.unit;
	this._multiple = ("multiple" in a) ? a.multiple : 1
};
Timeline.GregorianEtherPainter.prototype.initialize = function(c, b) {
	this._band = c;
	this._timeline = b;
	this._backgroundLayer = c.createLayerDiv(0);
	this._backgroundLayer.setAttribute("name", "ether-background");
	this._backgroundLayer.style.background = this._theme.ether.backgroundColors[c
			.getIndex()];
	this._markerLayer = null;
	this._lineLayer = null;
	var d = ("align" in this._params && this._params.align != undefined) ? this._params.align
			: this._theme.ether.interval.marker[b.isHorizontal() ? "hAlign"
					: "vAlign"];
	var a = ("showLine" in this._params) ? this._params.showLine
			: this._theme.ether.interval.line.show;
	this._intervalMarkerLayout = new Timeline.EtherIntervalMarkerLayout(
			this._timeline, this._band, this._theme, d, a);
	this._highlight = new Timeline.EtherHighlight(this._timeline, this._band,
			this._theme, this._backgroundLayer)
};
Timeline.GregorianEtherPainter.prototype.setHighlight = function(a, b) {
	this._highlight.position(a, b)
};
Timeline.GregorianEtherPainter.prototype.paint = function() {
	if (this._markerLayer) {
		this._band.removeLayerDiv(this._markerLayer)
	}
	this._markerLayer = this._band.createLayerDiv(100);
	this._markerLayer.setAttribute("name", "ether-markers");
	this._markerLayer.style.display = "none";
	if (this._lineLayer) {
		this._band.removeLayerDiv(this._lineLayer)
	}
	this._lineLayer = this._band.createLayerDiv(1);
	this._lineLayer.setAttribute("name", "ether-lines");
	this._lineLayer.style.display = "none";
	var c = this._band.getMinDate();
	var f = this._band.getMaxDate();
	var b = this._band.getTimeZone();
	var e = this._band.getLabeller();
	Timeline.DateTime.roundDownToInterval(c, this._unit, b, this._multiple,
			this._theme.firstDayOfWeek);
	var d = this;
	var a = function(g) {
		for ( var h = 0; h < d._multiple; h++) {
			Timeline.DateTime.incrementByInterval(g, d._unit)
		}
	};
	while (c.getTime() < f.getTime()) {
		this._intervalMarkerLayout.createIntervalMarker(c, e, this._unit,
				this._markerLayer, this._lineLayer);
		a(c)
	}
	this._markerLayer.style.display = "block";
	this._lineLayer.style.display = "block"
};
Timeline.GregorianEtherPainter.prototype.softPaint = function() {
};
Timeline.HotZoneGregorianEtherPainter = function(g) {
	this._params = g;
	this._theme = g.theme;
	this._zones = [ {
		startTime : Number.NEGATIVE_INFINITY,
		endTime : Number.POSITIVE_INFINITY,
		unit : g.unit,
		multiple : 1
	} ];
	for ( var e = 0; e < g.zones.length; e++) {
		var b = g.zones[e];
		var d = Timeline.DateTime.parseGregorianDateTime(b.start).getTime();
		var f = Timeline.DateTime.parseGregorianDateTime(b.end).getTime();
		for ( var c = 0; c < this._zones.length && f > d; c++) {
			var a = this._zones[c];
			if (d < a.endTime) {
				if (d > a.startTime) {
					this._zones.splice(c, 0, {
						startTime : a.startTime,
						endTime : d,
						unit : a.unit,
						multiple : a.multiple
					});
					c++;
					a.startTime = d
				}
				if (f < a.endTime) {
					this._zones.splice(c, 0, {
						startTime : d,
						endTime : f,
						unit : b.unit,
						multiple : (b.multiple) ? b.multiple : 1
					});
					c++;
					a.startTime = f;
					d = f
				} else {
					a.multiple = b.multiple;
					a.unit = b.unit;
					d = a.endTime
				}
			}
		}
	}
};
Timeline.HotZoneGregorianEtherPainter.prototype.initialize = function(c, b) {
	this._band = c;
	this._timeline = b;
	this._backgroundLayer = c.createLayerDiv(0);
	this._backgroundLayer.setAttribute("name", "ether-background");
	this._backgroundLayer.style.background = this._theme.ether.backgroundColors[c
			.getIndex()];
	this._markerLayer = null;
	this._lineLayer = null;
	var d = ("align" in this._params && this._params.align != undefined) ? this._params.align
			: this._theme.ether.interval.marker[b.isHorizontal() ? "hAlign"
					: "vAlign"];
	var a = ("showLine" in this._params) ? this._params.showLine
			: this._theme.ether.interval.line.show;
	this._intervalMarkerLayout = new Timeline.EtherIntervalMarkerLayout(
			this._timeline, this._band, this._theme, d, a);
	this._highlight = new Timeline.EtherHighlight(this._timeline, this._band,
			this._theme, this._backgroundLayer)
};
Timeline.HotZoneGregorianEtherPainter.prototype.setHighlight = function(a, b) {
	this._highlight.position(a, b)
};
Timeline.HotZoneGregorianEtherPainter.prototype.paint = function() {
	if (this._markerLayer) {
		this._band.removeLayerDiv(this._markerLayer)
	}
	this._markerLayer = this._band.createLayerDiv(100);
	this._markerLayer.setAttribute("name", "ether-markers");
	this._markerLayer.style.display = "none";
	if (this._lineLayer) {
		this._band.removeLayerDiv(this._lineLayer)
	}
	this._lineLayer = this._band.createLayerDiv(1);
	this._lineLayer.setAttribute("name", "ether-lines");
	this._lineLayer.style.display = "none";
	var d = this._band.getMinDate();
	var a = this._band.getMaxDate();
	var k = this._band.getTimeZone();
	var i = this._band.getLabeller();
	var b = this;
	var l = function(n, m) {
		for ( var o = 0; o < m.multiple; o++) {
			Timeline.DateTime.incrementByInterval(n, m.unit)
		}
	};
	var c = 0;
	while (c < this._zones.length) {
		if (d.getTime() < this._zones[c].endTime) {
			break
		}
		c++
	}
	var e = this._zones.length - 1;
	while (e >= 0) {
		if (a.getTime() > this._zones[e].startTime) {
			break
		}
		e--
	}
	for ( var h = c; h <= e; h++) {
		var g = this._zones[h];
		var j = new Date(Math.max(d.getTime(), g.startTime));
		var f = new Date(Math.min(a.getTime(), g.endTime));
		Timeline.DateTime.roundDownToInterval(j, g.unit, k, g.multiple,
				this._theme.firstDayOfWeek);
		Timeline.DateTime.roundUpToInterval(f, g.unit, k, g.multiple,
				this._theme.firstDayOfWeek);
		while (j.getTime() < f.getTime()) {
			this._intervalMarkerLayout.createIntervalMarker(j, i, g.unit,
					this._markerLayer, this._lineLayer);
			l(j, g)
		}
	}
	this._markerLayer.style.display = "block";
	this._lineLayer.style.display = "block"
};
Timeline.HotZoneGregorianEtherPainter.prototype.softPaint = function() {
};
Timeline.YearCountEtherPainter = function(a) {
	this._params = a;
	this._theme = a.theme;
	this._startDate = Timeline.DateTime.parseGregorianDateTime(a.startDate);
	this._multiple = ("multiple" in a) ? a.multiple : 1
};
Timeline.YearCountEtherPainter.prototype.initialize = function(c, b) {
	this._band = c;
	this._timeline = b;
	this._backgroundLayer = c.createLayerDiv(0);
	this._backgroundLayer.setAttribute("name", "ether-background");
	this._backgroundLayer.style.background = this._theme.ether.backgroundColors[c
			.getIndex()];
	this._markerLayer = null;
	this._lineLayer = null;
	var d = ("align" in this._params) ? this._params.align
			: this._theme.ether.interval.marker[b.isHorizontal() ? "hAlign"
					: "vAlign"];
	var a = ("showLine" in this._params) ? this._params.showLine
			: this._theme.ether.interval.line.show;
	this._intervalMarkerLayout = new Timeline.EtherIntervalMarkerLayout(
			this._timeline, this._band, this._theme, d, a);
	this._highlight = new Timeline.EtherHighlight(this._timeline, this._band,
			this._theme, this._backgroundLayer)
};
Timeline.YearCountEtherPainter.prototype.setHighlight = function(a, b) {
	this._highlight.position(a, b)
};
Timeline.YearCountEtherPainter.prototype.paint = function() {
	if (this._markerLayer) {
		this._band.removeLayerDiv(this._markerLayer)
	}
	this._markerLayer = this._band.createLayerDiv(100);
	this._markerLayer.setAttribute("name", "ether-markers");
	this._markerLayer.style.display = "none";
	if (this._lineLayer) {
		this._band.removeLayerDiv(this._lineLayer)
	}
	this._lineLayer = this._band.createLayerDiv(1);
	this._lineLayer.setAttribute("name", "ether-lines");
	this._lineLayer.style.display = "none";
	var b = new Date(this._startDate.getTime());
	var f = this._band.getMaxDate();
	var e = this._band.getMinDate().getUTCFullYear()
			- this._startDate.getUTCFullYear();
	b.setUTCFullYear(this._band.getMinDate().getUTCFullYear() - e
			% this._multiple);
	var c = this;
	var a = function(g) {
		for ( var h = 0; h < c._multiple; h++) {
			Timeline.DateTime.incrementByInterval(g, Timeline.DateTime.YEAR)
		}
	};
	var d = {
		labelInterval : function(g, i) {
			var h = g.getUTCFullYear() - c._startDate.getUTCFullYear();
			return {
				text : h,
				emphasized : h == 0
			}
		}
	};
	while (b.getTime() < f.getTime()) {
		this._intervalMarkerLayout.createIntervalMarker(b, d,
				Timeline.DateTime.YEAR, this._markerLayer, this._lineLayer);
		a(b)
	}
	this._markerLayer.style.display = "block";
	this._lineLayer.style.display = "block"
};
Timeline.YearCountEtherPainter.prototype.softPaint = function() {
};
Timeline.QuarterlyEtherPainter = function(a) {
	this._params = a;
	this._theme = a.theme;
	this._startDate = Timeline.DateTime.parseGregorianDateTime(a.startDate)
};
Timeline.QuarterlyEtherPainter.prototype.initialize = function(c, b) {
	this._band = c;
	this._timeline = b;
	this._backgroundLayer = c.createLayerDiv(0);
	this._backgroundLayer.setAttribute("name", "ether-background");
	this._backgroundLayer.style.background = this._theme.ether.backgroundColors[c
			.getIndex()];
	this._markerLayer = null;
	this._lineLayer = null;
	var d = ("align" in this._params) ? this._params.align
			: this._theme.ether.interval.marker[b.isHorizontal() ? "hAlign"
					: "vAlign"];
	var a = ("showLine" in this._params) ? this._params.showLine
			: this._theme.ether.interval.line.show;
	this._intervalMarkerLayout = new Timeline.EtherIntervalMarkerLayout(
			this._timeline, this._band, this._theme, d, a);
	this._highlight = new Timeline.EtherHighlight(this._timeline, this._band,
			this._theme, this._backgroundLayer)
};
Timeline.QuarterlyEtherPainter.prototype.setHighlight = function(a, b) {
	this._highlight.position(a, b)
};
Timeline.QuarterlyEtherPainter.prototype.paint = function() {
	if (this._markerLayer) {
		this._band.removeLayerDiv(this._markerLayer)
	}
	this._markerLayer = this._band.createLayerDiv(100);
	this._markerLayer.setAttribute("name", "ether-markers");
	this._markerLayer.style.display = "none";
	if (this._lineLayer) {
		this._band.removeLayerDiv(this._lineLayer)
	}
	this._lineLayer = this._band.createLayerDiv(1);
	this._lineLayer.setAttribute("name", "ether-lines");
	this._lineLayer.style.display = "none";
	var b = new Date(0);
	var e = this._band.getMaxDate();
	b.setUTCFullYear(Math.max(this._startDate.getUTCFullYear(), this._band
			.getMinDate().getUTCFullYear()));
	b.setUTCMonth(this._startDate.getUTCMonth());
	var c = this;
	var a = function(f) {
		f.setUTCMonth(f.getUTCMonth() + 3)
	};
	var d = {
		labelInterval : function(f, h) {
			var g = (4 + (f.getUTCMonth() - c._startDate.getUTCMonth()) / 3) % 4;
			if (g != 0) {
				return {
					text : "Q" + (g + 1),
					emphasized : false
				}
			} else {
				return {
					text : "Y"
							+ (f.getUTCFullYear()
									- c._startDate.getUTCFullYear() + 1),
					emphasized : true
				}
			}
		}
	};
	while (b.getTime() < e.getTime()) {
		this._intervalMarkerLayout.createIntervalMarker(b, d,
				Timeline.DateTime.YEAR, this._markerLayer, this._lineLayer);
		a(b)
	}
	this._markerLayer.style.display = "block";
	this._lineLayer.style.display = "block"
};
Timeline.QuarterlyEtherPainter.prototype.softPaint = function() {
};
Timeline.EtherIntervalMarkerLayout = function(m, l, c, e, h) {
	var a = m.isHorizontal();
	if (a) {
		if (e == "Top") {
			this.positionDiv = function(o, n) {
				o.style.left = n + "px";
				o.style.top = "0px"
			}
		} else {
			this.positionDiv = function(o, n) {
				o.style.left = n + "px";
				o.style.bottom = "0px"
			}
		}
	} else {
		if (e == "Left") {
			this.positionDiv = function(o, n) {
				o.style.top = n + "px";
				o.style.left = "0px"
			}
		} else {
			this.positionDiv = function(o, n) {
				o.style.top = n + "px";
				o.style.right = "0px"
			}
		}
	}
	var d = c.ether.interval.marker;
	var i = c.ether.interval.line;
	var b = c.ether.interval.weekend;
	var k = (a ? "h" : "v") + e;
	var g = d[k + "Styler"];
	var j = d[k + "EmphasizedStyler"];
	var f = Timeline.DateTime.gregorianUnitLengths[Timeline.DateTime.DAY];
	this.createIntervalMarker = function(t, A, B, C, q) {
		var u = Math.round(l.dateToPixelOffset(t));
		if (h && B != Timeline.DateTime.WEEK) {
			var v = m.getDocument().createElement("div");
			v.style.position = "absolute";
			if (i.opacity < 100) {
				Timeline.Graphics.setOpacity(v, i.opacity)
			}
			if (a) {
				v.style.borderLeft = "1px solid " + i.color;
				v.style.left = u + "px";
				v.style.width = "1px";
				v.style.top = "0px";
				v.style.height = "100%"
			} else {
				v.style.borderTop = "1px solid " + i.color;
				v.style.top = u + "px";
				v.style.height = "1px";
				v.style.left = "0px";
				v.style.width = "100%"
			}
			q.appendChild(v)
		}
		if (B == Timeline.DateTime.WEEK) {
			var n = c.firstDayOfWeek;
			var w = new Date(t.getTime() + (6 - n - 7) * f);
			var z = new Date(w.getTime() + 2 * f);
			var x = Math.round(l.dateToPixelOffset(w));
			var s = Math.round(l.dateToPixelOffset(z));
			var r = Math.max(1, s - x);
			var p = m.getDocument().createElement("div");
			p.style.position = "absolute";
			p.style.background = b.color;
			if (b.opacity < 100) {
				Timeline.Graphics.setOpacity(p, b.opacity)
			}
			if (a) {
				p.style.left = x + "px";
				p.style.width = r + "px";
				p.style.top = "0px";
				p.style.height = "100%"
			} else {
				p.style.top = x + "px";
				p.style.height = r + "px";
				p.style.left = "0px";
				p.style.width = "100%"
			}
			q.appendChild(p)
		}
		var y = A.labelInterval(t, B);
		var o = m.getDocument().createElement("div");
		o.innerHTML = y.text;
		o.style.position = "absolute";
		(y.emphasized ? j : g)(o);
		this.positionDiv(o, u);
		C.appendChild(o);
		return o
	}
};
Timeline.EtherHighlight = function(c, e, d, b) {
	var a = c.isHorizontal();
	this._highlightDiv = null;
	this._createHighlightDiv = function() {
		if (this._highlightDiv == null) {
			this._highlightDiv = c.getDocument().createElement("div");
			this._highlightDiv.setAttribute("name", "ether-highlight");
			this._highlightDiv.style.position = "absolute";
			this._highlightDiv.style.background = d.ether.highlightColor;
			var f = d.ether.highlightOpacity;
			if (f < 100) {
				Timeline.Graphics.setOpacity(this._highlightDiv, f)
			}
			b.appendChild(this._highlightDiv)
		}
	};
	this.position = function(f, i) {
		this._createHighlightDiv();
		var j = Math.round(e.dateToPixelOffset(f));
		var h = Math.round(e.dateToPixelOffset(i));
		var g = Math.max(h - j, 3);
		if (a) {
			this._highlightDiv.style.left = j + "px";
			this._highlightDiv.style.width = g + "px";
			this._highlightDiv.style.top = "2px";
			this._highlightDiv.style.height = (e.getViewWidth() - 4) + "px"
		} else {
			this._highlightDiv.style.top = j + "px";
			this._highlightDiv.style.height = g + "px";
			this._highlightDiv.style.left = "2px";
			this._highlightDiv.style.width = (e.getViewWidth() - 4) + "px"
		}
	}
};
Timeline.LinearEther = function(a) {
	this._params = a;
	this._interval = a.interval;
	this._pixelsPerInterval = a.pixelsPerInterval
};
Timeline.LinearEther.prototype.initialize = function(a) {
	this._timeline = a;
	this._unit = a.getUnit();
	if ("startsOn" in this._params) {
		this._start = this._unit.parseFromObject(this._params.startsOn)
	} else {
		if ("endsOn" in this._params) {
			this._start = this._unit.parseFromObject(this._params.endsOn);
			this.shiftPixels(-this._timeline.getPixelLength())
		} else {
			if ("centersOn" in this._params) {
				this._start = this._unit
						.parseFromObject(this._params.centersOn);
				this.shiftPixels(-this._timeline.getPixelLength() / 2)
			} else {
				this._start = this._unit.makeDefaultValue();
				this.shiftPixels(-this._timeline.getPixelLength() / 2)
			}
		}
	}
};
Timeline.LinearEther.prototype.setDate = function(a) {
	this._start = this._unit.cloneValue(a)
};
Timeline.LinearEther.prototype.shiftPixels = function(b) {
	var a = this._interval * b / this._pixelsPerInterval;
	this._start = this._unit.change(this._start, a)
};
Timeline.LinearEther.prototype.dateToPixelOffset = function(a) {
	var b = this._unit.compare(a, this._start);
	return this._pixelsPerInterval * b / this._interval
};
Timeline.LinearEther.prototype.pixelOffsetToDate = function(b) {
	var a = b * this._interval / this._pixelsPerInterval;
	return this._unit.change(this._start, a)
};
Timeline.HotZoneEther = function(a) {
	this._params = a;
	this._interval = a.interval;
	this._pixelsPerInterval = a.pixelsPerInterval
};
Timeline.HotZoneEther.prototype.initialize = function(g) {
	this._timeline = g;
	this._unit = g.getUnit();
	this._zones = [ {
		startTime : Number.NEGATIVE_INFINITY,
		endTime : Number.POSITIVE_INFINITY,
		magnify : 1
	} ];
	var h = this._params;
	for ( var e = 0; e < h.zones.length; e++) {
		var b = h.zones[e];
		var d = this._unit.parseFromObject(b.start);
		var f = this._unit.parseFromObject(b.end);
		for ( var c = 0; c < this._zones.length && this._unit.compare(f, d) > 0; c++) {
			var a = this._zones[c];
			if (this._unit.compare(d, a.endTime) < 0) {
				if (this._unit.compare(d, a.startTime) > 0) {
					this._zones.splice(c, 0, {
						startTime : a.startTime,
						endTime : d,
						magnify : a.magnify
					});
					c++;
					a.startTime = d
				}
				if (this._unit.compare(f, a.endTime) < 0) {
					this._zones.splice(c, 0, {
						startTime : d,
						endTime : f,
						magnify : b.magnify * a.magnify
					});
					c++;
					a.startTime = f;
					d = f
				} else {
					a.magnify *= b.magnify;
					d = a.endTime
				}
			}
		}
	}
	if ("startsOn" in this._params) {
		this._start = this._unit.parseFromObject(this._params.startsOn)
	} else {
		if ("endsOn" in this._params) {
			this._start = this._unit.parseFromObject(this._params.endsOn);
			this.shiftPixels(-this._timeline.getPixelLength())
		} else {
			if ("centersOn" in this._params) {
				this._start = this._unit
						.parseFromObject(this._params.centersOn);
				this.shiftPixels(-this._timeline.getPixelLength() / 2)
			} else {
				this._start = this._unit.makeDefaultValue();
				this.shiftPixels(-this._timeline.getPixelLength() / 2)
			}
		}
	}
};
Timeline.HotZoneEther.prototype.setDate = function(a) {
	this._start = this._unit.cloneValue(a)
};
Timeline.HotZoneEther.prototype.shiftPixels = function(a) {
	this._start = this.pixelOffsetToDate(a)
};
Timeline.HotZoneEther.prototype.dateToPixelOffset = function(a) {
	return this._dateDiffToPixelOffset(this._start, a)
};
Timeline.HotZoneEther.prototype.pixelOffsetToDate = function(a) {
	return this._pixelOffsetToDate(a, this._start)
};
Timeline.HotZoneEther.prototype._dateDiffToPixelOffset = function(i, d) {
	var b = this._getScale();
	var h = i;
	var c = d;
	var a = 0;
	if (this._unit.compare(h, c) < 0) {
		var g = 0;
		while (g < this._zones.length) {
			if (this._unit.compare(h, this._zones[g].endTime) < 0) {
				break
			}
			g++
		}
		while (this._unit.compare(h, c) < 0) {
			var e = this._zones[g];
			var f = this._unit.earlier(c, e.endTime);
			a += (this._unit.compare(f, h) / (b / e.magnify));
			h = f;
			g++
		}
	} else {
		var g = this._zones.length - 1;
		while (g >= 0) {
			if (this._unit.compare(h, this._zones[g].startTime) > 0) {
				break
			}
			g--
		}
		while (this._unit.compare(h, c) > 0) {
			var e = this._zones[g];
			var f = this._unit.later(c, e.startTime);
			a += (this._unit.compare(f, h) / (b / e.magnify));
			h = f;
			g--
		}
	}
	return a
};
Timeline.HotZoneEther.prototype._pixelOffsetToDate = function(h, c) {
	var g = this._getScale();
	var e = c;
	if (h > 0) {
		var f = 0;
		while (f < this._zones.length) {
			if (this._unit.compare(e, this._zones[f].endTime) < 0) {
				break
			}
			f++
		}
		while (h > 0) {
			var a = this._zones[f];
			var d = g / a.magnify;
			if (a.endTime == Number.POSITIVE_INFINITY) {
				e = this._unit.change(e, h * d);
				h = 0
			} else {
				var b = this._unit.compare(a.endTime, e) / d;
				if (b > h) {
					e = this._unit.change(e, h * d);
					h = 0
				} else {
					e = a.endTime;
					h -= b
				}
			}
			f++
		}
	} else {
		var f = this._zones.length - 1;
		while (f >= 0) {
			if (this._unit.compare(e, this._zones[f].startTime) > 0) {
				break
			}
			f--
		}
		h = -h;
		while (h > 0) {
			var a = this._zones[f];
			var d = g / a.magnify;
			if (a.startTime == Number.NEGATIVE_INFINITY) {
				e = this._unit.change(e, -h * d);
				h = 0
			} else {
				var b = this._unit.compare(e, a.startTime) / d;
				if (b > h) {
					e = this._unit.change(e, -h * d);
					h = 0
				} else {
					e = a.startTime;
					h -= b
				}
			}
			f--
		}
	}
	return e
};
Timeline.HotZoneEther.prototype._getScale = function() {
	return this._interval / this._pixelsPerInterval
};
Timeline.GregorianDateLabeller = function(a, b) {
	this._locale = a;
	this._timeZone = b
};
Timeline.GregorianDateLabeller.monthNames = [];
Timeline.GregorianDateLabeller.dayNames = [];
Timeline.GregorianDateLabeller.labelIntervalFunctions = [];
Timeline.GregorianDateLabeller.monthNames.en = [ "Jan", "Feb", "Mar", "Apr",
		"May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];
Timeline.GregorianDateLabeller.getMonthName = function(b, a) {
	return Timeline.GregorianDateLabeller.monthNames[a][b]
};
Timeline.GregorianDateLabeller.prototype.labelInterval = function(a, c) {
	var b = Timeline.GregorianDateLabeller.labelIntervalFunctions[this._locale];
	if (b == null) {
		b = Timeline.GregorianDateLabeller.prototype.defaultLabelInterval
	}
	return b.call(this, a, c)
};
Timeline.GregorianDateLabeller.prototype.labelPrecise = function(a) {
	return Timeline.DateTime.removeTimeZoneOffset(a, this._timeZone)
			.toUTCString()
};
Timeline.GregorianDateLabeller.prototype.defaultLabelInterval = function(b, f) {
	var c;
	var e = false;
	b = Timeline.DateTime.removeTimeZoneOffset(b, this._timeZone);
	switch (f) {
	case Timeline.DateTime.MILLISECOND:
		c = b.getUTCMilliseconds();
		break;
	case Timeline.DateTime.SECOND:
		c = b.getUTCSeconds();
		break;
	case Timeline.DateTime.MINUTE:
		var a = b.getUTCMinutes();
		if (a == 0) {
			c = b.getUTCHours() + ":00";
			e = true
		} else {
			c = a
		}
		break;
	case Timeline.DateTime.HOUR:
		c = b.getUTCHours() + "hr";
		break;
	case Timeline.DateTime.DAY:
		c = Timeline.GregorianDateLabeller.getMonthName(b.getUTCMonth(),
				this._locale)
				+ " " + b.getUTCDate();
		break;
	case Timeline.DateTime.WEEK:
		c = Timeline.GregorianDateLabeller.getMonthName(b.getUTCMonth(),
				this._locale)
				+ " " + b.getUTCDate();
		break;
	case Timeline.DateTime.MONTH:
		var a = b.getUTCMonth();
		if (a != 0) {
			c = Timeline.GregorianDateLabeller.getMonthName(a, this._locale);
			break
		}
	case Timeline.DateTime.YEAR:
	case Timeline.DateTime.DECADE:
	case Timeline.DateTime.CENTURY:
	case Timeline.DateTime.MILLENNIUM:
		var d = b.getUTCFullYear();
		if (d > 0) {
			c = b.getUTCFullYear()
		} else {
			c = (1 - d) + "BC"
		}
		e = (f == Timeline.DateTime.MONTH)
				|| (f == Timeline.DateTime.DECADE && d % 100 == 0)
				|| (f == Timeline.DateTime.CENTURY && d % 1000 == 0);
		break;
	default:
		c = b.toUTCString()
	}
	return {
		text : c,
		emphasized : e
	}
};
Timeline.StaticTrackBasedLayout = function(b) {
	this._eventSource = b.eventSource;
	this._ether = b.ether;
	this._theme = b.theme;
	this._showText = ("showText" in b) ? b.showText : true;
	this._laidout = false;
	var a = this;
	if (this._eventSource != null) {
		this._eventSource.addListener({
			onAddMany : function() {
				a._laidout = false
			}
		})
	}
};
Timeline.StaticTrackBasedLayout.prototype.initialize = function(a) {
	this._timeline = a
};
Timeline.StaticTrackBasedLayout.prototype.getTrack = function(a) {
	if (!this._laidout) {
		this._tracks = [];
		this._layout();
		this._laidout = true
	}
	return this._tracks[a.getID()]
};
Timeline.StaticTrackBasedLayout.prototype.getTrackCount = function() {
	if (!this._laidout) {
		this._tracks = [];
		this._layout();
		this._laidout = true
	}
	return this._trackCount
};
Timeline.StaticTrackBasedLayout.prototype._layout = function() {
	if (this._eventSource == null) {
		return
	}
	var j = [ Number.NEGATIVE_INFINITY ];
	var e = this;
	var f = this._showText;
	var c = this._theme;
	var i = c.event;
	var b = function(k, o, m, n) {
		var l = o - 1;
		if (k.isImprecise()) {
			l = m
		}
		if (f) {
			l = Math.max(l, o + i.label.width)
		}
		return l
	};
	var a = function(t, q, k, n) {
		if (t.isImprecise()) {
			var m = t.getStart();
			var s = t.getEnd();
			var p = Math.round(e._ether.dateToPixelOffset(m));
			var r = Math.round(e._ether.dateToPixelOffset(s))
		} else {
			var p = q;
			var r = k
		}
		var o = r;
		var l = Math.max(r - p, 1);
		if (f) {
			if (l < i.label.width) {
				o = r + i.label.width
			}
		}
		return o
	};
	var g = function(l) {
		var k = l.getStart();
		var o = l.getEnd();
		var q = Math.round(e._ether.dateToPixelOffset(k));
		var m = Math.round(e._ether.dateToPixelOffset(o));
		var p = 0;
		for (; p < j.length; p++) {
			if (j[p] < q) {
				break
			}
		}
		if (p >= j.length) {
			j.push(Number.NEGATIVE_INFINITY)
		}
		var n = (i.track.offset + p * (i.track.height + i.track.gap)) + "em";
		e._tracks[l.getID()] = p;
		if (l.isInstant()) {
			j[p] = b(l, q, m, n)
		} else {
			j[p] = a(l, q, m, n)
		}
	};
	var d = this._eventSource.getAllEventIterator();
	while (d.hasNext()) {
		var h = d.next();
		g(h)
	}
	this._trackCount = j.length
};
Timeline.DurationEventPainter = function(a) {
	this._params = a;
	this._theme = a.theme;
	this._layout = a.layout;
	this._showText = a.showText;
	this._showLineForNoText = ("showLineForNoText" in a) ? a.showLineForNoText
			: a.theme.event.instant.showLineForNoText;
	this._filterMatcher = null;
	this._highlightMatcher = null
};
Timeline.DurationEventPainter.prototype.initialize = function(b, a) {
	this._band = b;
	this._timeline = a;
	this._layout.initialize(b, a);
	this._eventLayer = null;
	this._highlightLayer = null
};
Timeline.DurationEventPainter.prototype.getLayout = function() {
	return this._layout
};
Timeline.DurationEventPainter.prototype.setLayout = function(a) {
	this._layout = a
};
Timeline.DurationEventPainter.prototype.getFilterMatcher = function() {
	return this._filterMatcher
};
Timeline.DurationEventPainter.prototype.setFilterMatcher = function(a) {
	this._filterMatcher = a
};
Timeline.DurationEventPainter.prototype.getHighlightMatcher = function() {
	return this._highlightMatcher
};
Timeline.DurationEventPainter.prototype.setHighlightMatcher = function(a) {
	this._highlightMatcher = a
};
Timeline.DurationEventPainter.prototype.paint = function() {
	var q = this._band.getEventSource();
	if (q == null) {
		return
	}
	if (this._highlightLayer != null) {
		this._band.removeLayerDiv(this._highlightLayer)
	}
	this._highlightLayer = this._band.createLayerDiv(105);
	this._highlightLayer.setAttribute("name", "event-highlights");
	this._highlightLayer.style.display = "none";
	if (this._eventLayer != null) {
		this._band.removeLayerDiv(this._eventLayer)
	}
	this._eventLayer = this._band.createLayerDiv(110);
	this._eventLayer.setAttribute("name", "events");
	this._eventLayer.style.display = "none";
	var d = this._band.getMinDate();
	var f = this._band.getMaxDate();
	var w = this._timeline.getDocument();
	var k = this;
	var t = this._eventLayer;
	var e = this._highlightLayer;
	var a = this._showText;
	var u = this._params.theme;
	var o = u.event;
	var n = o.track.offset;
	var b = ("trackHeight" in this._params) ? this._params.trackHeight
			: o.track.height;
	var s = ("trackGap" in this._params) ? this._params.trackGap : o.track.gap;
	var c = function(p, z) {
		var y = p.getIcon();
		var x = Timeline.Graphics.createTranslucentImage(w, y != null ? y
				: o.instant.icon);
		z.appendChild(x);
		z.style.cursor = "pointer";
		Timeline.DOM.registerEvent(z, "mousedown", function(A, B, C) {
			k._onClickInstantEvent(x, B, p)
		})
	};
	var r = function(p, B, A, z, y) {
		if (p >= 0) {
			var x = o.highlightColors[Math.min(p, o.highlightColors.length - 1)];
			var C = w.createElement("div");
			C.style.position = "absolute";
			C.style.overflow = "hidden";
			C.style.left = (B - 3) + "px";
			C.style.width = (A + 6) + "px";
			C.style.top = z + "em";
			C.style.height = y + "em";
			C.style.background = x;
			e.appendChild(C)
		}
	};
	var l = function(I, E, p, C, B, H, G) {
		if (I.isImprecise()) {
			var A = Math.max(p - E, 1);
			var z = w.createElement("div");
			z.style.position = "absolute";
			z.style.overflow = "hidden";
			z.style.top = C;
			z.style.height = b + "em";
			z.style.left = E + "px";
			z.style.width = A + "px";
			z.style.background = o.instant.impreciseColor;
			if (o.instant.impreciseOpacity < 100) {
				Timeline.Graphics.setOpacity(z, o.instant.impreciseOpacity)
			}
			t.appendChild(z)
		}
		var y = w.createElement("div");
		y.style.position = "absolute";
		y.style.overflow = "hidden";
		t.appendChild(y);
		var F = I.getTextColor();
		var x = I.getColor();
		var D = -8;
		var A = 16;
		if (a) {
			y.style.width = o.label.width + "px";
			y.style.color = F != null ? F : o.label.outsideColor;
			c(I, y);
			y.appendChild(w.createTextNode(I.getText()))
		} else {
			if (k._showLineForNoText) {
				y.style.width = "1px";
				y.style.borderLeft = "1px solid "
						+ (x != null ? x : o.instant.lineColor);
				D = 0;
				A = 1
			} else {
				c(I, y)
			}
		}
		y.style.top = C;
		y.style.height = b + "em";
		y.style.left = (E + D) + "px";
		r(B, (E + D), A, H, G)
	};
	var g = function(F, z, p, C, G, K, y) {
		var M = function(P) {
			P.style.cursor = "pointer";
			Timeline.DOM.registerEvent(P, "mousedown", function(Q, R, S) {
				k._onClickDurationEvent(R, F, S)
			})
		};
		var B = Math.max(p - z, 1);
		if (F.isImprecise()) {
			var E = w.createElement("div");
			E.style.position = "absolute";
			E.style.overflow = "hidden";
			E.style.top = C;
			E.style.height = b + "em";
			E.style.left = z + "px";
			E.style.width = B + "px";
			E.style.background = o.duration.impreciseColor;
			if (o.duration.impreciseOpacity < 100) {
				Timeline.Graphics.setOpacity(E, o.duration.impreciseOpacity)
			}
			t.appendChild(E);
			var A = F.getLatestStart();
			var I = F.getEarliestEnd();
			var D = Math.round(k._band.dateToPixelOffset(A));
			var O = Math.round(k._band.dateToPixelOffset(I))
		} else {
			var D = z;
			var O = p
		}
		var x = F.getTextColor();
		var N = true;
		if (D <= O) {
			B = Math.max(O - D, 1);
			N = !(B > o.label.width);
			E = w.createElement("div");
			E.style.position = "absolute";
			E.style.overflow = "hidden";
			E.style.top = C;
			E.style.height = b + "em";
			E.style.left = D + "px";
			E.style.width = B + "px";
			var J = F.getColor();
			E.style.background = J != null ? J : o.duration.color;
			if (o.duration.opacity < 100) {
				Timeline.Graphics.setOpacity(E, o.duration.opacity)
			}
			t.appendChild(E)
		} else {
			var L = D;
			D = O;
			O = L
		}
		if (E == null) {
			console.log(F)
		}
		M(E);
		if (a) {
			var H = w.createElement("div");
			H.style.position = "absolute";
			H.style.top = C;
			H.style.height = b + "em";
			H.style.left = ((B > o.label.width) ? D : O) + "px";
			H.style.width = o.label.width + "px";
			H.style.color = x != null ? x : (N ? o.label.outsideColor
					: o.label.insideColor);
			H.style.overflow = "hidden";
			H.appendChild(w.createTextNode(F.getText()));
			t.appendChild(H);
			M(H)
		}
		r(G, z, p - z, K, y)
	};
	var m = function(y, x) {
		var p = y.getStart();
		var B = y.getEnd();
		var C = Math.round(k._band.dateToPixelOffset(p));
		var z = Math.round(k._band.dateToPixelOffset(B));
		var A = (n + k._layout.getTrack(y) * (b + s));
		if (y.isInstant()) {
			l(y, C, z, A + "em", x, A - s, b + 2 * s)
		} else {
			g(y, C, z, A + "em", x, A - s, b + 2 * s)
		}
	};
	var v = (this._filterMatcher != null) ? this._filterMatcher : function(p) {
		return true
	};
	var i = (this._highlightMatcher != null) ? this._highlightMatcher
			: function(p) {
				return -1
			};
	var j = q.getEventIterator(d, f);
	while (j.hasNext()) {
		var h = j.next();
		if (v(h)) {
			m(h, i(h))
		}
	}
	this._highlightLayer.style.display = "block";
	this._eventLayer.style.display = "block"
};
Timeline.DurationEventPainter.prototype.softPaint = function() {
};
Timeline.DurationEventPainter.prototype._onClickInstantEvent = function(b, d, a) {
	d.cancelBubble = true;
	var e = Timeline.DOM.getPageCoordinates(b);
	this._showBubble(e.left + Math.ceil(b.offsetWidth / 2), e.top
			+ Math.ceil(b.offsetHeight / 2), a)
};
Timeline.DurationEventPainter.prototype._onClickDurationEvent = function(d, b,
		e) {
	d.cancelBubble = true;
	if ("pageX" in d) {
		var a = d.pageX;
		var g = d.pageY
	} else {
		var f = Timeline.DOM.getPageCoordinates(e);
		var a = d.offsetX + f.left;
		var g = d.offsetY + f.top
	}
	this._showBubble(a, g, b)
};
Timeline.DurationEventPainter.prototype._showBubble = function(a, d, b) {
	var c = this._band.openBubbleForPoint(a, d, this._theme.event.bubble.width,
			this._theme.event.bubble.height);
	b.fillInfoBubble(c, this._theme, this._band.getLabeller())
};
Timeline.DefaultEventSource = function(a) {
	this._events = (a instanceof Object) ? a : new Timeline.EventIndex();
	this._listeners = []
};
Timeline.DefaultEventSource.prototype.addListener = function(a) {
	this._listeners.push(a)
};
Timeline.DefaultEventSource.prototype.removeListener = function(b) {
	for ( var a = 0; a < this._listeners.length; a++) {
		if (this._listeners[a] == b) {
			this._listeners.splice(a, 1);
			break
		}
	}
};
Timeline.DefaultEventSource.prototype.loadXML = function(f, a) {
	var b = this._getBaseURL(a);
	var g = f.documentElement.getAttribute("wiki-url");
	var k = f.documentElement.getAttribute("wiki-section");
	var d = f.documentElement.getAttribute("date-time-format");
	var e = this._events.getUnit().getParser(d);
	var c = f.documentElement.firstChild;
	var h = false;
	while (c != null) {
		if (c.nodeType == 1) {
			var j = "";
			if (c.firstChild != null && c.firstChild.nodeType == 3) {
				j = c.firstChild.nodeValue
			}
			var i = new Timeline.DefaultEventSource.Event(e(c
					.getAttribute("start")), e(c.getAttribute("end")), e(c
					.getAttribute("latestStart")), e(c
					.getAttribute("earliestEnd")),
					c.getAttribute("isDuration") != "true", c
							.getAttribute("title"), j, this
							._resolveRelativeURL(c.getAttribute("image"), b),
					this._resolveRelativeURL(c.getAttribute("link"), b), this
							._resolveRelativeURL(c.getAttribute("icon"), b), c
							.getAttribute("color"), c.getAttribute("textColor"));
			i._node = c;
			i.getProperty = function(l) {
				return this._node.getAttribute(l)
			};
			i.setWikiInfo(g, k);
			this._events.add(i);
			h = true
		}
		c = c.nextSibling
	}
	if (h) {
		this._fire("onAddMany", [])
	}
};
Timeline.DefaultEventSource.prototype.loadJSON = function(f, b) {
	var c = this._getBaseURL(b);
	var j = false;
	if (f && f.events) {
		var h = ("wikiURL" in f) ? f.wikiURL : null;
		var l = ("wikiSection" in f) ? f.wikiSection : null;
		var d = ("dateTimeFormat" in f) ? f.dateTimeFormat : null;
		var g = this._events.getUnit().getParser(d);
		for ( var e = 0; e < f.events.length; e++) {
			var a = f.events[e];
			var k = new Timeline.DefaultEventSource.Event(g(a.start), g(a.end),
					g(a.latestStart), g(a.earliestEnd), a.isDuration || false,
					a.title, a.description, this
							._resolveRelativeURL(a.image, c), this
							._resolveRelativeURL(a.link, c), this
							._resolveRelativeURL(a.icon, c), a.color,
					a.textColor);
			k._obj = a;
			k.getProperty = function(i) {
				return this._obj[i]
			};
			k.setWikiInfo(h, l);
			this._events.add(k);
			j = true
		}
	}
	if (j) {
		this._fire("onAddMany", [])
	}
};
Timeline.DefaultEventSource.prototype.add = function(a) {
	this._events.add(a);
	this._fire("onAddOne", [ a ])
};
Timeline.DefaultEventSource.prototype.addMany = function(b) {
	for ( var a = 0; a < b.length; a++) {
		this._events.add(b[a])
	}
	this._fire("onAddMany", [])
};
Timeline.DefaultEventSource.prototype.clear = function() {
	this._events.removeAll();
	this._fire("onClear", [])
};
Timeline.DefaultEventSource.prototype.getEventIterator = function(a, b) {
	return this._events.getIterator(a, b)
};
Timeline.DefaultEventSource.prototype.getAllEventIterator = function() {
	return this._events.getAllIterator()
};
Timeline.DefaultEventSource.prototype.getCount = function() {
	return this._events.getCount()
};
Timeline.DefaultEventSource.prototype.getEarliestDate = function() {
	return this._events.getEarliestDate()
};
Timeline.DefaultEventSource.prototype.getLatestDate = function() {
	return this._events.getLatestDate()
};
Timeline.DefaultEventSource.prototype._fire = function(b, a) {
	for ( var c = 0; c < this._listeners.length; c++) {
		var d = this._listeners[c];
		if (b in d) {
			try {
				d[b].apply(d, a)
			} catch (f) {
				Timeline.Debug.exception(f)
			}
		}
	}
};
Timeline.DefaultEventSource.prototype._getBaseURL = function(a) {
	if (a.indexOf("://") < 0) {
		var c = this._getBaseURL(document.location.href);
		if (a.substr(0, 1) == "/") {
			a = c.substr(0, c.indexOf("/", c.indexOf("://") + 3)) + a
		} else {
			a = c + a
		}
	}
	var b = a.lastIndexOf("/");
	if (b < 0) {
		return ""
	} else {
		return a.substr(0, b + 1)
	}
};
Timeline.DefaultEventSource.prototype._resolveRelativeURL = function(a, b) {
	if (a == null || a == "") {
		return a
	} else {
		if (a.indexOf("://") > 0) {
			return a
		} else {
			if (a.substr(0, 1) == "/") {
				return b.substr(0, b.indexOf("/", b.indexOf("://") + 3)) + a
			} else {
				return b + a
			}
		}
	}
};
Timeline.DefaultEventSource.Event = function(a, e, g, f, b, l, k, c, i, h, d, j) {
	this._id = "e" + Math.floor(Math.random() * 1000000);
	this._instant = b || (e == null);
	this._start = a;
	this._end = (e != null) ? e : a;
	this._latestStart = (g != null) ? g : (b ? this._end : this._start);
	this._earliestEnd = (f != null) ? f : (b ? this._start : this._end);
	this._text = Timeline.HTML.deEntify(l);
	this._description = Timeline.HTML.deEntify(k);
	this._image = (c != null && c != "") ? c : null;
	this._link = (i != null && i != "") ? i : null;
	this._icon = (h != null && h != "") ? h : null;
	this._color = (d != null && d != "") ? d : null;
	this._textColor = (j != null && j != "") ? j : null;
	this._wikiURL = null;
	this._wikiSection = null
};
Timeline.DefaultEventSource.Event.prototype = {
	getID : function() {
		return this._id
	},
	isInstant : function() {
		return this._instant
	},
	isImprecise : function() {
		return this._start != this._latestStart
				|| this._end != this._earliestEnd
	},
	getStart : function() {
		return this._start
	},
	getEnd : function() {
		return this._end
	},
	getLatestStart : function() {
		return this._latestStart
	},
	getEarliestEnd : function() {
		return this._earliestEnd
	},
	getText : function() {
		return this._text
	},
	getDescription : function() {
		return this._description
	},
	getImage : function() {
		return this._image
	},
	getLink : function() {
		return this._link
	},
	getIcon : function() {
		return this._icon
	},
	getColor : function() {
		return this._color
	},
	getTextColor : function() {
		return this._textColor
	},
	getProperty : function(a) {
		return null
	},
	getWikiURL : function() {
		return this._wikiURL
	},
	getWikiSection : function() {
		return this._wikiSection
	},
	setWikiInfo : function(b, a) {
		this._wikiURL = b;
		this._wikiSection = a
	},
	fillDescription : function(a) {
		a.innerHTML = this._description
	},
	fillWikiInfo : function(e) {
		if (this._wikiURL != null && this._wikiSection != null) {
			var d = this.getProperty("wikiID");
			if (d == null || d.length == 0) {
				d = this.getText()
			}
			d = d.replace(/\s/g, "_");
			var c = this._wikiURL + this._wikiSection.replace(/\s/g, "_") + "/"
					+ d;
			var b = document.createElement("a");
			b.href = c;
			b.target = "new";
			b.innerHTML = Timeline.strings[Timeline.Platform.clientLocale].wikiLinkLabel;
			e.appendChild(document.createTextNode("["));
			e.appendChild(b);
			e.appendChild(document.createTextNode("]"))
		} else {
			e.style.display = "none"
		}
	},
	fillTime : function(a, b) {
		if (this._instant) {
			if (this.isImprecise()) {
				a.appendChild(a.ownerDocument.createTextNode(b
						.labelPrecise(this._start)));
				a.appendChild(a.ownerDocument.createElement("br"));
				a.appendChild(a.ownerDocument.createTextNode(b
						.labelPrecise(this._end)))
			} else {
				a.appendChild(a.ownerDocument.createTextNode(b
						.labelPrecise(this._start)))
			}
		} else {
			if (this.isImprecise()) {
				a.appendChild(a.ownerDocument.createTextNode(b
						.labelPrecise(this._start)
						+ " ~ " + b.labelPrecise(this._latestStart)));
				a.appendChild(a.ownerDocument.createElement("br"));
				a.appendChild(a.ownerDocument.createTextNode(b
						.labelPrecise(this._earliestEnd)
						+ " ~ " + b.labelPrecise(this._end)))
			} else {
				a.appendChild(a.ownerDocument.createTextNode(b
						.labelPrecise(this._start)));
				a.appendChild(a.ownerDocument.createElement("br"));
				a.appendChild(a.ownerDocument.createTextNode(b
						.labelPrecise(this._end)))
			}
		}
	},
	fillInfoBubble : function(b, e, l) {
		var m = b.ownerDocument;
		var k = this.getText();
		var i = this.getLink();
		var d = this.getImage();
		if (d != null) {
			var f = m.createElement("img");
			f.src = d;
			e.event.bubble.imageStyler(f);
			b.appendChild(f)
		}
		var n = m.createElement("div");
		var c = m.createTextNode(k);
		if (i != null) {
			var j = m.createElement("a");
			j.href = i;
			j.appendChild(c);
			n.appendChild(j)
		} else {
			n.appendChild(c)
		}
		e.event.bubble.titleStyler(n);
		b.appendChild(n);
		var o = m.createElement("div");
		this.fillDescription(o);
		e.event.bubble.bodyStyler(o);
		b.appendChild(o);
		var h = m.createElement("div");
		this.fillTime(h, l);
		e.event.bubble.timeStyler(h);
		b.appendChild(h);
		var g = m.createElement("div");
		this.fillWikiInfo(g);
		e.event.bubble.wikiStyler(g);
		b.appendChild(g)
	}
};
Timeline.ClassicTheme = new Object();
Timeline.ClassicTheme.implementations = [];
Timeline.ClassicTheme.create = function(a) {
	if (a == null) {
		a = Timeline.Platform.getDefaultLocale()
	}
	var b = Timeline.ClassicTheme.implementations[a];
	if (b == null) {
		b = Timeline.ClassicTheme._Impl
	}
	return new b()
};
Timeline.ClassicTheme._Impl = function() {
	this.firstDayOfWeek = 0;
	this.ether = {
		backgroundColors : [ "#EEE", "#DDD", "#CCC", "#AAA" ],
		highlightColor : "white",
		highlightOpacity : 50,
		interval : {
			line : {
				show : true,
				color : "#aaa",
				opacity : 25
			},
			weekend : {
				color : "#FFFFE0",
				opacity : 30
			},
			marker : {
				hAlign : "Bottom",
				hBottomStyler : function(a) {
					a.className = "timeline-ether-marker-bottom"
				},
				hBottomEmphasizedStyler : function(a) {
					a.className = "timeline-ether-marker-bottom-emphasized"
				},
				hTopStyler : function(a) {
					a.className = "timeline-ether-marker-top"
				},
				hTopEmphasizedStyler : function(a) {
					a.className = "timeline-ether-marker-top-emphasized"
				},
				vAlign : "Right",
				vRightStyler : function(a) {
					a.className = "timeline-ether-marker-right"
				},
				vRightEmphasizedStyler : function(a) {
					a.className = "timeline-ether-marker-right-emphasized"
				},
				vLeftStyler : function(a) {
					a.className = "timeline-ether-marker-left"
				},
				vLeftEmphasizedStyler : function(a) {
					a.className = "timeline-ether-marker-left-emphasized"
				}
			}
		}
	};
	this.event = {
		track : {
			offset : 0.5,
			height : 1.5,
			gap : 0.5
		},
		instant : {
			icon : Timeline.urlPrefix + "images/dull-blue-circle.png",
			lineColor : "#58A0DC",
			impreciseColor : "#58A0DC",
			impreciseOpacity : 20,
			showLineForNoText : true
		},
		duration : {
			color : "#58A0DC",
			opacity : 100,
			impreciseColor : "#58A0DC",
			impreciseOpacity : 20
		},
		label : {
			insideColor : "white",
			outsideColor : "black",
			width : 200
		},
		highlightColors : [ "#FFFF00", "#FFC000", "#FF0000", "#0000FF" ],
		bubble : {
			width : 250,
			height : 125,
			titleStyler : function(a) {
				a.className = "timeline-event-bubble-title"
			},
			bodyStyler : function(a) {
				a.className = "timeline-event-bubble-body"
			},
			imageStyler : function(a) {
				a.className = "timeline-event-bubble-image"
			},
			wikiStyler : function(a) {
				a.className = "timeline-event-bubble-wiki"
			},
			timeStyler : function(a) {
				a.className = "timeline-event-bubble-time"
			}
		}
	}
};
Timeline.NativeDateUnit = new Object();
Timeline.NativeDateUnit.createLabeller = function(a, b) {
	return new Timeline.GregorianDateLabeller(a, b)
};
Timeline.NativeDateUnit.makeDefaultValue = function() {
	return new Date()
};
Timeline.NativeDateUnit.cloneValue = function(a) {
	return new Date(a.getTime())
};
Timeline.NativeDateUnit.getParser = function(a) {
	if (typeof a == "string") {
		a = a.toLowerCase()
	}
	return (a == "iso8601" || a == "iso 8601") ? Timeline.DateTime.parseIso8601DateTime
			: Timeline.DateTime.parseGregorianDateTime
};
Timeline.NativeDateUnit.parseFromObject = function(a) {
	return Timeline.DateTime.parseGregorianDateTime(a)
};
Timeline.NativeDateUnit.toNumber = function(a) {
	return a.getTime()
};
Timeline.NativeDateUnit.fromNumber = function(a) {
	return new Date(a)
};
Timeline.NativeDateUnit.compare = function(d, c) {
	var b, a;
	if (typeof d == "object") {
		b = d.getTime()
	} else {
		b = Number(d)
	}
	if (typeof c == "object") {
		a = c.getTime()
	} else {
		a = Number(c)
	}
	return b - a
};
Timeline.NativeDateUnit.earlier = function(b, a) {
	return Timeline.NativeDateUnit.compare(b, a) < 0 ? b : a
};
Timeline.NativeDateUnit.later = function(b, a) {
	return Timeline.NativeDateUnit.compare(b, a) > 0 ? b : a
};
Timeline.NativeDateUnit.change = function(a, b) {
	return new Date(a.getTime() + b)
};
