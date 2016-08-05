component extends="commandbox.system.BaseCommand" {

	public void function postInstall( required string directory, required string siteId ) {
		FileMove( arguments.directory & "/application/i18n/myapp.properties"
			    , arguments.directory & "/application/i18n/#arguments.siteId#.properties"
		);

		var token = "{site_id}";
		var dashboardCfc  = arguments.directory & "/application/handlers/admin/Dashboard.cfc";
		var urlRewriteXml = arguments.directory & "/urlrewrite.xml";
		var dash          = FileRead( dashboardCfc  );
		var rewrite       = FileRead( urlRewriteXml );

		dash    = ReplaceNoCase( dash, "${site_id}", arguments.siteId, "all" );
		rewrite = ReplaceNoCase( rewrite, "${site_id}", arguments.siteId, "all" );

		FileWrite( dashboardCfc, dash );
		FileWrite( urlRewriteXml, rewrite );
	}

}