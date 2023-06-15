component extends="preside.system.config.Config" {

// COLDBOX LIFECYCLE METHODS
	public void function configure() {
		super.configure(); // important, loads core preside config in first

		_setupAdminApplication();
		_setupFeatures();
		_setupLauncher();
		_setupPermissionsAndRoles();
		_setupAdminNavigation();
		_setupMiscPresideSettings();
		_setupInterceptors();
		_setupLogboxLoggers();
	}

	public void function local() {
		super.local();

		coldbox.handlersIndexAutoReload = settings.env.handlersIndexAutoReload ?: true;
		coldbox.handlerCaching          = settings.env.handlerCaching          ?: false;
		settings.autoSyncDb             = settings.env.autoSyncDb              ?: true;
		settings.showerrors             = settings.env.showErrors              ?: true;
	}

// PRIVATE HELPERS
	private function _setupAdminApplication() {
		settings.preside_admin_path  = "${site_id}";
		settings.adminApplications = [ {
			  id                 = "${site_id}"
			, feature            = "${site_id}"
			, defaultEvent       = "admin.dashboard"
			, accessPermission   = "${site_id}.access"
			, activeEventPattern = "admin\..*"
			, layout             = "admin"
		} ];
	}

	private function _setupFeatures() {
		settings.antiSamy.enabled = false;

		settings.features[ "${site_id}" ] = { enabled=true };
		settings.features.datamanager.enabled   = true;
		settings.features.cms.enabled           = false;
		settings.features.sitetree.enabled      = false;
		settings.features.sites.enabled         = false;
		settings.features.assetManager.enabled  = false;
		settings.features.websiteUsers.enabled  = false;
		settings.features.formbuilder.enabled   = false;
		settings.features.multilingual.enabled  = false;
		settings.features.updateManager.enabled = false;
	}

	private void function _setupLauncher() {
		/* We have installed preside-ext-launcher for you and you may want to configure it.

		   See here for a guide: https://github.com/pixl8/preside-ext-launcher
		*/
	}

	private function _setupPermissionsAndRoles() {
		settings.system_users = "sysadmin";
		StructDelete( settings.adminPermissions, "sitetree"            );
		StructDelete( settings.adminPermissions, "sites"               );
		StructDelete( settings.adminPermissions, "datamanager"         );
		StructDelete( settings.adminPermissions, "systemConfiguration" );
		StructDelete( settings.adminPermissions, "assetmanager"        );

		settings.adminPermissions[ "${site_id}" ] = [ "access" ];

		// TODO: define more roles for your system here. See https://docs.presidecms.com/devguides/cmspermissioning.html
		settings.adminRoles = {};
		settings.adminRoles.user = [ "${site_id}.*" ];
	}

	private function _setupAdminNavigation() {
		ArrayDelete( settings.adminConfigurationMenuItems, "urlRedirects" );

		settings.admin.topNavItems = [ "datamanager", "emailcenter" ];

		/* See https://github.com/pixl8/preside-ext-alt-admin-theme and https://docs.preside.org/devguides/adminMenuItems.html
		   for help with configuring the top nav for your admin

		   EXAMPLE:

		   settings.topNavItems = [ "myMenuItem" ];
		   settings.adminMenuItems.myMenuItem = {
		       subMenuItems  = [ "item1", "item2" ]
		   };

		   settings.adminMenuItems.item1 = {
		         activeChecks = { datamanagerObject="object_a" }
		       , buildLinkArgs = { objectName="object_a" }
		   };
		   settings.adminMenuItems.item1 = {
		         activeChecks = { handlerPatterns=[ "^admin.myhandler\.?" ] }
		       , buildLinkArgs = { linkto="myhandler" }
		       , permissionKey = "my.custom.permission.key"
		   };
		*/
	}

	private function _setupMiscPresideSettings() {
		settings.default_locale    = "en";
		settings.default_log_name  = "${site_id}";
		settings.default_log_level = "information";
		settings.sql_log_name      = "${site_id}";
		settings.sql_log_level     = "information";
	}

	private void function _setupInterceptors() {
		/*
			e.g.

			interceptors = interceptors ?: [];
			ArrayAppend( interceptors, {
				  class      = "app.interceptors.MyApplicationInterceptor"
				, properties = {}
			} );

			interceptorSettings.customInterceptionPoints = interceptorSettings.customInterceptionPoints ?: [];
			interceptorSettings.customInterceptionPoints.append( "myCustomInterceptionPoint" );
		*/
	}

	private void function _setupLogboxLoggers() {
		/*
			e.g.

			logbox.appenders = logbox.appenders ?: {};

			logbox.appenders.myAppender = {
				  class      = 'coldbox.system.logging.appenders.RollingFileAppender'
				, properties = { filePath=settings.logsMapping, filename="mylog.log", async=true }
			};

			logbox.root = { appenders='defaultLogAppender', levelMin='FATAL', levelMax='WARN' },
			logbox.categories = logbox.categories ?: {};
			logbox.categories.mylbcategory = { appenders='myAppender', levelMin='FATAL', levelMax='INFO' }

			// etc.
		*/
	}

}
