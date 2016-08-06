component extends="commandbox.system.BaseCommand" {

	public void function postInstall( required string directory ) {
		print.line();
		var appid   = ask( "Enter an application ID (no spaces or special chars, e.g. office-manager): " );
		while( !_validSlug( appid ) ) {
			print.line();
			print.redLine( "Invalid application ID. Must contain only letters, numbers, - or _.");
			print.line();
			appid   = ask( "Enter an application ID (no spaces or special chars, e.g. office-manager): " );
		}

		var appName = ask( "Enter an application name (e.g. Office Manager): " );
		while( !Len(Trim( appName ) ) ) {
			appName = ask( "Enter an application name (e.g. Office Manager): " );
		}

		var author = ask( "Enter the application author (e.g. Super L33t Software co.): " );
		while( !Len(Trim( author ) ) ) {
			author = ask( "Enter the application author (e.g. Super L33t Software co.): " );
		}

		print.greenLine( "");
		print.greenLine( "Thank you. Finalizing your template now..." );

		var configCfcPath     = arguments.directory & "/application/config/Config.cfc";
		var appCfcPath        = arguments.directory & "/Application.cfc";
		var dashboardCfcPath  = arguments.directory & "/application/handlers/admin/Dashboard.cfc";
		var urlRewriteXmlPath = arguments.directory & "/urlrewrite.xml";
		var boxJsonPath       = arguments.directory & "/box.json";
		var dash              = FileRead( dashboardCfcPath  );
		var rewrite           = FileRead( urlRewriteXmlPath );
		var config            = FileRead( configCfcPath );
		var appcfc            = FileRead( appCfcPath    );
		var boxjson           = FileRead( boxJsonPath    );

		config  = ReplaceNoCase( config , "${site_id}", appid, "all" );
		appcfc  = ReplaceNoCase( appcfc , "${site_id}", appid, "all" );
		dash    = ReplaceNoCase( dash   , "${site_id}", appid, "all" );
		rewrite = ReplaceNoCase( rewrite, "${site_id}", appid, "all" );
		boxjson = ReplaceNoCase( boxjson, '"name":"PresideCMS Skeleton Web Application"', '"name":"#appName#"' );
		boxjson = ReplaceNoCase( boxjson, '"author":"Pixl8 Interactive"', '"author":"#author#"' );
		boxjson = ReplaceNoCase( boxjson, '"slug":"preside-skeleton-webapp"', '"slug":"#appid#"' );

		FileWrite( configCfcPath    , config );
		FileWrite( appCfcPath       , appcfc );
		FileWrite( dashboardCfcPath , dash );
		FileWrite( urlRewriteXmlPath, rewrite );
		FileWrite( boxJsonPath      , boxjson );

		try {
			FileMove( arguments.directory & "/application/i18n/myapp.properties"
				    , arguments.directory & "/application/i18n/#appid#.properties"
			);
		} catch ( any e ){
			print.yellowLine( "Warning: could not rename myapp.properties to #appid#.properties" );
		};
	}


	private boolean function _validSlug( required string slug ) {
		return ReFindNoCase( "^[a-z0-9-_]+$", arguments.slug );
	}
}