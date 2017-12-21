package cproject



import org.junit.*
import grails.test.mixin.*

@TestFor(CprojectController)
@Mock(Cproject)
class CprojectControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/cproject/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.cprojectInstanceList.size() == 0
        assert model.cprojectInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.cprojectInstance != null
    }

    void testSave() {
        controller.save()

        assert model.cprojectInstance != null
        assert view == '/cproject/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/cproject/show/1'
        assert controller.flash.message != null
        assert Cproject.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/cproject/list'

        populateValidParams(params)
        def cproject = new Cproject(params)

        assert cproject.save() != null

        params.id = cproject.id

        def model = controller.show()

        assert model.cprojectInstance == cproject
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/cproject/list'

        populateValidParams(params)
        def cproject = new Cproject(params)

        assert cproject.save() != null

        params.id = cproject.id

        def model = controller.edit()

        assert model.cprojectInstance == cproject
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/cproject/list'

        response.reset()

        populateValidParams(params)
        def cproject = new Cproject(params)

        assert cproject.save() != null

        // test invalid parameters in update
        params.id = cproject.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/cproject/edit"
        assert model.cprojectInstance != null

        cproject.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/cproject/show/$cproject.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        cproject.clearErrors()

        populateValidParams(params)
        params.id = cproject.id
        params.version = -1
        controller.update()

        assert view == "/cproject/edit"
        assert model.cprojectInstance != null
        assert model.cprojectInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/cproject/list'

        response.reset()

        populateValidParams(params)
        def cproject = new Cproject(params)

        assert cproject.save() != null
        assert Cproject.count() == 1

        params.id = cproject.id

        controller.delete()

        assert Cproject.count() == 0
        assert Cproject.get(cproject.id) == null
        assert response.redirectedUrl == '/cproject/list'
    }
}
