module.exports =

  activate: (state) ->
    atom.commands.add "atom-workspace", 'tabs-closer:close-unmodified-tabs', => @closeUnmodifiedTabs()

  getTabs: ->
    atom.workspace.getTextEditors()

  closeTab: (tab) ->
    pane = atom.workspace.getActivePane()
    pane.destroyItem(tab)

  closeUnmodifiedTabs: ->
    repo = atom.project.getRepositories()[0]
    if repo?
      tabs = @getTabs()
      @closeTab tab for tab in tabs when tab.constructor.name is 'TextEditor' and not repo.isPathModified(tab.getPath()) and not repo.isPathNew(tab.getPath())
