###
# Copyright (C) 2014-2015 Taiga Agile LLC <taiga@taiga.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# File: related-userstories.controller.spec.coffee
###

describe "RelatedUserStories", ->
    RelatedUserStoriesCtrl =  null
    provide = null
    controller = null
    mocks = {}

    _mockTgResources = () ->
        mocks.tgResources = {
            userstories: {
                listInEpic: sinon.stub()
            }
        }

        provide.value "tgResources", mocks.tgResources

    _mocks = () ->
        module ($provide) ->
            provide = $provide
            _mockTgResources()

            return null

    beforeEach ->
        module "taigaEpics"

        _mocks()

        inject ($controller) ->
            controller = $controller

        RelatedUserStoriesCtrl = controller "RelatedUserStoriesCtrl"

    it "load related userstories", (done) ->
        userstories = Immutable.fromJS([
            {
                id: 1
            }
        ])

        RelatedUserStoriesCtrl.epic = Immutable.fromJS({
            id: 66
        })

        promise = mocks.tgResources.userstories.listInEpic.withArgs(66).promise().resolve(userstories)
        RelatedUserStoriesCtrl.loadRelatedUserstories().then () ->
            expect(RelatedUserStoriesCtrl.userstories).is.equal(userstories)
            done()