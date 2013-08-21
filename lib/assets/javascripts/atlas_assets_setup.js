/* Classes
-------------------------------------------------------- */

if(!window.classes) window.classes = {};

/* Objects
-------------------------------------------------------- */

if(!window.app) window.app = {}

/* Constants
-------------------------------------------------------- */

if(!window.app.constants) window.app.constants = {};

_.extend(app.constants, {
	ERROR : "error",
	NOTICE : "notice",
	WARNING : "warning"
});

/* Events
-------------------------------------------------------- */

if(!window.app.events) window.app.events = {};

_.extend(app.events, {
	FLASH_ERROR : "flash:error",
	FLASH_WARNING : "flash:warning",
	FLASH_NOTICE : "flash:notice",
	FLASH_CLOSE : "flash:close",
	SEARCH_CHANGED : "search:changed",
	SELECT : "select"
});

app.mailman = _.extend({}, Backbone.Events);

/* CORS
-------------------------------------------------------- */

jQuery.support.cors = true;