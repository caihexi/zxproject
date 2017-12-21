package cproject



import org.junit.*
import grails.test.mixin.*

@TestFor(CjournalController)
@Mock(Cjournal)
class CjournalControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/cjournal/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.cjournalInstanceList.size() == 0
        assert model.cjournalInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.cjournalInstance != null
    }

    void testSave() {
        controller.save()

        assert model.cjournalInstance != null
        assert view == '/cjournal/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/cjournal/show/1'
        assert controller.flash.message != null
        assert Cjournal.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/cjournal/list'

        populateValidParams(params)
        def cjournal = new Cjournal(params)

        assert cjournal.save() != null

        params.id = cjournal.id

        def model = controller.show()

        assert model.cjournalInstance == cjournal
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/cjournal/list'

        populateValidParams(params)
        def cjournal = new Cjournal(params)

        assert cjournal.save() != null

        params.id = cjournal.id

        def model = controller.edit()

        assert model.cjournalInstance == cjournal
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/cjournal/list'

        response.reset()

        populateValidParams(params)
        def cjournal = new Cjournal(params)

        assert cjournal.save() != null

        // test invalid parameters in update
        params.id = cjournal.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/cjournal/edit"
        assert model.cjournalInstance != null

        cjournal.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/cjournal/show/$cjournal.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        cjournal.clearErrors()

        populateValidParams(params)
        params.id = cjournal.id
        params.version = -1
        controller.update()

        assert view == "/cjournal/edit"
        assert model.cjournalInstance != null
        assert model.cjournalInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/cjournal/list'

        response.reset()

        populateValidParams(params)
        def cjournal = new Cjournal(params)

        assert cjournal.save() != null
        assert Cjournal.count() == 1

        params.id = cjournal.id

        controller.delete()

        assert Cjournal.count() == 0
        assert Cjournal.get(cjournal.id) == null
        assert response.redirectedUrl == '/cjournal/list'
    }
}
