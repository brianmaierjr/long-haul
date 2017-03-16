
this.fitie = function (node) {
	// restrict to valid object-fit value
	var objectFit = node.currentStyle['object-fit'];

	if (!objectFit || !/^(contain|cover|fill)$/.test(objectFit)) return;

	// prepare container styles
	var outerWidth  = node.clientWidth;
	var outerHeight = node.clientHeight;
	var outerRatio  = outerWidth / outerHeight;

	var name = node.nodeName.toLowerCase();

	var setCSS = node.runtimeStyle;
	var getCSS = node.currentStyle;

	var addEventListener = node.addEventListener || node.attachEvent;
	var removeEventListener = node.removeEventListener || node.detachEvent;
	var on = node.addEventListener ? '' : 'on';
	var img = name === 'img';
	var type = img ? 'load' : 'loadedmetadata';

	addEventListener.call(node, on + type, onload);

	if (node.complete) onload();

	function onload() {
		removeEventListener.call(node, on + type, onload);

		// prepare container styles
		var imgCSS = {
			boxSizing: 'content-box',
			display:   'inline-block',
			overflow:  'hidden'
		};

		'backgroundColor backgroundImage borderColor borderStyle borderWidth bottom fontSize lineHeight height left opacity margin position right top visibility width'.replace(/\w+/g, function (key) {
			imgCSS[key] = getCSS[key];
		});

		// prepare image styles
		setCSS.border = setCSS.margin = setCSS.padding = 0;
		setCSS.display = 'block';
		setCSS.height = setCSS.width = 'auto';
		setCSS.opacity = 1;

		var innerWidth  = node.videoWidth || node.width;
		var innerHeight = node.videoHeight || node.height;
		var innerRatio  = innerWidth / innerHeight;

		// style container
		var imgx = document.createElement('object-fit');

		imgx.appendChild(node.parentNode.replaceChild(imgx, node));

		for (var key in imgCSS) imgx.runtimeStyle[key] = imgCSS[key];

		// style image
		var newSize;

		if (objectFit === 'fill') {
			if (img) {
				setCSS.width = outerWidth;
				setCSS.height = outerHeight;
			} else {
				setCSS['-ms-transform-origin'] = '0% 0%';
				setCSS['-ms-transform'] = 'scale(' + outerWidth / innerWidth + ',' + outerHeight / innerHeight + ')';
			}
		} else if (innerRatio < outerRatio ? objectFit === 'contain' : objectFit === 'cover') {
			newSize = outerHeight * innerRatio;

			setCSS.width  = Math.round(newSize) + 'px';
			setCSS.height = outerHeight + 'px';
			setCSS.marginLeft = Math.round((outerWidth - newSize) / 2) + 'px';
		} else {
			newSize = outerWidth / innerRatio;

			setCSS.width  = outerWidth + 'px';
			setCSS.height = Math.round(newSize) + 'px';
			setCSS.marginTop = Math.round((outerHeight - newSize) / 2) + 'px';
		}
	}
};
this.fitie.init = function () {
	if (document.body) {
		var all = document.querySelectorAll('img,video');
		var index = -1;

		while (all[++index]) fitie(all[index]);
	} else {
		setTimeout(fitie.init);
	}
};

if (/MSIE|Trident/.test(navigator.userAgent)) this.fitie.init();
