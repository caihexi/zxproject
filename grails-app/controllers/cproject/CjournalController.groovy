package cproject

import org.springframework.dao.DataIntegrityViolationException;
import java.util.Date; 

import cproject.chxbaseapi;

class CjournalController extends BaseController{

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]



	def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
		params.sort = params.sort ? params.sort : 'id'
		params.order = params.order ? params.order : 'desc'
		if (checkRole(session.user,'cjournal')) {
			[cjournalInstanceList: Cjournal.list(params), cjournalInstanceTotal: Cjournal.count()]
		}
		else {
			[cjournalInstanceList: Cjournal.findAllByInputMan(session.user,params), cjournalInstanceTotal: Cjournal.countByInputMan(session.user)]
		}
	}

    /*******
     * 显示日记账模板
     * @create 2017.12.9
     * @author caihexi
    def listCore(Map params){
        params.max = Math.min(params.max ?: 10, 100)
        params.sort = params.sort ? params.sort : 'id'
        params.order = params.order ? params.order : 'desc'
        Csubject subjectInstance = params.subjectId ? Csubject.read(params.subjectId) : null
        Company company = params.companyid ? Company.get(params.int("companyid")) : null
        Cproject project = params.projectid ? Cproject.get(params.int("projectid")) : null
        Cuser inputMan = null
        if (checkRole(session.user,'cjournal')) {
            inputMan = params.inputManid ? Cuser.read(params.int("inputManid")) : null
        }
        else {
            inputMan = session.user
        }
        def resultList = Cjournal.createCriteria().list(params, {
            and {
                eq('subject0', subjectInstance)
                between('journalDate', params.myfromday, params.mytoday + 1)
                if (inputMan) eq('inputMan',inputMan)
                if (company) eq('company',company)
                if (project) eq('projecti',project)
            }
        })
        render(template:"/cjournal/list",model:[cjournalInstanceList: resultList, cjournalInstanceTotal: resultList.totalCount,params:params])
    }
     */

	/***
	 * 科目收支一览表
	 * @param id 科目ID
	 * @param max
	 * @return
	 */
	def oneList(Integer max,Long id) {
		params.max = Math.min(max ?: 10, 100)
		params.sort = params.sort ? params.sort : 'id'
		params.order = params.order ? params.order : 'desc'
		Csubject subjectInstance = id ? Csubject.get(id) : null
		if (subjectInstance) {
			params.myfromday = chxbaseapi.paramsDate(params, "myfromday",new Date(110, 0, 1)); //2010-1-1
			params.mytoday = chxbaseapi.paramsDate(params, "mytoday",new Date());
			Cuser inputMan = null
			if (checkRole(session.user,'cjournal')) {
				inputMan = params.inputManid ? Cuser.get(params.int("inputManid")) : null
			}	
			else {
				inputMan = session.user
			}
			Company company = params.companyid ? Company.get(params.int("companyid")) : null
			Cproject projecti = params.projectid ? Cproject.get(params.int("projectid")) : null
			def criteria = Cjournal.createCriteria()
			def resultList = criteria.list(params, {
				and {
					//or {
						eq('subject0', subjectInstance)
						//eq('subject1', subjectInstance)
					//}
					between('journalDate', params.myfromday, params.mytoday + 1)
					if (inputMan) eq('inputMan',inputMan)
					if (company) eq('company',company)
					if (projecti) eq('projecti',projecti)
				}
			})
		[cjournalInstanceList: resultList, cjournalInstanceTotal: resultList.totalCount,params:params]
		}
		else {
			flash.message = "请选择一个科目！"
			params.id = null;
			[params:params]
		}
	}

	/***
	 * 科目收支一览表导出
	 * @param id 科目ID
	 * @param max
	 * @return
	 */
	def oneListDownload() {
			params.myfromday = chxbaseapi.paramsDate(params, "myfromday",new Date(110, 0, 1)); //2010-1-1
			params.mytoday = chxbaseapi.paramsDate(params, "mytoday",new Date());
			Cuser inputMan = null
			if (checkRole(session.user,'cjournal')) {
				inputMan = params.inputManid ? Cuser.get(params.int("inputManid")) : null
			}	
			else {
				inputMan = session.user
			}
			Company company = params.companyid ? Company.get(params.int("companyid")) : null
			Cproject projecti = params.projectid ? Cproject.get(params.int("projectid")) : null
			Csubject subjectInstance = params.id ? Csubject.get(params.int("id")) : null
			def criteria = Cjournal.createCriteria()
			def resultList = criteria.list(params, {
				and {
					if(subjectInstance) {
						or {
							eq('subject0', subjectInstance)
							//eq('subject1', subjectInstance)
						}
					}
					between('journalDate', params.myfromday, params.mytoday + 1)
					if (inputMan) eq('inputMan',inputMan)
					if (company) eq('company',company)
					if (projecti) eq('projecti',projecti)
					
				}
			})
/*
			StringBuffer result=new StringBuffer();
			result.append(Cjournal.csvTitle());
			resultList.each {Cjournal jInstance ->
				result.append(jInstance.csvLine());
			  }
			flash.message = result.toString();
			redirect(action:"myerror");
*/
			response.setContentType("application/ms-txt");
			response.setHeader("Content-disposition", "attachment; filename=cjournalList.csv");
			try {
				response.outputStream << Cjournal.csvTitle();
				resultList.each {Cjournal jInstance ->
				  response.outputStream << jInstance.csvLine();
				}
			}
			finally {
			  response.outputStream.flush();
			}
			
	}

	def create() {
        if (params.id){ //再记一笔
            Cjournal jOld =Cjournal.read(params.id)
            Cjournal jInstance=new Cjournal(subject0:jOld.subject0,projecti:jOld.projecti,company:jOld.company)
            jInstance.inputMan = session.user;
            //jInstance.journalDate = new Date();
            [cjournalInstance: jInstance]
        }else{
            Cjournal jInstance=new Cjournal(params)
            jInstance.inputMan = session.user;
            //jInstance.journalDate = new Date();
            [cjournalInstance: jInstance]
        }

	}

	def save() {
		def cjournalInstance = new Cjournal(params)
		if (!cjournalInstance.mycalc()) {
			render(view: "create", model: [cjournalInstance: cjournalInstance])
			return
		}

		flash.message = message(code: 'default.created.message', args: [
			message(code: 'cjournal.label', default: 'Cjournal'),
			cjournalInstance.id
		])
		redirect(action: "show", id: cjournalInstance.id)
	}

	def show(Long id) {
		def cjournalInstance = Cjournal.get(id)
		if (!cjournalInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'cjournal.label', default: 'Cjournal'),
				id
			])
			redirect(action: "list")
			return
		}
		if (checkRole(session.user,'journal') || (cjournalInstance?.inputMan?.id == session.user?.id))
		{
			return [cjournalInstance: cjournalInstance]
		}
		else {
			flash.message = "You have no Role! show journal[${id}]"
			redirect(action: "myerror")
		}
	}

	def edit(Long id) {
		if (!checkRole(session.user, 'journal')){
			flash.message = message(code: 'default.role.message', args: ["edit cjournal[${id}]"])
			redirect(action:'myerror');
			return
		}

		def cjournalInstance = Cjournal.get(id)
		if (!cjournalInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'cjournal.label', default: 'Cjournal'),
				id
			])
			redirect(action: "list")
			return
		}
		if (cjournalInstance?.inputMan?.id != session.user?.id)
		{
			flash.message = message(code: 'default.role.message', args: ["edit cjournal[${id}]"])
			redirect(action:'myerror');
			return
		}
			return [cjournalInstance: cjournalInstance]
	}

	def update(Long id, Long version) {
		if (!checkRole(session.user, 'journal')){
			flash.message = message(code: 'default.role.message', args: ["update cjournal[${id}]"])
			redirect(action:'myerror');
			return
		}
		def cjournalInstance = Cjournal.get(id)
		if (!cjournalInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'cjournal.label', default: 'Cjournal'),
				id
			])
			redirect(action: "list")
			return
		}
		if (cjournalInstance?.inputMan?.id != session.user?.id)
		{
			flash.message = message(code: 'default.role.message', args: ["update cjournal[${id}]"])
			redirect(action: "myerror")
			return
		}

		if (version != null) {
			if (cjournalInstance.version > version) {
				cjournalInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						[
							message(code: 'cjournal.label', default: 'Cjournal')] as Object[],
						"Another user has updated this Cjournal while you were editing")
				render(view: "edit", model: [cjournalInstance: cjournalInstance])
				return
			}
		}
		
		def oldDate = cjournalInstance.journalDate;
		Csubject oldSubject0 = cjournalInstance.subject0;
		//Csubject oldSubject1 = cjournalInstance.subject1;
		BigDecimal oldAmount = cjournalInstance.amount;
		//日期、金额、科目的变化都会引起科目余额的重新计算。

		cjournalInstance.properties = params

		if (!cjournalInstance.save(flush: true)) {
			render(view: "edit", model: [cjournalInstance: cjournalInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [
			message(code: 'cjournal.label', default: 'Cjournal'),
			cjournalInstance.id
		])
		
		if (oldDate != cjournalInstance.journalDate || oldSubject0 != cjournalInstance.subject0
//			||oldSubject1 != cjournalInstance.subject1 ||oldAmount != cjournalInstance.amount) {
            ||oldAmount != cjournalInstance.amount) {
		flash.message += "<br/>"+message(code: 'csubject.recalc.label');
		Cjournal.mycalcAll();
		}
		redirect(action: "show", id: cjournalInstance.id)
	}

	def delete(Long id) {
		if (!checkRole(session.user, 'journal')&&(cjournalInstance?.inputMan?.id != session.user?.id)){
			flash.message = message(code: 'default.role.message', args: ["delete cjournal[${id}]"])
			redirect(action:'myerror');
			return
		}
		def cjournalInstance = Cjournal.get(id)
		if (!cjournalInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'cjournal.label', default: 'Cjournal'),
				id
			])
			redirect(action: "list")
			return
		}
		try {
			cjournalInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [
				message(code: 'cjournal.label', default: 'Cjournal'),
				id
			])
			Cjournal.mycalcAll();
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [
				message(code: 'cjournal.label', default: 'Cjournal'),
				id
			])
			redirect(action: "show", id: id)
		}
	}
}
