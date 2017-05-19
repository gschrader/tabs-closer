module.exports =

  activate: (state) ->
    atom.commands.add "atom-workspace", 'tabs-closer:close-unmodified-tabs', => @closeUnmodifiedTabs()

  getTabs: ->
    atom.workspace.getTextEditors()

  closeTab: (tab) ->
    pane = atom.workspace.getActivePane()
    pane.destroyItem(tab)

  tabInRepo: (tab, repo) ->
      repo? and tab.getPath() and tab.getPath().indexOf(repo.getWorkingDirectory()) == 0

  closeUnmodifiedTabs: ->
    tabs = @getTabs()
    for repo in atom.project.getRepositories()
      @closeTab tab for tab in tabs when tab.constructor.name is 'TextEditor' and @tabInRepo(tab, repo) and not repo.isPathModified(tab.getPath()) and not repo.isPathNew(tab.getPath())
