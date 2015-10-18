/* 
 * Timemap.js Copyright 2008 Nick Rabinowitz.
 * Licensed under the MIT License (see LICENSE.txt)
 */
(function() {
	var j = this, g, h = j.Timeline, i = h.DateTime, d = j.jQuery, q = j.mxn, s = q.Mapstraction, c = q.LatLonPoint, a = q.BoundingBox, f = q.Marker, o = q.Polyline, r = "itemsloaded", k = "http://www.google.com/intl/en_us/mapfiles/ms/icons/", l, p, n, m, e;
	l = function(u, w, v) {
		var t = this, y = {
			mapCenter : new c(0, 0),
			mapZoom : 0,
			mapType : "physical",
			showMapTypeCtrl : true,
			showMapCtrl : true,
			syncBands : true,
			mapFilter : "hidePastFuture",
			centerOnItems : true,
			theme : "red",
			dateParser : "hybrid",
			checkResize : true,
			multipleInfoWindows : false
		}, x;
		t.mElement = w;
		t.tElement = u;
		t.datasets = {};
		t.chains = {};
		t.opts = v = d.extend(y, v);
		x = v.mapCenter;
		if (x.constructor != c && x.lat) {
			v.mapCenter = new c(x.lat, x.lon)
		}
		v.mapType = b.lookup(v.mapType, l.mapTypes);
		v.mapFilter = b.lookup(v.mapFilter, l.filters);
		v.theme = m.create(v.theme, v);
		t.initMap()
	};
	l.version = "2.0.1";
	var b = l.util = {};
	l.init = function(v) {
		var C = "TimeMap.init: Either %Id or %Selector is required", B = {
			options : {},
			datasets : [],
			bands : false,
			bandInfo : false,
			bandIntervals : "wk",
			scrollTo : "earliest"
		}, t = l.state, F, I, D = [], G, y, A, u, z = [], w;
		v.mapSelector = v.mapSelector || "#" + v.mapId;
		v.timelineSelector = v.timelineSelector || "#" + v.timelineId;
		if (t) {
			t.setConfigFromUrl(v)
		}
		v = d.extend(B, v);
		if (!v.bandInfo && !v.bands) {
			F = b.lookup(v.bandIntervals, l.intervals);
			v.bandInfo = [ {
				width : "80%",
				intervalUnit : F[0],
				intervalPixels : 70
			}, {
				width : "20%",
				intervalUnit : F[1],
				intervalPixels : 100,
				showEventText : false,
				overview : true,
				trackHeight : 0.4,
				trackGap : 0.2
			} ]
		}
		I = new l(d(v.timelineSelector).get(0), d(v.mapSelector).get(0),
				v.options);
		v.datasets.forEach(function(K, J) {
			y = d.extend({
				title : K.title,
				theme : K.theme,
				dateParser : K.dateParser
			}, K.options);
			u = K.id || "ds" + J;
			D[J] = I.createDataset(u, y);
			if (J > 0) {
				D[J].eventSource = D[0].eventSource
			}
		});
		I.eventSource = D[0].eventSource;
		w = (D[0] && D[0].eventSource) || new h.DefaultEventSource();
		if (v.bands) {
			v.bands.forEach(function(x) {
				if (x.eventSource !== null) {
					x.eventSource = w
				}
			});
			z = v.bands
		} else {
			v.bandInfo.forEach(function(K, J) {
				if (!(("eventSource" in K) && !K.eventSource)) {
					K.eventSource = w
				} else {
					K.eventSource = null
				}
				z[J] = h.createBandInfo(K);
				if (J > 0 && b.TimelineVersion() == "1.2") {
					z[J].eventPainter.setLayout(z[0].eventPainter.getLayout())
				}
			})
		}
		I.initTimeline(z);
		var E = l.loadManager, H = function() {
			E.increment()
		};
		E.init(I, v.datasets.length, v);
		v.datasets
				.forEach(function(P, K) {
					var Q = D[K], M = P.data || P.options || {}, O = P.type
							|| M.type, N = (typeof O == "string") ? l.loaders[O]
							: O, J = new N(M);
					J.load(Q, H)
				});
		return I
	};
	l.prototype = {
		initMap : function() {
			var t = this, u = t.opts, w, v;
			t.map = w = new s(t.mElement, u.mapProvider);
			w.setCenterAndZoom(u.mapCenter, u.mapZoom);
			w.addControls({
				pan : u.showMapCtrl,
				zoom : u.showMapCtrl ? "large" : false,
				map_type : u.showMapTypeCtrl
			});
			w.setMapType(u.mapType);
			if (u.multipleInfoWindows) {
				w.setOption("enableMultipleBubbles", true)
			}
			t.getNativeMap = function() {
				return w.getMap()
			}
		},
		initTimeline : function(w) {
			var C = this, B, u = C.opts, D = function(x) {
				return x.visible
			}, v = function(x) {
				return x.dataset.visible
			}, y = function(E, G, F) {
				F.item.openInfoWindow()
			}, t, A, z;
			for (A = 1; A < w.length; A++) {
				if (u.syncBands) {
					w[A].syncWith = 0
				}
				w[A].highlight = true
			}
			C.timeline = B = h.create(C.tElement, w);
			for (A = 0; A < B.getBandCount(); A++) {
				z = B.getBand(A).getEventPainter().constructor;
				z.prototype._showBubble = y
			}
			C.addFilterChain("map", function(x) {
				x.showPlacemark()
			}, function(x) {
				x.hidePlacemark()
			}, null, null, [ D, v ]);
			if (u.mapFilter) {
				C.addFilter("map", u.mapFilter);
				B.getBand(0).addOnScrollListener(function() {
					C.filter("map")
				})
			}
			C.addFilterChain("timeline", function(x) {
				x.showEvent()
			}, function(x) {
				x.hideEvent()
			}, null, function() {
				C.eventSource._events._index();
				B.layout()
			}, [ D, v ]);
			if (u.timelineFilter) {
				C.addFilter("map", u.timelineFilter)
			}
			if (u.checkResize) {
				j.onresize = function() {
					if (!t) {
						t = j.setTimeout(function() {
							t = null;
							B.layout()
						}, 500)
					}
				}
			}
		},
		parseDate : function(t) {
			var v = new Date(), u = this.eventSource, x = l.dateParsers.hybrid, w = u
					.getCount() > 0 ? true : false;
			switch (t) {
			case "now":
				break;
			case "earliest":
			case "first":
				if (w) {
					v = u.getEarliestDate()
				}
				break;
			case "latest":
			case "last":
				if (w) {
					v = u.getLatestDate()
				}
				break;
			default:
				v = x(t)
			}
			return v
		},
		scrollToDate : function(z, A, y) {
			var G = this.timeline, u = G.getBand(0), D, v, E = [], F, w, t;
			z = this.parseDate(z);
			if (z) {
				v = z.getTime();
				for (D = 0; D < G.getBandCount(); D++) {
					F = G.getBand(D);
					w = F.getMinDate().getTime();
					t = F.getMaxDate().getTime();
					E[D] = (A && v > w && v < t)
				}
				if (y) {
					var C = b.TimelineVersion() == "1.2" ? h : SimileAjax, B = C.Graphics
							.createAnimation(function(x, H) {
								u.setCenterVisibleDate(new Date(x))
							}, u.getCenterVisibleDate().getTime(), v, 1000);
					B.run()
				} else {
					u.setCenterVisibleDate(z)
				}
				for (D = 0; D < E.length; D++) {
					if (E[D]) {
						G.getBand(D).layout()
					}
				}
			} else {
				if (A) {
					G.layout()
				}
			}
		},
		createDataset : function(x, u) {
			var t = this, w = new n(t, u);
			w.id = x;
			t.datasets[x] = w;
			if (t.opts.centerOnItems) {
				var v = t.map;
				d(w).bind(r, function() {
					v.autoCenterAndZoom()
				})
			}
			return w
		},
		each : function(u) {
			var t = this, v;
			for (v in t.datasets) {
				if (t.datasets.hasOwnProperty(v)) {
					u(t.datasets[v])
				}
			}
		},
		eachItem : function(t) {
			this.each(function(u) {
				u.each(function(v) {
					t(v)
				})
			})
		},
		getItems : function() {
			var t = [];
			this.each(function(u) {
				t = t.concat(u.items)
			});
			return t
		},
		setSelected : function(t) {
			this.opts.selected = t
		},
		getSelected : function() {
			return this.opts.selected
		},
		filter : function(u) {
			var t = this.chains[u];
			if (t) {
				t.run()
			}
		},
		addFilterChain : function(x, u, t, y, w, v) {
			this.chains[x] = new p(this, u, t, y, w, v)
		},
		removeFilterChain : function(t) {
			delete this.chains[t]
		},
		addFilter : function(u, v) {
			var t = this.chains[u];
			if (t) {
				t.add(v)
			}
		},
		removeFilter : function(u, v) {
			var t = this.chains[u];
			if (t) {
				t.remove(v)
			}
		}
	};
	l.loadManager = new function() {
		var t = this;
		t.init = function(u, w, v) {
			t.count = 0;
			t.tm = u;
			t.target = w;
			t.opts = v || {}
		};
		t.increment = function() {
			t.count++;
			if (t.count >= t.target) {
				t.complete()
			}
		};
		t.complete = function() {
			var u = t.tm, w = t.opts, v = w.dataLoadedFunction;
			if (v) {
				v(u)
			} else {
				u.scrollToDate(w.scrollTo, true);
				if (u.initState) {
					u.initState()
				}
				v = w.dataDisplayedFunction;
				if (v) {
					v(u)
				}
			}
		}
	}();
	l.loaders = {
		cb : {},
		cancel : function(u) {
			var t = l.loaders.cb;
			t[u] = function() {
				delete t[u]
			}
		},
		cancelAll : function() {
			var t = l.loaders, u = t.cb, v;
			for (v in u) {
				if (u.hasOwnProperty(v)) {
					t.cancel(v)
				}
			}
		},
		counter : 0,
		base : function(u) {
			var v = function(w) {
				return w
			}, t = this;
			t.parse = u.parserFunction || v;
			t.preload = u.preloadFunction || v;
			t.transform = u.transformFunction || v;
			t.scrollTo = u.scrollTo || "earliest";
			t.getCallbackName = function(y, z) {
				var w = l.loaders.cb, x = "_" + l.loaders.counter++;
				z = z || function() {
					y.timemap.scrollToDate(t.scrollTo, true)
				};
				w[x] = function(A) {
					var B = t.parse(A);
					B = t.preload(B);
					y.loadItems(B, t.transform);
					z();
					delete w[x]
				};
				return x
			};
			t.getCallback = function(x, y) {
				var w = t.getCallbackName(x, y);
				return l.loaders.cb[w]
			};
			t.cancel = function() {
				l.loaders.cancel(t.callbackName)
			}
		},
		basic : function(u) {
			var t = new l.loaders.base(u);
			t.data = u.items || u.value || [];
			t.load = function(v, w) {
				(this.getCallback(v, w))(this.data)
			};
			return t
		},
		remote : function(u) {
			var t = new l.loaders.base(u);
			t.opts = d.extend({}, u, {
				type : "GET",
				dataType : "text"
			});
			t.load = function(v, w) {
				t.callbackName = t.getCallbackName(v, w);
				t.opts.success = l.loaders.cb[t.callbackName];
				d.ajax(t.opts)
			};
			return t
		}
	};
	p = function(v, u, t, A, x, w) {
		var y = this, z = d.noop;
		y.timemap = v;
		y.chain = w || [];
		y.on = u || z;
		y.off = t || z;
		y.pre = A || z;
		y.post = x || z
	};
	p.prototype = {
		add : function(t) {
			return this.chain.push(t)
		},
		remove : function(v) {
			var u = this.chain, t = v ? u.indexOf(v) : u.length - 1;
			return u.splice(t, 1)
		},
		run : function() {
			var u = this, t = u.chain;
			if (!t.length) {
				return
			}
			u.pre();
			u.timemap.eachItem(function(x) {
				var v, w = t.length;
				L: while (!v) {
					while (w--) {
						if (!t[w](x)) {
							u.off(x);
							break L
						}
					}
					u.on(x);
					v = true
				}
			});
			u.post()
		}
	};
	l.filters = {
		hidePastFuture : function(t) {
			return t.onVisibleTimeline()
		},
		hideFuture : function(v) {
			var u = v.timeline.getBand(0).getMaxVisibleDate().getTime(), t = v
					.getStartTime();
			if (t !== g) {
				return t < u
			}
			return true
		},
		showMomentOnly : function(u) {
			var w = u.timeline.getBand(0), x = w.getCenterVisibleDate()
					.getTime(), t = u.getStartTime(), v = u.getEndTime();
			if (t !== g) {
				return t < x && (v > x || t > x)
			}
			return true
		}
	};
	n = function(t, u) {
		var v = this;
		v.timemap = t;
		v.eventSource = new h.DefaultEventSource();
		v.items = [];
		v.visible = true;
		v.opts = u = d.extend({}, t.opts, u);
		u.dateParser = b.lookup(u.dateParser, l.dateParsers);
		u.theme = m.create(u.theme, u)
	};
	n.prototype = {
		getItems : function(u) {
			var t = this.items;
			return u === g ? t : u in t ? t[u] : null
		},
		getTitle : function() {
			return this.opts.title
		},
		each : function(t) {
			this.items.forEach(t)
		},
		loadItems : function(v, t) {
			if (v) {
				var u = this;
				v.forEach(function(w) {
					u.loadItem(w, t)
				});
				d(u).trigger(r)
			}
		},
		loadItem : function(w, t) {
			if (t) {
				w = t(w)
			}
			if (w) {
				var v = this, u;
				w.options = d.extend({}, v.opts, {
					title : null
				}, w.options);
				u = new e(w, v);
				v.items.push(u);
				return u
			}
		}
	};
	m = function(t) {
		var v = {
			color : "#FE766A",
			lineOpacity : 1,
			lineWeight : 2,
			fillOpacity : 0.4,
			eventTextColor : null,
			eventIconPath : "timemap/images/",
			eventIconImage : "red-circle.png",
			classicTape : false,
			icon : k + "red-dot.png",
			iconSize : [ 32, 32 ],
			iconShadow : k + "msmarker.shadow.png",
			iconShadowSize : [ 59, 32 ],
			iconAnchor : [ 16, 33 ]
		};
		var u = d.extend(v, t);
		v = {
			lineColor : u.color,
			fillColor : u.color,
			eventColor : u.color,
			eventIcon : u.eventIcon || u.eventIconPath + u.eventIconImage
		};
		return d.extend(v, u)
	};
	m.create = function(v, t) {
		v = b.lookup(v, l.themes);
		if (!v) {
			return new m(t)
		}
		if (t) {
			var w = false, u;
			for (u in t) {
				if (v.hasOwnProperty(u)) {
					w = {};
					break
				}
			}
			if (w) {
				for (u in v) {
					if (v.hasOwnProperty(u)) {
						w[u] = t[u] || v[u]
					}
				}
				w.eventIcon = t.eventIcon || w.eventIconPath + w.eventIconImage;
				return w
			}
		}
		return v
	};
	e = function(O, F) {
		var M = this, z = d
				.extend(
						{
							type : "none",
							description : "",
							infoPoint : null,
							infoHtml : "",
							infoUrl : "",
							openInfoWindow : O.options.infoUrl ? e.openInfoWindowAjax
									: e.openInfoWindowBasic,
							infoTemplate : '<div class="infotitle">{{title}}</div><div class="infodescription">{{description}}</div>',
							templatePattern : /\{\{([^}]+)\}\}/g,
							closeInfoWindow : e.closeInfoWindowBasic
						}, O.options), x = F.timemap, N = z.theme = m.create(
				z.theme, z), w = z.dateParser, E = h.DefaultEventSource.Event, C = O.start, A = O.end, u = N.eventIcon, B = N.eventTextColor, P = z.title = O.title
				|| "Untitled", J = null, v, D = [], H = [], t = null, y = "", I = null, K;
		M.dataset = F;
		M.map = x.map;
		M.timeline = x.timeline;
		M.opts = z;
		C = C ? w(C) : null;
		A = A ? w(A) : null;
		v = !A;
		if (C !== null) {
			if (b.TimelineVersion() == "1.2") {
				J = new E(C, A, null, null, v, P, null, null, null, u,
						N.eventColor, N.eventTextColor)
			} else {
				if (!B) {
					B = (N.classicTape && !v) ? "#FFFFFF" : "#000000"
				}
				J = new E({
					start : C,
					end : A,
					instant : v,
					text : P,
					icon : u,
					color : N.eventColor,
					textColor : B
				})
			}
			J.item = M;
			if (!z.noEventLoad) {
				F.eventSource.add(J)
			}
		}
		M.event = J;
		function G(U) {
			var T = null, W = "", Z = null, ac;
			if (U.point) {
				var V = U.point.lat, Q = U.point.lon;
				if (V === g || Q === g) {
					return T
				}
				Z = new c(parseFloat(V), parseFloat(Q));
				T = new f(Z);
				T.setLabel(U.title);
				T.addData(N);
				W = "marker"
			} else {
				if (U.polyline || U.polygon) {
					var aa = [], R = "polygon" in U, ab = U.polyline
							|| U.polygon, X;
					ac = new a();
					if (ab && ab.length) {
						for (X = 0; X < ab.length; X++) {
							Z = new c(parseFloat(ab[X].lat),
									parseFloat(ab[X].lon));
							aa.push(Z);
							ac.extend(Z)
						}
						T = new o(aa);
						T.addData({
							color : N.lineColor,
							width : N.lineWeight,
							opacity : N.lineOpacity,
							closed : R,
							fillColor : N.fillColor,
							fillOpacity : N.fillOpacity
						});
						W = R ? "polygon" : "polyline";
						Z = R ? ac.getCenter() : aa[Math.floor(aa.length / 2)]
					}
				} else {
					if ("overlay" in U) {
						var Y = new c(parseFloat(U.overlay.south),
								parseFloat(U.overlay.west)), S = new c(
								parseFloat(U.overlay.north),
								parseFloat(U.overlay.east));
						ac = new a(Y.lat, Y.lon, S.lat, S.lon);
						x.map.addImageOverlay("img" + (new Date()).getTime(),
								U.overlay.image, N.lineOpacity, Y.lon, Y.lat,
								S.lon, S.lat);
						W = "overlay";
						Z = ac.getCenter()
					}
				}
			}
			return {
				placemark : T,
				type : W,
				point : Z
			}
		}
		if ("placemarks" in O) {
			H = O.placemarks
		} else {
			[ "point", "polyline", "polygon", "overlay" ].forEach(function(Q) {
				if (Q in O) {
					t = {};
					t[Q] = O[Q];
					H.push(t)
				}
			})
		}
		H.forEach(function(R) {
			R.title = R.title || P;
			var Q = G(R);
			if (Q) {
				I = I || Q.point;
				y = y || Q.type;
				if (Q.placemark) {
					D.push(Q.placemark)
				}
			}
		});
		z.type = D.length > 1 ? "array" : y;
		z.infoPoint = z.infoPoint ? new c(parseFloat(z.infoPoint.lat),
				parseFloat(z.infoPoint.lon)) : I;
		D.forEach(function(Q) {
			Q.item = M;
			Q.click.addHandler(function() {
				M.openInfoWindow()
			});
			if (!z.noPlacemarkLoad) {
				if (b.getPlacemarkType(Q) == "marker") {
					x.map.addMarker(Q)
				} else {
					x.map.addPolyline(Q)
				}
				Q.hide()
			}
		});
		M.placemark = D.length == 1 ? D[0] : D.length ? D : null;
		M.getNativePlacemark = function() {
			var Q = M.placemark;
			return Q && (Q.proprietary_marker || Q.proprietary_polyline)
		};
		M.getType = function() {
			return z.type
		};
		M.getTitle = function() {
			return z.title
		};
		M.getInfoPoint = function() {
			return z.infoPoint || M.map.getCenter()
		};
		M.getStart = function() {
			return M.event ? M.event.getStart() : null
		};
		M.getEnd = function() {
			return M.event ? M.event.getEnd() : null
		};
		M.getStartTime = function() {
			var Q = M.getStart();
			if (Q) {
				return Q.getTime()
			}
		};
		M.getEndTime = function() {
			var Q = M.getEnd();
			if (Q) {
				return Q.getTime()
			}
		};
		M.isSelected = function() {
			return x.getSelected() === M
		};
		M.visible = true;
		M.placemarkVisible = false;
		M.eventVisible = true;
		M.openInfoWindow = function() {
			z.openInfoWindow.call(M);
			x.setSelected(M)
		};
		M.closeInfoWindow = function() {
			z.closeInfoWindow.call(M);
			x.setSelected(g)
		}
	};
	e.prototype = {
		showPlacemark : function() {
			var t = this, u = function(v) {
				if (v.api) {
					v.show()
				}
			};
			if (t.placemark && !t.placemarkVisible) {
				if (t.getType() == "array") {
					t.placemark.forEach(u)
				} else {
					u(t.placemark)
				}
				t.placemarkVisible = true
			}
		},
		hidePlacemark : function() {
			var t = this, u = function(v) {
				if (v.api) {
					v.hide()
				}
			};
			if (t.placemark && t.placemarkVisible) {
				if (t.getType() == "array") {
					t.placemark.forEach(u)
				} else {
					u(t.placemark)
				}
				t.placemarkVisible = false
			}
			t.closeInfoWindow()
		},
		showEvent : function() {
			var u = this, t = u.event;
			if (t && !u.eventVisible) {
				u.timeline.getBand(0).getEventSource()._events._events.add(t);
				u.eventVisible = true
			}
		},
		hideEvent : function() {
			var u = this, t = u.event;
			if (t && u.eventVisible) {
				u.timeline.getBand(0).getEventSource()._events._events
						.remove(t);
				u.eventVisible = false
			}
		},
		scrollToStart : function(u) {
			var t = this;
			if (t.event) {
				t.dataset.timemap.scrollToDate(t.getStart(), false, u)
			}
		},
		getInfoHtml : function() {
			var v = this.opts, u = v.infoHtml, w = v.templatePattern, t;
			if (!u) {
				u = v.infoTemplate;
				t = w.exec(u);
				while (t) {
					u = u.replace(t[0], v[t[1]] || "");
					t = w.exec(u)
				}
				v.infoHtml = u
			}
			return u
		},
		onVisibleTimeline : function() {
			var w = this, y = w.timeline.getBand(0), u = y.getMaxVisibleDate()
					.getTime(), v = y.getMinVisibleDate().getTime(), t = w
					.getStartTime(), x = w.getEndTime();
			return t !== g ? t < u && (x > v || t > v) : true
		}
	};
	e.openInfoWindowBasic = function() {
		var v = this, u = v.getInfoHtml(), w = v.dataset, t = v.placemark;
		if (!v.onVisibleTimeline()) {
			w.timemap.scrollToDate(v.getStart())
		}
		if (v.getType() == "marker" && t.api) {
			t.setInfoBubble(u);
			t.openBubble();
			v.closeHandler = t.closeInfoBubble.addHandler(function() {
				w.timemap.setSelected(g);
				t.closeInfoBubble.removeHandler(v.closeHandler)
			})
		} else {
			v.map.openBubble(v.getInfoPoint(), u);
			v.map.tmBubbleItem = v
		}
	};
	e.openInfoWindowAjax = function() {
		var t = this;
		if (!t.opts.infoHtml && t.opts.infoUrl) {
			d.get(t.opts.infoUrl, function(u) {
				t.opts.infoHtml = u;
				t.openInfoWindow()
			});
			return
		}
		t.openInfoWindow = function() {
			e.openInfoWindowBasic.call(t);
			t.dataset.timemap.setSelected(t)
		};
		t.openInfoWindow()
	};
	e.closeInfoWindowBasic = function() {
		var t = this;
		if (t.getType() == "marker") {
			t.placemark.closeBubble()
		} else {
			if (t == t.map.tmBubbleItem) {
				t.map.closeBubble();
				t.map.tmBubbleItem = null
			}
		}
	};
	l.util.getTagValue = function(v, t, u) {
		return b.getNodeList(v, t, u).first().text()
	};
	l.util.nsMap = {};
	l.util.getNodeList = function(w, u, v) {
		var t = l.util.nsMap;
		w = w.jquery ? w[0] : w;
		return !w ? d() : !v ? d(u, w)
				: (w.getElementsByTagNameNS && t[v]) ? d(w
						.getElementsByTagNameNS(t[v], u)) : d(w
						.getElementsByTagName(v + ":" + u))
	};
	l.util.makePoint = function(u, v) {
		var t = null;
		if (u.lat && u.lng) {
			t = [ u.lat(), u.lng() ]
		}
		if (d.type(u) == "array") {
			t = u
		}
		if (!t) {
			u = d.trim(u);
			if (u.indexOf(",") > -1) {
				t = u.split(",")
			} else {
				t = u.split(/[\r\n\f ]+/)
			}
		}
		if (t.length > 2) {
			t = t.slice(0, 2)
		}
		if (v) {
			t.reverse()
		}
		return {
			lat : d.trim(t[0]),
			lon : d.trim(t[1])
		}
	};
	l.util.makePoly = function(w, z) {
		var v = [], u, t, y = d.trim(w).split(/[\r\n\f ]+/);
		for (t = 0; t < y.length; t++) {
			u = (y[t].indexOf(",") > 0) ? y[t].split(",") : [ y[t], y[++t] ];
			if (u.length > 2) {
				u = u.slice(0, 2)
			}
			if (z) {
				u.reverse()
			}
			v.push({
				lat : u[0],
				lon : u[1]
			})
		}
		return v
	};
	l.util.formatDate = function(z, y) {
		y = y || 3;
		var A = "";
		if (z) {
			var x = z.getUTCFullYear(), u = z.getUTCMonth(), B = z.getUTCDate();
			if (x < 1000) {
				return (x < 1 ? (x * -1 + "BC") : x + "")
			}
			if (z.toISOString && y == 3) {
				return z.toISOString()
			}
			var t = function(D) {
				return ((D < 10) ? "0" : "") + D
			};
			A += x + "-" + t(u + 1) + "-" + t(B);
			if (y > 1) {
				var v = z.getUTCHours(), w = z.getUTCMinutes(), C = z
						.getUTCSeconds();
				A += "T" + t(v) + ":" + t(w);
				if (y > 2) {
					A += t(C)
				}
				A += "Z"
			}
		}
		return A
	};
	l.util.TimelineVersion = function() {
		return h.version || (h.DurationEventPainter ? "1.2" : "2.2.0")
	};
	l.util.getPlacemarkType = function(t) {
		return t.constructor == f ? "marker"
				: t.constructor == o ? (t.closed ? "polygon" : "polyline")
						: false
	};
	l.util.lookup = function(t, u) {
		return typeof t == "string" ? u[t] : t
	};
	if (!([].indexOf)) {
		Array.prototype.indexOf = function(v) {
			var t = this, u = t.length;
			while (--u >= 0) {
				if (t[u] === v) {
					break
				}
			}
			return u
		}
	}
	if (!([].forEach)) {
		Array.prototype.forEach = function(v) {
			var t = this, u;
			for (u = 0; u < t.length; u++) {
				if (u in t) {
					v(t[u], u, t)
				}
			}
		}
	}
	l.intervals = {
		sec : [ i.SECOND, i.MINUTE ],
		min : [ i.MINUTE, i.HOUR ],
		hr : [ i.HOUR, i.DAY ],
		day : [ i.DAY, i.WEEK ],
		wk : [ i.WEEK, i.MONTH ],
		mon : [ i.MONTH, i.YEAR ],
		yr : [ i.YEAR, i.DECADE ],
		dec : [ i.DECADE, i.CENTURY ]
	};
	l.mapTypes = {
		normal : s.ROAD,
		satellite : s.SATELLITE,
		hybrid : s.HYBRID,
		physical : s.PHYSICAL
	};
	l.dateParsers = {
		gregorian : function(u) {
			if (!u || typeof u != "string") {
				return null
			}
			var v = Boolean(u.match(/b\.?c\.?/i)), t = parseInt(u, 10), w;
			if (!isNaN(t)) {
				if (v) {
					t = 1 - t
				}
				w = new Date(0);
				w.setUTCFullYear(t);
				return w
			} else {
				return null
			}
		},
		hybrid : function(u) {
			if (u instanceof Date) {
				return u
			}
			var t = l.dateParsers, w = new Date(typeof u == "number" ? u : Date
					.parse(t.fixChromeBug(u)));
			if (isNaN(w)) {
				if (typeof u == "string") {
					if (u
							.match(/^-?\d{1,6} ?(a\.?d\.?|b\.?c\.?e?\.?|c\.?e\.?)?$/i)) {
						w = t.gregorian(u)
					} else {
						try {
							w = t.iso8601(u)
						} catch (v) {
							w = null
						}
					}
					if (!w && u.match(/^\d{7,}$/)) {
						w = new Date(parseInt(u, 10))
					}
				} else {
					return null
				}
			}
			return w
		},
		iso8601 : i.parseIso8601DateTime,
		fixChromeBug : function(t) {
			return Date.parse("-200") == Date.parse("200") ? (typeof t == "string"
					&& t.substr(0, 1) == "-" ? null : t)
					: t
		}
	};
	l.themes = {
		red : new m(),
		blue : new m({
			icon : k + "blue-dot.png",
			color : "#5A7ACF",
			eventIconImage : "blue-circle.png"
		}),
		green : new m({
			icon : k + "green-dot.png",
			color : "#19CF54",
			eventIconImage : "green-circle.png"
		}),
		ltblue : new m({
			icon : k + "ltblue-dot.png",
			color : "#5ACFCF",
			eventIconImage : "ltblue-circle.png"
		}),
		purple : new m({
			icon : k + "purple-dot.png",
			color : "#8E67FD",
			eventIconImage : "purple-circle.png"
		}),
		orange : new m({
			icon : k + "orange-dot.png",
			color : "#FF9900",
			eventIconImage : "orange-circle.png"
		}),
		yellow : new m({
			icon : k + "yellow-dot.png",
			color : "#ECE64A",
			eventIconImage : "yellow-circle.png"
		}),
		pink : new m({
			icon : k + "pink-dot.png",
			color : "#E14E9D",
			eventIconImage : "pink-circle.png"
		})
	};
	j.TimeMap = l;
	j.TimeMapFilterChain = p;
	j.TimeMapDataset = n;
	j.TimeMapTheme = m;
	j.TimeMapItem = e
})();
(function() {
	var e = this, d = e.TimeMap, b = e.TimeMapDataset, c = e.TimeMapItem, a = d.util;
	d.prototype.clear = function() {
		var f = this;
		f.eachItem(function(g) {
			g.event = g.placemark = null
		});
		f.map.removeAllPolylines();
		f.map.removeAllMarkers();
		f.eventSource.clear();
		f.datasets = []
	};
	d.prototype.deleteDataset = function(f) {
		this.datasets[f].clear();
		delete this.datasets[f]
	};
	d.prototype.hideDataset = function(f) {
		if (f in this.datasets) {
			this.datasets[f].hide()
		}
	};
	d.prototype.hideDatasets = function() {
		var f = this;
		f.each(function(g) {
			g.visible = false
		});
		f.filter("map");
		f.filter("timeline")
	};
	d.prototype.showDataset = function(f) {
		if (f in this.datasets) {
			this.datasets[f].show()
		}
	};
	d.prototype.showDatasets = function() {
		var f = this;
		f.each(function(g) {
			g.visible = true
		});
		f.filter("map");
		f.filter("timeline")
	};
	d.prototype.changeMapType = function(g) {
		var f = this;
		if (g == f.opts.mapType) {
			return
		}
		if (typeof (g) == "string") {
			g = d.mapTypes[g]
		}
		if (!g) {
			return
		}
		f.opts.mapType = g;
		f.map.setMapType(g)
	};
	d.prototype.refreshTimeline = function() {
		var g = this.timeline.getBand(0);
		var f = g.getCenterVisibleDate();
		if (a.TimelineVersion() == "1.2") {
			g.getEventPainter().getLayout()._laidout = false
		}
		this.timeline.layout();
		g.setCenterVisibleDate(f)
	};
	d.prototype.changeTimeIntervals = function(i) {
		var g = this;
		if (!i || i == g.opts.bandIntervals) {
			return
		}
		i = a.lookup(i, d.intervals);
		g.opts.bandIntervals = i;
		function j(m, l) {
			m.getEther()._interval = Timeline.DateTime.gregorianUnitLengths[l];
			m.getEtherPainter()._unit = l
		}
		var k = g.timeline.getBand(0), h = k.getCenterVisibleDate(), f;
		for (f = 0; f < g.timeline.getBandCount(); f++) {
			j(g.timeline.getBand(f), i[f])
		}
		if (k.getEventPainter().getLayout) {
			k.getEventPainter().getLayout()._laidout = false
		}
		g.timeline.layout();
		k.setCenterVisibleDate(h)
	};
	b.prototype.clear = function() {
		var f = this;
		f.each(function(g) {
			g.clear(true)
		});
		f.items = [];
		f.timemap.timeline.layout()
	};
	b.prototype.deleteItem = function(g) {
		var h = this, f;
		for (f = 0; f < h.items.length; f++) {
			if (h.items[f] == g) {
				g.clear();
				h.items.splice(f, 1);
				break
			}
		}
	};
	b.prototype.show = function() {
		var g = this, f = g.timemap;
		if (!g.visible) {
			g.visible = true;
			f.filter("map");
			f.filter("timeline")
		}
	};
	b.prototype.hide = function() {
		var g = this, f = g.timemap;
		if (g.visible) {
			g.visible = false;
			f.filter("map");
			f.filter("timeline")
		}
	};
	b.prototype.changeTheme = function(g) {
		var f = this;
		g = a.lookup(g, d.themes);
		f.opts.theme = g;
		f.each(function(h) {
			h.changeTheme(g, true)
		});
		f.timemap.timeline.layout()
	};
	c.prototype.show = function() {
		var f = this;
		f.showEvent();
		f.showPlacemark();
		f.visible = true
	};
	c.prototype.hide = function() {
		var f = this;
		f.hideEvent();
		f.hidePlacemark();
		f.visible = false
	};
	c.prototype.clear = function(j) {
		var h = this, g;
		if (h.event) {
			h.dataset.timemap.timeline.getBand(0).getEventSource()._events._events
					.remove(h.event);
			if (!j) {
				h.timeline.layout()
			}
		}
		function f(k) {
			try {
				if (h.getType() == "marker") {
					h.map.removeMarker(k)
				} else {
					h.map.removePolyline(k)
				}
			} catch (i) {
			}
		}
		if (h.placemark) {
			h.hidePlacemark();
			if (h.getType() == "array") {
				h.placemark.forEach(f)
			} else {
				f(h.placemark)
			}
		}
		h.event = h.placemark = null
	};
	c.prototype.createEvent = function(l, f) {
		var i = this, j = i.opts.theme, g = (f === undefined), k = i.getTitle();
		var h = new Timeline.DefaultEventSource.Event(l, f, null, null, g, k,
				null, null, null, j.eventIcon, j.eventColor, null);
		h.item = i;
		i.event = h;
		i.dataset.eventSource.add(h);
		i.timeline.layout()
	};
	c.prototype.changeTheme = function(n, l) {
		var k = this, h = k.getType(), j = k.event, g = k.placemark, f;
		n = a.lookup(n, d.themes);
		k.opts.theme = n;
		function m(i) {
			i.addData(n);
			i.update()
		}
		if (g) {
			if (h == "array") {
				g.forEach(m)
			} else {
				m(g)
			}
		}
		if (j) {
			j._color = n.eventColor;
			j._icon = n.eventIcon;
			if (!l) {
				k.timeline.layout()
			}
		}
	};
	c.prototype.getNextPrev = function(f, g) {
		var k = this, l = k.dataset.timemap.timeline.getBand(0)
				.getEventSource(), h = f ? l.getEventReverseIterator(new Date(l
				.getEarliestDate().getTime() - 1), k.event.getStart()) : l
				.getEventIterator(k.event.getStart(), new Date(l
						.getLatestDate().getTime() + 1)), j = null;
		if (!k.event) {
			return
		}
		while (j === null) {
			if (h.hasNext()) {
				j = h.next().item;
				if (g && j.dataset != k.dataset) {
					j = null
				}
			} else {
				break
			}
		}
		return j
	};
	c.prototype.getNext = function(f) {
		return this.getNextPrev(false, f)
	};
	c.prototype.getPrev = function(f) {
		return this.getNextPrev(true, f)
	}
})();
(function() {
	var a = TimeMap.params = {
		Param : function(c, b) {
			var d = this;
			b = b || {};
			d.paramName = c;
			d.sourceName = b.sourceName || c;
			d.get = b.get;
			d.set = b.set;
			d.setConfig = b.setConfig || function(e, f) {
				e[c] = f
			};
			d.fromString = b.fromStr || function(e) {
				return e
			};
			d.toString = b.toStr || function(e) {
				return e.toString()
			};
			d.getString = function(e) {
				d.toString(d.get(e))
			};
			d.setString = function(f, e) {
				d.set(f, d.fromString(e))
			};
			d.setConfigXML = b.setConfigXML || function(f, i) {
				var g = d.sourceName, e = g.split(":"), h;
				if (e.length > 1) {
					g = e[1];
					h = e[0]
				}
				d.setConfig(f, TimeMap.util.getTagValue(i, g, h))
			}
		},
		OptionParam : function(d, b) {
			b = b || {};
			var c = {
				get : function(e) {
					return e.opts[d]
				},
				set : function(f, e) {
					f.opts[d] = e
				},
				setConfig : function(e, f) {
					e.options = e.options || {};
					e.options[d] = f
				}
			};
			b = $.extend(c, b);
			return new a.Param(d, b)
		}
	};
	TimeMap.loaders.base.prototype.params = {
		title : new a.Param("title"),
		start : new a.Param("start"),
		end : new a.Param("end"),
		description : new a.OptionParam("description"),
		lat : new a.Param("lat", {
			setConfig : function(b, c) {
				b.point = b.point || {};
				b.point.lat = c
			}
		}),
		lon : new a.Param("lon", {
			setConfig : function(b, c) {
				b.point = b.point || {};
				b.point.lon = c
			}
		})
	}
})();
(function() {
	var b = TimeMap.params, a = TimeMap.state = {
		fromUrl : function() {
			var d = location.hash.substring(1).split("&"), e = a.params, c = {};
			d.forEach(function(g) {
				var f = g.split("=");
				if (f.length > 1) {
					key = f[0];
					if (key && key in e) {
						c[key] = e[key].fromString(decodeURI(f[1]))
					}
				}
			});
			return c
		},
		toParamString : function(e) {
			var f = a.params, c = [], d;
			for (d in e) {
				if (e.hasOwnProperty(d)) {
					if (d in f) {
						c.push(d + "=" + encodeURI(f[d].toString(e[d])))
					}
				}
			}
			return c.join("&")
		},
		toUrl : function(d) {
			var e = a.toParamString(d), c = location.href.split("#")[0];
			return c + "#" + e
		},
		setConfig : function(c, e) {
			var f = a.params, d;
			for (d in e) {
				if (e.hasOwnProperty(d)) {
					if (d in f) {
						f[d].setConfig(c, e[d])
					}
				}
			}
		},
		setConfigFromUrl : function(c) {
			a.setConfig(c, a.fromUrl())
		}
	};
	TimeMap.prototype.setState = function(d) {
		var e = a.params, c;
		for (c in d) {
			if (d.hasOwnProperty(c)) {
				if (c in e) {
					e[c].set(this, d[c])
				}
			}
		}
	};
	TimeMap.prototype.getState = function() {
		var d = {}, e = a.params, c;
		for (c in e) {
			if (e.hasOwnProperty(c)) {
				d[c] = e[c].get(this)
			}
		}
		return d
	};
	TimeMap.prototype.initState = function() {
		var c = this;
		c.setStateFromUrl();
		window.onhashchange = function() {
			c.setStateFromUrl()
		}
	};
	TimeMap.prototype.setStateFromUrl = function() {
		this.setState(a.fromUrl())
	};
	TimeMap.prototype.getStateParamString = function() {
		return a.toParamString(this.getState())
	};
	TimeMap.prototype.getStateUrl = function() {
		return a.toUrl(this.getState())
	};
	TimeMap.state.params = {
		zoom : new b.OptionParam("mapZoom", {
			get : function(c) {
				return c.map.getZoom()
			},
			set : function(c, d) {
				c.map.setZoom(d)
			},
			fromStr : function(c) {
				return parseInt(c, 10)
			}
		}),
		center : new b.OptionParam("mapCenter", {
			get : function(c) {
				return c.map.getCenter()
			},
			set : function(c, d) {
				c.map.setCenter(d)
			},
			fromStr : function(c) {
				var d = c.split(",");
				if (d.length < 2) {
					return null
				}
				return new mxn.LatLonPoint(parseFloat(d[0]), parseFloat(d[1]))
			},
			toStr : function(c) {
				return c.lat + "," + c.lng
			}
		}),
		date : new b.Param("scrollTo", {
			get : function(c) {
				return c.timeline.getBand(0).getCenterVisibleDate()
			},
			set : function(c, d) {
				c.scrollToDate(d)
			},
			fromStr : function(c) {
				return TimeMap.dateParsers.hybrid(c)
			},
			toStr : function(c) {
				return TimeMap.util.formatDate(c)
			}
		}),
		selected : new b.OptionParam("selected", {
			set : function(c, f) {
				var e = f && c.datasets[f.dataset], d;
				if (e) {
					d = e.getItems()[f.index];
					if (d) {
						d.openInfoWindow()
					}
				}
			},
			fromStr : function(e) {
				if (e) {
					var d = e.lastIndexOf("-"), f, c;
					if (d >= 0) {
						return {
							dataset : e.substr(0, d),
							index : parseInt(e.substr(d + 1))
						}
					}
				}
			},
			toStr : function(c) {
				var d = c && c.dataset;
				return c ? d.id + "-" + d.items.indexOf(c) : ""
			}
		})
	}
})();
(function() {
	var a = TimeMap.loaders;
	a.jsonp = function(c) {
		var b = new a.remote(c);
		b.opts.dataType = "jsonp";
		return b
	};
	a.json = function(c) {
		var b = new a.remote(c);
		b.opts.dataType = "json";
		return b
	};
	a.json_string = a.json
})();
TimeMap.loaders.xml = function(c) {
	var a = new TimeMap.loaders.remote(c), e = c.tagMap || {}, b = c.extraTags
			|| [], d = a.params;
	a.load = function(f, g) {
		a.callbackName = a.getCallbackName(f, g);
		a.opts.dataType = $.browser.msie ? "text" : "xml";
		a.opts.success = function(i) {
			var h;
			if (typeof i == "string") {
				h = new ActiveXObject("Microsoft.XMLDOM");
				h.async = false;
				h.loadXML(i)
			} else {
				h = i
			}
			TimeMap.loaders.cb[a.callbackName](h)
		};
		$.ajax(a.opts)
	};
	a.extraParams = [];
	b.forEach(function(f) {
		a.extraParams.push(new TimeMap.params.OptionParam(e[f] || f, {
			sourceName : f
		}))
	});
	a.parseExtra = function(f, g) {
		a.extraParams.forEach(function(h) {
			h.setConfigXML(f, g)
		});
		g = null
	};
	return a
};
TimeMap.loaders.flickr = function(b) {
	var a = new TimeMap.loaders.jsonp(b);
	a.opts.jsonp = "jsoncallback";
	a.preload = function(c) {
		return c.items
	};
	a.transform = function(d) {
		var c = {
			title : d.title,
			start : d.date_taken,
			point : {
				lat : d.latitude,
				lon : d.longitude
			},
			options : {
				description : d.description.replace(/&gt;/g, ">").replace(
						/&lt;/g, "<").replace(/&quot;/g, '"')
			}
		};
		if (b.transformFunction) {
			c = b.transformFunction(c)
		}
		return c
	};
	return a
};
TimeMap.loaders.georss = function(b) {
	var a = new TimeMap.loaders.xml(b);
	a.parse = TimeMap.loaders.georss.parse;
	return a
};
TimeMap.loaders.georss.parse = function(l) {
	var j = [], v, f, q, n, u;
	var a = TimeMap.util, c = a.getTagValue, r = a.getNodeList, o = a.makePoint, b = a.makePoly, g = a.formatDate, e = a.nsMap;
	e.georss = "http://www.georss.org/georss";
	e.gml = "http://www.opengis.net/gml";
	e.geo = "http://www.w3.org/2003/01/geo/wgs84_pos#";
	e.kml = "http://www.opengis.net/kml/2.2";
	var t = (l.firstChild.tagName == "rss") ? "rss" : "atom";
	var p = (t == "rss" ? "item" : "entry");
	f = r(l, p);
	for (n = 0; n < f.length; n++) {
		q = f[n];
		v = {
			options : {}
		};
		v.title = c(q, "title");
		p = (t == "rss" ? "description" : "summary");
		v.options.description = c(q, p);
		u = r(q, "TimeStamp", "kml");
		if (u.length > 0) {
			v.start = c(u[0], "when", "kml")
		}
		if (!v.start) {
			u = r(q, "TimeSpan", "kml");
			if (u.length > 0) {
				v.start = c(u[0], "begin", "kml");
				v.end = c(u[0], "end", "kml") || g(new Date())
			}
		}
		if (!v.start) {
			if (t == "rss") {
				var s = new Date(Date.parse(c(q, "pubDate")));
				v.start = g(s)
			} else {
				v.start = c(q, "updated")
			}
		}
		var h = false;
		PLACEMARK: while (!h) {
			var m, k;
			m = c(q, "point", "georss");
			if (m) {
				v.point = o(m);
				break PLACEMARK
			}
			u = r(q, "Point", "gml");
			if (u.length > 0) {
				m = c(u[0], "pos", "gml");
				if (!m) {
					m = c(u[0], "coordinates", "gml")
				}
				if (m) {
					v.point = o(m);
					break PLACEMARK
				}
			}
			if (c(q, "lat", "geo")) {
				m = [ c(q, "lat", "geo"), c(q, "long", "geo") ];
				v.point = o(m);
				break PLACEMARK
			}
			m = c(q, "line", "georss");
			if (m) {
				v.polyline = b(m);
				break PLACEMARK
			}
			m = c(q, "polygon", "georss");
			if (m) {
				v.polygon = b(m);
				break PLACEMARK
			}
			u = r(q, "LineString", "gml");
			if (u.length > 0) {
				k = "polyline"
			} else {
				u = r(q, "Polygon", "gml");
				if (u.length > 0) {
					k = "polygon"
				}
			}
			if (u.length > 0) {
				m = c(u[0], "posList", "gml");
				if (!m) {
					m = c(u[0], "coordinates", "gml")
				}
				if (m) {
					v[k] = b(m);
					break PLACEMARK
				}
			}
			h = true
		}
		this.parseExtra(v, q);
		j.push(v)
	}
	l = f = q = u = null;
	return j
};
TimeMap.loaders.gss = function(c) {
	var b = new TimeMap.loaders.jsonp(c), h = b.params, g, a, f = TimeMap.loaders.gss.setParamField, d = c.paramMap
			|| {}, e = c.extraColumns || [];
	if (!b.opts.url && c.key) {
		b.opts.url = "http://spreadsheets.google.com/feeds/list/" + c.key
				+ "/1/public/values?alt=json-in-script&callback=?"
	}
	for (a = 0; a < e.length; a++) {
		g = e[a];
		h[g] = new TimeMap.params.OptionParam(g)
	}
	for (g in h) {
		if (h.hasOwnProperty(g)) {
			fieldName = d[g] || g;
			f(h[g], fieldName)
		}
	}
	b.preload = function(i) {
		return i.feed.entry
	};
	b.transform = function(k) {
		var j = {}, m = b.params, l, i = c.transformFunction;
		for (l in m) {
			if (m.hasOwnProperty(l)) {
				m[l].setConfigGSS(j, k)
			}
		}
		if (i) {
			j = i(j)
		}
		return j
	};
	return b
};
TimeMap.loaders.gss.setParamField = function(b, c) {
	var a = function(e, f) {
		var d = e["gsx$" + f.toLowerCase().replace(" ", "")];
		return d ? d.$t : null
	};
	b.setConfigGSS = function(d, e) {
		this.setConfig(d, a(e, c))
	}
};
TimeMap.loaders.kml = function(b) {
	var a = new TimeMap.loaders.xml(b), d = b.tagMap || {}, c = b.extendedData
			|| [];
	c.forEach(function(e) {
		a.extraParams.push(new TimeMap.params.ExtendedDataParam(d[e] || e, e))
	});
	a.parse = TimeMap.loaders.kml.parse;
	return a
};
TimeMap.loaders.kml.parse = function(b) {
	var m = this, i = [], f, j, d, l, a;
	var g = TimeMap.util, e = g.getTagValue, k = g.getNodeList, c = g.makePoint, h = g.makePoly, o = g.formatDate;
	function n(t, r) {
		var p = $(t).children("TimeStamp"), s = $(t).children("TimeSpan");
		if (s.length) {
			r.start = e(s, "begin");
			r.end = e(s, "end") || o(new Date())
		} else {
			r.start = e(p, "when")
		}
		if (!r.start) {
			var q = $(t).parent();
			if (q.is("Folder") || q.is("Document")) {
				n(q, r)
			}
		}
	}
	k(b, "Placemark").each(function() {
		var p = this;
		f = {
			options : {}
		};
		f.title = e(p, "name");
		f.options.description = e(p, "description");
		n(p, f);
		f.placemarks = [];
		k(p, "Point").each(function() {
			a = {
				point : {}
			};
			l = e(this, "coordinates");
			a.point = c(l, 1);
			f.placemarks.push(a)
		});
		k(p, "LineString").each(function() {
			a = {
				polyline : []
			};
			l = e(this, "coordinates");
			a.polyline = h(l, 1);
			f.placemarks.push(a)
		});
		k(p, "Polygon").each(function() {
			a = {
				polygon : []
			};
			l = e(this, "coordinates");
			a.polygon = h(l, 1);
			f.placemarks.push(a)
		});
		m.parseExtra(f, p);
		i.push(f)
	});
	k(b, "GroundOverlay").each(function() {
		var p = this;
		f = {
			options : {},
			overlay : {}
		};
		f.title = e(p, "name");
		f.options.description = e(p, "description");
		n(p, f);
		f.overlay.image = e(p, "Icon href");
		d = k(p, "LatLonBox");
		f.overlay.north = e(d, "north");
		f.overlay.south = e(d, "south");
		f.overlay.east = e(d, "east");
		f.overlay.west = e(d, "west");
		m.parseExtra(f, p);
		i.push(f)
	});
	b = null;
	return i
};
TimeMap.params.ExtendedDataParam = function(b, a) {
	return new TimeMap.params.OptionParam(b, {
		setConfigXML : function(d, e) {
			var c = TimeMap.util, f = this;
			c.getNodeList(e, "Data").each(function() {
				var g = $(this);
				if (g.attr("name") == a) {
					f.setConfig(d, c.getTagValue(g, "value"))
				}
			})
		},
		sourceName : a
	})
};
TimeMap.loaders.metaweb = function(c) {
	var b = new TimeMap.loaders.jsonp(c), f = c.query || {}, e = encodeURIComponent(JSON
			.stringify({
				qname : {
					query : f
				}
			})), d = c.host || "http://www.freebase.com", a = c.service
			|| "/api/service/mqlread";
	b.opts.url = d + a + "?queries=" + e + "&callback=?";
	b.preload = function(g) {
		var h = g.qname;
		if (h.code.indexOf("/api/status/ok") !== 0) {
			return []
		}
		return h.result
	};
	return b
};
TimeMap.loaders.progressive = function(o) {
	var l = o.loader, j = o.type;
	if (!l) {
		var e = (typeof (j) == "string") ? TimeMap.loaders[j] : j;
		l = new e(o)
	}
	var h = l.opts.url, i = l.load, d = o.interval, n = o.formatDate
			|| TimeMap.util.formatDate, k = o.formatUrl || function(q, r, p) {
		return q.replace("[start]", n(r)).replace("[end]", n(p))
	}, c = TimeMap.dateParsers.hybrid, m = c(o.start), f = c(o.dataMinDate), b = c(o.dataMaxDate), g = {};
	var a = function(p) {
		var q = p.timemap.timeline.getBand(0);
		q
				.addOnScrollListener(function() {
					var t = q.getCenterVisibleDate(), u = Math.floor((t
							.getTime() - m.getTime())
							/ d), r = m.getTime() + (d * u), v = r + d, s = r
							- d, w = function() {
						p.timemap.timeline.layout()
					};
					if ((!b || r < b.getTime()) && (!f || r > f.getTime())
							&& !g[u]) {
						l.load(p, w, new Date(r), u)
					}
					if (v < q.getMaxDate().getTime() && (!b || v < b.getTime())
							&& !g[u + 1]) {
						l.load(p, w, new Date(v), u + 1)
					}
					if (s > q.getMinDate().getTime() && (!f || s > f.getTime())
							&& !g[u - 1]) {
						l.load(p, w, new Date(s), u - 1)
					}
				});
		a = false
	};
	l.load = function(r, t, s, q) {
		s = c(s) || m;
		q = q || 0;
		var p = new Date(s.getTime() + d);
		g[q] = true;
		l.opts.url = k(h, s, p);
		i.call(l, r, function() {
			if (a) {
				a(r)
			}
			t()
		})
	};
	return l
};