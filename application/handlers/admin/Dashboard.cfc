component extends="preside.system.base.AdminHandler" {

	public void function index( event, rc, prc ) {
		prc.pageTitle = translateResource( "myapp:dashboard.page.title" );
		prc.pageIcon  = "dashboard";
	}

}