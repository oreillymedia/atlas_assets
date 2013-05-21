/* Classes
-------------------------------------------------------- */

if(!window.classes) window.classes = {};

/* Objects
-------------------------------------------------------- */

if(!window.app) window.app = {}

/* Events
-------------------------------------------------------- */

if(!window.app.events) window.app.events = {};

_.extend(app.events, {

	FLASH_ERROR : "flash:error",
	FLASH_WARNING : "flash:warning",
	FLASH_NOTICE : "flash:notice",
	FLASH_CLOSE : "flash:close",

	SEARCH_CHANGED : "search:changed",

	SELECT : "select",
	EDITOR_RESIZE : "editor:resize"

});

app.mailman = _.extend({}, Backbone.Events);

/* CORS
-------------------------------------------------------- */

jQuery.support.cors = true;