{$, View} = require 'atom'

module.exports =

  activate: (state) ->
    atom.workspaceView.command 'tabs-closer:close-unmodified-tabs', => @closeUnmodifiedTabs()

  getTabs: ->
    atom.workspaceView.find('.tab').toArray().map (elt) -> $(elt).view()

  closeTab: (tab) ->
    pane = atom.workspaceView.getActivePane()
    pane.destroyItem(tab.item)

  closeUnmodifiedTabs: ->
    repo = atom.project.getRepo()
    if repo?
      tabs = @getTabs()
      @closeTab tab for tab in tabs when tab.item.constructor.name is 'Editor' and not repo.isPathModified(tab.item.getPath()) and not repo.isPathNew(tab.item.getPath())
