observeEvent(input$link_to_tabpanel_b, {
  updateTabsetPanel(session, "nav-main", "-Collect-")
})

observeEvent(input$link_to_tabpanel_Instruction, {
  updateTabsetPanel(session, "nav-main", "-Instructions-")
})

observeEvent(input$link_to_tabpanel_about, {
  updateTabsetPanel(session, "nav-main", "-About-")
})
