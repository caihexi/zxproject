package cproject


abstract class BaseController {

	def beforeInterceptor = [action: this.&auth , except:['login','handleLogin','myerror']]

	def index() { 
		render(view:"/index");
	}
	
	def myerror() {
		render(view:"/myerror")
	}
	
	boolean auth(){
		if (!session.user){
			redirect(controller:'cuser',action:'login')
			return false
		}
		else{
			return true
		} 
	}
	
	/***
	 * 权限审核
	 * @author 蔡贺曦
	 * @param uInstance
	 * @param controllerName controllerName
	 * @return 是否有权
	 * @since 2013.11.29
	 */
	Boolean checkRole(Cuser uInstance,String controllerName) {
		if(uInstance.userRole?.indexOf('admin')>=0) return true;
		switch (controllerName) {
			case ['company','content']:
				return(uInstance.userRole.indexOf('content')>=0);
			case 'cuser':
				return(uInstance.userRole.indexOf('user')>=0);
			case 'cproject':
				return(uInstance.userRole.indexOf('project')>=0);
			case ['csubject','cjournal']:
				return(uInstance.userRole.indexOf('account')>=0);
		}
		return false
	}
	
}
