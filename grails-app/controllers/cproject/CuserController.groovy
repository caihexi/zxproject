package cproject

import org.springframework.dao.DataIntegrityViolationException


class CuserController extends BaseController{

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def login(){
		if (session.user){
			redirect(action:'index')
		}
	}

	def logout(){
		params.login = session.user.login
		session.user=null
		render(view:'/cuser/login',params:params);
	}

	def handleLogin(){
		Cuser user = Cuser.findByLogin(params.login)
		if (user){
			if (user.userPassword==params.userPassword){
				session.user = user
				redirect(action:'index')
			}
			else {
				//flash.message = "Incorrect password for ${params.login}"
				flash.message = message(code:"incorrect.password.label",args:[params.login],default:"Incorrect password for ${params.login}");
				redirect(action:'login',params:params)
			}
		}
		else {
			if (params.login == 'admin'){
				user = new Cuser(login:"admin",userPassword:"zx82zx",userRole:"admin",userName:"admin")
				user.save(flush:true);
				flash.message = "User admin is created, please relogin..."
				redirect(action:'login',params:params)
			}
			else{
//				flash.message = "User not found for login ${params.login}"
				flash.message = message(code:"incorrect.login.label",args:[params.login],default:"User not found for login ${params.login}");
				redirect(action:'login',params:params)
			}
		}
	}

	def list(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		if (checkRole(session.user,'cuser')) {
			return [cuserInstanceList: Cuser.list(params), cuserInstanceTotal: Cuser.count()]
		}
		else {
			return [cuserInstanceList: Cuser.findAllById(session.user?.id), cuserInstanceTotal: 1]
		}
	}

	def create() {
		if (!checkRole(session.user,'cuser')) {
			flash.message = message(code: 'default.role.message', args: ["create user"]) 
			redirect(action: "myerror")
			return
		}

		 [cuserInstance: new Cuser(params)]

	}

	def save() {
		if (!checkRole(session.user,'cuser')) {
			flash.message = message(code: 'default.role.message', args: ["save user"])
			redirect(action: "myerror")
			return
		}
		
		def cuserInstance = new Cuser(params)
		if (!cuserInstance.save(flush: true)) {
			render(view: "create", model: [cuserInstance: cuserInstance])
			return
		}

		flash.message = message(code: 'default.created.message', args: [
			message(code: 'cuser.label', default: 'Cuser'),
			cuserInstance.id
		])
		redirect(action: "show", id: cuserInstance.id)
	}

	def show(Long id) {
		if (!checkRole(session.user,'cuser')&&(id!=session.user?.id)) {
			flash.message = message(code: 'default.role.message', args: ["show user[${id}]"])
			redirect(action: "myerror")
			return
		}
		def cuserInstance = Cuser.get(id)
		if (!cuserInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'cuser.label', default: 'Cuser'),
				id
			])
			redirect(action: "list")
			return
		}

		[cuserInstance: cuserInstance]
	}

	def edit(Long id) {
		if (!checkRole(session.user,'cuser')) {
			flash.message = message(code: 'default.role.message', args: ["edit user[${id}]"])
			redirect(action: "myerror")
			return
		}
		if(id==1) {
			if (session.user.id != 1) {
				flash.message = message(code: 'default.role.message', args: ["修改系统管理员信息。"])
				redirect(action:"myerror")
				return
			}
		}
		def cuserInstance = Cuser.get(id)
		if (!cuserInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'cuser.label', default: 'Cuser'),
				id
			])
			redirect(action: "list")
			return
		}
		[cuserInstance: cuserInstance]
	}

	def update(Long id, Long version) {
		if (!checkRole(session.user,'cuser')) {
			flash.message = message(code: 'default.role.message', args: ["update user[${id}]"])
			redirect(action: "myerror")
			return
		}
		def cuserInstance = Cuser.get(id)
		if (!cuserInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'cuser.label', default: 'Cuser'),
				id
			])
			redirect(action: "list")
			return
		}

		if (version != null) {
			if (cuserInstance.version > version) {
				cuserInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						[
							message(code: 'cuser.label', default: 'Cuser')] as Object[],
						"Another user has updated this Cuser while you were editing")
				render(view: "edit", model: [cuserInstance: cuserInstance])
				return
			}
		}

		cuserInstance.properties = params
		if (cuserInstance.id!=1) {
			StringBuffer userRole = new StringBuffer()
			if (params.userRole_content == "on") userRole.append(",content")
			if (params.userRole_project == "on") userRole.append(",project")
			if (params.userRole_account == "on") userRole.append(",account")
			if (params.userRole_user == "on") userRole.append(",user")
			if (userRole.length()>0) userRole.deleteCharAt(0);
			cuserInstance.userRole = userRole.toString();
		}
		if (!cuserInstance.save(flush: true)) {
			render(view: "edit", model: [cuserInstance: cuserInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [
			message(code: 'cuser.label', default: 'Cuser'),
			cuserInstance.id
		])
		redirect(action: "show", id: cuserInstance.id)
	}

	def delete(Long id) {
		if (!checkRole(session.user,'cuser')) {
			flash.message = message(code: 'default.role.message', args: ["delete user[${id}]"])
			redirect(action: "myerror")
			return
		}
		def cuserInstance = Cuser.get(id)
		if (!cuserInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'cuser.label', default: 'Cuser'),
				id
			])
			redirect(action: "list")
			return
		}
		cuserInstance.status = 0;
		if (cuserInstance.save()) {
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'cuser.label', default: 'Cuser'),id])
			redirect(action: "list")
		}
		else {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cuser.label', default: 'Cuser'),id])
			redirect(action: "show", id: id)
		}
/*
		try {
			cuserInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [
				message(code: 'cuser.label', default: 'Cuser'),
				id
			])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [
				message(code: 'cuser.label', default: 'Cuser'),
				id
			])
			redirect(action: "show", id: id)
		}
		*/
	}
	
	def resetPassword(Long id) {
		if (!checkRole(session.user,'cuser')) {
			flash.message = message(code: 'default.role.message', args: ["reset password user[${id}]"])
			redirect(action: "myerror")
			return
		}
		if (id==1 && session.user.id != 1) {
			flash.message = message(code: 'default.role.message', args: ["reset administrator's Password"])
			redirect(action:"myerror")
			return
		}
		def cuserInstance = Cuser.get(id)
		if (!cuserInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'cuser.label', default: 'Cuser'),
				id
			])
			redirect(action: "list")
			return
		}
		cuserInstance.userPassword = '123456'
		if (cuserInstance.save()) {
			flash.message = message(code:'cuser.changedPassword.label',default:'password change to 123456')
		}
		else {
			flash.message = message(code:'default.not.update.message',default:'update error!')
		}
		redirect(action: "show",id:cuserInstance.id);
	}
	
	
	def changePassword() {
		Cuser cuserInstance = Cuser.get(session.user?.id)
		if (!cuserInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'cuser.label', default: 'Cuser'),
				id
			])
			redirect(action: "list")
			return
		}
		render(view:"edit",model:[cuserInstance:cuserInstance,isChangePassword:true])
	}
}
