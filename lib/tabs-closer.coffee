{$, View} = require 'atom'

module.exports =

  activate: (state) ->
    atom.workspaceView.command 'tabs-closer:close-unmodified-tabs', => @closeUnmodifiedTabs()

  getTabs: ->
    atom.workspace.getTextEditors()

  closeTab: (tab) ->
    pane = atom.workspace.getActivePane()
    pane.destroyItem(tab)

  closeUnmodifiedTabs: ->
    repo = atom.project.getRepo()
    if repo?
      tabs = @getTabs()
      @closeTab tab for tab in tabs when tab.constructor.name is 'TextEditor' and not repo.isPathModified(tab.getPath()) and not repo.isPathNew(tab.getPath())
