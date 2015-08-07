ReportTab = require 'reportTab'
templates = require '../templates/templates.js'
d3 = window.d3

class OverviewTab extends ReportTab
  name: 'Overview'
  className: 'overview'
  template: templates.overview
  dependencies:[ 
    'BenthicDiversityToolbox', 'FishingEffort'
  ]
  render: () ->

    # create random data for visualization
    benthic_diversity = @recordSet('BenthicDiversityToolbox', 'BenthicDiversity').toArray()
    fishing_effort = @recordSet('FishingEffort', 'FishingEffort').toArray()
    
    isCollection = @model.isCollection()
    fishing_effort_perc = fishing_effort[0]
    console.log("fishing_effort_perc")
    # setup context object with data and render the template from it
    context =
      sketch: @model.forTemplate()
      sketchClass: @sketchClass.forTemplate()
      attributes: @model.getAttributes()
      admin: @project.isAdmin window.user
      isCollection: isCollection
      benthic_diversity: benthic_diversity
      fishing_effort_perc: fishing_effort_perc
    
    @$el.html @template.render(context, templates)




module.exports = OverviewTab