package cproject

import org.springframework.dao.DataIntegrityViolationException

class CprojectController extends BaseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [cprojectInstanceList: Cproject.list(params), cprojectInstanceTotal: Cproject.count()]
    }

    def create() {
		if (!checkRole(session.user,'cproject')) {
			flash.message = message(code: 'default.role.message', args: ["create project[${id}]"])
			redirect(action: "myerror")
			return
		}
       [cprojectInstance: new Cproject(params)]
    }

    def save() {
 		if (!checkRole(session.user,'cproject')) {
			flash.message = message(code: 'default.role.message', args: ["save project[${id}]"])
			redirect(action: "myerror")
			return
		}
       def cprojectInstance = new Cproject(params)
        if (!cprojectInstance.save(flush: true)) {
            render(view: "create", model: [cprojectInstance: cprojectInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'cproject.label', default: 'Cproject'), cprojectInstance.id])
        redirect(action: "show", id: cprojectInstance.id)
    }

    def show(Long id) {
        def cprojectInstance = Cproject.get(id)
        if (!cprojectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cproject.label', default: 'Cproject'), id])
            redirect(action: "list")
            return
        }

        [cprojectInstance: cprojectInstance,cjournalInstanceList:Cjournal.findAllByProjecti(cprojectInstance,[max:20,sort:'id',order:'desc'])]
    }

    def edit(Long id) {
 		if (!checkRole(session.user,'cproject')) {
			flash.message = message(code: 'default.role.message', args: ["edit project[${id}]"])
			redirect(action: "myerror")
			return
		}
       def cprojectInstance = Cproject.get(id)
        if (!cprojectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cproject.label', default: 'Cproject'), id])
            redirect(action: "list")
            return
        }

        [cprojectInstance: cprojectInstance]
    }

    def update(Long id, Long version) {
		if (!checkRole(session.user,'cproject')) {
			flash.message = message(code: 'default.role.message', args: ["update project[${id}]"])
			redirect(action: "myerror")
			return
		}
        def cprojectInstance = Cproject.get(id)
        if (!cprojectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cproject.label', default: 'Cproject'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (cprojectInstance.version > version) {
                cprojectInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'cproject.label', default: 'Cproject')] as Object[],
                          "Another user has updated this Cproject while you were editing")
                render(view: "edit", model: [cprojectInstance: cprojectInstance])
                return
            }
        }

        cprojectInstance.properties = params

        if (!cprojectInstance.save(flush: true)) {
            render(view: "edit", model: [cprojectInstance: cprojectInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'cproject.label', default: 'Cproject'), cprojectInstance.id])
        redirect(action: "show", id: cprojectInstance.id)
    }

    def delete(Long id) {
		if (!checkRole(session.user,'cproject')) {
			flash.message = message(code: 'default.role.message', args: ["delete project[${id}]"])
			redirect(action: "myerror")
			return
		}
        def cprojectInstance = Cproject.get(id)
        if (!cprojectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cproject.label', default: 'Cproject'), id])
            redirect(action: "list")
            return
        }
        if (Cjournal.findByProjecti(cprojectInstance)){
            flash.message = "该项目日记账，请先删除对应的日记账，才可删除本项目！"
            redirect(action: "list")
        }
		cprojectInstance.deleted = true;
		if (cprojectInstance.save()) {
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'cproject.label', default: 'Cproject'), id])
			redirect(action: "list")
		}
		else {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cproject.label', default: 'Cproject'), id])
            redirect(action: "show", id: id)
		}
/*
        try {
            cprojectInstance.delete(flush: true)
                redirect(action: "show", id: id)
       flash.message = message(code: 'default.deleted.message', args: [message(code: 'cproject.label', default: 'Cproject'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cproject.label', default: 'Cproject'), id])
            redirect(action: "show", id: id)
        }
		*/
    }
}
