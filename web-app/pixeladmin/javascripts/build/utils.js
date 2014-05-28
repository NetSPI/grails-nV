(function() {
  if (!String.prototype.endsWith) {

    /*
     * Determines whether a string ends with the specified suffix.
     * 
     * @param  {String} suffix
     * @return Boolean
     */
    String.prototype.endsWith = function(suffix) {
      return this.indexOf(suffix, this.length - suffix.length) !== -1;
    };
  }

  if (!String.prototype.trim) {

    /*
     * Removes whitespace from both sides of a string.
     * 
     * @return {String}
     */
    String.prototype.trim = function() {
      return this.replace(/^\s+|\s+$/g, '');
    };
  }

  if (!Array.prototype.indexOf) {

    /*
     * The indexOf() method returns the first index at which a given element can be found in the array, or -1 if it is not present.
     * 
     * @param  {Variant} searchElement
     * @param  {Integer} fromIndex
     * @return {Integer}
     */
    Array.prototype.indexOf = function(searchElement, fromIndex) {
      var i, length, _i;
      if (this === void 0 || this === null) {
        throw new TypeError('"this" is null or not defined');
      }
      length = this.length >>> 0;
      fromIndex = +fromIndex || 0;
      if (Math.abs(fromIndex) === Infinity) {
        fromIndex = 0;
      }
      if (fromIndex < 0) {
        fromIndex += length;
        if (fromIndex < 0) {
          fromIndex = 0;
        }
      }
      for (i = _i = fromIndex; fromIndex <= length ? _i < length : _i > length; i = fromIndex <= length ? ++_i : --_i) {
        if (this[i] === searchElement) {
          return i;
        }
      }
      return -1;
    };
  }

  if (!Function.prototype.bind) {
    Function.prototype.bind = function(oThis) {
      var aArgs, fBound, fNOP, fToBind;
      if (typeof this !== "function") {
        throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable");
      }
      aArgs = Array.prototype.slice.call(arguments, 1);
      fToBind = this;
      fNOP = function() {};
      fBound = function() {
        return fToBind.apply((this instanceof fNOP && oThis ? this : oThis), aArgs.concat(Array.prototype.slice.call(arguments)));
      };
      fNOP.prototype = this.prototype;
      fBound.prototype = new fNOP();
      return fBound;
    };
  }

  if (!Object.keys) {
    Object.keys = (function() {
      'use strict';
      var dontEnums, hasDontEnumBug, hasOwnProperty;
      hasOwnProperty = Object.prototype.hasOwnProperty;
      hasDontEnumBug = {
        toString: null
      }.propertyIsEnumerable('toString') ? false : true;
      dontEnums = ['toString', 'toLocaleString', 'valueOf', 'hasOwnProperty', 'isPrototypeOf', 'propertyIsEnumerable', 'constructor'];
      return function(obj) {
        var dontEnum, prop, result, _i, _j, _len, _len1;
        if (typeof obj !== 'object' && (typeof obj !== 'function' || obj === null)) {
          throw new TypeError('Object.keys called on non-object');
        }
        result = [];
        for (_i = 0, _len = obj.length; _i < _len; _i++) {
          prop = obj[_i];
          if (hasOwnProperty.call(obj, prop)) {
            result.push(prop);
          }
        }
        if (hasDontEnumBug) {
          for (_j = 0, _len1 = dontEnums.length; _j < _len1; _j++) {
            dontEnum = dontEnums[_j];
            if (hasOwnProperty.call(obj, dontEnum)) {
              result.push(dontEnum);
            }
          }
        }
        return result;
      };
    }).call(this);
  }


  /*
   * Detect screen size.
   * 
   * @param  {jQuery Object} $ssw_point
   * @param  {jQuery Object} $tsw_point
   * @return {String}
   */

  window.getScreenSize = function($ssw_point, $tsw_point) {
    if ($ssw_point.is(':visible')) {
      return 'small';
    } else if ($tsw_point.is(':visible')) {
      return 'tablet';
    } else {
      return 'desktop';
    }
  };

  window.elHasClass = function(el, selector) {
    return (" " + el.className + " ").indexOf(" " + selector + " ") > -1;
  };

  window.elRemoveClass = function(el, selector) {
    return el.className = (" " + el.className + " ").replace(" " + selector + " ", ' ').trim();
  };

}).call(this);
