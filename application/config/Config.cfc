component extends="preside.system.config.Config" {

	public void function configure() {
		super.configure();

		settings.preside_admin_path  = "${site_id}";
		settings.system_users        = "sysadmin";
		settings.default_locale      = "en";

		settings.default_log_name    = "${site_id}";
		settings.default_log_level   = "information";
		settings.sql_log_name        = "${site_id}";
		settings.sql_log_level       = "information";

		settings.features.${site_id} = { enabled=true };
		settings.features.datamanager.enabled   = true;
		settings.features.cms.enabled           = false;
		settings.features.sitetree.enabled      = false;
		settings.features.sites.enabled         = false;
		settings.features.assetManager.enabled  = false;
		settings.features.websiteUsers.enabled  = false;
		settings.features.formbuilder.enabled   = false;
		settings.features.multilingual.enabled  = false;
		settings.features.updateManager.enabled = false;

		settings.adminApplications = [ {
			  id                 = "${site_id}"
			, feature            = "${site_id}"
			, defaultEvent       = "admin.dashboard"
			, accessPermission   = "${site_id}.access"
			, activeEventPattern = "admin\..*"
			, layout             = "admin"
		} ];

		StructDelete( settings.adminPermissions, "sitetree"            );
		StructDelete( settings.adminPermissions, "sites"               );
		StructDelete( settings.adminPermissions, "datamanager"         );
		StructDelete( settings.adminPermissions, "systemConfiguration" );
		StructDelete( settings.adminPermissions, "assetmanager"        );

		settings.adminPermissions.${site_id} = [ "access" ];
		settings.adminPermissions.presideobject = {
			/*
				TODO: add preside objects here that you'll need granting access to for object pickers. e.g.
				  someobject    = [ "read" ]
				, anotherobject = [ "read" ]
			*/
		};

		// TODO: define more roles for your system here. See https://docs.presidecms.com/devguides/cmspermissioning.html
		settings.adminRoles = {};
		settings.adminRoles.user = [ "${site_id}.*", "presideobject.*" ];

		 // TODO: define sidebar items for your system here. See https://docs.presidecms.com/devguides/adminlefthandmenu.html
		settings.adminSideBarItems = [];
		settings.adminConfigurationMenuItems.delete( "urlRedirects" );
		settings.antiSamy.enabled = false;
	}
}
