package cproject



import org.junit.*
import grails.test.mixin.*

@TestFor(CsubjectController)
@Mock(Csubject)
class CsubjectControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/csubject/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.csubjectInstanceList.size() == 0
        assert model.csubjectInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.csubjectInstance != null
    }

    void testSave() {
        controller.save()

        assert model.csubjectInstance != null
        assert view == '/csubject/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/csubject/show/1'
        assert controller.flash.message != null
        assert Csubject.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/csubject/list'

        populateValidParams(params)
        def csubject = new Csubject(params)

        assert csubject.save() != null

        params.id = csubject.id

        def model = controller.show()

        assert model.csubjectInstance == csubject
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/csubject/list'

        populateValidParams(params)
        def csubject = new Csubject(params)

        assert csubject.save() != null

        params.id = csubject.id

        def model = controller.edit()

        assert model.csubjectInstance == csubject
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/csubject/list'

        response.reset()

        populateValidParams(params)
        def csubject = new Csubject(params)

        assert csubject.save() != null

        // test invalid parameters in update
        params.id = csubject.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/csubject/edit"
        assert model.csubjectInstance != null

        csubject.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/csubject/show/$csubject.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        csubject.clearErrors()

        populateValidParams(params)
        params.id = csubject.id
        params.version = -1
        controller.update()

        assert view == "/csubject/edit"
        assert model.csubjectInstance != null
        assert model.csubjectInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/csubject/list'

        response.reset()

        populateValidParams(params)
        def csubject = new Csubject(params)

        assert csubject.save() != null
        assert Csubject.count() == 1

        params.id = csubject.id

        controller.delete()

        assert Csubject.count() == 0
        assert Csubject.get(csubject.id) == null
        assert response.redirectedUrl == '/csubject/list'
    }
}
