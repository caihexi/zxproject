package cproject

import groovy.xml.MarkupBuilder

import java.util.Map;
import org.springframework.dao.DataIntegrityViolationException

class CsubjectController extends BaseController{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def myini() {
		StringBuffer result = new StringBuffer()
		if (!Csubject.get(1)) {
			result.append("begin create...")
			Csubject csInstance;
			String subjectname;
			for (i in 1..3) {
				subjectname = message(code:"csubject.subjectType.${i}",default:"unknow");
				csInstance = new Csubject(subjectType:i,subjectName:subjectname);
				csInstance.subjectParent = csInstance;
				if (csInstance.save()) result.append(subjectname).append(" ok");
				else result.append(subjectname).append(" faild");
			}
		}
		else result.append("already ini...")
		flash.message = result.toString();
		redirect(action:'list')
    }

	
	def injectXml ={
		MarkupBuilder xml, Csubject node ->
		xml.csubject(name:node.toString(), id:node.id){
			Csubject.findAllBySubjectParent(node)?.each{
					Csubject item->
					if (item!=node)
					injectXml(xml,item)
			   }
			}
	}
	
	
	def mylist(Long id){ 
		def writer = new StringWriter()
		def xml = new MarkupBuilder(writer)
		id = id ? id : 0
		if (id==0) {
			xml.root(name:message(code:'csubject.label'),id:0){
				Csubject.findAll("from Csubject where id=subject_parent_id").each {Csubject row->
					injectXml(xml, row)
				}
			}
		}
		else {
			Csubject csInstance = Csubject.get(id)
			if (csInstance) {
				injectXml(xml,csInstance);
			}
		}
//		System.out.println(writer.toString());
		[ "data": writer.toString()] 
		} 

	
   def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [csubjectInstanceList: Csubject.list(params), csubjectInstanceTotal: Csubject.count()]
    }

    def create() {
 		if (!checkRole(session.user,'csubject')) {
			flash.message = message(code: 'default.role.message', args: ["create csubject"]) 
			redirect(action: "myerror")
			return
		}
       [csubjectInstance: new Csubject(params)]
    }

    def save() {
  		if (!checkRole(session.user,'csubject')) {
			flash.message = message(code: 'default.role.message', args: ["save csubject"]) 
			redirect(action: "myerror")
			return
		}
        def csubjectInstance = new Csubject(params)
		csubjectInstance.subjectType = csubjectInstance.subjectParent.subjectType;
        if (!csubjectInstance.save(flush: true)) {
            render(view: "create", model: [csubjectInstance: csubjectInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'csubject.label', default: 'Csubject'), csubjectInstance.id])
        redirect(action: "show", id: csubjectInstance.id)
    }

    def show(Long id) {
		if (id==0) {
			redirect(action:'mylist',id:0);
			return
		}
        def csubjectInstance = Csubject.get(id)
        if (!csubjectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'csubject.label', default: 'Csubject'), id])
            redirect(action: "list")
            return
        }

        [csubjectInstance: csubjectInstance,cjournalInstanceList:Cjournal.findAllBySubject0(csubjectInstance,[max:20,sort:'id',order:'desc'])]
    }

    def edit(Long id) {
 		if (!checkRole(session.user,'csubject')) {
			flash.message = message(code: 'default.role.message', args: ["edit csubject"]) 
			redirect(action: "myerror")
			return
		}
         def csubjectInstance = Csubject.get(id)
        if (!csubjectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'csubject.label', default: 'Csubject'), id])
            redirect(action: "list")
            return
        }

        [csubjectInstance: csubjectInstance]
    }

    def update(Long id, Long version) {
  		if (!checkRole(session.user,'csubject')) {
			flash.message = message(code: 'default.role.message', args: ["update csubject"]) 
			redirect(action: "myerror")
			return
		}
        def csubjectInstance = Csubject.get(id)
        if (!csubjectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'csubject.label', default: 'Csubject'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (csubjectInstance.version > version) {
                csubjectInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'csubject.label', default: 'Csubject')] as Object[],
                          "Another user has updated this Csubject while you were editing")
                render(view: "edit", model: [csubjectInstance: csubjectInstance])
                return
            }
        }

        csubjectInstance.properties = params
		csubjectInstance.subjectType = csubjectInstance.subjectParent.subjectType;
		
        if (!csubjectInstance.save(flush: true)) {
            render(view: "edit", model: [csubjectInstance: csubjectInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'csubject.label', default: 'Csubject'), csubjectInstance.id])
        redirect(action: "show", id: csubjectInstance.id)
    }

    def delete(Long id) {
 		if (!checkRole(session.user,'csubject')) {
			flash.message = message(code: 'default.role.message', args: ["delete csubject"]) 
			redirect(action: "myerror")
			return
		}
         def csubjectInstance = Csubject.get(id)
        if (!csubjectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'csubject.label', default: 'Csubject'), id])
            redirect(action: "list")
            return
        }
        if (Cjournal.findBySubject0(csubjectInstance)){
            flash.message = "该科目日记账，请先删除对应的日记账，才可删除本科目！"
            redirect(action: "list")
        }
		csubjectInstance.deleted = true;
		if (csubjectInstance.save()) {
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'csubject.label', default: 'Csubject'), id])
            redirect(action: "list")
		}
		else {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'csubject.label', default: 'Csubject'), id])
            redirect(action: "show", id: id)
 		}
		
/*
        try {
            csubjectInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'csubject.label', default: 'Csubject'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'csubject.label', default: 'Csubject'), id])
            redirect(action: "show", id: id)
        }
		*/
    }
}
