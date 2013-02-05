/*
Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	config.language = I18n.currentLocale();
	// config.uiColor = '#AADC6E';

	// config.filebrowserUploadUrl = '/admin/gallery';
 	// config.filebrowserImageUploadUrl = '/admin/gallery&type=image';
 	// config.filebrowserFlashUploadUrl = '/admin/gallery&type=flash';
 	// config.filebrowserBrowseUrl="/admin/gallery?choose=true";
 	// config.filebrowserImageBrowseUrl = '/admin/gallery?choose=true&type=image';
 	// config.filebrowserFlashBrowseUrl = '/admin/gallery?choose=true&type=flash';
};

$(function(){
	CKEDITOR.replaceClass;
});