component extends="commandbox.system.BaseCommand" {

	public void function postInstall( required string directory ) {
		print.line();
		print.boldLine( "===================================" );
		print.boldLine( "Preside Admin Skeleton setup wizard" );
		print.boldLine( "===================================" );
		print.line();
		print.line( "You're nearly there. Answer a few questions and we'll get your new site setup and ready to go :)" );
		print.line().toConsole();

		var appid    = "";
		var appName   = "";
		var author    = "";

		while( !Len(Trim( appName ) ) ) {
			appName = ask( "Enter a name for your application (e.g. My Cool App): " );
		}
		while( !Len(Trim( author ) ) ) {
			author = ask( "Enter the site author (e.g. Super L33t Software co.): " );
		}

		do {
			appid = ask( "Enter an application ID (no spaces or special chars, e.g. office-manager): " );
			if ( !_validSlug( appid ) ) {
				appid = "";
				print.line();
				print.redLine( "Invalid app ID. Must contain only letters, numbers, - or _.");
				print.line();
			}
		} while( !Len( appid ) );

		print.line( "" );
		print.greenLine( "Thank you. Finalizing your template now..." ).toConsole();

		var configCfcPath       = arguments.directory & "/application/config/Config.cfc";
		var appCfcPath          = arguments.directory & "/Application.cfc";
		var dashboardCfcPath    = arguments.directory & "/application/handlers/admin/Dashboard.cfc";
		var urlRewriteXmlPath   = arguments.directory & "/urlrewrite.xml";
		var boxJsonPath         = arguments.directory & "/box.json";
		var boxJsonTemplatePath = arguments.directory & "/box.json.template";
		var dash                = FileRead( dashboardCfcPath  );
		var rewrite             = FileRead( urlRewriteXmlPath );
		var config              = FileRead( configCfcPath );
		var appcfc              = FileRead( appCfcPath    );
		var boxjson             = FileRead( boxJsonTemplatePath );

		config  = ReplaceNoCase( config , "${site_id}", appid, "all" );
		appcfc  = ReplaceNoCase( appcfc , "${site_id}", appid, "all" );
		dash    = ReplaceNoCase( dash   , "${site_id}", appid, "all" );
		rewrite = ReplaceNoCase( rewrite, "${site_id}", appid, "all" );
		boxjson = ReplaceNoCase( boxjson, '${site_name}', appName, "all" );
		boxjson = ReplaceNoCase( boxjson, '${site_id}', appid, "all" );
		boxjson = ReplaceNoCase( boxjson, '${author}', author, "all" );

		FileWrite( configCfcPath    , config );
		FileWrite( appCfcPath       , appcfc );
		FileWrite( dashboardCfcPath , dash );
		FileWrite( urlRewriteXmlPath, rewrite );
		FileWrite( boxJsonPath      , boxjson );
		FileDelete( boxJsonTemplatePath );

		try {
			FileMove( arguments.directory & "/application/i18n/myapp.properties"
				    , arguments.directory & "/application/i18n/#appid#.properties"
			);
		} catch ( any e ){
			print.yellowLine( "Warning: could not rename myapp.properties to #appid#.properties" );
		};

		command( "install" ).params( "presidecms" ).run();
		command( "install" ).params( "preside-ext-launcher" ).run();
		command( "install" ).params( "preside-ext-alt-admin-theme" ).run();
	}


	private boolean function _validSlug( required string slug ) {
		return ReFindNoCase( "^[a-z0-9-_]+$", arguments.slug );
	}
}
