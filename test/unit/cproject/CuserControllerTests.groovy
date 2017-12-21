package cproject



import org.junit.*
import grails.test.mixin.*

@TestFor(CuserController)
@Mock(Cuser)
class CuserControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/cuser/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.cuserInstanceList.size() == 0
        assert model.cuserInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.cuserInstance != null
    }

    void testSave() {
        controller.save()

        assert model.cuserInstance != null
        assert view == '/cuser/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/cuser/show/1'
        assert controller.flash.message != null
        assert Cuser.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/cuser/list'

        populateValidParams(params)
        def cuser = new Cuser(params)

        assert cuser.save() != null

        params.id = cuser.id

        def model = controller.show()

        assert model.cuserInstance == cuser
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/cuser/list'

        populateValidParams(params)
        def cuser = new Cuser(params)

        assert cuser.save() != null

        params.id = cuser.id

        def model = controller.edit()

        assert model.cuserInstance == cuser
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/cuser/list'

        response.reset()

        populateValidParams(params)
        def cuser = new Cuser(params)

        assert cuser.save() != null

        // test invalid parameters in update
        params.id = cuser.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/cuser/edit"
        assert model.cuserInstance != null

        cuser.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/cuser/show/$cuser.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        cuser.clearErrors()

        populateValidParams(params)
        params.id = cuser.id
        params.version = -1
        controller.update()

        assert view == "/cuser/edit"
        assert model.cuserInstance != null
        assert model.cuserInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/cuser/list'

        response.reset()

        populateValidParams(params)
        def cuser = new Cuser(params)

        assert cuser.save() != null
        assert Cuser.count() == 1

        params.id = cuser.id

        controller.delete()

        assert Cuser.count() == 0
        assert Cuser.get(cuser.id) == null
        assert response.redirectedUrl == '/cuser/list'
    }
}
