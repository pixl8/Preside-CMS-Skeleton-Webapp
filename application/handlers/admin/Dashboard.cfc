component extends="preside.system.base.AdminHandler" {

	public void function index( event, rc, prc ) {
		prc.pageTitle = translateResource( "${site_id}:dashboard.page.title" );
		prc.pageIcon  = "dashboard";
	}

}