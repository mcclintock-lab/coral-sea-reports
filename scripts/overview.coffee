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
    fishing_effort_perc = @recordSet('FishingEffort', 'FishingEffort').toArray()[0]
    diversity_of_captures = @recordSet('BenthicDiversityToolbox', 'DiversityOfCaptures').toArray()[0]
    
    doc = Number(diversity_of_captures.DOC).toFixed(1)


    volume_of_captures = @recordSet('BenthicDiversityToolbox', 'VolumeOfCaptures').toArray()[0]
    reefs = @recordSet('BenthicDiversityToolbox', 'Reefs').toArray()
    seabirds = @recordSet('BenthicDiversityToolbox', 'Seabirds').toArray()
    seamounts = @recordSet('BenthicDiversityToolbox', 'Seamounts').toArray()

    isCollection = @model.isCollection()

    # setup context object with data and render the template from it
    context =
      sketch: @model.forTemplate()
      sketchClass: @sketchClass.forTemplate()
      attributes: @model.getAttributes()
      admin: @project.isAdmin window.user
      isCollection: isCollection
      benthic_diversity: benthic_diversity
      fishing_effort_perc: fishing_effort_perc
      doc: doc
      volume_of_captures: volume_of_captures
      reefs: reefs
      seabirds: seabirds
      seamounts: seamounts
    
    @$el.html @template.render(context, templates)




module.exports = OverviewTab