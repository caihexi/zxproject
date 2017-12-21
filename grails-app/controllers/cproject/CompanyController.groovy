package cproject

import org.apache.jasper.compiler.Node.ParamsAction;
import org.springframework.dao.DataIntegrityViolationException

class CompanyController extends BaseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100) 
		params.sort = params.sort ? params.sort : 'companyName';
        [companyInstanceList: Company.list(params), companyInstanceTotal: Company.count()]
    }

    def create() {
        [companyInstance: new Company(params)]
    }

    def save() {
        def companyInstance = new Company(params)
        if (!companyInstance.save(flush: true)) {
            render(view: "create", model: [companyInstance: companyInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'company.label', default: 'Company'), companyInstance.id])
        redirect(action: "show", id: companyInstance.id)
    }

    def show(Long id) {
        def companyInstance = Company.get(id)
        if (!companyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
            redirect(action: "list")
            return
        }
        [companyInstance: companyInstance,cjournalInstanceList:Cjournal.findAllByCompany(companyInstance,[max:20,sort:'id',order:'desc'])]
    }

    def edit(Long id) {
		if (!checkRole(session.user,'company')) {
			flash.message = message(code: 'default.role.message', args: ["edit company[${id}]"])
			redirect(action: "myerror")
			return
		}
        def companyInstance = Company.get(id)
        if (!companyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
            redirect(action: "list")
            return
        }
        [companyInstance: companyInstance]
    }

    def update(Long id, Long version) {
 		if (!checkRole(session.user,'company')) {
			flash.message = message(code: 'default.role.message', args: ["update company[${id}]"])
			redirect(action: "myerror")
			return
		}
       def companyInstance = Company.get(id)
        if (!companyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (companyInstance.version > version) {
                companyInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'company.label', default: 'Company')] as Object[],
                          "Another user has updated this Company while you were editing")
                render(view: "edit", model: [companyInstance: companyInstance])
                return
            }
        }

        companyInstance.properties = params

        if (!companyInstance.save(flush: true)) {
            render(view: "edit", model: [companyInstance: companyInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'company.label', default: 'Company'), companyInstance.id])
        redirect(action: "show", id: companyInstance.id)
    }

    def delete(Long id) {
 		if (!checkRole(session.user,'company')) {
			flash.message = message(code: 'default.role.message', args: ["delete company[${id}]"])
			redirect(action: "myerror")
			return
		}
       def companyInstance = Company.get(id)
        if (!companyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
            redirect(action: "list")
            return
        }
		companyInstance.deleted = true;
		if (companyInstance.save()) {
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'company.label', default: 'Company'), id])
			redirect(action: "list")
		}
		else {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'company.label', default: 'Company'), id])
			redirect(action: "show", id: id)
		}
/*
        try {
            companyInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'company.label', default: 'Company'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'company.label', default: 'Company'), id])
            redirect(action: "show", id: id)
        }
		*/
    }
}
