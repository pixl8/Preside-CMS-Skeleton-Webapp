component extends="commandbox.system.BaseCommand" {

	public void function postInstall( required string directory, required string siteId ) {
		FileMove( arguments.directory & "/application/i18n/myapp.properties"
			    , arguments.directory & "/application/i18n/#arguments.siteId#.properties"
		);
	}

}